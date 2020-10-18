require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "#create" do
    before do
      @message = FactoryBot.build(:message)
    end
    it "contentとimageがあれば保存できる" do
      expect(@message).to be_valid
    end
    it "contentがあれば保存できる" do
      @message.image = nil
      expect(@message).to be_valid
    end
    it "imageがあれば保存できる" do
      @message.content = ""
      expect(@message).to be_valid
    end
    it "contentとimageがなければ保存できない" do
      @message.content = ""
      @message.image = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("Content can't be blank")
    end
    it "roomが紐づいていないと保存できない" do
      @message.room = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("Room must exist")
    end
    it "userが紐づいていないと保存できない" do
      @message.user = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("User must exist")
    end
    
  end
end
