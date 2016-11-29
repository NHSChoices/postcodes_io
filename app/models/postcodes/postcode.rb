module Postcodes
  class Postcode < ActiveRecord::Base
    self.table_name = 'postcodes'
    serialize :data, JSON

    after_initialize :strip_whitespace
    validate :english_postcode

    # allow accessing info values with dot notation
    def method_missing(name, *args, &block)
      return data[name.to_s] if data.key? name.to_s
      return data[name] if @info.key? name
      super.method_missing name
    end

    private

    # remove any whitespace. m1 1ab => m11ab
    def strip_whitespace
      self.postcode = postcode.gsub(/\s+/, '').upcase
    end

    def english_postcode
      unless data && data['country'] == 'England'
        errors.add(:country, 'is not registered as part of England. Please contact partnerships@phe.gov.uk if you require an account and work in England.')
      end
    end

  end
end
