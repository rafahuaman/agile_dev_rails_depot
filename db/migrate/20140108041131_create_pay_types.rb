class CreatePayTypes < ActiveRecord::Migration
  def change
    create_table :pay_types do |t|
      t.string :name

      t.timestamps
    end
    PayType.create(name: "Check")
    PayType.create(name: "Credit card")
    PayType.create(name: "Purchase order")
    
  end
end
