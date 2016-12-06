module Mrbox
  COMMAND = "mrbox"
  VERSION = "0.0.1"
  AUTHOR = "Kouichi Nakanishi(keizo042)"
  attr_accessor :banner

  def banner 
    "Usage: #{COMMAND} [options] [command] ..\nAuthor:#{AUTHOR}" 
  end
end
