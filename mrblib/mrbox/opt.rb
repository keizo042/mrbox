module Mrbox
  class Opt 

    def initalize(argv)
      return self.run argv
    end

    def run argv
      OptionParser.new do |opt|
        opt.version = Mrbox::Version
        opt.banner = Mrbox.banner
        opt.on("-f", "--file=[VALUE]", "set your bulid config.rb. default: build_config.rb") do |v|
          if v.nil? 
            opt[:file] = "build_config.rb"
          else
            opt[:file] = v
          end
        end

        opt.on("-n", "--name=VALUE", "set build_config's name") do |v|
          opt[:name] = v
        end
        opt.on("-h", "--help", Mrbox.help)
      end

      options = opt.parse!(argv)
      rest = argv

      Class.new do
        attr_accessor :options , :argv
        def initialize(opt, argv)
          @argv = argv
          @options = opt
        end
      end.new(options,rest)
    end
  end
end
