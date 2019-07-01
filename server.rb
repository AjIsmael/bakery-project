require 'sinatra'
require "httparty"
require "action_mailer"
require "./mailer.rb"
require "./spreadsheet.rb"

app_key = ENV['Eventbrite_key']

Orders = []

def add_order(name, quantity)
  new_item = true
  for order in Orders
    if order[0] == name.name
      order[1] += quantity
      new_item = false
    end
  end
  if new_item == true
    Orders << [name.name, quantity, name.price]
  end
end
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

chocolate_chip_cookie = Cookie.new("Chocolate Chip Cookie", "78 calories per cookie", "Chopped up bits from a Nestlé semi-sweet chocolate bar into a cookie", 1.95, "https://media2.s-nbcnews.com/i/newscms/2016_31/1148469/chocolate-chip-cookies-closeup-tease-today-160804_ed3e8232811c7ce9ee02697fc6f5a072.jpg")
peanut_butter_cookie = Cookie.new("Peanut Butter Cookie", "135 calories per cookie", "Cookie that is distinguished for having the best peanut butter",1.60, "https://assets.marthastewart.com/styles/wmax-1500/d29/peanut-butter-cookies-a100600/peanut-butter-cookies-a100600_horiz.jpg?itok=4_xrYDLm")
rasperry_cookie = Cookie.new("Rasperry Cookie", "120 calories per cookie", "Thumbprint cookies with a buttery base, filled with raspberry preserves",1.60, "https://friendly-bakery-nycda.herokuapp.com/images/cookies/raspberry-cookies.jpg")

lemon_meringue_cake = Cake.new("Lemon Meringue Cake", "170 calories per slice", "It's not only a deliciously different dessert; it's also a conversation piece!", 4.50, "https://friendly-bakery-nycda.herokuapp.com/images/cakes/lemon-meringue-cake.jpg")
vanilla_cake = Cake.new("Vanilla with berries", "170 calories per slice", "Pairs fluffy vanilla cake layers with a silky vanilla buttercream.", 4.50, "https://friendly-bakery-nycda.herokuapp.com/images/cakes/vanilla-white-cake.jpg")
neapolitan_ice_cream = Cake.new("Neapolitan Ice Cream","180 calories per slice","Tasty combination of chocolate, strawberry, and vanilla ice cream. ", 4.50, "https://friendly-bakery-nycda.herokuapp.com/images/cakes/neapolitan-ice-cream-cake.jpg")

apple_pie_muffins = Muffin.new("Apple Pie Muffins", "180 calories per muffin","These buttery fruity muffins are ideal for dessert or fancy breakfast treats.", 2.70, "https://friendly-bakery-nycda.herokuapp.com/images/muffins/apple-pie-muffins.jpg")
coffee_cake_muffins = Muffin.new("Coffee Cake Muffins","180 calories per muffin","Its sweet center and crumble topping, a great dish to serve.",2.70,"https://friendly-bakery-nycda.herokuapp.com/images/muffins/coconut-muffins.jpg")
coconut_muffins = Muffin.new("Coconut Muffins", "180 calories per muffin", "Loaded with coconut are for an easy breakfast or a sweet treat.", 2.70, "https://friendly-bakery-nycda.herokuapp.com/images/muffins/coconut-muffins.jpg")

CAKES =  [lemon_meringue_cake, vanilla_cake, neapolitan_ice_cream]
MUFFINS = [apple_pie_muffins,coffee_cake_muffins,coconut_muffins]
COOKIES = [chocolate_chip_cookie, peanut_butter_cookie, rasperry_cookie]

def send_email(rec)
  Newsletter.menu(rec,COOKIES,CAKES,MUFFINS).deliver_now
end

get "/" do
  erb :home
end

get "/cakes" do
  @cakes = CAKES
  if params[:cake0].to_i > 0
    add_order(lemon_meringue_cake, params[:cake0].to_i)
  end
  if params[:cake1].to_i > 0
    add_order(vanilla_cake, params[:cake1].to_i)
  end
  if params[:cake2].to_i > 0
    add_order(neapolitan_ice_cream, params[:cake2].to_i)
  end
  @ordersNum = Orders.length
  erb :cakes
end

get "/cookies" do
  @cookies = COOKIES
  if params[:cookie0].to_i > 0
    add_order(chocolate_chip_cookie, params[:cookie0].to_i)
  end
  if params[:cookie1].to_i > 0
    add_order(peanut_butter_cookie, params[:cookie1].to_i)
  end
  if params[:cookie2].to_i > 0
    add_order(rasperry_cookie, params[:cookie2].to_i)
  end
  @ordersNum = Orders.length
  erb :cookies
end
get "/muffins" do
  @muffins = MUFFINS
  if params[:muffin0].to_i > 0
    add_order(apple_pie_muffins, params[:muffin0].to_i)
  end
  if params[:muffin1].to_i > 0
    add_order(coffee_cake_muffins, params[:muffin1].to_i)
  end
  if params[:muffin2].to_i > 0
    add_order(coconut_muffins, params[:muffin2].to_i)
  end
  @ordersNum = Orders.length
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
  send_email(params[:Email]) if params[:Email]
  erb :home
end

get "/cart" do
  @order = Orders
  @confirmedOrder = false
  erb :cart
end

def confirm_order(recipent, fullname, order, orderNum, time)
  Newsletter.confirmOrder(recipent, fullname, order, orderNum, time).deliver_now
end
post "/cart" do
  @orderNum = rand.to_s[2..10]
  create_ticket(Orders,@orderNum)
  order = Orders
  @name = params[:FullName]
  @email = params[:Email]
  @time = Time.now
  @confirmedOrder = true
  confirm_order(@email, @name, order, @orderNum, @time)
  Orders.clear
  @order = Orders
  erb :cart
end
