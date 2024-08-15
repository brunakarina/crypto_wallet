class WelcomeController < ApplicationController
  def index
    @meu_nome = params[:nome] #params variavel global e acessamos através da chave :nome
  end
end
