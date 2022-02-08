require 'rails_helper'

RSpec.feature "Testing Add-to-cart", type: :feature, js: true do
  
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
      )
    end
  end

  scenario "Navigate to an individual product" do
    # ACT
    visit root_path
    save_screenshot

    expect(page).to have_content ' My Cart (0)'
    page.first(:button, 'Add').click
    
    # DEBUG / VERIFY
    expect(page).to have_content ' My Cart (1)'
    save_screenshot # needs to go after expect to work
  end
end
