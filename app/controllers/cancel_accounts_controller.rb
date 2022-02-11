class CancelAccountsController < ApplicationController
  before_action :set_account, only: [:close_account]
    def close_account
      @account = current_user.account
      if @account.active == true
        @account.update(active: false)
      else
        @account.update(active: true)
      end
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Conta encerrada com sucesso' }
        format.json { head :no_content }
      end
    end

  private
  def set_account
    @account = current_user.account
  end
end
