require 'rails_helper'

describe Answer do

  let(:user) { FactoryGirl.create(:user) }
  let(:question) {FactoryGirl.create(:question)}
  before do
    @answer = Answer.new(content: "Lorem ipsum", user_id: user.id, user_name: user.name, question_id: question.id)
  end

  subject { @answer }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @answer.user_id = nil }
    it { should_not be_valid }
  end
end

describe User do

  before do
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to(:answers) }

end