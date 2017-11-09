class Chef < ApplicationRecord
  before_save { self.email = email.downcase }#converts email to lower case letters before saving.
  validates :chefname, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false }
  has_many :recipes, dependent: :destroy #Asserts that Chef class can have many recipes associated with it.  "dependent: :destroy" ensure that all of a chef's recipes are destroyed with the chef.
  has_secure_password
  validates :password, presence: true, length: { minimum: 5 }, allow_nil: true# 'allow_nil: true' allows a nil password for an edit, but requires one for signup.
  has_many :messages, dependent: :destroy
end