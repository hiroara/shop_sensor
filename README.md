shop_sensor
===========

This is unofficial client library of [ShopSense API](http://shopsense.shopstyle.com/shopsense/7234015).

## Installation

Add this line to your application's Gemfile:

    gem 'shop_sensor'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shop_sensor

## Usage

### Basic Request

```
client = ShopSensor::Client.new
brands_response = client.brands # request to `/brands' endpoint
products_response = client.products fts: "coat" # search on `/product' endpoint with keyword `coat'
```

### Configuration

```
ShopSensor.configure do |config|
  config.api_key = '<YOUR API KEY>'
  config.locale = :ja_JP # switch `site` parameter, and API returns correspond products.
end
```

## Contributing

1. Fork it ( http://github.com/hiroara/shop_sensor/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
