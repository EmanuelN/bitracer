# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Bitracer.Repo.insert!(%Bitracer.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Bitracer.Registration
alias Bitracer.Accounts.User
alias Bitracer.Repo

changeset1 = User.changeset(%User{}, %{
  username: "Bob",
  email: "bob@bitracer.com",
  password: "bitracer",
  password_confirmation: "bitracer"
})
changeset2 = User.changeset(%User{}, %{
  username: "John",
  email: "john@bitracer.com",
  password: "bitracer",
  password_confirmation: "bitracer"
})
changeset3 = User.changeset(%User{}, %{
  username: "Saj",
  email: "saj@bitracer.com",
  password: "bitracer",
  password_confirmation: "bitracer"
})
changeset4 = User.changeset(%User{}, %{
  username: "Emanuel",
  email: "emanuel@bitracer.com",
  password: "bitracer",
  password_confirmation: "bitracer"
})
Registration.create(changeset1, Repo)
Registration.create(changeset2, Repo)
Registration.create(changeset3, Repo)
Registration.create(changeset4, Repo)
