defmodule JITJerky.Repo.Migrations.CreateAddress do
  use Ecto.Migration

  def change do
    create table(:address) do
      add :country, :string
      add :name, :string
      add :address_line1, :string
      add :address_line2, :string
      add :city, :string
      add :province, :string
      add :postal_code, :string
      add :telephone, :string

      timestamps()
    end

  end
end
