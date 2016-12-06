module Mrbox
  class Program
    conf="~/.mrbox"
    def initalize(v)
      @options = v.options
      @argv = v.argv
    end

    def run
      if @options[:help] 
        return
      end
      if argv.length < 1
        puts "invaild arguments"
        return
      end
      case argv[0]
      when "bulid"
        unless @options[:name].nil?
          puts "set your config name"
        end
      when "mruby","mrbc", "mirb", "mruby-strip"
      else
        Mrbox.help
      end
    end
  end
end
