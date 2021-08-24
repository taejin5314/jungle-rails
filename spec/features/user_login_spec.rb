require 'rails_helper'

# feature block => describe block
RSpec.feature "Visitor login", type: :feature, js: true do

  
  # SETUP
  before :each do
    @user = User.create! name: "test", email: "toast@google.com", password:"tomato", password_confirmation:"tomato"
  end

  #scenario block => it block
  scenario "They see a page that they are logged in" do
    # ACT
    visit '/login'
    fill_in 'email', with: 'toast@google.com'
    fill_in 'password', with: 'tomato'

    click_on 'Submit'

    # DEBUG
    # sleep(2)
    # save_screenshot

    # VERIFY
    expect(page).to have_content 'Signed in as test'
  end

end