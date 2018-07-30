defmodule Cms.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string, null: false, size: 150
      add :content, :text, null: false
      add :description, :string, null: false, size: 300
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:articles, [:user_id])
  end
end
