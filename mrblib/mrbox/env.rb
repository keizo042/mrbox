module Mrbox
  class Env
    attr_reader :mrbox, :projects

    def initialize( mrbox = "~/.mrbox", repo = "https://github.com/mruby/mruby.git" )
      @mrbox = File.expand_path(mrbox)
      @projects = [ @mrbox ,"projects"].join("/")
      @default = [ @projects,  "default" ].join("/")
      @repo = repo
    end

    def setup
      unless File.directory?(@mrbox)
        Dir.mkdir(@mrbox)
      end
      unless File.directory?(File.expand_path(@projects))
        Dir.mkdir(@projects)
      end
      unless File.directory?(@default)
        Dir.mkdir(@default)
      end
      default_mruby = File.expand_path( [ @default, "mruby" ].join("/"))
      unless File.directory?(default_mruby)
        Mrbox.git("clone", [@repo ,default_mruby].join(" "))
      end
    end
  end
end
