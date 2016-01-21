require_relative '../acceptance_helper'

feature 'Edit profileuser', %q{
  I want to be edit my profile
} do

  given(:user) { create(:user) }
  given(:another_user) { create(:user) }

  describe 'Authenticated user as the owner of the profile' do

    before do
      sign_in(user)
      visit user_path(user)
    end

    scenario 'The owner of the profile sees edit link for profile' do
      expect(page).to have_link('Edit profile')
    end

    scenario 'The owner of the profile want to be edit profile' do
      click_on 'Edit profile'

      fill_in 'Name', with: "New Name"
      fill_in 'Email', with: "new_email@email.ru"
      click_on 'Update Profile'

      expect(current_path).to eq user_path(user)
      expect(page).to have_content 'New Name'
      expect(page).to have_content 'new_email@email.ru'
    end

  end

  scenario 'Not the owner, dont want to be edit profile' do
    sign_in(another_user)
    visit user_path(user)
    expect(page).not_to have_link('Edit profile')

    visit edit_user_path(user)
    expect(page).to have_content 'You are not authorized to access this page'
  end

end