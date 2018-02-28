class VendingSessionsController < ApplicationController

  def new
    @addresses = Set.new
    current_user.vendors.each do |vendor|
      vendor.company.addresses.each do |address|
        @addresses.add address
      end
    end

    if @addresses.count == 1
      session[:vending_session_address] = @addresses.first.id
      redirect_to session.delete(:return_to)
    end
  end

  def create
    # session[:vending_session_vendor] = vending_session_params.vendor_id
    session[:vending_session_address] = address_id_param
    redirect_to session.delete(:return_to)
  end

  private

    def address_id_param
      params.require(:address_id)
    end

end
