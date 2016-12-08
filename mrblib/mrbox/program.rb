module Mrbox
  class Program
    def run(cmds, mrbs, options)
      if options[:help] 
        return
      end
      if cmds.length < 2
        puts "invaild arguments.."
        Mrbox.banner
        Mrbox.help
        return
      end
      begin
      Mrbox::Commands.send( cmds[1].to_sym, cmds.slice( 2, (cmds.length -1) ).to_a, mrbs, options )
      rescue NoMethodError => e
        puts "invalid commans: #{cmds[1]}"
        Mrbox.help
      rescue => e
        puts e
      end
    end
  end
end
