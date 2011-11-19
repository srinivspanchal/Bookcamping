class User::SetupUser
  def self.create_from_omniauth(omniauth)
    User.transaction do
      user = User.create! do |user|
        user.name = omniauth['info']['name']
        user.email = omniauth['info']['email']
        user.password = 'ignored, just pass validation'
        user.password_confirmation = 'ignored, just pass validation'
      end
      Identity.create!(user: user, provider: omniauth['provider'], uid: omniauth['uid'])
      setup user
    end
  end

  def self.create(user)
    User.transaction do
      user.save!
      Identity.create_identity(user, user.password)
      setup user
    end
  end

  def self.setup(user)
    create_profile_shelves(user)
    user
  end


  def self.create_profile_shelves(user)
    PaperTrail.enabled = false

    unless user.like_it_shelf
      UserShelf.create!(slug: 'favoritos', user: user, name: 'FAVORITOS',
                        visibility: :public, rol: 'like_it', color: '#44adc6')
    end

    unless user.read_later_shelf
      UserShelf.create!(slug: 'para_leer', user: user, name: 'PARA LEER',
                        visibility: :private, rol: 'read_later', color: '#67c095')
    end

    unless user.my_references_shelf
      UserShelf.create!(slug: 'mis_aportaciones', user: user, name: 'MIS APORTACIONES',
                        visibility: :public, rol: 'my_references', color: '#e7de21')
    end

    PaperTrail.enabled = true
  end
end


