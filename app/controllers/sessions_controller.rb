class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
    # if user && user.authenticate(params[:session][:password])　と同義
      #ユーザーがデータベースにあり、かつ、認証に成功した
      log_in user
      #ユーザーのセッションを永続的にする
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      #params[:session][:remember_me] はチェックボックスがオンで'1'になる
      redirect_to user
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
    else
      flash.now[:danger] = 'Invalid email/password combination' 
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
end
