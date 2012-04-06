class TargetPracticeTestCase < MiniTest::Unit::TestCase
  def setup
    assert @@files, "File data was not set!"
  end

  def files
    @@files
  end

  def files=(f)
    @@files = f
  end
end