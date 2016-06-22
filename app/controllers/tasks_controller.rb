class TasksController < ApplicationController
  skip_before_action :authorize, only: [:sort]

  def index
    @tasks = current_user.tasks.where(completed: false)
  end

  def create
    @task = Task.new(name: params[:name],
                     description: params[:description],
                     completed: false,
                     user_id: current_user.id,
                     priority: current_user.largest_priority_number + 1 )

    if @task.save
      @tasks = current_user.tasks.where(completed: false)
      partial = render_to_string(partial: 'tasks/task_list')
      respond_to do |format|
        format.json { render json: {success: true, partial: partial} }
      end
    end

  end

  def complete_task
    @task = Task.find(params[:completed_task_id].to_i)
    @task.update_attributes(completed: true,
                            priority: nil,
                            completion_date: Date.today)
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

  def sort
    params[:order].each do |key,value|
      Task.find(value[:id]).update_attribute(:priority,value[:position])
    end
    render :nothing => true
  end
end
