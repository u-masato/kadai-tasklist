class TasksController < ApplicationController
    
    def index
        @tasks = Task.all
    end
    
    def show
        @task = Task.find(params[:id])
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
        @task = Task.find(params[:id])
    end

    def update
        @task = Task.find(params[:id])
        if @task.update(safe_task)
            flash[:success] = 'タスクの更新に成功しました'
            redirect_to @task
        else
            flash.now[:danger] = 'タスクの更新に失敗しました'
            render :edit
        end
    end
    
    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        
        flash[:success] = 'タスクの削除に成功しました'
        redirect_to tasks_url
    end
    
    private
    
    def safe_task
        params.require(:task).permit(:content)
    end

end
