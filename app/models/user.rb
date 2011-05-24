class User < ActiveRecord::Base
  has_many :book_lists
  has_many :books

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
    end
  end

  def super?
    self.id.present? and self.id < 4
  end
end
