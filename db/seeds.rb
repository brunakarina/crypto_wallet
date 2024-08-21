# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

spinner = TTY::Spinner.new("[:spinner] Cadastrando moedas...")
spinner.auto_spin

coins = [
          {
            description: "bitcoin",
            acronym: "BTC",
            url_image: "https://static.vecteezy.com/system/resources/previews/019/767/927/non_2x/bitcoin-logo-bitcoin-icon-transparent-free-png.png"
          },
        ]

coins.each do |coin|
  Coin.find_or_create_by!(coin)
end

spinner.success("(Concluido!)")