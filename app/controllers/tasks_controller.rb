class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    
    def index
        @tasks = Task.all
    end
    
    def show
    end

    def new
        @task = Task.new
    end

    def create
        @task = Task.new(safe_task)
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
        params.require(:task).permit(:content, :status)
    end
    
    def set_task
        @task = Task.find(params[:id])
    end

end
