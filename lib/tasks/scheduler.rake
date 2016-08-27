desc "This task is called by the Heroku scheduler add-on"

task :send_reminders => :environment do
  puts "Sending reminders..."
  puts Date.today + 1.week
  reminders = 0
  Membership.all.each do |membership|
    if (membership.member.memberships.first.end_date <= (Date.today + 1.week) && 
      membership.end_date == (Date.today + 1.week))
      membership.send_expiration_reminder_email
      reminders += 1
    end
  end
  puts reminders
  puts "reminders sent"
end