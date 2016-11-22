class UsersController < ApplicationController
  
  def index
    @users = User.all.paginate(page: params[:page])
  end

  def show
    @user = User.find_by_id(params[:id])
    @questions = @user.questions.paginate(page: params[:page])
    @question = @user.questions.build
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      # Handle a successful save.
      sign_in @user
      flash[:success] = "Welcome to the SO App!"
      redirect_to @user
    else
      render new_user_path
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
