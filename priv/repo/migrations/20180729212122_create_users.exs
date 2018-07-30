defmodule Cms.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false, size: 100
      add :email, :string, null: false, size: 100
      add :password, :string, null: false, size: 200
      
      timestamps()
    end

  end
end
