require 'rails_helper'

RSpec.describe "Users", type: :system do
  it "ログインしてない状態でトップページにアクセスした場合、サインインページに移動する" do
    #トップページに移動
    visit root_path
    #ログインしてない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq "/users/sign_in"
  end

  it "ログイン成功、トップページに遷移する" do
    #ユーザーをDBに保存
    @user = FactoryBot.create(:user)
    #サインページに移動
    visit new_user_session_path
    #ログインしてない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq("/users/sign_in")
    #保存済みのログイン、パスワードを入力する
    fill_in "session_email", with: @user.email
    fill_in "session_password", with: @user.password
    #ログインボタン押す
    click_on("Log in")
  
    #ログイン後トップページに遷移している
    expect(current_path).to eq root_path
  end

  it "ログイン失敗し、再びサインインページに戻ってくる" do
    #ユーザーを保存
    @user = FactoryBot.create(:user)
    #トップページに遷移
    visit root_path
    #ログインしてない場合、サインインページに遷移していることを確認すr
    expect(current_path).to eq("/users/sign_in")
    #誤った情報を入力
    fill_in "session_email", with: "dsds@com"
    fill_in "session_password", with: "dsds@com"
    #ログインボタンを押す    
    click_on("Log in")
    #サインページに持ってきていることを確認する
    expect(current_path).to eq("/users/sign_in")
  end
end
