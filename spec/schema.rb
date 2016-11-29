ActiveRecord::Schema.define do
  self.verbose = false

  create_table :postcodes, id: false do |t|
    t.string   :postcode, null: false
    t.string   :data

    t.index :postcode, unique: true
  end

end
