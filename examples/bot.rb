require 'facebook/messenger'

include Facebook::Messenger

Bot.on :message do |message|
  puts "Received '#{message.inspect}' from #{message.sender}"
  cmd = message.text
  cmd = cmd.split.each_slice(1).map{|a|a.join ' '}

  case message.text
  when /^(!)shell/
   # cmd = message.text
   # cmd.split.each_slice(1).map{|a|a.join ' '}

    message.reply(
      text: `#{cmd[1]} #{cmd[2]} #{cmd[3]} #{cmd[4]} #{cmd[5]} #{cmd[6]} #{cmd[7]} #{cmd[8]} #{cmd[9]} #{cmd[10]}`
     #text: "kk"
    )
  when /^(!)ansible-shell/
    message.reply(
      text: `ansible -m shell -a #{cmd[1]} #{cmd[2]} #{cmd[3]} #{cmd[4]} #{cmd[5]} #{cmd[6]} #{cmd[7]} #{cmd[8]} #{cmd[9]} #{cmd[10]}`
   )
  when /^(!)ansible-playbook/
    message.reply(
      text: `ansible-playbook #{cmd[1]} #{cmd[2]} #{cmd[3]} #{cmd[4]} #{cmd[5]} #{cmd[6]} #{cmd[7]} #{cmd[8]} #{cmd[9]} #{cmd[10]}`
   )
  when /something humans like/i
    message.reply(
      text: 'I found something humans seem to like:'
    )

    message.reply(
      attachment: {
        type: 'image',
        payload: {
          url: 'https://i.imgur.com/iMKrDQc.gif'
        }
      }
    )

    message.reply(
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: 'Did human like it?',
          buttons: [
            { type: 'postback', title: 'Yes', payload: 'HUMAN_LIKED' },
            { type: 'postback', title: 'No', payload: 'HUMAN_DISLIKED' }
          ]
        }
      }
    )
  else
    message.reply(
      text: 'You are now marked for extermination.'
    )

    message.reply(
      text: 'Have a nice day.'
    )
  end
end

Bot.on :postback do |postback|
  case postback.payload
  when 'HUMAN_LIKED'
    text = 'That makes bot happy!'
  when 'HUMAN_DISLIKED'
    text = 'Oh.'
  end

  postback.reply(
    text: text
  )
end

Bot.on :delivery do |delivery|
  puts "Delivered message(s) #{delivery.ids}"
end
