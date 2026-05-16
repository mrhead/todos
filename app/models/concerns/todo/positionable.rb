module Todo::Positionable
  extend ActiveSupport::Concern

  included do
    before_create :set_position

    scope :by_position, -> { order(:position, :id) }
  end

  def move_to_top
    transaction do
      normalize_positions
      todos_in_current_list.where.not(id: id).update_all("position = position + 1")
      update_column(:position, 1)
    end
  end

  def move_to_bottom
    transaction do
      normalize_positions
      update_column(:position, next_position)
    end
  end

  private

  def set_position
    normalize_positions
    self.position ||= next_position
  end

  def next_position
    todos_in_current_list.where.not(id: id).maximum(:position).to_i + 1
  end

  def normalize_positions
    next_position = todos_in_current_list.where.not(position: nil).maximum(:position).to_i + 1

    todos_in_current_list.where(position: nil).find_each do |todo|
      todo.update_columns(position: next_position)
      next_position += 1
    end
  end

  def todos_in_current_list
    self.class.where(completed: completed)
  end
end
