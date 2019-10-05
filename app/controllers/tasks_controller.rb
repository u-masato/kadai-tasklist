class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    before_action :check_user, only: [:show, :edit, :update, :destroy]
    
    def index
      if logged_in?
        @tasks = current_user.tasks
      else
        redirect_to login_path
      end
    end
    
    def show
    end

    def new
        @task = Task.new
    end

    def create
        # @task = Task.new(safe_task)
        # @task.user = current_user
        @task = current_user.tasks.build(safe_task)
        if @task.save
            flash[:success] = 'タスク登録に成功しました'
            redirect_to @task
        else
            flash.now[:danger] = 'タスク登録に失敗しました'
            render :new
        end
    end
    
    def edit
    end

    def update
        if @task.update(safe_task)
            flash[:success] = 'タスクの更新に成功しました'
            redirect_to @task
        else
            flash.now[:danger] = 'タスクの更新に失敗しました'
            render :edit
        end
    end
    
    def destroy
        @task.destroy
        
        flash[:success] = 'タスクの削除に成功しました'
        redirect_to tasks_url
    end
    
    private
    
    def safe_task
        p "#"*20
        p params.require(:task).permit(:content, :status)
        p "#"*20
        binding.pry
        params.require(:task).permit(:content, :status)
    end
    
    def check_user
      redirect_to root_url if @task.blank? || current_user.blank? || @task.user != current_user
    end
    
    def set_task
        @task = Task.find_by(id: params[:id])
    end

end
