class PaymentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :admin_user,     only: [:create, :destroy]
  
  def create
    @user = User.find(params[:user_id])
    @payment = @user.payments.build(payment_params)
    if @payment.save
      flash[:success] = "Paiment enregistré!"
      @payment.update_column("created_by", current_user.id)
      @user.update_column("total", @user.total - @payment.amount)
      redirect_to @user
    else
      redirect_to @user
    end
  end

  def destroy
    @payment = Payment.find(params[:id])
    @user = User.find(@payment.user_id)
    @user.update_column("total", @user.total + @payment.amount)
    @payment.destroy
    flash[:success] = "Paiement supprimé"
    redirect_to user_path(@user)
  end
  
  private

    def payment_params
      params.require(:payment).permit(:description, :amount)
    end
end