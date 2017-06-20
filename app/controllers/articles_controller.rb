class ArticlesController < ApplicationController
  def index
  end
  def show
    @article = Article.find(params[:id])
  end
  def new
  end
  def edit
  end
  def create
    #render plain: params[:article].inspect
    @article = Article.new
    @article.update_attributes(article_params)
    @article.save
    redirect_to @article
  end
  def update
  end
  
  private
  def article_params
    params.require(:article).permit(:title, :text)
  end
end
