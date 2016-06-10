class TasksController < ApplicationController

  def index
    @tasks = current_user.tasks.where(completed: false)
  end

  def create
    @task = Task.new(name: params[:name], description: params[:description], completed: false, user_id: current_user.id)
    if @task.valid?
      if @task.save
        respond_to do |format|
          format.json { render json: {success: true} }
        end
      end
    end
  end

  def complete_task
    @task = Task.find(params[:completed_task_id].to_i)
    @task.update_attributes(completed: true)
    respond_to do |format|
      format.json { render json: {success: true} }
    end
  end

  def destroy
    @task = Task.find(params[:target_task_id].to_i)
    @task.destroy
    respond_to do |format|
      format.json { render json: {success: true} }
    end
  end
end
