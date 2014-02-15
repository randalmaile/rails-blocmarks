class MailProcessor
  attr_reader :pop3

  def pop3
    {
      server: 'pop.gmail.com', port: 995, ssl: true,
      username: ENV['GMAIL_USERNAME'],
      password: ENV['GMAIL_PASSWORD']
    }
  end
end
