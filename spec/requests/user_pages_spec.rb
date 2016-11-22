require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Questions controller" do

        describe "submitting to the create action" do
          before { post questions_path }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete question_path(FactoryGirl.create(:question)) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
    end
  end
end

describe "User pages" do

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:quest1) { FactoryGirl.create(:question, user: user, content: "Foo") }
    let!(:quest2) { FactoryGirl.create(:question, user: user, content: "Bar") }

    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }

    describe "questions" do
      it { should have_content(quest1.content) }
      it { should have_content(quest2.content) }
      it { should have_content(user.questions.count) }
    end
  end

  subject { page }

  describe "signup page" do

    before { visit signup_path }
    let(:submit) { "Create my account" }

    describe "with invalid information" do
      describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_content('error') }
      end
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
    
    describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_content('error') }
      end

    describe "with valid information" do
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }        
      end
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "profile page" do  
    let(:user){ FactoryGirl.create(:user) }
    
    it "should have right texts" do
      visit user_path user
      should have_content(user.name) 
      should have_title(user.name) 
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    
    before { sign_in user }
    before { visit edit_user_path(user) }

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end
    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
end