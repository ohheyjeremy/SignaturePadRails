# app/models/signature_pad_rails/signature.rb
module SignaturePadRails
  class Signature < ApplicationRecord
    self.table_name = "signature_pad_rails_signatures"
    
    belongs_to :signable, polymorphic: true
    validates :data, presence: true
  end
end