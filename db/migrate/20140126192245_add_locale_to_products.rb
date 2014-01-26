class AddLocaleToProducts < ActiveRecord::Migration
  def change
    add_column :products, :locale, :string
    
    Product.all.each do |product|
      product.locale = "en"
    end
  end
end
