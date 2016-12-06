def __main__(argv)
  begin
    Mrbox::Env.check
  rescue => e
    puts e
  end
  begin
  opt = Mrbox::Opt.new argv
  rescue => e
    puts e
  end
  begin
  Mrbox::Program.new(opt).run 
  rescue => e
    puts e
  end
end
