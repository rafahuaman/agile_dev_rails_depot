class AddPayTypeToOrders < ActiveRecord::Migration
  def up
    rename_column :orders, :pay_type, :old_pay_type
    add_reference :orders, :pay_type
    Order.all.each do |order|
      order.pay_type = PayType.find_by name: order.old_pay_type
      order.save!
    end
    remove_column :orders, :old_pay_type
  end
  
  def down
    add_column :orders, :pay_type_new, :string
    Order.all.each do |order|
      order.pay_type_new = PayType.find(order.pay_type_id).name
      order.save!
    end
    remove_reference :orders, :pay_type
    rename_column :orders, :pay_type_new, :pay_type
  end
end
