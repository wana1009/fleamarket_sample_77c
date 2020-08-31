class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def new
    super
  end

  def create
    @user = User.new(sign_up_params)
    if @user.invalid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end

    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @address = @user.build_address
    render :new_address
  end

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = Address.new(address_params)
    if @address.invalid?
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end

    @user.build_address(@address.attributes)
    @user.save
    session["devise.regist_data"]["user"].clear
    sign_in(:user, @user)
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  def address_params
    params.require(:address).permit(:first_name, :last_name, :first_kana, :last_kana, :postal_code, :town, :house_number, :building_name, :phone_number)
  end


end