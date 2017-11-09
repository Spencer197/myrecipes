class Message < ApplicationRecord
  belongs_to :chef
  validates :content, presence: true
  validates :chef_id, presence: true

  def self.most_recent
    order(:created_at).last(20)#Grabs the last 20 messages for display.
  end
end