def sign_up
    visit('/users/new')
    fill_in :email, with: 'michael@jackson.com'
    fill_in :password, with: 'password'
    click_button 'Sign up'
end