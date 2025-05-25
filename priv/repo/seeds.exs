# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LostFound.Repo.insert!(%LostFound.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias LostFound.ROLES
alias LostFound.USERS
alias LostFound.CATEGORIES

roles = [
  %{name: "ADMIN", description: "SUPER_USER"}
]

for role <- roles do
  ROLES.create_role(role)
end

admin = %{
  fname: "Natasha",
  lname: "Lubumbe",
  gender: "F",
  phone: "0974283737",
  password: "tasha",
  role_id: 1
}

USERS.create_user(admin)

