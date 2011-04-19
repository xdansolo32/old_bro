# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Daniel Sun"
  user.email                 "dansun@example.com"
  user.loginId				 "sandun"
  user.password              "foobar"
  user.password_confirmation "foobar"
end