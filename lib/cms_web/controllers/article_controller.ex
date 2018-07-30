defmodule CmsWeb.ArticleController do
  use CmsWeb, :controller
  alias Cms.Models.Article

  def index(conn, %{"offset" => offset} ) do
    articles = get_articles(offset)
    render(conn, "index.html", articles: articles)
  end

  def index(conn, _params) do
    articles = Article.list_articles()
    render(conn, "index.html", articles: articles)
  end



  def new(conn, _params) do
    changeset = Article.change_article(%Article{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"article" => article_params}) do

    case Article.create_article(article_params) do
      {:ok, article} ->
        conn
        |> put_flash(:info, "Article created successfully.")
        |> redirect(to: article_path(conn, :show, article))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    article = Article.get_article(id)
    render(conn, "show.html", article: article)
  end

  def edit(conn, %{"id" => id}) do
    article = Article.get_article!(id)
    changeset = Article.change_article(article)
    render(conn, "edit.html", article: article, changeset: changeset)
  end

  def update(conn, %{"id" => id, "article" => article_params}) do
    article = Article.get_article!(id)

    case Article.update_article(article, article_params) do
      {:ok, article} ->
        conn
        |> put_flash(:info, "Article updated successfully.")
        |> redirect(to: article_path(conn, :show, article))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", article: article, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    article = Article.get_article!(id)
    {:ok, _article} = Article.delete_article(article)

    conn
    |> put_flash(:info, "Article deleted successfully.")
    |> redirect(to: article_path(conn, :index))
  end


  defp get_articles(offset) do
    with {offset, _} <- Integer.parse(offset) do
      Article.list_articles(offset)
    else
      :error -> Article.list_articles()
    end
  end
end
