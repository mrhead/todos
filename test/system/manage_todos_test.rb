require "application_system_test_case"

class ManageTodosTest < ApplicationSystemTestCase
  test "create a to-do" do
    visit todos_url

    fill_in placeholder: "Add a todo", with: "A new todo!"
    click_button "Add"

    assert_content "A new todo!"
  end

  test "complete a to-do" do
    todo = todos(:new)

    visit todos_url
    check("checkbox_todo_#{todo.id}")

    assert_selector ".todos.completed #todo_#{todo.id}"
  end

  test "uncomplete a to-do" do
    todo = todos(:completed)

    visit todos_url
    uncheck("checkbox_todo_#{todo.id}")

    assert_selector ".todos.uncompleted #todo_#{todo.id}"
  end

  test "update a to-do" do
    todo = todos(:new)

    visit todos_url

    within "#todo_#{todo.id}" do
      click_link "Edit"
      fill_in :todo_name, with: "New name"
      click_button "Save"
    end

    assert_content "New name"
  end

  test "cancel to-do update" do
    todo = todos(:new)

    visit todos_url

    within "#todo_#{todo.id}" do
      click_link "Edit"
      click_link "Cancel"
    end

    refute_selector "#todo_#{todo.id} form"
  end
end
