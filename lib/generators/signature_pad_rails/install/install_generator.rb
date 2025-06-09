# lib/generators/signature_pad_rails/install/install_generator.rb
module SignaturePadRails
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)
      
      def create_migrations
        rake "signature_pad_rails:install:migrations"
      end
      
      def create_initializer
        template "initializer.rb", "config/initializers/signature_pad_rails.rb"
      end
      
      def install_javascript
        create_file "app/javascript/signature_pad_rails.js", <<-JS
import SignaturePad from 'signature_pad'

document.addEventListener('turbo:load', () => {
  const canvas = document.querySelector('#signature-pad')
  
  if (canvas) {
    const signaturePad = new SignaturePad(canvas, {
      backgroundColor: 'rgb(255, 255, 255)'
    })

    document.querySelector('#clear-signature').addEventListener('click', (e) => {
      e.preventDefault()
      signaturePad.clear()
    })

    document.querySelector('#save-signature').addEventListener('click', (e) => {
      e.preventDefault()
      if (signaturePad.isEmpty()) {
        alert('Please provide a signature first.')
      } else {
        const signatureData = signaturePad.toDataURL()
        document.querySelector('#signature_data').value = signatureData
        document.querySelector('#signature-form').submit()
      }
    })
  }
})
        JS
      end
      
      def add_yarn_package
        run "yarn add signature_pad"
      end
    end
  end
end