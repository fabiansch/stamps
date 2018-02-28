class StampingsController < ApplicationController
  before_action :set_stamping, only: [:show, :edit, :update, :destroy]

  # GET /stampings
  # GET /stampings.json
  def index
    @stampings = Stamping.all
  end

  # GET /stampings/1
  # GET /stampings/1.json
  def show
  end

  # GET /stampings/new
  def new
    if session[:vending_session_address].nil?
      session[:return_to] ||= request.original_fullpath
      redirect_to vending_session_new_path
    else
    @stamping = Stamping.new
    address = Address.find( session[:vending_session_address] )

    @cards = Card.where(company_id: address.company)
    @users = User.all
    end
  end

  # GET /stampings/1/edit
  def edit
  end

  # POST /stampings
  # POST /stampings.json
  def create
    @stamping = Stamping.new(stamping_params.merge(address_id: session[:vending_session_address]))
    @cards = Card.all
    @users = User.all

    @stamping.vendor = Vendor.where( ["company_id = ? and user_id = ?",
                                        @stamping.card.company,
                                        current_user]).first

    @stamping.count.times do
      Stamp.create( card: @stamping.card,
                    user: @stamping.user,
                    stamping: @stamping )
    end

    respond_to do |format|
      if @stamping.save
        format.html { redirect_to @stamping, notice: 'Stamping was successfully created.' }
        format.json { render :show, status: :created, location: @stamping }
      else
        format.html { render :new }
        format.json { render json: @stamping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stampings/1
  # PATCH/PUT /stampings/1.json
  def update
    respond_to do |format|
      if @stamping.update(stamping_params)
        format.html { redirect_to @stamping, notice: 'Stamping was successfully updated.' }
        format.json { render :show, status: :ok, location: @stamping }
      else
        format.html { render :edit }
        format.json { render json: @stamping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stampings/1
  # DELETE /stampings/1.json
  def destroy
    @stamping.destroy
    respond_to do |format|
      format.html { redirect_to stampings_url, notice: 'Stamping was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stamping
      @stamping = Stamping.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stamping_params
      params.require(:stamping).permit(:count, :card_id, :user_id)
    end
end
