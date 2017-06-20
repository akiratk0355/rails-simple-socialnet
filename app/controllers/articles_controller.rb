class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  def show
    @article = Article.find(params[:id])
  end
  def new
    @article = Article.new
  end
  def edit
  end
  def create
    #render plain: params[:article].inspect
    @article = Article.new
    @article.update_attributes(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end
  def update
  end
  
  private
  def article_params
    params.require(:article).permit(:title, :text)
  end
end
