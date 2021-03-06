require 'rails_helper'
require_relative 'web_helpers'

RSpec.feature "Liking posts", type: :feature do

  scenario "can like another users photo" do
    sign_up_test_user_1
    post_goat
    expect(find("div#post_0")).to have_text("0 \u2665")
    click_link "Log Out"
    create_test_user_2
    sign_in_test_user_2
    within("div#post_0") do
      click_link "Like"
    end
    expect(find("div#post_0")).to have_text("1 \u2665")
  end

  scenario "can only like a users photo once" do
    sign_up_test_user_1
    post_goat
    expect(find("div#post_0")).to have_text("0 \u2665")
    click_link "Log Out"
    create_test_user_2
    sign_in_test_user_2
    within("div#post_0") do
      click_link "Like"
    end
    expect(find("div#post_0")).not_to have_link("Like")
  end

  scenario "can unlike a users photo" do
    sign_up_test_user_1
    post_goat
    expect(find("div#post_0")).to have_text("0 \u2665")
    click_link "Log Out"
    create_test_user_2
    sign_in_test_user_2
    within("div#post_0") do
      click_link "Like"
    end
    within("div#post_0") do
      click_link "Unlike"
    end
    expect(find("div#post_0")).to have_text("0 \u2665")
  end
end
