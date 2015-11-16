class Account::TasksController < Account::ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      redirect_to account_root_path
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])

    if @task.update_attributes(task_params)
      redirect_to account_root_path
    else
      render :edit
    end
  end

  def start
    @task = current_user.tasks.find(params[:id])

    if @task.may_start?
      @task.start!
      redirect_to account_root_path
    else
      render :edit
    end
  end

  def finish
    @task = current_user.tasks.find(params[:id])

    if @task.may_finish?
      @task.finish!
      redirect_to account_root_path
    else
      render :edit
    end
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy

    redirect_to account_root_path
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :aasm_state)
  end
end
