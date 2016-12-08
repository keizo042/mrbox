def __main__(argv)

  begin
    cmds, args, options = Mrbox::Opt.new.run argv
  rescue NameError => e
    p e
    return
  rescue => e
    puts e
  end

  begin
  Mrbox::Program.new.run(cmds, args, options)
  rescue => e
    puts "program"
    puts "error:#{e.class}"
    puts "why:#{e}"
  end
end
