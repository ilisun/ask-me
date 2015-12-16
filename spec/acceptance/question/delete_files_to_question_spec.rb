require_relative '../acceptance_helper'

feature 'Delete files to question', %q{
  In order to illustrate my question
  As an question's author
  I'd like to be able to detach files
} do

  given(:user) { create(:user) }
  given(:question) {create(:question, user: user)}
  given!(:attachment) {create(:attachment, attachmentable: question)}

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User can delete a file from the question', js: true do
    within '.question' do
      expect(page).to have_content attachment.file.identifier
      expect(page).to have_link '×', href: attachment_path(attachment)
      click_link '×'
    end

    expect(current_path).to eq question_path(question)
    expect(page).to_not have_content attachment.file.identifier
    expect(page).to have_content 'Your attachment is successfully deleted.'
  end
end