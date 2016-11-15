require 'rails_helper'

describe Question do

  let(:user) { FactoryGirl.create(:user) }
  
  before do
    @question = Question.new(label: "label text", content: "Lorem ipsum", user_id: user.id)
  end

  subject { @question }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:label) }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @question.user_id = nil }
    it { should_not be_valid }
  end
end

describe User do

  before do
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to(:questions) }

end