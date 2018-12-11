require 'test_helper'

class TodosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get todos_url

    assert_select '.todo-list'
  end

  test "toggle a todo" do
    todo = todos(:new)

    assert_changes "todo.completed?", from: false, to: true do
      post toggle_todo_url(todo), xhr: true
      todo.reload
    end
  end
end
