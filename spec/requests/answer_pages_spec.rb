require 'spec_helper'

describe "answer pages" do
	describe "edit" do
		let(:user) { FactoryGirl.create(:user) }
	  let(:answer) { FactoryGirl.create(:answer) }
	  before { sign_in user}  
	  before { visit edit_answer_path(:answer) }

	  describe "page" do
	    it { should have_title("Update your answer") }
	  end

	  describe "with invalid information" do
	    before { click_button "Save changes" }

	    it { should have_content('error') }
	  end
	  describe "with valid information" do
      let(:new_content)  { "New Content" }
      before do
        fill_in "Content",          with: new_content
        click_button "Save changes"
      end

      it { should have_title(new_content) }
      it { should have_selector('div.alert.alert-success') }
      specify { expect(user.reload.content).to  eq new_content }
    end
  end
end