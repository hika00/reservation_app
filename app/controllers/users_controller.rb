class UsersController < ApplicationController
  before_action :authenticate_user!

  def account
    @user = current_user
  end

  def profile
    @user = current_user
  end

  def edit_profile
    @user = current_user
  end

  def update_profile
    @user = current_user
    if @user.update(user_params)
      redirect_to root_path, notice: "プロフィールを更新しました。"
    else
      render :edit_profile, status: :unprocessable_entity
    end
  end

  def description
    @user = current_user
  end


  private

  def user_params
    params.require(:user).permit(:name, :description, :avatar)
  end
end
