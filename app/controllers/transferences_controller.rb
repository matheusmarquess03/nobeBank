# frozen_string_literal: true

class TransferencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipient, only: [:create]

  def new
    @transference = Transfer.new
  end

  def create
    if current_user.valid_password?(transference_params[:password])
      @transference_service = Transference.new(
        value: transference_params[:value],
        sender: current_user.account,
        recipient: @recipient
      )
      respond_to do |format|
        if @transference_service.call?
          format.html { redirect_to root_path, notice: 'TranferĂȘncia realizada com sucesso.' }
        else
          format.html { redirect_to new_transference_path, notice: 'Houve um erro ao realizar a transferĂȘncia.' }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to new_transference_path, notice: 'Senha Incorreta' }
      end
    end
  end

  private

  def transference_params
    params.require(:transfer)
          .permit(
            :value,
            :recipient,
            :password
          )
  end

  def set_recipient
    @recipient = BankAccountQuery.find_account_by_number(transference_params[:recipient])
  end
end
