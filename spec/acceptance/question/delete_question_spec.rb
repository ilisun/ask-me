require_relative '../acceptance_helper'

feature 'Delete question', %q{
   As authenticated user
   I want to be able to delete my question
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
        expect(page).to have_link('delete', href: "/questions/#{question.id}")
      end
    end

    scenario 'Author of question want to be delete question' do
      within '#question-link' do
        click_link ('delete'), href: "/questions/#{question.id}"
      end
      expect(current_path).to eq questions_path
      expect(page).not_to have_content question.title
      expect(page).to have_content 'Your question is successfully deleted'
    end

  end

  scenario 'Not the author, dont want to be delete question' do
    sign_in(another_user)
    visit question_path(question)
    within '#question-link' do
      expect(page).not_to have_link('delete', href: "/questions/#{question.id}")
    end
  end

end