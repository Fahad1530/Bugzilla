
User.create!([{
  name: "Fahad",
  email: "fahadmurtaza1530@gmail.com",
  password: 123456,
  role: "manager"

},
{
  name: "ali",
  email: "fahad.murtaza@devsinc.com",
  role: "developer",
  password: 123456

},
{
  name: "ibrar",
  email: "ibrarhussain0602@gmail.com",
  role: "qa",
  password: 123456
}])

u = User.create(name: "Fahad",
  email: "fahadmurtaza1530@gmail.com",
  password: 123456,
  role: "manager")
  
