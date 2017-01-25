feature "Creating links" do
    scenario "I can create a new link" do
        sign_up
        visit 'links/new'
        fill_in 'url', with: 'http://www.google.co.uk'
        fill_in 'title', with: 'This is Google'
        click_button 'Create link'
        
        expect(current_path).to eq '/links'
        
        within 'ul#links' do
            expect(page).to have_content('This is Google')
        end
    end
end