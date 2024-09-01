class AddMiningTypeToCoins < ActiveRecord::Migration[5.2]
  def change
    add_reference :coins, :mining_type, foreign_key: true, null: true
    #add uma referencia na tabela coins, esse campo mining_type que ele está add na tabela coins, ele vai ter uma referencia (chave estrangeira)
  end
end
