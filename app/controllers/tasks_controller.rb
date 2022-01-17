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

    respond_to do |format|
      format.html { redirect_to task }
      format.turbo_stream { redirect_to new_task_path }
    end
  end

  def show; end

  def edit; end

  def update
    @task.update!(task_params)
    redirect_to @task
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name)
  end
end
