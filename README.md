# PostcodesIo

A simple wrapper around [postcodes.io](http://postcodes.io/)

The purpose of this fork is that the postcodes will be stored locally to have a faster lookup.

When added to Rails project this gem adds a migration that creates the table `postcodes`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'postcodes_io'
```

And then execute:

    $ bundle


## Usage

Require the gem

```ruby
require 'postcodes_io'
```

Create new instance of the Postcodes::IO

```ruby
pio = Postcodes::IO.new
```

Lookup a postcode
```ruby
postcode = pio.lookup('NN12 8TN') # => record gets saved to the table
postcode = pio.lookup('NN12 8TN') # => record is retrieved from table and doesn't hit the API
```

It rejects all postcodes which country is not England
```ruby
[1] pry(main)> pc = Postcodes::Postcode.new(postcode: 'aa  aa', data: {'country' => 'Wales'})
=> #<Postcodes::Postcode:0x007fc59115aaa0 postcode: "AAAA", data: {"country"=>"Wales"}>
[2] pry(main)> pc.valid?
=> false
[3] pry(main)> pc.errors
=> #<ActiveModel::Errors:0x007fc590507b18
 @base=#<Postcodes::Postcode:0x007fc59115aaa0 postcode: "AAAA", data: {"country"=>"Wales"}>,
 @messages={:country=>["is not registered as part of England. Please contact partnerships@phe.gov.uk if you require an account and work in England."]}>
```

Inspect the results!
```ruby
postcode.longitude # -1.02144562675883
postcode.latitude # 52.0776806788868
```

Make a batch postcode lookup request

> max 100 postcodes per request

```ruby
postcodes = pio.lookup('NN12 8TN', 'DA3 8NG') # or pio.lookup(['NN12 8TN', 'DA3 8NG'])
postcodes.each do |p|
  puts p.nuts
end
```


##All available fields

|name|description|
|----|-----------|
|postcode| pretty formatted postcode|
|quality| 1-9 value of the quality of the grid reference |
|eastings| OS grid reference |
|northings | OS grid reference |
|country | The code for the appropriate country|
|nhs_ha | The health area code for the postcode |
|admin_county | The county the postcode has been assigned |
|admin_district| The current district/unitary authority to which the postcode has been assigned |
|admin_ward| The current administrative/electoral area to which the postcode has been assigned |
|longitude| The WGS84 longitude |
|latitude| The WGS84 latitude |
|parliamentary_constituency| he Westminster Parliamentary Constituency|
|european_electoral_region| The European Electoral Region code|
|primary_care_trust| The code for the Primary Care area |
|region| [former GORs](http://www.ons.gov.uk/ons/guide-method/geography/beginner-s-guide/administrative/england/government-office-regions/index.html)|
|parish| The smallest type of administrative area|
|lsoa| [The 2011 Census lower layer SOA code](http://www.ons.gov.uk/ons/guide-method/geography/beginner-s-guide/census/super-output-areas--soas-/index.html)|
|msoa| [The 2011 Census middle layer SOA (MSOA) code](The 2011 Census lower layer SOA code for England and Wales](http://www.ons.gov.uk/ons/guide-method/geography/beginner-s-guide/census/super-output-areas--soas-/index.html)|
|ccg| Clinical Commissioning Group |
|nuts| [see here](http://en.wikipedia.org/wiki/Nomenclature_of_Territorial_Units_for_Statistics)|

For more details see [the documentation on postcodes.io](http://postcodes.io/docs)
## Contributing

1. Fork it ( https://github.com/[my-github-username]/postcodes_io/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
