class TransferencesController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_recipient, only: [:create]

  def new
    @transference = Transfer.new
  end

  def create
    transference_service = Transference.new(
      value: transference_params[:value],
      sender: current_user.account,
      recipient: @recipient,
    )
    respond_to do |format|
      if transference_service.call?
        format.html { redirect_to root_path, notice: "Transferência realizada com sucesso." }
      else
        format.html { render :new, notice: "Ocorreu um erro com a transferência ." }
      end
    end
  end

  private

  def transference_params
    params.require(:transfer)
      .permit(
        :value,
        :recipient
      )
  end

  def set_recipient
    @recipient = BankAccountQuery.find_account_by_number(transference_params[:recipient])
  end
end
