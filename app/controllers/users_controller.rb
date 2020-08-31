class UsersController < ApplicationControllerend
  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :first_name, :last_name, :first_kana, :last_kana, :birthday)
    
  end  
end