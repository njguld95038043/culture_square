class Public::ChatsController < ApplicationController

  def show
    #相手のEndUser情報を取得。
    @end_user = EndUser.find(params[:id])
    #end_user_roomsテーブルのend_user_idが自分のレコードのroom_idを配列で取得。
    rooms = current_end_user.end_user_rooms.pluck(:room_id)
    #end_user_idが相手(@end_user)で、room_idが自分の属するroom_id（配列）となるend_user_roomsテーブルのレコードを取得して、end_user_room変数に格納。
    #これによって、自分と相手のroom_idが存在していれば、その共通のroom_idと相手のend_user_idがend_user_room変数に格納される（1レコード）。存在しなければ、nilになる。
    end_user_rooms = EndUserRoom.find_by(end_user_id: @end_user.id, room_id: rooms)

    if end_user_rooms.nil?
     @room = Room.new
     @room.save
     EndUserRoom.create(end_user_id: @end_user.id, room_id: @room.id)
     EndUserRoom.create(end_user_id: current_end_user.id, room_id: @room.id)
    else
     @room = end_user_rooms.room
    end

    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_end_user.chats.new(chat_params)
    @chat.save
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

end
