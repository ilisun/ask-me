require_relative '../acceptance_helper'

feature 'Delete comment', %q{
  As an authenticated user
  I want to be able to delete comment of answer or question
} do

  given(:user) {create(:user)}
  given!(:question) {create(:question, user: user)}
  given!(:answer) {create(:answer, question: question, user: user)}
  given!(:comment) { create(:comment, commentable: answer, user: user) }

  scenario 'Authenticated author delete comment', js: true do
    sign_in user
    visit question_path(question)
    within '.comment' do
      expect(page).to have_link('delete', href: "/comments/#{comment.id}")
      click_link ('delete'), href: "/comments/#{comment.id}"
    end
    expect(page).to_not have_content comment.body
  end

  scenario 'Non-authenticated user tries to delete comment' do
    visit question_path(question)
    expect(page).not_to have_link('delete', href: "/comments/#{comment.id}")
  end

end