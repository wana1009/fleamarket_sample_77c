class UsersController < ApplicationController
  before_action :move_to_index, only: [:show]
  before_action :move_to_mypage, only: [:show]

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @nickname = current_user.nickname
    @user_items_count = Item.where(seller_id: current_user.id).length
  end


  private

  # ログインしていない時にマイページに入れないように制限
  def move_to_index
    redirect_to root_path unless user_signed_in?
  end

  # ログイン後、ユーザーIDが異なる場合と、@userが空の時にログインユーザーのマイページに移動させる
  def move_to_mypage
    @user = User.find(params[:id])
    redirect_to user_path(current_user) if current_user.id != @user.id
    redirect_to user_path(current_user) if @user = nil
  end

  def user_params
    params.require(:user).permit(:nickname, :email, :first_name, :last_name, :first_kana, :last_kana, :birthday)
    
  end  
end
