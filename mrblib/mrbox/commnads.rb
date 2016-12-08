module Mrbox
  class Commands
    class << self

      def build(argv, mrbs, options)
        if options[:name].nil?
          name = "default"
        else
          name = options[:name].to_s
        end

        project = Project.new name
        unless File.exist?(project.mruby)
          Mrbox.git("clone", "http://github.com/mruby/mruby.git #{project.mruby}")
        end


        f = options[:file]
        if f.nil?
          project.make
          return
        end

        file = [Dir.getwd ,f.to_s].join("/")

        puts "reading #{file}..."
        lines = File.open(file, "r").readlines.join

        unless lines.nil? || lines.empty?
          puts "writing #{project.build_config_rb}..."
          File.new(project.build_config_rb, "w").write (lines)
        end

        project.make
      end

      def setup(argv, mrbs, options)
        env = Mrbox::Env.new
        env.setup
      end

      def init(argv, mrbs, options)
        create_local_env
      end

      def update(argv, mrbs, options)
      end

      def remove(argv, mrbs, options)
      end

      def mruby(argv, mrbs, options)
        if options[:name].nil?
          name = "default"
        else
          name = options[:name]
        end
        Project.new name
        project.run( "mruby", (argv + mrbs) )
      end

      def mrbc(argv, mrbs, options)
        if options[:name].nil?
          name = "default"
        else
          name = options[:name]
        end
        Project.new name
        project.run("mrbc", (argv + mrbs) )
      end

      def mrbc(argv, mrbs, options)
        if options[:name].nil?
          name = "default"
        else
          name = options[:name]
        end
        Project.new name
        project.run("mrbc", (argv + mrbs) )
      end

      def mruby_strip(argv, mrbs, options)
        if options[:name].nil?
          name = "default"
        else
          name = options[:name]
        end
        Project.new name
        project.run("mruby-strip", (argv + mrbs) )
      end

      def help(argv, mrbs, options)
      end

      def method_missing(method, argv, mrbs, options)
        if method.to_s == "mruby-strip"
          self.send :mruby_strip, (argv + mrbs), options
        end
        puts "invaild commands:#{method} " + argv.map{|v| v.to_s}.join(" ")
        Mrbox.help
      end
    end

    def initialze
    end

    def create_local_env
        dir = Dir.getwd + ".mrbox"
        Dir.mkdir(dir)
        File.open("#{dir}/data") do |f|
        end
    end

    class Project
      attr_reader :name, :path, :mruby, :build_config_rb, :minirake ,:bin
      def initialize(name)
        @name = name
        @mrbox = File.expand_path("~/.mrbox")
        @path = "#{@mrbox}/projects/#{@name}"
        @mruby = "#{@path}/mruby"
        @build_config_rb = "#{@path}/build_config.rb"
        @bin = "#{@path}/bin"
        @minirake = "#{@mruby}/minirake"
      end

      def make
        if File.exists?(@build_config_rb) 
          cmd = "MRUBY_CONFIG=#{@build_config_rb} #{config} #{@minirake} -C #{@mruby} "
          puts cmd
          Kernel.system(cmd)
        else
          cmd = "#{@minirake} -C #{@mruby}"
          puts cmd
          Kernel.system(cmd)
        end
      end

      def remove
      end

      def run(obj, argv)
      end
    end
  end
end
