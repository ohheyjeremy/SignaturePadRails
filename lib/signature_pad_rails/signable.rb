# lib/signature_pad_rails/signable.rb
module SignaturePadRails
  module Signable
    extend ActiveSupport::Concern

    included do
      has_one :signature, 
              class_name: 'SignaturePadRails::Signature', 
              as: :signable, 
              dependent: :destroy
      
      accepts_nested_attributes_for :signature
    end
  end
end