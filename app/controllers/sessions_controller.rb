class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)               # paramsハッシュで受け取ったemail値を小文字化し、email属性に渡してUserモデルから同じemailの値のUserを探して、user変数に代入
    if user && user.authenticate(params[:session][:password])  
      
      log_in(user)
      # redirect_to user そのユーザーのページに遷移する
    else
      flash.now[:danger] = "Invalid email/password combination"                 # flashメッセージを表示し、新しいリクエストが発生した時に消す
      render 'new'                                                              # newビューの出力
    end
  end
end
