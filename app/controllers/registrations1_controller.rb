class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :photo, :twitter, :facebook, :instagram, :youtube, :custom_link, :bank_num, :bank_routting,  :password, :password_confirmation, :current_password)
  end
end
