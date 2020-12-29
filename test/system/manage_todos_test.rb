require "application_system_test_case"

class ManageTodosTest < ApplicationSystemTestCase
  test "create a to-do" do
    visit todos_url
    new_todo_field = find('[placeholder="Add a new to-do..."]')

    fill_in placeholder: "Add a new to-do...", with: "A new todo!"
    new_todo_field.native.send_keys(:return)

    assert_content "A new todo!"
    assert_equal "", new_todo_field.value
  end

  test "complete a to-do" do
    todo = todos(:new)

    visit todos_url
    within "#todo_#{todo.id}" do
      check("todo_completed")
    end

    assert_selector ".todo-list--completed #todo_#{todo.id}"
  end

  test "uncomplete a to-do" do
    todo = todos(:completed)

    visit todos_url
    within "#todo_#{todo.id}" do
      uncheck("todo_completed")
    end

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

      assert_button "Save", count: 0
    end
  end

  test "delete a to-do" do
    todo = todos(:new)

    visit todos_url

    find("#todo_#{todo.id}").hover
    within "#todo_#{todo.id}" do
      accept_alert do
        click_button "Delete"
      end
    end

    refute_selector "#todo_#{todo.id}"
  end
end
