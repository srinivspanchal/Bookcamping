# ShelfItem
# A item stored inside a section
#
# SCHEMA
#create_table "shelf_items", :force => true do |t|
#  t.integer  "shelf_id"
#  t.integer  "book_id"
#  t.integer  "user_id"
#  t.datetime "created_at"
#  t.integer  "camp_id"
#end
#
class ShelfItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :shelf
  belongs_to :book
  belongs_to :camp

  # Keep it!
  belongs_to :camp_shelf, :foreign_key => :shelf_id

  validates :user_id, presence: true
  validates :shelf_id, presence: true
  validates :book_id, presence: true
  #validates :camp_id, presence: true

  after_create :add_book_to_shelf
  after_destroy :remove_book_from_shelf

  def title_name

  end

  protected
  def add_book_to_shelf
    PaperTrail.enabled = false
    current = shelf.books_count
    shelf.update_attribute(:books_count, current + 1)
    PaperTrail.enabled = true
  end

  def remove_book_from_shelf
    PaperTrail.enabled = false
    shelf.update_attribute(:books_count, (shelf.books_count - 1))
    PaperTrail.enabled = true
  end
end
