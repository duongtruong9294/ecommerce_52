require "rails_helper"
RSpec.describe User, type: :model do

  describe "db schema" do
    context "columns" do
      it do
        should have_db_column(:email).of_type(:string)
        should have_db_column(:name).of_type(:string)
        should have_db_column(:encrypted_password).of_type(:string)
        should have_db_column(:address).of_type(:string)
        should have_db_column(:phone).of_type(:string)
        should have_db_column(:role).of_type(:integer)
        should have_db_column(:remember_created_at).of_type(:datetime)
        should have_db_column(:confirmation_token).of_type(:string)
        should have_db_column(:confirmed_at).of_type(:datetime)
        should have_db_column(:confirmation_sent_at).of_type(:datetime)
        should have_db_column(:unconfirmed_email).of_type(:string)
        should have_db_column(:reset_password_token).of_type(:string)
        should have_db_column(:reset_password_sent_at).of_type(:datetime)
        should have_db_column(:failed_attempts).of_type(:integer)
        should have_db_column(:unlock_token).of_type(:string)
        should have_db_column(:locked_at).of_type(:datetime)
        should have_db_column(:deleted_at).of_type(:datetime)
      end
    end
  end
  describe "validations" do
    it do
      should validate_presence_of :email
      should validate_length_of :email
      should validate_presence_of :name
      should validate_length_of(:name).is_at_most(50)
      should validate_presence_of :password
      should validate_length_of(:password).is_at_least(6).with_message("is too short (minimum is 6 characters)")
      should validate_presence_of :password
      should validate_length_of(:password).is_at_most(128).with_message("is too long (maximum is 128 characters)")
      should validate_presence_of :address
      should validate_length_of(:address).is_at_most(255).with_message("is too long (maximum is 255 characters)")
    end
  end
  describe "associations" do
    it do
      should have_many(:comments).dependent(:destroy)
      should have_many(:rattings).dependent(:destroy)
      should have_many(:orders).dependent(:destroy)
      should have_many(:suggests).dependent(:destroy)
    end
  end
  describe "scope" do
    let!(:user) {create(:user)}
    let!(:admin) {create(:admin)}
    let!(:abc) {create(:abc)}
    it "orders by created_at DESC" do
      expect(User.all.newest).to eq [abc, admin, user]
    end
  end
end
