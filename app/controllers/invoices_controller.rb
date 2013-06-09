class InvoicesController < ApplicationController

  before_filter :load_invoice, only: [:show, :update]

  respond_to :html, :json

  def index
    respond_with(Invoice.all)
  end

  def show
    respond_with(@invoice)
  end

  def update
    @invoice.update_attribute(:stripe_token, params[:invoice][:stripe_token].to_s)

    render json: { invoice: @invoice }.to_json
  end

  private

  def load_invoice
    @invoice = Invoice.where(token: params[:id].to_s).first
  end
end
