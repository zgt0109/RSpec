require 'rails_helper'

RSpec.describe Contact, :type => :model do
  describe Contact do
    # it "is valid with a firstname, lastname and email" do
    #   contact = Contact.new(
    #     firstname: 'Aaron',
    #     lastname: 'Summer',
    #     email: 'test@qq.com'
    #   )
    #   expect(contact).to be_valid
    # end

    it "is invalid without a firstname" do
      contact = build(:contact, firstname: nil)
      #contact = Contact.new(firstname: nil)
      contact.valid?
      expect(contact.errors[:firstname]).to include("can't be blank")
    end

    it "is invalid without a lastname" do
      contact = build(:contact, lastname: nil)
      #contact = Contact.new(lastname: nil)
      contact.valid?
      expect(contact.errors[:lastname]).to include("can't be blank")
    end

    it "is invalid without an email address" do
      contact = build(:contact, email: nil)
      #contact = Contact.new(email: nil)
      contact.valid?
      expect(contact.errors[:email]).to include("can't be blank")
    end

    it "is invalid with a duplicate email address" do
      FactoryGirl.create(:contact, email: 'aaron@example.com')
      contact = FactoryGirl.build(:contact, email: 'aaron@example.com')
      contact.valid?
      expect(contact.errors[:email]).to include('has already been taken')
    end

    it "returns a contact's full name as a string" do
      contact = FactoryGirl.build(:contact,
        firstname: 'John',
        lastname: 'Doe')
      expect(contact.name).to eq 'JohnDoe'
    end

    # it "returns a sorted array of results that match" do
    #   smith = Contact.create(
    #     firstname: 'John',
    #     lastname: 'Smith',
    #     email: 'jsmith@123.com'
    #   )
    #   jones = Contact.create(
    #     firstname: 'Tim',
    #     lastname: 'Jones',
    #     email: 'tjones@123.com'
    #   )
    #   johnson = Contact.create(
    #     firstname: 'John',
    #     lastname: 'Johnson',
    #     email: 'jjohnson@123.com'
    #   )
    #   expect(Contact.by_letter("J")).to eq [johnson, jones]
    # end

    it "omits results that do not match" do
      smith = Contact.create(
        firstname: 'John',
        lastname: 'Smith',
        email: 'jsmith@123.com'
      )
      jones = Contact.create(
        firstname: 'Tim',
        lastname: 'Jones',
        email: 'tjones@123.com'
      )
      johnson = Contact.create(
        firstname: 'John',
        lastname: 'Johnson',
        email: 'jjohnson@123.com'
      )
      expect(Contact.by_letter("J")).not_to include smith
    end

    # describe "filter last name by letter" do
    #   before :each do
    #     @smith = Contact.create(
    #       firstname: 'John',
    #       lastname: 'Smith',
    #       email: 'jsmith@123.com'
    #     )
    #     @jones = Contact.create(
    #       firstname: 'Tim',
    #       lastname: 'Jones',
    #       email: 'tjones@123.com'
    #     )
    #     @johnson = Contact.create(
    #       firstname: 'John',
    #       lastname: 'Johnson',
    #       email: 'jjohnson@123.com'
    #     )
    #   end
    #
    #   context "matching letters" do
    #     it "returns a sorted array of results that match" do
    #       expect(Contact.by_letter("J")).to eq [@johnson, @jones]
    #     end
    #   end
    #
    #   context "non-matching letters" do
    #     it "omits results that do not match" do
    #       expect(Contact.by_letter("J")).not_to include @smith
    #     end
    #   end
    #
    # end

    it "is has a valid factory" do
      expect(build(:contact)).to be_valid
    end

    it "has three phone numbers" do
      expect(create(:contact).phones.count).to eq 3
    end

  end
end
