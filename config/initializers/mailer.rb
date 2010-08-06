ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'anticlever.com',
  :user_name            => 'jobber@anticlever.com',
  :password             => 'j0b9753',
  :authentication       => 'plain',
  :enable_starttls_auto => true
}
