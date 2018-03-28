class Api::StampingsController < Api::ApplicationController
  before_action :set_stamping, only: [:show, :edit, :update, :destroy]

  # GET /stampings.json
  def index
  end

  # GET /stampings/1.json
  def show
  end

  # GET /stampings/new
  def new
    address_id = new_params[:address_id]

    if address_id.nil?
      puts 'error. no address_id'
    else
      @stamping = Stamping.new
      address = Address.find( address_id )

      @cards = Card.where(company_id: address.company)
      respond_with @cards
    end
  end

  # GET /stampings/1/edit
  def edit
  end

  # POST /stampings.json
  def create
    stamping =  Stamping.new(create_params)

    stamping.vendor = Vendor.where( ["company_id = ? and user_id = ?",
                                        stamping.card.company,
                                        current_user]).first
    if stamping.count == -101
      Stamping.where(["card_id = ? and user_id = ?",
                                        stamping.card_id,
                                        stamping.user_id]).each do |s|
        s.destroy
      end
      return
    end

    stamping.save

    stamping.count.times do
      Stamp.create( card: stamping.card,
                    user: stamping.user,
                    stamping: stamping )
    end
  end

  # PATCH/PUT /stampings/1.json
  def update
  end

  # DELETE /stampings/1.json
  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stamping
      @stamping = Stamping.find(params[:id])
    end

    def new_params
      params.require(:address_id)
      params.permit(:address_id)
    end

    def create_params
      params.require(:count)
      params.require(:card_id)
      params.require(:address_id)
      params.require(:email)
      params.permit(:count, :card_id, :address_id).merge({user_id: User.where(["email = ?", params['email']]).first.id.to_i})
    end
end
