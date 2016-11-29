require "postcodes_io/engine"
require "postcodes_io/lookup"

module Postcodes
  class IO
    include Lookup
  end
end
