# lib/signature_pad_rails.rb
require "signature_pad_rails/version"
require "signature_pad_rails/engine"

module SignaturePadRails
end

# lib/signature_pad_rails/engine.rb
module SignaturePadRails
  class Engine < ::Rails::Engine
    isolate_namespace SignaturePadRails
    
    initializer "signature_pad_rails.assets" do |app|
      app.config.assets.precompile += %w( signature_pad_rails/signature_pad.js )
    end
  end
end
