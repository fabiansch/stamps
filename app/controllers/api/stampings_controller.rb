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
    stamping.save

    if stamping.count < 0
      stamps_to_delete_count = stamping.count.abs * stamping.card.stamps_count
      stamps = Stamp.where([ "card_id = ? and user_id = ?",
                             stamping.card_id,
                             stamping.user_id])
      if stamps.count >= stamps_to_delete_count
        stamps.order(:created_at)
              .last(stamps_to_delete_count)
              .each do |s|
          s.destroy
        end
      else
        render json: { error: "You want to delete #{stamping.count.abs} cards, \
                               but user has only #{stamps.count} stamps." },
               status: :bad_request
      end
    else
      stamping.count.times do
        Stamp.create( card: stamping.card,
                      user: stamping.user,
                      stamping: stamping )
      end
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
