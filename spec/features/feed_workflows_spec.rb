require 'rails_helper'

RSpec.feature "FeedWorkflows", type: :feature do
  before :each do
    clean_db
  end

  scenario "Register new feed" do
    VCR.use_cassette "elpais" do
      visit new_feed_path
<<<<<<< HEAD
      fill_in "Name", with: "BBC"
      fill_in "Url", with: "http://bbc.com"
=======
      fill_in "Name", with: "El Pais"
      fill_in "Url", with: "http://brasil.elpais.com"
>>>>>>> bedc28a65cc36318a9a5ad03dc9b25444db2193a
      expect do
        click_button "Register"
      end.to change{ Feed.count }.by 1
      expect(page).to have_current_path(feeds_path)
    end
  end

  scenario "Destroy feed" do
    3.times{ create(:feed) }
    visit feeds_path
    expect do
      first(".destroy a").click
    end.to change{Feed.count}.by -1
  end

  scenario "Edit feed" do
    feed = create(:feed, name: "Test")
    visit edit_feed_path(feed)
    expect(find_field('Name').value).to eq 'Test'
    expect(page).to have_field('Url', disabled: true)
  end

  scenario "Get basic info from host" do
    VCR.use_cassette "elpais" do
      visit new_feed_path
      fill_in "Url", with: "http://brasil.elpais.com"
      click_button "Register"
      feed = Feed.first
      expect(feed.name).not_to be_blank
      expect(feed.favicon).not_to be_blank
    end
  end

  scenario "Get basic info from host" do
    VCR.use_cassette "folha" do
      visit new_feed_path
      fill_in "Url", with: "http://feeds.folha.uol.com.br/folha/emcimadahora/rss091.xml"
      click_button "Register"
      feed = Feed.first
      expect(feed.name).not_to be_blank
      expect(feed.favicon).not_to be_blank
    end
  end
end
