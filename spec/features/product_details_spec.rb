require 'rails_helper'

# feature block => describe block
RSpec.feature "Visitor navigates to product page by clicking the product", type: :feature, js: true do

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

  #scenario block => it block
  scenario "They see a product image and details" do
    # ACT
    visit root_path
    first('.product').click_on "Details"

    # DEBUG
    # sleep(5)
    # puts page.html
    # save_screenshot

    # VERIFY
    expect(page).to have_css 'article.product-detail'
    expect(page).to have_css 'section.products-show'
  end

end