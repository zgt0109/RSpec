class Contact < ActiveRecord::Base
  has_many :phones, dependent: :delete_all
  accepts_nested_attributes_for :phones, :allow_destroy => true

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phones, length: { is: 3 }

  def name
    [firstname, lastname].join('')
  end

  def self.by_letter(letter)
    where("lastname LIKE ?", "#{letter}%").order(:lastname)
  end
end
