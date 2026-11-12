class RoomsController < ApplicationController

  def index
    if params[:keyword].present?
      @rooms = Room.where("address LIKE ?", "%#{params[:keyword]}%")
    else
      @rooms = current_user.rooms
    end
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.new(room_params)

    if @room.save
      redirect_to @room, notice: "施設が作成されました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    
    if @room.update(room_params)
      redirect_to @room, notice: "施設情報が更新されました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy 

    redirect_to rooms_path, notice: "施設が削除されました。"
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :price, :address, :image)
  end
end
