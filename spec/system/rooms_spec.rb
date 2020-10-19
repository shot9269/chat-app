require 'rails_helper'

RSpec.describe "Rooms", type: :system do
  before do
    @room_user = FactoryBot.create(:room_user)
  end

  it "チャットルームが削除されると関連するメッセージが全て削除されること" do
    #サインインする
    sign_in(@room_user.user)
    #作成されたチャットルームへ遷移する
    click_on(@room_user.room.name)
    #メッセージ情報を５つdbに追加

    # fill_in "form_id", with: "hello"
    # expect{
    #   find('input[name="commit"]').click
    # }.to change{Message.count}.by(1)
    # fill_in "form_id", with: "hello"
    # expect{
    #   find('input[name="commit"]').click
    # }.to change{Message.count}.by(1)
    # fill_in "form_id", with: "hello"
    # expect{
    #   find('input[name="commit"]').click
    # }.to change{Message.count}.by(1)
    # fill_in "form_id", with: "hello"
    # expect{
    #   find('input[name="commit"]').click
    # }.to change{Message.count}.by(1)
    # fill_in "form_id", with: "hello"
    # expect{
    #   find('input[name="commit"]').click
    # }.to change{Message.count}.by(1)
    FactoryBot.create_list(:message, 5, room_id: @room_user.room.id, user_id: @room_user.user.id)
    
    #チャットを終了するをクリックすることで、作成したメッセージを全て削除されたか確認する
    expect {
      find_link("チャットを終了する",  href: room_path(@room_user.room)).click
    }.to change { @room_user.room.messages.count }.by(-5)   
     #トップページに遷移していることを確認する
    expect(current_path).to eq root_path
  end
end
