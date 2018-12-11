module TodosHelper
  def todo_class(todo)
    classes = ["todo"]

    if todo.completed?
      classes << "todo--completed"
    else
      classes << "todo--uncompleted"
    end

    classes.join(" ")
  end
end
