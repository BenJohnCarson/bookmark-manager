feature "user signup" do
    
    scenario 'requires a matching confirmation password' do
        expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
    end
    
    scenario "can sign up to the app" do
        sign_up
        expect { sign_up }.to change(User, :count).by(1)
        expect(current_path).to eq '/links'
        expect(page).to have_content('Welcome, michael@jackson.com')
    end
end