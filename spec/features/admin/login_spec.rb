require "rails_helper"

describe "Admin login" do
  describe "happy path" do
    it "I can log in as an admin and get to my dashboard" do
	    admin = User.create(name: "Super",
                        email: "superuser@awesome-site.com",
                        password: "super_secret_passw0rd",
                        role: 2)

      visit login_path
      fill_in "Email", with: "superuser@awesome-site.com"
      fill_in "Password", with: "super_secret_passw0rd"
      click_button 'Log In'

      expect(current_path).to eq(admin_dashboard_path)
    end
  end
end

# describe "as default user" do
#   it 'does not allow default user to see admin dashboard index' do
#     user = User.create(name: "Fern",
#                       email: "fern@gully.com",
#                       password: "password",
#                       role: 0)

#     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

#     visit admin_dashboard_path

#     expect(page).to have_content("The page you were looking for doesn't exist.")
#   end
# end
