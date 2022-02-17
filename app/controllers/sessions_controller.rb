class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #ユーザーがデータベースにあり、かつ、認証に成功した
      log_in user
      redirect_to user
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
    else
      flash.now[:danger] = 'Invalid email/password combination' 
      render 'new'
    end
  end
  
  def destroy
  end
  
end
