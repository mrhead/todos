class Todo < ApplicationRecord
  include Positionable

  validates :name, presence: true

  scope :completed, -> { where(completed: true) }
  scope :open, -> { where(completed: false) }

  def toggle_completed!
    transaction do
      update!(completed: !completed?)
      completed? ? move_to_top : move_to_bottom
    end
  end
end
