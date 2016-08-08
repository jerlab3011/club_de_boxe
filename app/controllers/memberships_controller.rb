class MembershipsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :index]
  before_action :admin_user,     only: [:create, :destroy, :index]
  

  def create
    @user = User.find(params[:user_id])
    @membership = @user.memberships.build(membership_params)
    if @membership.save
      flash[:success] = "Abonnement créé!"
      @membership.update_column("created_by", current_user.id)
      @user.update_column("total", @user.total + @membership.reload.price)
      redirect_to @user
    else
      redirect_to @user
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
    @user = User.find(@membership.user_id)
    @user.update_column("total", @user.total - @membership.price)
    @membership.destroy
    flash[:success] = "Abonnement supprimé"
    redirect_to user_path(@user)
  end
  
  def active
    @memberships = Membership.where("end_date > ? AND start_date <= ?", Date.today, Date.today).paginate(page: params[:page])
  end
  
  private

    def membership_params
      params.require(:membership).permit(:description, :duration, :start_date)
    end
end