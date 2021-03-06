class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user,   only: [:show, :edit, :update]
  before_action :admin_user,     only: [:index, :destroy]

  def index
    if params[:search]
      @users = User.search(params[:search]).paginate(page: params[:page])
    else  
      @users = User.paginate(page: params[:page])
    end
    @all_users = User.all
    respond_to do |format|
      format.html
      format.csv { send_data @all_users.to_csv }
    end
      
  end

  def show
    @user = User.find(params[:id])
    @members = @user.members.paginate(page: params[:page])
    @member = @user.members.build
    @payments = @user.payments.paginate(page: params[:page])
    @payment = @user.payments.build
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Svp veuillez vérifier vos courriels pour activer votre compte. Cela peut prendre quelques minutes."
      @user.create_user_member
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profil sauvegardé"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Compte supprimé"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:last_name, :first_name, :email, :address, :postal_code, :phone,
      :gender, :birth_date, :password, :password_confirmation, :search)
    end
    

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless (current_user?(@user) || current_user.admin?)
    end
    
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
