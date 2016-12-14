module Mrbox
  class Program
    def run(opt)
      if opt.options[:help] 
        return
      end
      if opt.mruby.length < 1
        puts "invaild arguments.."
        Mrbox.help
        return
      end
      begin
        cmd = opt.mrbox[1].to_sym
        argv = opt.mrbox[2, opt.mrbox.length - 1].to_a
        Mrbox::Commands.send( cmd, argv , opt.mruby, opt.options)
      rescue => e
        puts "program"
        puts e
      end
    end
  end
end
