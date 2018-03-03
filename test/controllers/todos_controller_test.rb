require 'test_helper'

class TodosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    todo = todos(:new)

    get todos_url

    assert_select 'li', todo.name
  end
end
