require "action_mailer"
# set which directory ActionMailer should use
ActionMailer::Base.view_paths = File.dirname(__FILE__)

# ActionMailer configuration
ActionMailer::Base.smtp_settings = {
  address:    "smtp.gmail.com",
  port:       '587',
  user_name:  ENV['User_email'],
  password:   ENV['user_password'],
  authentication: :plain
}

class Newsletter < ActionMailer::Base
  default from: "from@example.com"
  def menu(recipent)
    mail(to: recipent, subject: 'Here is Aj\'s Bakery Catalog')
  end
end
