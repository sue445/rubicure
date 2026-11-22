# FIXME: NameError: uninitialized constant ActiveSupport::LoggerThreadSafeLevel::Logger when activesupport < 7.1
require "logger"

require "rubicure"

Precure.each_with_series do |series|
  puts <<~MESSAGE
    ====================
    title:     #{series.title}
    broadcast: #{series.started_date} - #{series.try(:ended_date)}
    girls:     #{series.girls.count}
  MESSAGE

  series.girls.each do |girl|
    puts <<~MESSAGE
      ------------------------
        human_name:      #{girl.human_name}
        human_full_name: #{girl.human_full_name}
        human_real_name: #{girl.human_real_name}
        precure_name:    #{girl.precure_name}
        cast_name:       #{girl.cast_name}
        color:           #{girl.color}
        extra_names:     #{girl[:extra_names]}
        state_names:     #{girl.state_names}
        attack_messages: #{girl.attack_messages}
        transform_message:
      #{girl.transform_message}
    MESSAGE
  end
end
