require 'spec_helper'

describe "question pages", type: :request do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user}

  describe "question creation" do
    before { visit user_path(user) }

    describe "with invalid information" do

      it "should not create a question" do
        expect { click_button "Post" }.not_to change(Question, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('not created') }
      end
    end

    describe "with valid information" do
      before { 
        fill_in 'question_content', with: "Lorem ipsum"  
        fill_in 'question_label', with: "Lorem ipsum" 
      }
      it "should create a question" do
        expect { click_button "Post" }.to change(Question, :count).by(1)
      end
    end
  end
end
