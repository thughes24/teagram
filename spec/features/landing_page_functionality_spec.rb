require 'spec_helper'

feature "Render Log-in and Sign-up forms when respective buttons pressed" do
  scenario "log-in button pressed" do
    visit '/'
    click_link "Log In"
    expect(page).to have_no_text("Email")
  end
  scenario "sign-up button pressed" do
    visit '/'
    click_link "Sign Up"
    expect(page).to have_text("Username")
  end
end