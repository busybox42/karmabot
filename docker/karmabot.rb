#!/bin/sh

touch /usr/src/app/karmabot.tmp

cat <<EOF > /usr/src/app/karmabot.tmp 
#!/usr/local/bin/ruby

require 'slack-ruby-client'
require 'json'

time = Time.now.to_i

Slack.configure { |config| config.token = "$TOKEN" }
client = Slack::Web::Client.new
loop {
  client.chat_postMessage(channel: "$CHANNEL", text: "ruby++", as_user: true);
  client.chat_postMessage(channel: "$CHANNEL", text: "perl--", as_user: true);
  sleep 1
  a = client.conversations_history(channel: "$CHANNEL", inclusive: true, oldest: time).to_json;
  msg = JSON.parse(a)['messages'].reverse
  msg.each do |t|
    e = t['ts'].to_i
    ts = Time.at(e)
    if t['username'].nil?
      u = "Me"
    else
      u = t['username']
    end
    puts "#{ts} #{u}: #{t['text']}"
  end
  client.im_mark(channel: "$CHANNEL", ts: time)
  time = Time.now.to_i
  sleep (rand(300..1200))
}
EOF

chmod +x /usr/src/app/karmabot.tmp
mv /usr/src/app/karmabot.rb /usr/src/app/karmabot_installer
mv /usr/src/app/karmabot.tmp /usr/src/app/karmabot.rb

/usr/src/app/karmabot.rb
