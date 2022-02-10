class BankStatementController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
  end

  def create
    @transactions = TransferQuery.find_between_dates(
      initial_date: statement_params[:initial_date],
      final_date: statement_params[:final_date],
      account: current_user.account,
    )
    respond_to do |format|
      if @transactions.any?
        format.html { render :new, notice: "Extrato emitido com sucesso." }
      else
        format.html { render :new, notice: "Houve um erro ao emitir extrato." }
      end
    end
  end

  private

  def statement_params
    params.require(:account).permit(:account_number, :initial_date, :final_date)
  end
end
