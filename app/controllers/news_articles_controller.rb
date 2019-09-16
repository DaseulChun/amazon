class NewsArticlesController < ApplicationController
  
  before_action :find_news_article, only: [:show, :edit, :update, :destroy]

  def new
    @news_article = NewsArticle.new
  end

  def create
    @news_article = NewsArticle.new news_article_params
    if @news_article.save
      redirect_to @news_article
    else
      render :new
    end
  end

  def index
    @news_articles = NewsArticle.order(created_at: :desc)
  end

  def show
    @news_article = NewsArticle.find(params[:id])
  end

  def destroy
    @news_article = NewsArticle.find(params[:id])
    @news_article.destroy
    redirect_to news_articles_path
    flash[:danger] = "News Article destroyed!"
  end

  private

  def news_article_params
    params.require(:news_article).permit(:title, :description)
  end

  def find_news_article
    @news_article = NewsArticle.find params[:id]
  end
end
