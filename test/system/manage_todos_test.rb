require "application_system_test_case"

class ManageTodosTest < ApplicationSystemTestCase
  test "create a to-do" do
    visit todos_url

    fill_in placeholder: "Add a todo", with: "A new todo!"
    click_button "Add"

    assert_content "A new todo!"
  end
end
