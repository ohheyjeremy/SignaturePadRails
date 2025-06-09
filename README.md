# SignaturePadRails

Easy integration of signature_pad.js with Rails applications.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'signature_pad_rails'
```

And then execute:
```bash
$ bundle install
$ rails generate signature_pad_rails:install
$ rails db:migrate
```

## Usage

### 1. Include the concern in your model:

```ruby
class Swmm < ApplicationRecord
  include SignaturePadRails::Signable
end
```

### 2. Add the signature pad to your form:

```erb
<%= render 'signature_pad_rails/signature_pad', signable: @swmm %>
```

### 3. Import the JavaScript in your application.js:

```javascript
import "signature_pad_rails"
```

### 4. Permit signature attributes in your controller:

```ruby
def swmm_params
  params.require(:swmm).permit(
    # other params...
    signature_attributes: [:data]
  )
end
```

### 5. Display signatures:

```erb
<% if @swmm.signature.present? %>
  <div class="signature-display">
    <%= image_tag @swmm.signature.data, alt: "Signature" %>
  </div>
<% end %>
```

## Configuration

You can configure SignaturePadRails in an initializer:

```ruby
# config/initializers/signature_pad_rails.rb
SignaturePadRails.configure do |config|
  config.pad_width = 400
  config.pad_height = 200
  config.background_color = 'rgb(255, 255, 255)'
  config.pen_color = 'rgb(0, 0, 0)'
  config.min_width = 0.5
  config.max_width = 2.5
  config.throttle = 16
  config.min_distance = 5
end
```

## Advanced Usage

### Custom Styling

Add custom CSS to style the signature pad:

```css
.signature-pad-container {
  width: 100%;
  max-width: 600px;
  margin: 0 auto;
}

.signature-pad {
  border: 2px solid #ddd;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.signature-pad-actions {
  margin-top: 1rem;
  display: flex;
  justify-content: space-between;
}
```

### Multiple Signatures

For models with multiple signatures:

```ruby
class Document < ApplicationRecord
  has_many :signatures, 
           class_name: 'SignaturePadRails::Signature', 
           as: :signable, 
           dependent: :destroy
end
```

### Validation

Add custom validation to ensure signatures are provided:

```ruby
class Swmm < ApplicationRecord
  include SignaturePadRails::Signable
  
  validates :signature, presence: true, on: :update
end
```

## API Reference

### SignaturePadRails::Signable

The main concern that adds signature functionality to your models.

#### Methods

- `signature` - Returns the associated signature
- `signature_present?` - Returns true if a signature exists
- `signature_data` - Returns the raw signature data

### SignaturePadRails::Signature

The signature model that stores signature data.

#### Attributes

- `data` - Base64 encoded signature image
- `signable` - Polymorphic association to the parent model
- `created_at` - Timestamp when signature was created
- `updated_at` - Timestamp when signature was last updated

## JavaScript API

The gem provides JavaScript functionality that can be customized:

```javascript
// Get the signature pad instance
const signaturePad = document.querySelector('#signature-pad').signaturePad;

// Clear the pad programmatically
signaturePad.clear();

// Check if empty
if (signaturePad.isEmpty()) {
  console.log('No signature');
}

// Get signature data
const data = signaturePad.toDataURL();
```

## Turbo Support

The gem is fully compatible with Turbo. For forms submitted via Turbo:

```erb
<%= form_with model: @swmm, data: { turbo: true } do |form| %>
  <%= render 'signature_pad_rails/signature_pad', signable: @swmm, form: form %>
<% end %>
```

## Stimulus Integration

For custom Stimulus controllers:

```javascript
import { Controller } from "@hotwired/stimulus"
import SignaturePad from "signature_pad"

export default class extends Controller {
  static targets = [ "canvas", "input" ]
  
  connect() {
    this.signaturePad = new SignaturePad(this.canvasTarget)
  }
  
  clear() {
    this.signaturePad.clear()
  }
  
  save() {
    if (!this.signaturePad.isEmpty()) {
      this.inputTarget.value = this.signaturePad.toDataURL()
    }
  }
}
```

## Troubleshooting

### Common Issues

1. **Signature not saving**: Ensure you've added `signature_attributes: [:data]` to your strong parameters.

2. **JavaScript not loading**: Make sure you've run `yarn add signature_pad` and imported the JavaScript.

3. **Canvas sizing issues**: The canvas may need to be resized on window resize:

```javascript
window.addEventListener('resize', () => {
  // Resize canvas logic
});
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yourusername/signature_pad_rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/yourusername/signature_pad_rails/blob/main/CODE_OF_CONDUCT.md).

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Testing

```bash
bundle exec rspec
```

To run tests with coverage:

```bash
COVERAGE=true bundle exec rspec
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SignaturePadRails project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/yourusername/signature_pad_rails/blob/main/CODE_OF_CONDUCT.md).

## Credits

This gem is built on top of the excellent [signature_pad](https://github.com/szimek/signature_pad) library by Szymon Nowak.

## Support

For bug reports and feature requests, please use the [GitHub issue tracker](https://github.com/yourusername/signature_pad_rails/issues).

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes.

## Requirements

- Ruby 2.7.0 or higher
- Rails 7.0.0 or higher
- Modern browser with canvas support
- Node.js and Yarn (for JavaScript dependencies)