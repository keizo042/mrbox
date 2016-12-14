module Mrbox
  class Opt 

    def initialize
      @options = {}
      @parser = OptionParser.new do |opt|
        opt.version = Mrbox::VERSION
        opt.banner = Mrbox.banner

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
        cmds = argv
        mrbs = []
      else
        cmds = argv[0, sp - 1].to_a
        mrbs = argv[sp + 1 ,argv.length - 1].to_a
      end

      @parser.parse!(cmds)

      return cmds, mrbs, @options
    end
  end
end
