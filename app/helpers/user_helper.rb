module UserHelper
  include ActionView::Helpers::AssetTagHelper

  SIZES = {micro: 20, small: 40, medium: 80}
  def avatar_image(user, size = :medium)
    s = SIZES[size]
    s ||= 40
    image_url = nil

    image_url = gravatar_url(user, s)
    image_tag(image_url, alt: user.name, width: s, height: s)
  end

  def gravatar_url(user, s)
    default_url = "http://bookcamping.cc/images/guest#{s}x#{s}.png"
    if user.email.present?
      gravatar_id = Digest::MD5::hexdigest(user.email).downcase
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{s}&d=#{CGI.escape(default_url)}"
    else
      default_url
    end
  end

  def link_to_user(user)
    link_to(avatar_image(user, :small) << ' ' << user.name, user)
  end

  def render_members(members)
    render partial: 'users/members',
      locals: {members: members} if members.present?
  end

  def render_users(users)
    render partial: 'users/users',
      locals: {users: users} if users.present?
  end
end
