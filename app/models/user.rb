# User
#
class User < ActiveRecord::Base
  # Extensions
  extend FriendlyId
  friendly_id :name, use: :slugged
  include Identifiable
  include HasRoles
  include HasMembers
  include HasTags
  include UserMemberships
  include BooleanAccessor
  store :settings, accessors: [:uploader]
  boolean_accessor [:uploader]

  # RELATIONS 
  has_many :references, dependent: :restrict
  has_many :comments, dependent: :destroy
  has_many :versions, foreign_key: :whodunnit
  has_many :shelves, dependent: :restrict
  has_many :camp_shelves, dependent: :restrict
  has_many :user_shelves, dependent: :destroy

  # SCOPES
  scope :groups, where(group: true)
  scope :persons, where(group: false)

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :email, uniqueness:true, presence: true, if: :email_required?

  # Not collaborators scoped (see MembershipsController)
  def self.not_collaborators(model)
    ids = model.collaborators.map(&:id)
    User.where { id.not_in(ids) }
  end

  def collaborators
    ids = memberships.map(&:user_id) << id
    User.where(id: ids)
  end

  # Add reference to my_references_shelf
  def add_reference(reference)
    reference.user = self
    User.transaction do
      reference.save
      return true
    end
    return false
  end

  def user_groups
    unless @user_groups
      ids = Membership.where(user_id: self.id, resource_type: 'User').map(&:resource_id)
      @user_groups = User.where(id: ids)
    end
    @user_groups
  end

  def audit_login
    self.last_login_at = Time.now
    self.login_count ||= 0
    self.login_count = self.login_count + 1
    self.save(:validate => false)
  end

  protected
  def email_required?
    false #self.group == false
  end
end
