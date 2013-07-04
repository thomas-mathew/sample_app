ActionMailer::Base.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  domain:               'gmail.com',
  user_name:            'qvbproject@gmail.com',
  password:             'Chicago91',
  authentication:       'plain',
  enable_starttls_auto: true  
}
