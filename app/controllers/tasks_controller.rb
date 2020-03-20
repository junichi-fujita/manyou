class TasksController < ApplicationController
  before_action :set_task, only:[:show, :edit, :update, :destroy]

  def index
    @tasks = Task.order(created_at: :desc)
  end

  def new
    @task = Task.new
  end

  def show

  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path, notice: "「#{@task.name}」を作成しました。"
    else
      render "new"
    end
  end

  def update
    @task.assign_attributes(task_params)
    if @task.save
      redirect_to @task, notice: "「#{@task.name}」を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(
      :name,
      :description,
      :created_at,
      :updated_at,
    )
  end
end
