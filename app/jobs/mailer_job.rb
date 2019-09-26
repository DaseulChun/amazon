class MailerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "--------------------------"
    puts "---- Running Job ----"
    puts "--------------------------"
  end
end
