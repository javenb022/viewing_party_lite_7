require "rails_helper"

describe "admin dashboard" do
  before(:each) do
    admin = User.create(name: "Lauren", email: "lauren@gmail.com", password: "passw0rd", role: 2)
    @user1 = create(:user)
    @user2 = create(:user)
    @user3 = create(:user)
    visit login_path

    fill_in "Email", with: "lauren@gmail.com"
    fill_in "Password", with: "passw0rd"
    click_button 'Log In'
  end

  it "has a list of default users email addresses" do
    expect(current_path).to eq(admin_dashboard_path)

    expect(page).to have_content(@user1.email)
    expect(page).to have_content(@user2.email)
    expect(page).to have_content(@user3.email)
  end

  it "takes me to the admin users dashboard when I click an email address and I see the same dashboard that user would see" do
    click_link "#{@user1.email}"
    expect(current_path).to eq("/admin/users/#{@user1.id}")

    expect(page).to have_content("#{@user1.name}'s Dashboard")
    expect(page).to have_button("Discover Movies")
    expect(page).to have_content("Parties Hosting")
    expect(page).to have_content("Parties Attending")
  end
end







