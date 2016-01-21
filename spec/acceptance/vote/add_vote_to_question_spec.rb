require_relative '../acceptance_helper'

feature 'Add vote to question', %q{
  In order to vote for question
  As authenticated user
  I'd like to be able to vote for or against question
} do

  given(:user) {create(:user)}
  given(:question) {create(:question)}

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'sees vote links' do
      within '.vote.vote-question' do
        expect(page).to have_link('', href: "/questions/#{question.id}/vote_up?class=Question")
        expect(page).to have_link('', href: "/questions/#{question.id}/vote_down?class=Question")
        expect(page).to have_selector("#vote-question-#{question.id}")
      end
    end

    scenario 'tries to vote for question', js: true do
      within '.vote.vote-question' do
        find(:xpath, "//a[@href='/questions/#{question.id}/vote_up?class=Question']").trigger("click")
        within "#vote-question-#{question.id}" do
          expect(page).to have_selector 'span', text: "1"
        end

        find(:xpath, "//a[@href='/questions/#{question.id}/vote_down?class=Question']").trigger("click")
        within "#vote-question-#{question.id}" do
          expect(page).to have_selector 'span', text: "-1"
        end
      end
    end

    scenario 'can vote only once', js: true do
      within '.vote.vote-question' do
        find(:xpath, "//a[@href='/questions/#{question.id}/vote_down?class=Question']").trigger("click")
        find(:xpath, "//a[@href='/questions/#{question.id}/vote_down?class=Question']").trigger("click")
        within "#vote-question-#{question.id}" do
          expect(page).to have_selector 'span', text: "-1"
        end
      end
    end

  end

  scenario "Unauthenticated user sees vote sum", js: true do
    visit question_path(question)

    within '.vote.vote-question' do
      expect(page).to have_selector("#vote-question-#{question.id}")
    end
  end

  scenario "Unauthenticated user can not vote for question", js: true do
    visit question_path(question)

    find(:xpath, "//a[@href='/questions/#{question.id}/vote_up?class=Question']").trigger("click")
    # expect(page).to have_content 'You need to sign in or sign up before continuing.'
    within "#vote-question-#{question.id}" do
      expect(page).to have_selector 'span', text: "0"
    end
  end

end