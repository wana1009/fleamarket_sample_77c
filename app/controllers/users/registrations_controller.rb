# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end

    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @address = @user.build_address
    render :new_address
  end

  def new_address
  end

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = Address.new(address_params)
    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end
    @user.build_address(@address.attributes)
    @user.save
    sign_in(:user, @user)
    redirect_to root_path
  end


  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys:
                              [:nickname,  :birthday, :first_name,
                               :last_name, :first_kana, :last_kana])
  end

  def address_params
    params.require(:address).permit(:first_name, :last_name, :first_kana,
                                    :last_kana, :postal_code, :prefecture,
                                    :prefecture_id, :town, :house_number, :building_name,
                                    :phone_number)
  end
end