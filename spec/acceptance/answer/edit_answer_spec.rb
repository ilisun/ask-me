require 'rails_helper'

feature 'Edit answer', %q{
  As an author of answer
  I want to be edit my answer
} do

  given(:user) {create(:user)}
  given(:question) {create(:question, user: user)}
  given!(:answer) {create(:answer, question: question, user: user)}
  given(:another_user) {create(:user)}

  describe 'Authenticated user as author of answer' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'Author of answer sees edit link for answer' do
      within '#answer-link' do
        expect(page).to have_link('edit')
      end
    end

    scenario 'Author of answer want to be edit answer' do
      within '#answer-link' do
        click_on 'edit'
      end

      fill_in 'Body', with: "New body for answer"
      click_on 'Save'
      expect(current_path).to eq question_path(question)
      expect(page).to have_content 'Your answer successfully fixed.'
      expect(page).to have_content 'New body for answer'
    end
  end

  scenario 'Not the author, dont want to be edit question' do
    sign_in(another_user)
    visit question_path(question)
    within '#answer-link' do
      expect(page).not_to have_link('edit')
    end
    visit edit_question_answer_path(answer.question, answer)
    expect(page).to have_content 'You are not the author of this answer!'
  end

end