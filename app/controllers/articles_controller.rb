class ArticlesController < ApplicationController
  #Get /articles
  def index
    #Obtiene los registros
    @articles = Article.all
  end
  #Get /articles/:id
  def show
    #Encontrar registro por id
    @article = Article.find(params[:id])
  end
  #Get /articles/new
  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  #POST /articles
  def create
  @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new
    end
  end
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  #PUT /articles/:id
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
    #@article.update_attributes({title: 'Nuevo Titulo'})
  end

  private

  def article_params
    params.require(:article).permit(:title,:body)
  end
end
