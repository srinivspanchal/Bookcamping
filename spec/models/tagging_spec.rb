require 'spec_helper'

describe Tagging do
  before :each do
    @user = FactoryGirl.create :user
    @tag = FactoryGirl.create :tag
    @reference = FactoryGirl.create :reference
  end
  
  it "should be unique for each ref/tag" do
    tg = Tagging.new(user: @user, reference: @reference, tag: @tag)
    tg.save.should == true
    tg = Tagging.new(user: @user, reference: @reference, tag: @tag)
    tg.save.should == false
  end

  it "should increment and decrement size" do
    tg = Tagging.new(user: @user, reference: @reference, tag: @tag)
    tg.save
    @tag.size.should == 1
    tg.destroy
    @tag.size.should == 0
  end
end
