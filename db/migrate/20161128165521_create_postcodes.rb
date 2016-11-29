class CreatePostcodes < ActiveRecord::Migration
  def change
    create_table :postcodes, id: false do |t|
      t.string   :postcode, null: false
      t.string   :data

      t.index :postcode, unique: true
    end
  end
end
