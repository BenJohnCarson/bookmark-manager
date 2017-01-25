feature "user signup" do
    scenario "can sign up to the app" do
        sign_up
        expect { sign_up }.to change(User, :count).by(1)
        expect(current_path).to eq '/links'
        expect(page).to have_content('Welcome, michael@jackson.com')
    end
end