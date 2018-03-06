class AddPositionToTodos < ActiveRecord::Migration[5.2]
  def change
    add_column :todos, :position, :int
  end
end
