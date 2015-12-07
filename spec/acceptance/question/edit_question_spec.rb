require 'rails_helper'

feature 'Edit question', %q{
  As an author of question
  I want to be edit my question
} do

  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given(:question) {create(:question, user: user)}

  describe 'Authenticated user as author of question' do

    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'Author of question sees edit link for question' do
      within '#question-link' do
        expect(page).to have_link('edit')
      end
    end

    scenario 'Author of question want to be edit question' do
      within '#question-link' do
        click_on 'edit'
      end
      fill_in 'Title', with: "New title for question"
      fill_in 'Body', with: "New body for question"
      click_on 'Save'
      expect(current_path).to eq question_path(question)
      expect(page).to have_content 'Your question successfully fixed.'
      expect(page).to have_content 'New title for question'
      expect(page).to have_content 'New body for question'
    end

  end

  scenario 'Not the author, dont want to be edit question' do
    sign_in(another_user)
    visit question_path(question)
    within '#question-link' do
      expect(page).not_to have_link('edit')
    end
    visit edit_question_path(question)
    expect(page).to have_content 'You are not the author of this question!'
  end

end