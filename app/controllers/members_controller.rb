class MembersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user,   only: [:show, :edit, :update]
  before_action :admin_user,     only: [:index, :destroy]

  def index
    if params[:search]
      @members = Member.search(params[:search]).paginate(page: params[:page])
    else  
      @members = Member.paginate(page: params[:page])
    end
  end
  
  def show
    @member = Member.find(params[:id])
    @user = User.find(@member.user_id)
    @memberships = @member.memberships.paginate(page: params[:page])
    @membership = @member.memberships.build
  end

  def create
    @user = User.find(params[:user_id])
    @member = @user.members.build(member_params)
    if @member.save
      flash[:info] = "Nouveau membre créé."
      redirect_to @user
    else
      redirect_to @user
    end
  end
  
  def edit
    @member = Member.find(params[:id])
  end
  
  def update
    @member = Member.find(params[:id])
    if @member.update_attributes(member_params)
      flash[:success] = "Profil du membre sauvegardé"
      redirect_to @member
    else
      render 'edit'
    end
  end
  
  def destroy
    Member.find(params[:id]).destroy
    flash[:success] = "Membre supprimé"
    redirect_to users_url
  end

  private

    def member_params
      params.require(:member).permit(:last_name, :first_name, :address, :postal_code, :phone,
      :gender, :birth_date, :search)
    end
    

    def correct_user
      @member = Member.find(params[:id])
      @user = User.find(@member.user_id)
      redirect_to(root_url) unless (current_user?(@user) || current_user.admin?)
    end
    
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
