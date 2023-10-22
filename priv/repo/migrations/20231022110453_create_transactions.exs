defmodule ChpterCallbackUrl.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :message, :string
      add :success, :boolean, default: false, null: false
      add :status, :integer
      add :amount, :string
      add :transaction_code, :string
      add :transaction_reference, :string

      timestamps()
    end
  end
end
