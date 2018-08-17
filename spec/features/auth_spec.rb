require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do

  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content('New User')
  end


  feature 'signing up a user' do
    let!(:user) { create :user }
    scenario 'shows username on the homepage after signup' do
      log_in(user)
      expect(page).to have_content(user.username)
    end
  end
end

feature 'logging in' do
  let!(:user) { create :user }

  scenario 'shows username on the homepage after login' do
    log_in(user)
    visit user_url(user)
    expect(page).to have_content(user.username)
  end

end

feature 'logging out' do
  let!(:user) { create :user }
  scenario 'begins with a logged out state' do
    # debugger
    # expect(user.logged_in?).to_return(false)
    visit new_session_url
    expect(page).to have_no_content(user.username)
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    visit new_session_url
    expect(page).to have_no_content(user.username)
  end

end
