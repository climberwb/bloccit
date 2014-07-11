class Comment < ActiveRecord::Base
  belongs_to :post

  belongs_to :topic

  belongs_to :user

  validates :body, length: { minimum: 5 }, presence: true

  after_create :send_favorite_emails

   def send_favorite_emails
     # for every favorite associated with post, send email
     self.post.favorites.each do |favorite|

       FavoriteMailer.new_comment(favorite.user, self.post, self).deliver unless favorite.user_id == self.user_id

       if favorite.user_id != self.user_id && favorite.user.email_favorites?
         FavoriteMailer.new_comment(favorite.user, self.post, self).deliver
       end
     end
   end

  private

  def send_favorite_emails
    self.post.favorites.each do |favorite|
      FavoriteMailer.new_comment(favorite.user, self.post, self).deliver
    end
  end
end
