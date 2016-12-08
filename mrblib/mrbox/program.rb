module Mrbox
  class Program
    def run(argv, options)
      if options[:help] 
        return
      end
      if argv.length < 2
        puts "invaild arguments.."
        Mrbox.banner
        Mrbox.help
        return
      end
      begin
      Mrbox::Commands.send( argv[1].to_sym, argv.slice(2, (argv.length -1)).to_a, options)
      rescue NoMethodError => e
        puts e
        Mrbox.help
      end
    end
  end
end
