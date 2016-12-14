module Mrbox
  class Commands
    class << self

      def build(argv, mrbs, options)
        project = Project.new options[:name]
        unless File.exist?(project.mruby)
          Mrbox.git("clone", "http://github.com/mruby/mruby.git #{project.mruby}")
        end

        f = options[:file]
        if f.nil?
          project.make
          return
        end

        file = File.expand_path(f)

        puts "reading #{file}..."
        begin
        lines = File.open(file, "r").readlines.join
        rescue => e
          puts "reading error:#{e}"
        end

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

      def config(argv, mrbs, options)
        Project.new
      end

      def init(argv, mrbs, options)
        puts "not yet implement"
      end

      def update(argv, mrbs, options)
        proj = Project.new options[:name]
        proj.update
      end

      def show (argv, mrbs, options)
        Dir.entries(File.expand_path("~/.mrbox/projects")).reject{|i| i.start_with?(".") }.each do |prj|
          puts prj
        end
      end

      def clean(argv, mrbs, options)
        if options[:name].nil?
          puts "requre option ' --name' "
          return
        end
        proj = Project.new options[:name]
        unless proj.exists?
          puts "already removed"
          return
        end
        unless File.directory?(path)
          puts "invaild directory"
          return
        end
        proj.remove
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
        Project.new options[:name]
        project.run("mrbc", (argv + mrbs) )
      end

      def mruby_strip(argv, mrbs, options)
        Project.new name options[:name]
        project.run("mruby-strip", (argv + mrbs) )
      end

      def help(argv, mrbs, options)
        Mrbox.help
      end

      def method_missing(method, argv, mrbs, options)
        if method == "mruby-strip"
          self.send :mruby_strip, argv , mrbs, options
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
        File.open([dir , "data"].join("/")) do |f|
        end
    end

    class Project
      attr_reader :name, :path, :mruby, :build_config_rb, :minirake ,:bin
      def initialize(name)
        if name.nil?
          @name  = "default"
        else
          @name = name
        end
        @mrbox = File.expand_path("~/.mrbox")
        @path = "#{@mrbox}/projects/#{@name}"
        @mruby = "#{@path}/mruby"
        @build_config_rb = "#{@path}/build_config.rb"
        @bin = "#{@path}/bin"
        @minirake = "#{@mruby}/minirake"
      end

      def make
        if File.exists?(@build_config_rb) 
          cmd = "MRUBY_CONFIG=#{@build_config_rb} #{@minirake} -C #{@mruby}"
          puts cmd
          Kernel.system(cmd)
        else
          cmd = "#{@minirake} -C #{@mruby}"
          puts cmd
          Kernel.system(cmd)
        end
      end

      def exist?
        Dir.exist?(@path)
      end

      def update
          Mrbox.git("-C #{@path} pull","")
      end

      def remove
        Mrbox.rm("-rf", @path)
      end

      def run(obj, argv)
      end
    end
  end
end
