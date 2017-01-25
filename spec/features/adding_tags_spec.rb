feature "Adding tags" do
    scenario "I can add a tag to a link" do
        visit 'links/new'
        fill_in 'url', with: 'http://www.google.co.uk'
        fill_in 'title', with: 'This is Google'
        fill_in 'tag', with: 'search engine'
        
        click_button 'Create link'
        link = Link.first
        expect(link.tags.map(&:name)).to include('search engine')
        end
end