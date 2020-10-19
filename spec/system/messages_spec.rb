require 'rails_helper'

RSpec.describe "Messages", type: :system do
 before do
   @room_user = FactoryBot.create(:room_user)
 end

 context "投稿に失敗した時" do
   it "送る値がからのため、メーセージ送信に失敗" do
     #サインインする
     sign_in(@room_user.user)
    #  #作成されたチャットルームへ遷移する
     click_on(@room_user.room.name)
     #DBに保存されていないことを確認す
     expect{
       find('input[name="commit"]').click
     }.not_to change{Message.count}
     #元のページに戻ってくることを確認する
     expect(current_path).to eq room_messages_path(@room_user.room)
   end
  end

  context "投稿に成功した時" do
    it "テキストの投稿に成功すると、投稿一覧に遷移して、投稿した内容が表示される" do
      sign_in(@room_user.user)
      #作成されたチャットルームへ移動
      click_on(@room_user.room.name)
      #値をテキストフォームに入力する
      fill_in "form_id", with: "hello"
      #送信した値がDBに保存されていることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change{Message.count}.by(1)
      #投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq room_messages_path(@room_user.room)
      #送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content("hello")
    end
 

    it "テキストと画像の投稿に成功すること"do
      sign_in(@room_user.user)
      click_on(@room_user.room.name)
      image_path = Rails.root.join("public/images/test_image.jpg")
      #画像選択フォームに画像を添付する
      attach_file('message[image]',image_path, make_visible: true)
      #値をテキストフォームに入力する
      post = "hugahuga"
      fill_in "form_id", with: post
      #送信した値がDBに保存されていることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change{Message.count}.by(1)
      #送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)
      #投稿一覧に遷移している
      expect(current_path).to eq room_messages_path(@room_user.room)
      #送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector("img")
    end
  end
end 
