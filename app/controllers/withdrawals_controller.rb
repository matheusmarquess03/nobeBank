# frozen_string_literal: true

class WithdrawalsController < ApplicationController
  before_action :authenticate_user!
  def new
    @withdraw = Transfer.new
  end

  def create
    if current_user.valid_password?(withdraw_params[:password])
      set_withdraw_service
      respond_to do |format|
        if @withdraw_service.call?
          format.html { redirect_to root_path, notice: 'Saque realizado com sucesso.' }
        else
          format.html { render :new, notice: 'Ocorreu um erro com seu saque.' }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to new_withdrawal_path, notice: 'Senha Incorreta.' }
      end
    end
  end

  private

  def set_withdraw_service
    @withdraw_service = Withdraw.new(
      value: withdraw_params[:value],
      recipient: current_user.account
    )
  end

  def withdraw_params
    params.require(:transfer).permit(:value, :password)
  end
end
