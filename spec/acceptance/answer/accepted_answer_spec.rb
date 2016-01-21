require_relative '../acceptance_helper'

feature 'Accepted answer', %q{
  In order to accepted or unaccepted answer
  As author question
} do

  given(:user) {create(:user)}
  given(:another_user) {create(:user)}
  given!(:question) {create(:question, user: user)}
  given!(:answer) {create(:answer, question: question, user: user)}
  given!(:accepted_answer) {create(:answer, question: question, user: user, accepted: true)}

  context 'Authenticated user and author question' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'i sees accepted link and can accepted answer', js: true do
      within "#accepted-#{answer.id}" do
        expect(page).to have_link('', href: "/answers/#{answer.id}/accepted")
        find(:xpath, "//a[@href='/answers/#{answer.id}/accepted']").trigger("click")

        expect(page).to have_selector('div.check.accepted')
        expect(page).to have_link('', href: "/answers/#{answer.id}/unaccepted")
        expect(page).not_to have_link('', href: "/answers/#{answer.id}/accepted")
      end
    end

    scenario 'i sees unaccepted link and can unaccepted answer', js: true do
      within "#accepted-#{accepted_answer.id}" do
        expect(page).to have_link('', href: "/answers/#{accepted_answer.id}/unaccepted")
        find(:xpath, "//a[@href='/answers/#{accepted_answer.id}/unaccepted']").trigger("click")

        expect(page).to have_selector('div.check')
        expect(page).to have_link('', href: "/answers/#{accepted_answer.id}/accepted")
        expect(page).not_to have_link('', href: "/answers/#{accepted_answer.id}/unaccepted")
      end
    end
  end

  scenario 'Not author question can not accepted answer' do
    sign_in(another_user)
    visit question_path(question)

    within "#accepted-#{answer.id}" do
      expect(page).not_to have_selector('div.check.accepted')
      expect(page).not_to have_link('', href: "/answers/#{answer.id}/accepted")
      expect(page).not_to have_link('', href: "/answers/#{answer.id}/unaccepted")
    end

    within "#accepted-#{accepted_answer.id}" do
      expect(page).to have_selector('div.check.accepted')
      expect(page).not_to have_link('', href: "/answers/#{answer.id}/accepted")
      expect(page).not_to have_link('', href: "/answers/#{answer.id}/unaccepted")
    end
  end

end