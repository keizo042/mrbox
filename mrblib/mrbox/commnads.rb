module Mrbox
  class Commands
        @mrbox ="~/.mrbox"
    class << self

      def build(argv, options)
        if options[:name].nil?
          dist= "default"
        else
          dist = options[:name].to_s
        end

        path = @mrbox + "/projects/" + dist
        mruby = File.expand_path( path + "/mruby")
        unless File.directory?(mruby)
          Kernel.system("git clone http://github.com/mruby/mruby.git " + mruby)
        end
        File.open((Dir.getwd + "/" + options[:file].to_s))

        build_config_rb = path + "/build_config.rb"
        if File.exists?(build_config_rb) 
        Kernel.system(( "MRUBY_CONFIG=" + build_config_rb + " " + mruby + "/minirake "  + "-C " + mruby ))
        else
        Kernel.system(( mruby + "/minirake "  + "-C " + mruby ))
        end
      end

      def setup(argv, options)
        puts "not yet implement"
      end

      def init(argv, options)
        dir = Dir.getwd + ".mrbox"
        Dir.mkdir(dir)
        File.open((dir + "data")) do |f|
        end
      end

      def update(argv, options)
        puts "not yet implement"
      end

      def exe(name, argv)
        Kernel.system((name + argv.map{ |v| v.to_s}.join(" ")))

      end
      def mruby(argv, options)
        if options[:name].nil?
          dist= "default"
        else
          dist = options[:name]
        end
        path = @mrbox + "/projects/" + dist
        bin = File.expand_path((path + "/mruby/bin"))
        exe((bin + "/mruby "), argv)
      end

      def mrbc(argv, options)
        if options[:name].nil?
          dist= "default"
        else
          dist = options[:name]
        end
        path = @mrbox + "/projects/" + dist
        bin = File.expand_path((path + "mruby/bin"))
        exe((bin + "mrbc"), argv)
      end

      def mirb(argv, options)
        if options[:name].nil?
          dist= "default"
        else
          dist = options[:name]
        end
        path = @mrbox + "/projects/" + dist
        bin = File.expand_path( path + "mruby/bin")
        exe((bin + "mirb"), argv)
      end

#      def method_missing(method, argv, options)
#        if ["build", "init", "update", "help", "mrbc", "mruby", "mirb" ].include?(method.to_s)
#          send(method, argv, options)
#        end
#        puts "invaild arguments:#{method} " + argv.map{|v| v.to_s}.join(" ")
#        Mrbox.help
#      end
    end
  end
end
