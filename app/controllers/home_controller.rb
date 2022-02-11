# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @accounts = Account.all
  end

  def show
    @account = Account.find_by_id(params[:id])
  end
end
