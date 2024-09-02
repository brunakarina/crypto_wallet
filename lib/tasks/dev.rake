namespace :dev do
  desc "Set up the development environment."
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") { %x(rails db:drop) }
   
      show_spinner("Criando BD...")  { %x(rails db:create) }
    
      show_spinner("Migrando BD...") { %x(rails db:migrate) }

      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
           
    else
      puts "You are not in development environment."
    end    
  end

  desc "registering cryptocurrencies"
    task add_coins: :environment do
      show_spinner("Cadastrando moedas...") do
      coins = [
              {
                description: "Bitcoin",
                acronym: "BTC",
                url_image: "https://static.vecteezy.com/system/resources/previews/019/767/927/non_2x/bitcoin-logo-bitcoin-icon-transparent-free-png.png",
                mining_type_id: MiningType.find_by(acronym: 'PoW').id
              },
              { 
                  description: "Ethereum",
                  acronym: "ETH",
                  url_image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZCRfwkqpPvFb3QmmwGONG2i6PsgnqZ3L7dRzCNlaSTB1-ruu5",
                  mining_type: MiningType.all.sample
                },
                { 
                  description: "Dash",
                  acronym: "DASH",
                  url_image: "https://ih1.redbubble.net/image.406055498.8711/ap,550x550,12x12,1,transparent,t.png",
                  mining_type: MiningType.all.sample
                },
                { 
                  description: "Iota",
                  acronym: "IOT",
                  url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/1720.png",
                  mining_type: MiningType.all.sample
                },
                { 
                  description: "ZCash",
                  acronym: "ZEC",
                  url_image: "https://www.cryptocompare.com/media/351360/zec.png",
                  mining_type: MiningType.all.sample
                }
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
        {description: "Proof of Work", acronym: "PoW"},
        {description: "Proof of Stake", acronym: "PoS"},
        {description: "Proof of Capacity", acronym: "PoC"},
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
