class Object
  def true?
    !false?
  end

  def false?
    respond_to?(:empty?) ? empty? : !self
  end
end

class Array
  def false?
    empty?
  end
end

class String
  def false?
    empty?
  end
end

class NilClass
  def false?
    true
  end
end

class TrueClass
  def false?
    false
  end
end

class FalseClass
  def false?
    true
  end
end

class Numeric
  def false?
    self == 0
  end
end
