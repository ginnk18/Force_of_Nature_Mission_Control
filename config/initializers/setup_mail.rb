ActionMailer::Base.smtp_settings = {
  address: 'smtp.sendgrid.net',
  port: '587',
  enable_starttls_auto: true,
  authentication: :plain,
  user_name: ENV['SENDGRID_USER_NAME'],
  password: ENV['SENDGRID_PASSWORD']
}
