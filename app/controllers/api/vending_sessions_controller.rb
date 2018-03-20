class Api::VendingSessionsController < Api::ApplicationController

  def new
    addresses = Set.new
    current_user.vendors.each do |vendor|
      vendor.company.addresses.each do |address|
        addresses.add({company_name: address.company.name, address: address})
      end
    end

    respond_with addresses
  end

end
