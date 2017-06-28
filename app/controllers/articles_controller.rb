class ArticlesController < ApplicationController
  load_and_authorize_resource
  def index
    @articles = Article.order(updated_at: :desc)
    @articles = @articles.includes(:user, :comments)
  end
  def show
    @article = Article.find(params[:id])
  end
  def new
    @article = Article.new
  end
  def edit
    @article = Article.find(params[:id])
  end
  def create
    #render plain: params[:article].inspect
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to articles_path
    else
      render 'new'
    end
  end
  def update
    @article = Article.find(params[:id])
    
    if @article.update(article_params) # invokes validation
      redirect_to @article
    else
      render 'edit'
    end
  end
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    
    redirect_to articles_path
  end
  
  private
  def article_params
    params.require(:article).permit(:title, :text)
  end
end
