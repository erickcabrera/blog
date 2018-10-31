class ArticlesController < ApplicationController
  #before_action :validate_user, except: [:show,:index]
  before_action :authenticate_user!, only: [:create, :new]
  before_action :set_article, except: [:index, :new, :create]

  #Get /articles
  def index
    #Obtiene los registros
    @articles = Article.all
  end
  #Get /articles/:id
  def show
    #Encontrar registro por id
    #@article = Article.find(params[:id])
    @article.update_visits_count
  end
  #Get /articles/new
  def new
    @article = Article.new
  end

  def edit

  end

  #POST /articles
  def create
  @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new
    end
  end
  def destroy

    @article.destroy
    redirect_to articles_path
  end

  #PUT /articles/:id
  def update

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
    #@article.update_attributes({title: 'Nuevo Titulo'})
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

  def validate_user
    redirect_to new_user_session_path, notice: "Necesitas iniciar sesion"
  end

  def article_params
    params.require(:article).permit(:title,:body)
  end
end
