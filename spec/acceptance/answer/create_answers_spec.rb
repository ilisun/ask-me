require 'rails_helper'

feature 'User answer', %q{
  In order to exchange my knowledge
  As an authenticated user
  I want to be able to create answers
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user create answer' do
    sign_in(user)

    create_answer(question)

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content 'My answer My answer'
    end
  end

  scenario 'Authenticated user tries to create invalid answer' do
    sign_in(user)
    visit question_path(question)
    click_on 'Create'
  end

  scenario 'Non-authenticated user tries to visit question page' do
    create_answer(question)
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end