require_relative '../acceptance_helper'

feature 'Delete files to answer', %q{
  In order to illustrate my answer
  As an answer's author
  I'd like to be able to detach files
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) {create(:answer, question: question, user: user)}
  given!(:attachment) {create(:attachment, attachmentable: answer)}
  given(:another_user) {create(:user)}

  scenario 'User can delete a file from the answer', js: true do
    sign_in(user)
    visit question_path(question)

    within '.answers' do
      expect(page).to have_content attachment.file.identifier
      expect(page).to have_link '×', href: attachment_path(attachment)
      click_link '×'
    end

    expect(current_path).to eq question_path(question)
    expect(page).to_not have_content attachment.file.identifier
    expect(page).to have_content 'Your attachment is successfully deleted.'
  end

  scenario 'Not the author, dont want to delete a file from the answer', js: true do
    sign_in(another_user)
    visit question_path(question)

    within '.answers' do
      expect(page).to have_content attachment.file.identifier
      expect(page).to_not have_link '×', href: attachment_path(attachment)
    end
  end

end