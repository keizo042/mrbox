module Mrbox
  class Commands
    class << self

      def build(mrbox, mruby, options)
        project = Project.new options[:name]
        Mrbox.git("clone http://github.com/mruby/mruby.git #{project.mruby}") unless File.exist?(project.mruby)

        f = options[:file]
        if f.nil?
          file = "#{project.mruby}/build_config.rb"
        else
          file = File.expand_path(f)
        end

        unless File.exist?(project.build_config_rb)
          puts "reading #{file}..."
          begin
            lines = File.open(file, "r").readlines.join
          rescue 
            return
          end

          unless lines.nil? || lines.empty?
            puts "writing #{project.build_config_rb}..."
            File.new(project.build_config_rb, "w").write (lines)
          end
        end


        project.make
      end

      def setup(mrbox, mruby, options)
        Project.new.setup
      end

      def config(mrbox, mruby, options)
        project = Project.new
        project.config
      end

      def init(mrbox, mruby, options)
        env = Mrbox::Env.new(File.join(Dir.getwd,".mrbox"))
        project = Project.new "default", env
        project.setup
      end

      def update(mrbox, mruby, options)
        project = Project.new options[:name]
        project.update
      end

      def show (mrbox, mruby, options)
        Dir.entries(File.expand_path("~/.mrbox/projects")).reject{|i| i.start_with?(".") }.each { |project|
          puts project
        }
      end

      def clean(mrbox, mruby, options)
        if options[:name].nil?
          puts "requre option ' --name' "
          return
        end
        project = Project.new options[:name]
        unless project.exist?
          puts "already removed"
          return
        end
        unless File.directory?(project.path)
          puts "invaild directory"
          return
        end
        project.remove
      end

      def edit(argv, mruby, options)

        editor = ENV['EDITOR']
        if editor.nil?
          editor = 'nano'
        end
        project = Project.new(options[:name])
        if argv.length > 1
          project.build_config_rb = "#{project.path}/#{argv[0]}"
        end
        project.edit editor
      end

      def mruby(argv, mruby, options)
        project = Project.new options[:name]
        project.run( "mruby",  mruby )
      end

      def mrbc(argv, mruby, options)
        project = Project.new options[:name]
        project.run("mrbc", mruby )
      end
      def mirb(argv, mruby, options)
        project = Project.new options[:name]
        project.run("mirb", mruby )
      end

      def mruby_strip(argv, mrbs, options)
        project = Project.new options[:name]
        project.run("mruby-strip",  mrbs)
      end

      def help(argv, mrbs, options)
        Mrbox.help
      end

      def git(mrbox, mruby, options)
        project = Project.new options[:name]
        project.git argv
      end

      def method_missing(method, mrbox, mruby, options)
        if method == "mruby-strip"
          #self.send(:mruby_strip, mrbox , mruby, options)
        end
        puts "invaild commands:#{method} " + mrbox.map{|v| v.to_s}.join(" ")
      end
    end

    class Project
      attr_reader :name, :path, :mruby, :build_config_rb, :minirake ,:bin
      def initialize(name = "default", env = Mrbox::Env.new)
        if name.nil?
          @name  = "default"
        else
          @name = name
        end
        @mrbox = env.mrbox
        @env = env
        @path = File.join(@mrbox, "projects", @name)
        @mruby = File.join(@path,"mruby")
        @build_config_rb = File.join(@path, "build_config.rb")
        @bin = File.join(@mruby, "bin")
        @minirake = File.join(@mruby, "minirake")
      end

      def make
        cmd = "MRUBY_CONFIG=#{@build_config_rb} #{@minirake} -C #{@mruby}/"
        puts cmd
        Kernel.system(cmd)
      end

      def exist?
        Dir.exist?(@path)
      end

      def setup
        @env.setup
      end

      def update
          Mrbox.git("-C #{@mruby} pull")
      end

      def remove
        Mrbox.rm("-rf", @path)
      end

      def edit editor
        Kernel.system("#{editor} #{@build_config_rb}")
      end
      def config
        puts "not yet implementation:"
      end

      def git
      end
      
      def run(obj, argv)
        cmd= "#{@bin}/#{obj}" 
        i = argv.index("-e")
        argv[i + 1] = "'#{argv[i + 1]}'" unless i.nil?
        puts "execute: #{cmd} #{argv.join(" ")}.."
        IO.popen("#{cmd} #{argv.join(" ")}" ,"r+") do |io|
          puts io.read
        end
      end
    end
  end
end
