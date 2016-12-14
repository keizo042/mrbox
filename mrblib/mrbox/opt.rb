module Mrbox
  class Opt 
    attr_reader :options, :mrbox, :mruby

    def initialize
      @options = {}
      @mrbox = []
      @mruby = []
      @parser = OptionParser.new do |opt|
        opt.on("-f", "--file VALUE", "set your bulid config.rb. default: build_config.rb") do |v|
            @options[:file] = v
        end
        opt.on("-n", "--name=VALUE", "set build_config's name") do |v|
          @options[:name] = v
        end
        end
    end

    def run(argv)
      sp = argv.index("--")
      if sp.nil?
        @mrbox = argv
        @mruby = []
      else
        @mrbox = argv[0, sp ].to_a
        @mruby = argv[sp + 1 ,argv.length - 1].to_a
      end
      @parser.parse!(@mrbox)
      @mrbox.shift

      self
    end
  end
end
