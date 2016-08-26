class MembershipsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :index]
  before_action :admin_user,     only: [:create, :destroy, :index]
  

  def create
    @member = Member.find(params[:member_id])
    @user = User.find(@member.user_id)
    @membership = @member.memberships.build(membership_params)
    if @membership.save
      flash[:success] = "Abonnement créé!"
      @membership.update_column("created_by", current_user.id)
      @user.update_column("total", @user.total + @membership.reload.price)
      redirect_to @user
    else
      redirect_to @member
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
    @member = Member.find(@membership.member_id)
    @user = User.find(@member.user_id)
    @user.update_column("total", @user.total - @membership.price)
    @membership.destroy
    flash[:success] = "Abonnement supprimé"
    redirect_to user_path(@user)
  end
  
  def active
    @memberships = Membership.where("end_date > ? AND start_date <= ?", Date.today, Date.today)
    @memberships = @memberships.sort_by {|member| member.user.last_name}
  end
  
  private

    def membership_params
      params.require(:membership).permit(:description, :duration, :start_date)
    end
end