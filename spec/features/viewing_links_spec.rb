feature 'Viewing links' do
    
    before do
        Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy', tags: [Tag.first_or_create(name: 'education')])
        Link.create(url: 'http://www.google.com', title: 'Google', tags: [Tag.first_or_create(name: 'search')])
    end
    
    scenario 'I can see existing links on the links page' do
        visit '/links'
        expect(page.status_code).to eq 200
        within 'ul#links' do
            expect(page).to have_content('Makers Academy')
        end
    end
    
    scenario "I can filter my links by tag" do
        visit 'tags/search'
        expect(page.status_code).to eq(200)
        within 'ul#links' do
            expect(page).to have_content('Google')
            expect(page).to_not have_content('Makers Academy')
        end
    end
end