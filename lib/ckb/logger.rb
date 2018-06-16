require 'lumberjack'

module CKB

  def self.get_logger(progname=nil)
    Lumberjack::Logger.new(STDOUT, progname: progname)
  end

  Logger = get_logger(self.name)

end