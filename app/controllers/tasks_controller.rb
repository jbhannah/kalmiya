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
    current_user.tasks.create!(task_params)
    head :created
  end

  def show; end

  def edit; end

  def update
    @task.update!(task_params)
    redirect_to @task, status: :see_other
  end

  def destroy
    @task.destroy!
    head :no_content
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :completed)
  end
end
