# frozen_string_literal: true

user1 = User.new(
  name: 'Fahad',
  email: 'fahadmurtaza1530gmail.com',
  password: 123_456,
  role: 'manager'
)
user1.skip_confirmation!
user1.save!

user1.projects.create(
  title: 'Fahad Project'
)

user1.projects.create(
  title: 'Second Project'
)

user1.projects.create(
  title: 'Third Project'
)

user1.projects.create(
  title: 'Third Project'
)

user1.projects.create(
  title: 'Third Project'
)

user2 = User.new(
  name: 'ali',
  email: 'fahad.murtaza@devsinc.com',
  role: 'developer',
  password: 123_456
)
user2.skip_confirmation!
user2.save!

user3 = User.new(
  name: 'ibrar',
  email: 'ibrarhussain0602@gmail.com',
  role: 'qa',
  password: 123_456
)
user3.skip_confirmation!
user3.save!
