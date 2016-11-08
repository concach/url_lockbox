require 'uri'

class Link < ApplicationRecord
  belongs_to :user

  validates :url, presence: true
  validates :title, presence: true
  validates :read, absence: false
  validates :user_id, presence: true

  def validate_url(url = self.url)
    if url.split(" ").length > 1
      self.url = url.split(" ")[0]
      ApplicationMailer.send_email(url.split(" ")[2], self) if url.split(" ")[2]
    end
    uri = URI.parse(self.url)
    uri.kind_of?(URI::HTTP)
  rescue URI::InvalidURIError
    false
  end
end
