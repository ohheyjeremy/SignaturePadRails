# lib/generators/signature_pad_rails/templates/migration.rb
class CreateSignaturePadRailsSignatures < ActiveRecord::Migration[7.0]
  def change
    create_table :signature_pad_rails_signatures do |t|
      t.text :data
      t.references :signable, polymorphic: true, null: false
      
      t.timestamps
    end
  end
end