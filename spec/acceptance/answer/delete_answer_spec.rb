require_relative '../acceptance_helper'

feature 'Delete answer', %q{
   In order to hide answer from community
   As authenticated user
   I want to be able to delete my answer
} do

  given(:user) {create(:user)}
  given!(:question) {create(:question, user: user)}
  given!(:answer) {create(:answer, question: question, user: user)}
  given(:another_user) {create(:user)}

  scenario 'Authenticated user deletes your answer', js: true do
    sign_in(user)
    visit question_path(question)

    expect(page).to have_link('delete', href: "/questions/#{question.id}/answers/#{answer.id}")

    within '.answers' do
      click_link ('delete'), href: "/questions/#{question.id}/answers/#{answer.id}"
      page.driver.browser.accept_js_confirms

      expect(page).not_to have_content answer.body
      expect(page).not_to have_selector('h2', text: "Answers")
    end

    expect(current_path).to eq question_path(question)
  end

  scenario 'Another authenticated user tries to delete answer' do
    sign_in(another_user)
    visit question_path(question)

    expect(page).not_to have_link('delete', href: "/questions/#{question.id}/answers/#{answer.id}")
  end

  scenario 'Non-authenticated user tries to delete answer' do
    visit question_path(question)
    expect(page).not_to have_link('delete', href: "/questions/#{question.id}/answers/#{answer.id}")
  end

end