class UsersController < ApplicationController
	before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  # ↓コメントアウト
  # before_action :baria_user, only: [:update]

  def show
    # @user = current_user
  	@user = User.find(params[:id])
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
    # @books = @user.books
    @books = @user.books
  end

  def index
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to user_path(@user), notice: "successfully updated user!"
  	else
  		render action: :edit
      # "show"
  	end
  end

  def correct_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  # フォロー・フォロワー一覧の実装
# フォローしている　＝　folloeing,follows
  def follows
    user = User.find(params[:id])
    @users = user.followings
  end
# フォローされている　＝　followers
  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
  # NoMethodError id がでたので下記をコメントアウト
  #  def baria_user
  # 	unless params[:id].to_i == current_user.id
  # 		redirect_to user_path(current_user)
  # 	end
  # end
end
