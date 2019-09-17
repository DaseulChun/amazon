require 'rails_helper'

RSpec.describe NewsArticlesController, type: :controller do

  # There are many situations, we need to simulating signing in a user
  # to reduce duplicated lines, 
  # made current_user into method on the very top 
  # to use it all over the tests 
  def current_user
    @current_user ||= FactoryBot.create(:user)
  end

  describe '#new' do
    context "without signed in user" do
      it "redirects the user to session new" do
        get(:new)
        expect(response).to redirect_to new_session_path
      end
      it "sets a danger flash message" do
        get(:new)
        expect(flash[:danger]).to be
      end
    end

    context 'with signed in user' do
      # To simulate signing in a user 
      before do
        session[:user_id] = current_user.id
      end

      it "renders a new template" do
        get(:new)
        expect(response).to(render_template(:new))
      end
      
      it "sets an instance variable with a new news article" do
        get(:new)
        expect(assigns(:news_article)).to(be_a_new(NewsArticle))
      end
    end
  end

  describe '#create' do
    # method that will gonna be used in '#create' actions testing
    def valid_request
      post(:create, params: {news_article: FactoryBot.attributes_for(:news_article)})
    end

    context "without signed in user" do
      it "redirects to the new session page" do
        valid_request
        expect(response).to redirect_to new_session_path
      end
    end

    # below will be almost all failed for the first time (authentication)
    # since news_articles DOES NOT associated with user, yet
    context "with signed in user" do
      # To simulate sigining in user
      before do
        session[:user_id] = current_user.id
      end

      context "with valid parameters" do
        it "saves a new news article to the db" do
          count_before = NewsArticle.count
          valid_request
          count_after = NewsArticle.count
          expect(count_after).to eq(count_before + 1)
        end

        it "redirects to the show page of that news article" do
          valid_request
          news_article = NewsArticle.last
          expect(response).to(redirect_to(news_article_path(news_article.id)))
        end
      end

      context "with invalid parameters" do
        def invalid_request
          post(:create, params: {news_article: FactoryBot.attributes_for(:news_article, title: nil)})
        end

        it "does not create a news article in the db" do
          count_before = NewsArticle.count
          invalid_request
          count_after = NewsArticle.count
          expect(count_after).to eq(count_before)
        end

        it "renders the new template" do
          invalid_request
          expect(response).to render_template(:new)
        end

        it "assigns an invalid news article as an instance variable" do
          invalid_request
          expect(assigns(:news_article)).to be_a(NewsArticle)
          expect(assigns(:news_article).valid?). to be false
        end
      end
    end
  end

  describe '#show' do
    it "renders the show template" do
      # need to add association : news_article factory file
      # will get 
      # Validation failed: User must exist Error
      news_article = FactoryBot.create(:news_article)
      get(:show, params: { id: news_article.id })
      expect(response).to render_template :show
    end
    
    it "sets @news_article for the shown object" do
      news_article = FactoryBot.create(:news_article)
      get(:show, params: { id: news_article.id })
      expect(assigns(:news_article)).to eq(news_article)
    end
  end

  describe '#destroy' do
    context "without signed in user" do
    end

    context "with signed in user" do
      context "with news article owner" do
        it "removes the news article from the db" do
          news_article = FactoryBot.create(:news_article)
          delete(:destroy, params: { id: news_article.id })
          expect(NewsArticle.find_by(id: news_article.id )).to(be(nil))
        end

        it "redirects to the news articles index" do
          news_article = FactoryBot.create(:news_article)
          delete(:destroy, params: { id: news_article.id })
          expect(response).to redirect_to news_articles_path
        end

        it "sets a flash message" do
          news_article = FactoryBot.create(:news_article)
          delete(:destroy, params: { id: news_article.id })
          expect(flash[:danger]).to be
        end
      end

      context "with news article non-owner" do
      end
    end
  end

  describe '#index' do
    before do
      get :index
    end
    it "renders the index template" do
      # get(:index)
      expect(response).to render_template(:index)
    end

    it "assigns an instance variable to all created news articles" do
      # get(:index)
      news_article_1 = FactoryBot.create(:news_article)
      news_article_2 = FactoryBot.create(:news_article)
      expect(assigns(:news_articles)).to eq([news_article_2, news_article_1])
    end
  end
end
