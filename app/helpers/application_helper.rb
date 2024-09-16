module ApplicationHelper
  def data_br(data_us)
    data_us.strftime("%d/%m/%Y")
  end

  def ambiente_rails
    if Rails.env.development?
      "desenvolvimento"
    elsif Rails.env.production?
      "Produçao"
    else 
      "teste"
    end
  end
    
end
