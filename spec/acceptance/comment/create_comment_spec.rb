require_relative '../acceptance_helper'

feature 'Create comment', %q{
  As an authenticated user
  I want to be able to create comment of answer or question
} do

  given(:user) {create(:user)}
  given!(:question) {create(:question, user: user)}
  given!(:answer) {create(:answer, question: question, user: user)}

  describe 'Authenticated user' do
    before do
      sign_in user
      visit question_path(question)
    end

    scenario 'Create comment to the question', js: true do
      create_comment_to_question(question)
      within '.question' do
        expect(page).to have_content 'My comment to question'
      end
    end

    scenario 'Create comment to the answer', js: true do
      create_comment_to_answer(answer)
      expect(page).to have_content 'My comment to answer'
    end
  end

  scenario 'Non-authenticated user tries to visit question page' do
    visit question_path(question)
    expect(page).not_to have_link('add comment', href: "/questions/#{question.id}/comments/new")
  end

end