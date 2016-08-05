class MembershipsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @membership = current_user.memberships.build(membership_params)
    @user = current_user
    if @membership.save
      flash[:success] = "Abonnement créé!"
      current_user.update_column("total", current_user.total + @membership.reload.price)
      redirect_to current_user
    else
      redirect_to @user
    end
  end

  def destroy
  end
  
  private

    def membership_params
      params.require(:membership).permit(:description, :duration, :start_date)
    end
end