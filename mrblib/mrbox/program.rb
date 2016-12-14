module Mrbox
  class Program
    def run(cmds, mrbs, options)
      if options[:help] 
        return
      end
      if cmds.length < 1
        puts "invaild arguments.."
        Mrbox.banner
        Mrbox.help
        return
      end
      begin
        cmd = cmds[1].to_sym
        argv = cmds[2, cmds.length - 1].to_a
        Mrbox::Commands.send( cmd, argv , mrbs, options)
      rescue => e
        puts "program"
        puts e
      end
    end
  end
end
