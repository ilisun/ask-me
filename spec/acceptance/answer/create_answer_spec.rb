require_relative '../acceptance_helper'

feature 'User answer', %q{
  In order to exchange my knowledge
  As an authenticated user
  I want to be able to create answers
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user create answer', js: true do
    sign_in(user)
    visit question_path(question)
    create_answer(question)

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content 'My answer My answer'
    end
  end

  scenario 'Authenticated user tries to create invalid answer', js: true do
    sign_in(user)
    visit question_path(question)
    fill_in 'answer[body]', with: 'body'
    click_on 'Create'
    expect(page).to have_content "ERROR: Body is too short (minimum is 10 characters)"
  end

  scenario 'Non-authenticated user tries to visit question page' do
    create_answer(question)

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end