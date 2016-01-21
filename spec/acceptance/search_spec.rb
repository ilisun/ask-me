require_relative 'acceptance_helper'
require_relative 'sphinx_helper'

feature 'Search for service', %q{
  In order to find any question or answer with specified conditions
  As any user
  I'd like to be able to search for service
} do
  given(:user) { create(:user) }
  given!(:question) { create(:question, title: "First question", body: "First question Body") }
  given!(:another_question) { create(:question, title: "Second question", body: "Second question Body") }
  given!(:answer) { create(:answer, question: another_question, body: 'Answer for second question')}

  scenario 'User sees search field on the any page', js: true do

    [root_path, question_path(question), new_question_path].each do |path|
      visit path
      within '#searchForm' do
        expect(page).to have_selector '#search'
      end
    end
  end

  scenario 'Search for question', js: true do
    sign_in(user)

    ThinkingSphinx::Test.run do
      visit root_path
      within '#searchForm' do
        fill_in 'search', with: "First"
        click_on 'button_search'
      end
      expect(page).to have_content(question.title)
      expect(page).to have_content(question.body)
      expect(page).not_to have_content(another_question.title)
      expect(page).not_to have_content(answer.body)
    end
  end

  scenario 'Search for answer', js: true do
    sign_in(user)

    ThinkingSphinx::Test.run do
      visit root_path
      within '#searchForm' do
        fill_in 'search', with: "Answer"
        click_on 'button_search'
      end
      expect(page).to have_content(another_question.title)
      expect(page).to have_content(answer.body)
      expect(page).not_to have_content(question.title)
      expect(page).not_to have_content(question.body)
    end
  end

end