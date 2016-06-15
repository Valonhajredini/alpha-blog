class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :edit, :show, :destroy]
  before_action :require_user, exept: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  def index
  @articles = Article.paginate(page: params[:page], per_page: 5)
end
  def new
    @article = Article.new
  end
  def edit
  @article = set_article
  end
  def show
    set_article
  end

  def create

    @article = Article.new(article_params)
     @article.user = current_user

    if @article.save
      flash[:success] = "Article wos successfully created"
      redirect_to article_path(@article)

  else
    render 'new'
  end
  end
  def update

    if set_article.update(article_params)
      flash[:success] = "Article wos successfully created"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
def destroy
  set_article.destroy
  flash[:danger]= "Article wos succesfully destroyt"
  redirect_to articles_path


end

  private
def set_article
  @article = Article.find(params[:id])
end
  def article_params
    params.require(:article).permit(:title, :description)
  end
def require_same_user
  if current_user != @article.user
    flash[:danger] = "You can only edit and delete your own articles"
    redirect_to root_path
  end
end
end