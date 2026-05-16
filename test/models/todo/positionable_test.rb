require "test_helper"

class Todo::PositionableTest < ActiveSupport::TestCase
  setup do
    Todo.delete_all
  end

  test "new todos append to the open list" do
    first = Todo.create!(name: "First")
    second = Todo.create!(name: "Second")

    assert_equal [1, 2], [first.position, second.position]
    assert_equal [first, second], Todo.open.by_position.to_a
  end

  test "completed todos move to the top of the completed list" do
    older = Todo.create!(name: "Older completed", completed: true)
    newer = Todo.create!(name: "Newer completed", completed: true)
    todo = Todo.create!(name: "Open")

    todo.toggle_completed!

    assert_predicate todo, :completed?
    assert_equal 1, todo.position
    assert_equal [todo, older, newer], Todo.completed.by_position.to_a
  end

  test "uncompleted todos move to the bottom of the open list" do
    first = Todo.create!(name: "First open")
    second = Todo.create!(name: "Second open")
    todo = Todo.create!(name: "Completed", completed: true)

    todo.toggle_completed!

    assert_not todo.completed?
    assert_equal 3, todo.position
    assert_equal [first, second, todo], Todo.open.by_position.to_a
  end

  test "position order is deterministic" do
    first = Todo.create!(name: "First", position: 1)
    second = Todo.create!(name: "Second", position: 1)

    assert_equal [first, second], Todo.open.by_position.to_a
  end

  test "new todos normalize existing unpositioned todos" do
    unpositioned = Todo.create!(name: "Unpositioned")
    unpositioned.update_column(:position, nil)

    todo = Todo.create!(name: "Next")

    assert_equal [1, 2], Todo.open.by_position.pluck(:position)
    assert_equal 2, todo.position
  end
end
