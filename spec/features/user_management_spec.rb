feature "user signup" do
    
    scenario 'requires a matching confirmation password' do
        expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
        expect(current_path).to eq('/users')
        expect(page).to have_content "Password does not match the confirmation"
    end
    
    scenario "I can't sign up without an email address" do
        expect { sign_up(email:nil) }.not_to change(User, :count)
        expect(page).to have_content('Email must not be blank')
    end
    
    scenario "I can't sign up with an invalid email address" do
        expect {sign_up(email: "invalid@email") }.not_to change(User, :count)
        expect(current_path).to eq('/users')
        expect(page).to have_content('Email has an invalid format')
    end
    
    scenario "I can't sign up with an email address that already exists" do
       sign_up
       expect { sign_up }.not_to change(User, :count)
       expect(page).to have_content('Email is already taken')
    end
   
    scenario "can sign up to the app" do
        expect { sign_up }.to change(User, :count).by(1)
        expect(current_path).to eq '/links'
        expect(page).to have_content('Welcome, michael@jackson.com')
    end
end
