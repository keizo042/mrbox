def __main__(argv)
  begin
    Mrbox::Env.check
  rescue => e
    puts "env"
    puts e.class
    puts e
  end

  begin
    v, options = Mrbox::Opt.new.run argv
  rescue NameError => e
    p e
    return
  rescue => e
    puts "opt"
    puts e.class
    puts e
  end

  begin
  Mrbox::Program.new.run(v, options)
  rescue => e
    puts "program"
    puts "error:#{e.class}"
    puts "why:#{e}"
  end
end
