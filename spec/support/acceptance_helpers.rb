module AcceptanceHelper

  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  def create_question
    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'
    click_on 'Create'
  end

  def create_answer(question)
    visit question_path(question)
    fill_in 'answer[body]', with: 'My answer My answer'
    click_on 'Create'
  end

end