# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110608101759) do

  create_table "book_lists", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "book_lists", ["user_id"], :name => "index_book_lists_on_user_id"

  create_table "bookmarks", :force => true do |t|
    t.integer  "book_id"
    t.integer  "user_id"
    t.integer  "camp_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bookmarks", ["book_id"], :name => "index_bookmarks_on_book_id"
  add_index "bookmarks", ["camp_id"], :name => "index_bookmarks_on_camp_id"
  add_index "bookmarks", ["user_id"], :name => "index_bookmarks_on_user_id"

  create_table "books", :force => true do |t|
    t.integer  "user_id"
    t.integer  "book_list_id"
    t.string   "title",            :limit => 300
    t.string   "authors",          :limit => 100
    t.string   "editor",           :limit => 100
    t.text     "description"
    t.string   "url",              :limit => 300
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count",                   :default => 0
    t.string   "glasslevel",       :limit => 50
    t.string   "license",          :limit => 50
    t.string   "media",            :limit => 1024
    t.string   "media_type",       :limit => 32
    t.string   "date",             :limit => 40
    t.integer  "camp_id"
    t.string   "marks",            :limit => 300
    t.integer  "like_it_marks",                    :default => 0
    t.integer  "read_later_marks",                 :default => 0
  end

  add_index "books", ["book_list_id"], :name => "index_books_on_book_list_id"
  add_index "books", ["camp_id"], :name => "index_books_on_camp_id"
  add_index "books", ["user_id"], :name => "index_books_on_user_id"

  create_table "camps", :force => true do |t|
    t.string   "name",                :limit => 100
    t.string   "subdomain",           :limit => 100
    t.string   "line1",               :limit => 200
    t.string   "line2",               :limit => 200
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "model_name",          :limit => 32
    t.string   "origin",              :limit => 256
    t.boolean  "show_media_on_lists",                :default => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.string   "ancestry"
    t.string   "body",          :limit => 512
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "camp_id"
  end

  add_index "comments", ["camp_id"], :name => "index_comments_on_camp_id"
  add_index "comments", ["resource_id", "resource_type"], :name => "index_comments_on_resource_id_and_resource_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "camp_id"
    t.string   "rol",        :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shelf_items", :force => true do |t|
    t.integer  "shelf_id"
    t.integer  "book_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.integer  "camp_id"
  end

  add_index "shelf_items", ["book_id"], :name => "index_shelf_items_on_book_id"
  add_index "shelf_items", ["camp_id"], :name => "index_shelf_items_on_camp_id"
  add_index "shelf_items", ["shelf_id"], :name => "index_shelf_items_on_shelf_id"
  add_index "shelf_items", ["user_id"], :name => "index_shelf_items_on_user_id"

  create_table "shelves", :force => true do |t|
    t.integer  "user_id"
    t.string   "name",           :limit => 200
    t.string   "slug",           :limit => 50
    t.string   "description",    :limit => 512
    t.integer  "books_count",                   :default => 0
    t.integer  "comments_count",                :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "camp_id"
  end

  add_index "shelves", ["camp_id"], :name => "index_shelves_on_camp_id"

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "rol",           :limit => 10
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "login_count",                 :default => 0
    t.datetime "last_login_at"
  end

  create_table "versions", :force => true do |t|
    t.string   "item_type",                 :null => false
    t.integer  "item_id",                   :null => false
    t.string   "event",                     :null => false
    t.string   "whodunnit"
    t.string   "title",      :limit => 300
    t.string   "user_name",  :limit => 100
    t.text     "object"
    t.datetime "created_at"
    t.integer  "camp_id"
  end

  add_index "versions", ["camp_id"], :name => "index_versions_on_camp_id"
  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
