require 'sinatra'
require "httparty"

app_key = 'AVPKBRW3EJMHUBKBT347'

Orders = []
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
vanilla_cake = Cake.new("Vanilla Cake with Blueberries", "170 calories per slice", "pairs fluffy vanilla cake layers with a silky vanilla buttercream.", "4.50", "https://friendly-bakery-nycda.herokuapp.com/images/cakes/vanilla-white-cake.jpg")
neapolitan_ice_cream = Cake.new("Neapolitan Ice Cream","180 calories per slice","tasty combination of chocolate, strawberry, and vanilla ice cream. ", "4.50", "https://friendly-bakery-nycda.herokuapp.com/images/cakes/neapolitan-ice-cream-cake.jpg")

apple_pie_muffins = Muffin.new("Apple Pie Muffins", "180 calories per muffin","These buttery fruity muffins are ideal for dessert or fancy breakfast treats.", "2.70", "https://friendly-bakery-nycda.herokuapp.com/images/muffins/apple-pie-muffins.jpg")
coffee_cake_muffins = Muffin.new("Coffee Cake Muffins","180 calories per muffin","Its sweet center and crumble topping, is great dish to serve at a brunch.","2.70","https://friendly-bakery-nycda.herokuapp.com/images/muffins/coconut-muffins.jpg")
coconut_muffins = Muffin.new("Coconut Muffins", "180 calories per muffin", "Loaded with coconut are for an easy breakfast or a sweet treat late at night.", "2.70", "https://friendly-bakery-nycda.herokuapp.com/images/muffins/coconut-muffins.jpg")



get "/" do
  erb :home
end

get "/cakes" do
  @cakes = [lemon_meringue_cake, vanilla_cake, neapolitan_ice_cream]
  erb :cakes
end

get "/cookies" do
  @cookies = [chocolate_chip_cookie, peanut_butter_cookie, rasperry_cookie]
  if params[:cookie0].to_i > 0
    Orders << [chocolate_chip_cookie.name, params[:cookie0],chocolate_chip_cookie.price]
  end
  erb :cookies
end
get "/muffins" do
  @muffins = [apple_pie_muffins,coffee_cake_muffins,coconut_muffins]
  erb :muffins
end

get "/events" do
  response = HTTParty.get("https://www.eventbriteapi.com/v3/events/search/?q=baking&location.address=#{params[:address]}&price=free&token=#{app_key}", format: :plain)
  jsonFile = JSON.parse response, symbolize_names: true
  events = jsonFile.dig(:events)
  eventtitles = []
  describtion = []
  start_date = []
  image = []
  1..3.times do |i|
    event = events[i]
    eventtitles << event.dig(:name,:text)
    describtion << event.dig(:url)
    start_date << event.dig(:start,:local).split('T')[0]
    image << event.dig(:logo,:original, :url)
  end

  @titles = eventtitles
  @description=  describtion
  @date = start_date
  @image = image
  erb :events
end

get "/home" do
  erb :home
end

get "/cart" do
  @order = Orders
  erb :cart
end
