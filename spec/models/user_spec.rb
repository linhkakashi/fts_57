require "rails_helper"
require "rspec/mocks"
RSpec.describe User, type: :model do
  let(:user) {FactoryGirl.create :user}

  describe "Associations" do
    it "should has many exams" do
      user = User.reflect_on_association :exams
      expect(user.macro).to eql :has_many
    end

    it "should has many questions" do
      user = User.reflect_on_association :questions
      expect(user.macro).to eql :has_many
    end
  end

  describe "validates" do
    subject {user}
    context "name is not nil" do
      it {is_expected.to be_valid}
    end

    context "password is not nil" do
      it {is_expected.to be_valid}
    end

    context "name is invalid" do
      before {user.name = nil}
      it {is_expected.not_to be_valid}
    end

    context "password is invalid" do
      before {user.password = nil}
      it {is_expected.not_to be_valid}
    end

    context "name have length greater 45 character" do
      it {is_expected.to validate_length_of(:name).is_at_most 45}
    end
  end
end
