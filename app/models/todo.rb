class Todo < ApplicationRecord
  acts_as_list scope: [:completed]

  validates :name, presence: true

  scope :by_position, -> { order(:position) }
  scope :completed, -> { where(completed: true) }
  scope :uncompleted, -> { where(completed: false) }

  def toggle_completed!
    toggle!(:completed)
    move_to_top if completed?
  end
end
