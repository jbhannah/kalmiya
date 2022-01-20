# frozen_string_literal: true

# Tasks controller
class TasksController < ApplicationController
  before_action :set_task, except: %i[index new create]

  def index
    @tasks = current_user.tasks
  end

  def new
    @task = current_user.tasks.new
  end

  def create
    task = current_user.tasks.create!(task_params)

    redirect_by_format html: task, turbo_stream: new_task_path
  end

  def show; end

  def edit; end

  def update
    @task.update!(task_params)
    redirect_to @task
  end

  def destroy
    @task.destroy!
    redirect_to tasks_path, status: :see_other
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name)
  end
end
