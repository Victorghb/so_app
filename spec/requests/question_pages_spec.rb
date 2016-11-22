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

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    let(:question) { FactoryGirl.create(:question) }
    
    before { sign_in user }
    before { visit edit_question_path(question) }

    describe "page" do
      it { should have_content("Update your question") }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end
    describe "with valid information" do
      let(:new_content)  { "New Content" }
      before do
        fill_in "Content",             with: new_content
        click_button "Save changes"
      end

      it { should have_title(new_content) }
      it { should have_selector('div.alert.alert-success') }

      specify { expect(question.reload.content).to  eq new_content }
    end
  end
end
