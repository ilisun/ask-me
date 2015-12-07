require 'rails_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an authenticated user
  I want to be able to ask the question
} do

  given(:user) { create(:user) }
  # also: User.create!(email: 'user@user.com', password: '12345678')

  scenario 'Authenticated user create the question' do
    sign_in(user)

    create_question

    expect(page).to have_content 'Your question successfully created.'
  end

  scenario 'Authenticated user create invalid question' do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: ' '
    click_on 'Create'

    expect(page).to have_content 'Your question is incorrect.'
  end

  scenario 'Non-authenticated user try to create question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end