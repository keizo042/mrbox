module Mrbox
    COMMAND = "mrbox"
    VERSION = "0.1.0"
    AUTHOR = "Kouichi Nakanishi(keizo042)"

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
    def description
    end
    def help
      banner
      description
    end
  end
end
