feature "Adding tags" do
    scenario "I can add a tag to a link" do
        visit 'links/new'
        fill_in 'url', with: 'http://www.google.co.uk'
        fill_in 'title', with: 'This is Google'
        fill_in 'tag', with: 'search engine'
        click_button 'Create link'
        
        expect(current_path).to eq '/links'
        
        within 'ul#links' do
            expect(page).to have_content('search engine')
        end
    end
end