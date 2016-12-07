module Mrbox
  class Commands
    class << self
      mrbox ="~/.mrbox"
      def build(argv, options)
        if options[:name].nil?
          dist= "default"
        else
          dist = options[:name]
        end

        path = mrbox + "/projects/" + dist
        mruby = File.expand_path( path + "mruby")
        if File.directory?(mruby)
          Kernel.system("git clone http://github.com/mruby/mruby.git " + mruby)
        end
        File.open(Dir.getwd + "/" + options[:file])
        Kernel.system( "MRUBY_CONFIG=" + path + "/buld_config.rb " + mruby + "/minirake "  + "-C " + mruby )
      end

      def setup(argv, options)
        puts "not yet implement"
      end

      def init(argv, options)
        dir = Dir.getwd + ".mrbox"
        Dir.mkdir(dir)
        File.open((dir + "data") do |f|
        end
      end

      def update(argv, options)
        puts "not yet implement"
      end

      def exe(name, argv)
        Kernel.system(name + argv.map{ |v| v.to_s}.join(" "))

      end
      def mruby(argv, options)
        if options[:name].nil?
          dist= "default"
        else
          dist = options[:name]
        end
        path = mrbox + "/projects/" + dist
        bin = File.expand_path( path + "mruby/bin")
        exe((bin + "mruby"), argv)
      end

      def mrbc(argv, options)
        if options[:name].nil?
          dist= "default"
        else
          dist = options[:name]
        end
        path = mrbox + "/projects/" + dist
        bin = File.expand_path( path + "mruby/bin")
        exe((bin + "mrbc"), argv)
      end

      def mirb(argv, options)
        if options[:name].nil?
          dist= "default"
        else
          dist = options[:name]
        end
        path = mrbox + "/projects/" + dist
        bin = File.expand_path( path + "mruby/bin")
        exe((bin + "mirb"), argv)
      end

      def method_missing(method, argv, options)
        puts "invaild arguments:#{method} " + argv.map{|v| v.to_s}.join(" ")
        Mrbox.help
      end
    end
  end
end
