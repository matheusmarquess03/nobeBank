class DepositsController < ApplicationController
  before_action :authenticate_user!
  def new
    @deposit = Transfer.new
  end

  def create
    deposit_service = Deposit.new(
      value: deposit_params[:value],
      recipient: current_user.account,
    )
    respond_to do |format|
      if deposit_service.call?
        format.html { redirect_to root_path, notice: "Deposito realizado com sucesso." }
      else
        format.html { render :new, notice: "Ocorreu um erro com seu depósito." }
      end
    end
  end

  def deposit_params
    params.require(:transfer).permit(:value)
  end
end
