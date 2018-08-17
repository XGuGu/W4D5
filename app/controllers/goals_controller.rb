class GoalsController < ApplicationController
  helper_method :current_user_goal

  def index
    @goals = Goal.all
    render :index
  end
  # 
  # def show
  #   @goal = Goal.find(params[:id])
  #   render :show
  # end

  def new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)

    if @goal.save
      redirect_to goals_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    @goal = Goal.find(params[:id])

    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to goals_url
  end

  def current_user_goal
    @goal = Goal.find(params[:id])
    current_user.id == @goal.user_id
  end

  private

  def goal_params
    params.require(:goal).permit(:user_id, :title, :body, :public, :complete)
  end


end
