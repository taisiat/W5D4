# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  long_url   :string           not null
#  short_url  :string
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShortenedUrl < ApplicationRecord
    validates :short_url, uniqueness: true
    validates :long_url, presence: true

    after_initialize do |shortened_url|
        if self.new_record?
            self.generate_short_url
        end
    end

    belongs_to :submitter,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User

    def random_code
        encoding = SecureRandom.urlsafe_base64
        while ShortenedUrl.exists?(:short_url => encoding)
            encoding = SecureRandom.urlsafe_base64
        end
        encoding
    end

    private
    def generate_short_url
        self.short_url = self.random_code
    end
    
end
