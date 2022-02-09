class WithdrawalsController < ApplicationController
  #before_action :authenticate_user!
  def new
    @withdraw = Transfer.new
  end

  def create
    withdraw_service = Withdraw.new(
      value: withdraw_params[:value],
      recipient: current_user.account,
    )
    respond_to do |format|
      if withdraw_service.call?
        format.html { redirect_to root_path, notice: "Saque realizado com sucesso." }
      else
        format.html { render :new, notice: "Ocorreu um erro com seu saque." }
      end
    end
  end

  private

  def withdraw_params
    params.require(:transfer).permit(:value)
  end
end
