require 'rails_helper'
RSpec.describe Order, type: :model do

  describe "db schema" do
    context "columns" do
      it do
        should have_db_column(:receiver_name).of_type(:string)
        should have_db_column(:receiver_address).of_type(:string)
        should have_db_column(:receiver_phone).of_type(:string)
        should have_db_column(:total_price).of_type(:float)
        should have_db_column(:status).of_type(:integer)
        should define_enum_for(:status).with([:pending, :accepted, :rejected])
        should have_db_column(:user_id).of_type(:integer)
        should have_db_column(:deleted_at).of_type(:datetime)
      end
    end
  end
  describe "validations" do
    it do
      should validate_presence_of :receiver_name
      should validate_length_of(:receiver_name).is_at_most(50).with_message("is too long (maximum is 50 characters)")
      should validate_presence_of :receiver_address
      should validate_length_of(:receiver_address).is_at_most(255).with_message("is too long (maximum is 255 characters)")
      should validate_presence_of :receiver_phone
      should validate_length_of(:receiver_phone).is_at_most(20).with_message("is too long (maximum is 20 characters)")
      should validate_presence_of :user_id
      should validate_presence_of :total_price
    end
  end
  describe "associations" do
    it do
      should belong_to(:user)
      should have_many(:order_items).dependent(:destroy)
    end
  end
  describe "scope" do
    let!(:order1) {create(:order1)}
    let!(:order2) {create(:order2)}
    let!(:order3) {create(:order3)}
    it "orders by created_at DESC" do
      expect(Order.all.newest).to eq [order3, order2, order1]
    end
    it "check scope feed_user_id" do
      expect(Order.feed_user_id(2)).to eq [order2]
    end
    it "check scope by_status" do
      expect(Order.by_status("pending")).to eq [order1, order2, order3]
    end
  end
end
