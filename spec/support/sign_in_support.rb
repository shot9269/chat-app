module SignInSupport
  def sign_in(user)
    visit root_path
    fill_in "session_password", with: user.password
    fill_in "session_email", with: user.email
    click_on("Log in")
    expect(current_path).to eq root_path
  end

end