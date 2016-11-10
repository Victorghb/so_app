require 'rails_helper'

describe "Static pages" do 
	let(:base_title) { "SO" }
	subject { page }

	describe "Help page" do

		before { visit help_path}

		it {should have_content('This is the help page for the SO application.')}
		it {should have_title("#{base_title} | Help")}
	end

	describe "Home page" do

		before {visit '/'}

		it {should have_title("#{base_title} | Home")}
	end
end