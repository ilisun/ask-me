require_relative '../acceptance_helper'

feature 'Add vote to answer', %q{
  In order to vote for answer
  As authenticated user
  I'd like to be able to vote for or against answer
} do

  given(:user) {create(:user)}
  given(:question) {create(:question)}
  given!(:answer) {create(:answer, question: question)}

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'sees vote links' do
      within '.vote.vote-answer' do
        expect(page).to have_link('', href: "/answers/#{answer.id}/vote_up?class=Answer")
        expect(page).to have_link('', href: "/answers/#{answer.id}/vote_down?class=Answer")
        expect(page).to have_selector("#vote-answer-#{answer.id}")
      end
    end

    scenario 'tries to vote for answer', js: true do
      within '.vote.vote-answer' do
        find(:xpath, "//a[@href='/answers/#{answer.id}/vote_up?class=Answer']").trigger("click")
        within "#vote-answer-#{answer.id}" do
          expect(page).to have_selector 'span', text: "1"
        end

        find(:xpath, "//a[@href='/answers/#{answer.id}/vote_down?class=Answer']").trigger("click")
        within "#vote-answer-#{answer.id}" do
          expect(page).to have_selector 'span', text: "-1"
        end
      end
    end

    scenario 'can vote only once', js: true do
      within '.vote.vote-answer' do
        find(:xpath, "//a[@href='/answers/#{answer.id}/vote_down?class=Answer']").trigger("click")
        find(:xpath, "//a[@href='/answers/#{answer.id}/vote_down?class=Answer']").trigger("click")
        within "#vote-answer-#{answer.id}" do
          expect(page).to have_selector 'span', text: "-1"
        end
      end
    end

  end

  scenario "Unauthenticated user sees vote sum", js: true do
    visit question_path(question)

    within '.vote.vote-answer' do
      expect(page).to have_selector("#vote-answer-#{answer.id}")
    end
  end

  scenario "Unauthenticated user can not vote for answer", js: true do
    visit question_path(question)

    find(:xpath, "//a[@href='/answers/#{answer.id}/vote_up?class=Answer']").trigger("click")
    # expect(page).to have_content 'You need to sign in or sign up before continuing.'
    within "#vote-answer-#{answer.id}" do
      expect(page).to have_selector 'span', text: "0"
    end
  end

end