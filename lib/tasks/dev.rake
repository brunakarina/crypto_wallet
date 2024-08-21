namespace :dev do
  desc "Set up the development environment."
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") { %x(rails db:drop) }
   
      show_spinner("Criando BD...")  { %x(rails db:create) }
    
      show_spinner("Migrando BD...") { %x(rails db:migrate) }

      %x(rails dev:add_coins)
      %x(rails dev:add_mining_types)     
    else
      puts "You are not in development environment."
    end    
  end

  desc "registering cryptocurrencies"
    task add_coins: :environment do
      show_spinner("Cadastrando moedas...") do
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
    end
  end

  desc "Cadastro de Tipos de Mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração...") do
      mining_types = [
        {name: "Proof of Work", acronym: "PoW"},
        {name: "Proof of Stake", acronym: "PoS"},
        {name: "Proof of Capacity", acronym: "PoC"},
      ]
      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end
    end
  end


  private
  
  def show_spinner(msg_start, msg_end = "successfully completed!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
