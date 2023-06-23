class TasksController < ApplicationController
  before_action :logged_in_user
  before_action :set_task, only: %i[ show edit update destroy toggle_completed position ]

  def toggle_completed
    @task.completed = !@task.completed
    @task.remove_from_list
    update_priority
    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path }
        format.json { render :show, status: :ok, location: @task }
      else
        # show some error message
      end
    end
  end

  # GET /tasks or /tasks.json
  def index
    @tasks = current_user.tasks.order(:position)
    @tasks_pending = current_user.tasks.where(:completed => false).order(:position)
    @tasks_completed = current_user.tasks.where(:completed => true).order(:position)
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user = current_user

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    @task.remove_from_list

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def position
    @task.insert_at(params[:position].to_i)
    update_priority
    head :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :details, :priority, :date, :completed, :position)
    end

    def update_priority
      Task.where(completed: false).each do |t|
        t.update(priority: t.position)
      end
    end
end
