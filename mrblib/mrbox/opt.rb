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
        cmds = argv.slice(0, (sp - 1) )
        mrbs = argv.slice( (sp + 1), (argv.length -1) )
      end

      parser.parse!(cmds)

      return cmds, mrbs, @options
    end
  end
end
