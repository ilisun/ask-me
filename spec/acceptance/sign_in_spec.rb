require 'rails_helper'

feature 'Siging in', %q{
  In order to be able ask questions
  As an user
  I want be able to sign in
 } do

  # given(:user) { create(:user) }

  scenario 'Existing user try to sign in' do
    # sign_in(user)

    User.create!(email: 'user@user.com', password: '12345678')
    visit new_user_session_path
    fill_in 'Email', with: 'user@user.com'
    fill_in 'Password', with: '12345678'
    # save_and_open_page
    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Non-existing user try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@user.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'Invalid email or password.'
    expect(current_path).to eq new_user_session_path

  end
end