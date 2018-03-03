class Todo < ApplicationRecord
  validates :name, presence: true

  scope :completed, -> { where(completed: true) }
  scope :uncompleted, -> { where(completed: false) }
end
