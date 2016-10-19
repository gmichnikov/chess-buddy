class Array
  def to_chess
    if self.length == 2
      number = 8 - self[0]
      letter = ("a".ord + self[1]).chr
      "#{letter}#{number}"
    else
      nil
    end
  end
end
