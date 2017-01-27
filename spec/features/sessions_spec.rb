feature "User can sign in and out" do 
    
    let!(:user) do
        User.create(email: 'michael@jackson.com',
                    password: 'password',
                    password_confirmation: 'password')
    end
    
    scenario 'sign in with correct details' do
        sign_in(email: user.email, password: user.password)
        expect(page).to have_content "Welcome, #{user.email}"
    end
    
    scenario 'can sign out' do
        sign_in(email: user.email, password: user.password)
        click_button 'Sign out'
        expect(page).to have_content('Farewell!')
        expect(page).not_to have_content('Welcome, michael@jackson.com')
    end
end
