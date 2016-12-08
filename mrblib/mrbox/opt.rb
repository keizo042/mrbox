module Mrbox
  class Opt 

    def initialize
      @options = {}
    end

    def run(argv)
      parser = OptionParser.new do |opt|
        opt.version = Mrbox::VERSION
        opt.banner = Mrbox.banner

        opt.on("-f", "--file VALUE", "set your bulid config.rb. default: build_config.rb") do |v|
          if v.nil? 
            @options[:file] = "build_config.rb"
          else
            @options[:file] = v
          end
        end

        opt.on("-n", "--name=VALUE", "set build_config's name") do |v|
          @options[:name] = v
        end
      end

      sp = argv.index("--")

      if sp.nil?
        cmds = argv
        mrbs = []
      else
        cmds = argv.slice(0, sp ).to_a
        mrbs = argv.slice( sp , (argv.length -1) ).to_a
      end

      parser.parse!(cmds)

      return cmds, mrbs, @options
    end
  end
end
