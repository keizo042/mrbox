module Mrbox
    COMMAND = "mrbox"
    VERSION = "0.0.1"
    AUTHOR = "Kouichi Nakanishi(keizo042)"

    flags = {
      :help => {},
      :file => {},
      :name => {}
    }
    subcmds = {
       :build => {},
       :mruby => {},
       :mirb => {},
       :mrbc => {},
    }

  class << self
    def banner 
      "Usage: #{COMMAND} [options] [command] ..\nAuthor:#{AUTHOR}" 
    end
    def help
      puts "help"
    end
  end
end
