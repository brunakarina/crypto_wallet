namespace :dev do
  desc "Set up the development environment."
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") { %x(rails db:drop)}
   
      show_spinner("Criando BD...")  {%x(rails db:create)}
    
      show_spinner("Migrando BD...") {%x(rails db:migrate)}

      show_spinner("Populando BD...") {%x(rails db:seed)}
       
    else
      puts "You are not in development environment."
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
