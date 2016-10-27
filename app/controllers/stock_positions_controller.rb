class StockPositionsController < ApplicationController
  before_action :set_stock_position, only: [:show, :edit, :update, :destroy]

  # GET /stock_positions
  # GET /stock_positions.json
  def index
    @stock_positions = StockPosition.all
  end

  # GET /stock_positions/1
  # GET /stock_positions/1.json
  def show
  end

  # GET /stock_positions/new
  def new
    @stock_position = StockPosition.new
  end

  # GET /stock_positions/1/edit
  def edit
  end

  # POST /stock_positions
  # POST /stock_positions.json
  def create
    @stock_position = StockPosition.new(stock_position_params)

    respond_to do |format|
      if @stock_position.save
        format.html { redirect_to @stock_position, notice: 'Stock position was successfully created.' }
        format.json { render :show, status: :created, location: @stock_position }
      else
        format.html { render :new }
        format.json { render json: @stock_position.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stock_positions/1
  # PATCH/PUT /stock_positions/1.json
  def update
    respond_to do |format|
      if @stock_position.update(stock_position_params)
        format.html { redirect_to @stock_position, notice: 'Stock position was successfully updated.' }
        format.json { render :show, status: :ok, location: @stock_position }
      else
        format.html { render :edit }
        format.json { render json: @stock_position.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stock_positions/1
  # DELETE /stock_positions/1.json
  def destroy
    @stock_position.destroy
    respond_to do |format|
      format.html { redirect_to stock_positions_url, notice: 'Stock position was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock_position
      @stock_position = StockPosition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_position_params
      params.require(:stock_position).permit(:symbol, :qty, :purchase_date, :purchase_price, :commission, :current_price, :last_updated)
    end
end
