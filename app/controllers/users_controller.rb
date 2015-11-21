class UsersController < ApplicationController
  before_action :ensure_logged_in, only: [:show]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    # if current_user
    @user = User.find_by_id(params[:id])
    render :show
  end






  private

  def user_params
    self.params.require(:user).permit(:user_name, :password)
  end

end
