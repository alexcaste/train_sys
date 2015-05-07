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

describe('the all cities path', {:type => :feature}) do
  it("displays a list of trains") do
    city = City.new({c_name: "Baltimore", id: nil})
    city.save()
    visit('/')
    click_link('Operator')
    expect(page).to have_content(city.c_name())
  end
end

describe('the view single train path', {:type => :feature})do
  it("displays the page for a single train")do
  rock = Train.new(t_name: "Concrete", id: nil)
  rock.save()
  visit('/operator')
  click_link('Concrete')
  expect(page).to have_content('Concrete')
  end
end

describe('the view single city path', {:type => :feature})do
  it("displays the page for a single city")do
  city = City.new({c_name: "Baltimore", id: nil})
  city.save()
  visit('/operator')
  click_link('Baltimore')
  expect(page).to have_content('Baltimore')
  end
end

describe('the delete a city path', {:type => :feature})do
  it("allows user to delete a city")do
  city = City.new({c_name: "Baltimore", id: nil})
  city.save()
  visit('/operator')
  click_button('Delete')
  expect(page).to have_content('Flee mortal')
  end
end

describe('the delete a train path', {:type => :feature})do
  it("allows user to delete a train")do
  rock = Train.new(t_name: "Concrete", id: nil)
  rock.save()
  visit('/operator')
  click_button('Delete')
  expect(page).to have_content('Please insert 25 cents')
  end
end

describe('the add a stop to a train path', {:type => :feature})do
  it("allows user to add a stop to a train")do
  rock = Train.new(t_name: "Concrete", id: nil)
  rock.save()
  city = City.new({c_name: "Baltimore", id: nil})
  city.save()
  visit('/operator')
  click_link('Concrete')
  select('Baltimore')
  fill_in('time', :with => "1200")
  click_button('Add')
  expect(page).to have_content('City: Baltimore.  Time: 1200.')
  end
end

describe('the add a stop to a city path', {:type => :feature})do
  it("allows user to add a stop to a city")do
    rock = Train.new(t_name: "Concrete", id: nil)
    rock.save()
    city = City.new({c_name: "Baltimore", id: nil})
    city.save()
    visit('/operator')
    click_link('Baltimore')
    select('Concrete')
    fill_in('time', :with => "1200")
    click_button('Add')
    expect(page).to have_content('Train: Concrete.  Time: 1200.')
  end
end

describe('the change the name of a city path', {:type => :feature})do
  it("allows user to change the name of a city")do
  city = City.new({c_name: "Baltimore", id: nil})
  city.save()
  visit('/operator')
  click_link('Baltimore')
  fill_in('c_name', :with => "Portland")
  click_button('Change')
  expect(page).to have_content('Portland')
  end
end

describe('the change the name of a train path', {:type => :feature})do
  it("allows user to change the name of a train") do
  rock = Train.new(t_name: "Concrete", id: nil)
  rock.save()
  visit('/operator')
  click_link('Concrete')
  fill_in('t_name', :with => "Midnight")
  click_button('Change')
  expect(page).to have_content('Midnight')
  end
end
