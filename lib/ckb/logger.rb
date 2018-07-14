require 'lumberjack'

module CKB

  def self.default_log_level
    @default_log_level ||= :info
  end

  def self.default_log_level=(level)
    @default_log_level = level
  end

  def self.get_logger(progname=nil, level=default_log_level)
    Lumberjack::Logger.new(STDOUT, progname: progname, level: level)
  end

  Logger = get_logger(self.name)

end
