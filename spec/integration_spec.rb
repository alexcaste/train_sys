require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exception, false)
require 'pry'

describe('the all trains path', {:type => :feature}) do
  it("displays a list of trains") do
    rock = Train.new(t_name: "Concrete", id: nil)
    rock.save()
    visit('/')
    click_link('Operator')
    expect(page).to have_content(rock.t_name())
  end
end

describe('the all trains path', {:type => :feature}) do
  it("displays a list of trains") do
    city = City.new({c_name: "Baltimore", id: nil})
    city.save()
    visit('/')
    click_link('Operator')
    expect(page).to have_content(city.c_name())
  end
end
