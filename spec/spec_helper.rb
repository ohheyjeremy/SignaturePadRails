# spec/spec_helper.rb
require 'signature_pad_rails'
require 'rails'
require 'active_record'

RSpec.configure do |config|
  # RSpec configuration
end

# spec/models/signature_spec.rb
require 'spec_helper'

RSpec.describe SignaturePadRails::Signature do
  it "requires data" do
    signature = described_class.new
    expect(signature).not_to be_valid
    expect(signature.errors[:data]).to include("can't be blank")
  end
end