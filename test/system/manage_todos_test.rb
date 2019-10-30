require "application_system_test_case"

class ManageTodosTest < ApplicationSystemTestCase
  test "create a to-do" do
    visit todos_url

    fill_in placeholder: "Add a new to-do...", with: "A new todo!"
    page.execute_script("form = document.querySelector('form'); Rails.fire(form, 'submit');")

    assert_content "A new todo!"
  end

  test "complete a to-do" do
    todo = todos(:new)

    visit todos_url
    check("checkbox_todo_#{todo.id}")

    assert_selector ".todo-list--completed #todo_#{todo.id}"
  end

  test "uncomplete a to-do" do
    todo = todos(:completed)

    visit todos_url
    uncheck("checkbox_todo_#{todo.id}")

    assert_selector ".todo-list--uncompleted #todo_#{todo.id}"
  end

  test "update a to-do" do
    todo = todos(:new)

    visit todos_url

    find("#todo_#{todo.id}").hover
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

    find("#todo_#{todo.id}").hover
    within "#todo_#{todo.id}" do
      click_link "Edit"
      click_link "Cancel"
    end

    refute_selector "#todo_#{todo.id} form"
  end

  test "delete a to-do" do
    todo = todos(:new)

    visit todos_url

    find("#todo_#{todo.id}").hover
    within "#todo_#{todo.id}" do
      accept_alert do
        click_link "Delete"
      end
    end

    refute_selector "#todo_#{todo.id}"
  end
end
