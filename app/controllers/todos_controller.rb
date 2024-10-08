class TodosController < ApplicationController
  before_action :set_todo, only: [:edit, :update, :show, :toggle, :destroy]

  def index
    @new_todo = Todo.new
    @open_todos = Todo.open.by_position
    @completed_todos = Todo.completed.by_position
  end

  def create
    @todo = Todo.new(todo_params)

    unless @todo.save
      head :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @todo.update(todo_params)
      render "show"
    end
  end

  def show
  end

  def toggle
    @todo.toggle_completed!
  end

  def destroy
    @todo.destroy
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:name)
  end
end
