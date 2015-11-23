module TestUtil
  def time(str)
    Time.zone.parse(str)
  end

  def date(str)
    Date.parse(str)
  end
end
