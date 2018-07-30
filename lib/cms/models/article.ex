defmodule Cms.Models.Article do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Cms.Models.Article
  alias Cms.Repo
  alias Cms.Models.User

  schema "articles" do
    field :content, :string
    field :description, :string
    field :title, :string

    belongs_to(:user, User)
    timestamps()
  end

  @attr_valid [:title, :content, :description, :user_id]

  def changeset(article, attrs) do
    article
    |> cast(attrs, @attr_valid)
    |> validate_required(@attr_valid)
    |> validate_length(:title, [min: 6, max: 200])
    |> validate_length(:content, min: 5)
    |> validate_length(:description, [min: 5, max: 200])
  end

  def list_articles(offset), do: do_query(offset)
  def list_articles(), do: do_query(0)

  defp do_query(offset) do
    query =
      from a in Article,
      join: u in User, on: [id: a.user_id],
      preload: [user: u],
      offset: ^offset,
      limit: 10

    Repo.all(query)
  end


  def get_article(id) do
    query =
      from a in Article,
      join: u in User, on: [id: a.user_id],
      preload: [user: u],
      where: a.id == ^id

    Repo.one(query)
  end


  def create_article(attrs \\ %{}) do
    %Article{}
    |> Article.changeset(attrs)
    |> Repo.insert()
  end


  def update_article(%Article{} = article, attrs) do
    article
    |> Article.changeset(attrs)
    |> Repo.update()
  end


  def delete_article(%Article{} = article) do
    Repo.delete(article)
  end


  def change_article(%Article{} = article) do
    Article.changeset(article, %{})
  end
end
