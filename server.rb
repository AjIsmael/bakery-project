require 'sinatra'

class Cookie
  attr_accessor :name, :calories, :description, :price, :image
  def initialize(name, calories, description, price, image)
    self.name = name
    self.calories = calories
    self.description = description
    self.price = price
    self.image = image
  end
end

class Muffin
  attr_accessor :name, :calories, :description, :price, :image
  def initialize(name,calories, description, price, image)
    self.name = name
    self.calories = calories
    self.description = description
    self.price = price
    self.image = image
  end
end

class Cake
  attr_accessor :name, :calories, :description, :price, :image
  def initialize(name,calories, description, price, image)
    self.name = name
    self.calories = calories
    self.description = description
    self.price = price
    self.image = image
  end
end

chocolate_chip_cookie = Cookie.new("Chocolate Chip Cookie", "78 calories per cookie", "chopped up bits from a Nestlé semi-sweet chocolate bar into a cookie", "1.95", "https://media2.s-nbcnews.com/i/newscms/2016_31/1148469/chocolate-chip-cookies-closeup-tease-today-160804_ed3e8232811c7ce9ee02697fc6f5a072.jpg")
peanut_butter_cookie = Cookie.new("Peanut Butter Cookie", "135 calories per cookie", "cookie that is distinguished for having the best peanut butter","1.60", "https://assets.marthastewart.com/styles/wmax-1500/d29/peanut-butter-cookies-a100600/peanut-butter-cookies-a100600_horiz.jpg?itok=4_xrYDLm")
rasperry_cookie = Cookie.new("Rasperry Cookie", "120 calories per cookie", "Thumbprint cookies with a buttery base, filled with raspberry preserves","1.60", "https://friendly-bakery-nycda.herokuapp.com/images/cookies/raspberry-cookies.jpg")

lemon_meringue_cake = Cake.new("Lemon Meringue Cake", "170 calories per slice", "It's not only a deliciously different dessert, but it's also a conversation piece!", "4.50", "https://friendly-bakery-nycda.herokuapp.com/images/cakes/lemon-meringue-cake.jpg")
vanilla_cake = Cake.new("Vanilla Cake with Blueberries", "170 calories per slice", "pairs fluffy vanilla cake layers with a silky vanilla buttercream. the perfect cake for birthdays, weddings, or any occasion!", "4.50", "https://friendly-bakery-nycda.herokuapp.com/images/cakes/vanilla-white-cake.jpg")
neapolitan_ice_cream = Cake.new("Neapolitan Ice Cream","180 calories per slice","tasty combination of chocolate, strawberry, and vanilla ice cream. ", "4.50", "https://friendly-bakery-nycda.herokuapp.com/images/cakes/neapolitan-ice-cream-cake.jpg")

apple_pie_muffins = Muffin.new("Apple Pie Muffins", "180 calories per muffin","These buttery fruity muffins are ideal for dessert or fancy weekend breakfast treats.", "2.70", "https://friendly-bakery-nycda.herokuapp.com/images/muffins/apple-pie-muffins.jpg")
coffee_cake_muffins = Muffin.new("Coffee Cake Muffins","180 calories per muffin","Coffee Cake Muffins, with its sweet center and crumble topping, make a great dish to serve at a brunch, or bring to a potluck.","2.70","https://friendly-bakery-nycda.herokuapp.com/images/muffins/coconut-muffins.jpg")
coconut_muffins = Muffin.new("Coconut Muffins", "180 calories per muffin", "Muffins loaded with coconut are one my favorite muffins for an easy breakfast or a sweet treat late at night.", "2.70", "https://friendly-bakery-nycda.herokuapp.com/images/muffins/coconut-muffins.jpg")



get "/" do
  erb :home
end

get "/cakes" do
  @cakes = [lemon_meringue_cake, vanilla_cake, neapolitan_ice_cream]
  erb :cakes
end

get "/cookies" do
  @cookies = [chocolate_chip_cookie, peanut_butter_cookie, rasperry_cookie]
  erb :cookies
end
get "/muffins" do
  @muffins = [apple_pie_muffins,coffee_cake_muffins,coconut_muffins]
  erb :muffins
end

get "/events" do
  erb :events
end

get "/home" do
  erb :home
end

get "/cart" do
  erb :cart
end
