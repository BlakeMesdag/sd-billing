class InvoicesController < ApplicationController

  before_filter :load_invoice, only: [:show, :update]
  before_filter :ensure_user_logged_in, unless: :showing_invoice?, only: [:index, :create]

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

  def create
    @invoice = Invoice.create(invoice_params)

    render json: { invoice: @invoice }.to_json
  end

  private

  def load_invoice
    @invoice = Invoice.where(token: params[:id].to_s).first
  end

  def showing_invoice?
    params[:all] =~ /^invoices\/[aA-zZ0-9]+$/
  end

  def ensure_user_logged_in
    redirect_to '/login' unless session[:active]
  end

  def invoice_params
    params.require(:invoice).permit(:name, :email, :description, :amount)
  end
end
