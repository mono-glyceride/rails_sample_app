class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)    # 実装は終わっていないことに注意!
    if @user.save
      # 保存の成功をここで扱う。
      log_in @user
      #同時にログイン
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      #等価　redirect_to user_url(@user)
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # 更新に成功した場合を扱う。
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
  
  
  # beforeアクション

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
