class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information udpated"
      redirect_to current_user
    else
      flash[:error] = "Invalid user information"
      redirect_to edit_user_registration_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
