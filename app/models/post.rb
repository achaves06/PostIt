 class Post < ActiveRecord::Base
   belongs_to :creator, foreign_key: "user_id", class_name: "User"
   before_validation :smart_add_url_protocol

   has_many :comments
   has_many :post_categories
   has_many :categories, through: :post_categories, foreign_key: "post_id"

   validates :title, presence: true
   validates :url, presence: true, uniqueness: true

   protected

   def smart_add_url_protocol # this adds http to the url if not there, otherwise link_to tries to add url to path and causes and erro
     unless self.url.empty?
       unless self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//]
         self.url = "http://#{self.url}"
       end
     end
   end
 end
