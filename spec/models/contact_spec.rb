require 'rails_helper'

RSpec.describe Contact, :type => :model do
  describe Contact do
    it "is valid with a firstname, lastname and email" do
      contact = Contact.new(
        firstname: 'Aaron',
        lastname: 'Summer',
        email: 'test@qq.com'
      )
      expect(contact).to be_valid
    end

    it "is invalid without a firstname" do
      contact = Contact.new(firstname: nil)
      contact.valid?
      expect(contact.errors[:firstname]).to include("can't be blank")
    end

    it "is invalid without a lastname" do
      contact = Contact.new(lastname: nil)
      contact.valid?
      expect(contact.errors[:lastname]).to include("can't be blank")
    end

    it "is invalid without an email address" do
      contact = Contact.new(email: nil)
      contact.valid?
      expect(contact.errors[:email]).to include("can't be blank")
    end
    it "is invalid with a duplicate email address" do
      Contact.create(
        firstname: 'Joe', lastname: 'Tester',
        email: 'test@123.com'
      )
      contact = Contact.new(
        firstname: 'Jane', lastname: 'Tester',
        email: 'test@123.com'
      )
      contact.valid?
      expect(contact.errors[:email]).to include("has already been taken")
    end

    it "returns a contact's full name as a string" do
      contact = Contact.new(firstname: 'John', lastname: 'Doe',
      email: 'john@123.com')
      expect(contact.name).to eq 'JohnDoe'
    end

    it "returns a sorted array of results that match" do
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
      expect(Contact.by_letter("J")).to eq [johnson, jones]
    end

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

    describe "filter last name by letter" do
      before :each do
        @smith = Contact.create(
          firstname: 'John',
          lastname: 'Smith',
          email: 'jsmith@123.com'
        )
        @jones = Contact.create(
          firstname: 'Tim',
          lastname: 'Jones',
          email: 'tjones@123.com'
        )
        @johnson = Contact.create(
          firstname: 'John',
          lastname: 'Johnson',
          email: 'jjohnson@123.com'
        )
      end

      context "matching letters" do
        it "returns a sorted array of results that match" do
          expect(Contact.by_letter("J")).to eq [@johnson, @jones]
        end
      end

      context "non-matching letters" do
        it "omits results that do not match" do
          expect(Contact.by_letter("J")).not_to include @smith
        end
      end

    end

  end
end
