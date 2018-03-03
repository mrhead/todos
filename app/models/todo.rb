class Todo < ApplicationRecord
  validates :name, presence: true
end
