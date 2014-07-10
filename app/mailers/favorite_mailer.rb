class FavoriteMailer < ActionMailer::Base
  default from: "warren.kushner@gmail.com"

  def new_comment(user, post, comment)
    @user = user
    @post = post
    @comment = comment


    headers["Message-ID"] = "<comments/#{@comment.id}@Bloccit.com>"
    headers["In-Reply-To"] = "<post/#{@post.id}@Bloccit.com"
    headers["References"] = "<post/#{@post.id}@Bloccit.com>"

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
user.email