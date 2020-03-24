class TasksController < ApplicationController
  before_action :set_task, only:[:show, :edit, :update, :destroy]

  def index
    if params[:sort_end_date] == "asc"
      @tasks = Task.order(end_date: :asc).page(params[:page]).per(5)
    elsif params[:sort_end_date] == "desc"
      @tasks = Task.order(end_date: :desc).page(params[:page]).per(5)
    elsif params[:priority_num] == "asc"
      @tasks = Task.order(priority: :asc).page(params[:page]).per(5)
    elsif params[:priority_num] == "desc"
      @tasks = Task.order(priority: :desc).page(params[:page]).per(5)
    else
      @tasks = Task.order(created_at: :desc).page(params[:page]).per(5)
    end
  end

  def search
    if params[:search][:q_name] && params[:search][:q_status]
      @tasks = Task.search_double(params[:search][:q_name], 
        params[:search][:q_status]).page(params[:page]).per(5)
    elsif params[:search][:q_name] != ""
      # binding.pry
      @tasks = Task.search_name(params[:search][:q_name]).page(params[:page]).per(5)
    elsif params[:search][:q_status] != ""
      @tasks = Task.search_status(params[:search][:q_status]).page(params[:page]).per(5)
    else
      @tasks = Task.order(created_at: :desc).page(params[:page]).per(5)
    end
    render "index"
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
    redirect_to root_path, notice: "「#{@task.name}」を削除しました。"
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
      :end_date,
      :status,
      :priority,
    )
  end
end
