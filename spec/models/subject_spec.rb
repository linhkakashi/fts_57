require "rails_helper"
require "rspec/mocks"
RSpec.describe Subject, type: :model do
  let(:subject_obj) {FactoryGirl.create :subject}

  describe "Associations" do
    it "should has many exams" do
      subject = Subject.reflect_on_association :exams
      expect(subject.macro).to eql :has_many
    end

    it "should has many questions" do
      subject = Subject.reflect_on_association :questions
      expect(subject.macro).to eql :has_many
    end
  end

  describe "validates" do
    subject {subject_obj}
    context "name is not nil" do
      it {is_expected.to be_valid}
    end

    context "name is not valid" do
      before {subject_obj.name = nil}
      it {is_expected.not_to be_valid}
    end
  end
end
