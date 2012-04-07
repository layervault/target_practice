class TargetPracticeTestCase < MiniTest::Unit::TestCase
  @@meta_assertions = {}

  def setup
    assert @@files, "File data was not set!"
  end

  def files
    @@files
  end

  def files=(f)
    @@files = f
  end

  def assert_attributes(obj, hash={})
    return if hash.nil?

    hash.each do |k,v|
      assert obj.send(k.to_sym) if !is_meta_command?(k)

      if is_meta_command? k
        perform_meta_assertion(obj, k, v)
      elsif v.kind_of? Array
        index = 0
        v.each do |i|
          assert_attributes(obj.send(k.to_sym)[index], i)
          index += 1
        end
      elsif v.kind_of? Hash
        assert_attributes(obj.send(k.to_sym), v)
      elsif v.kind_of? String
        assert_equal v, obj.send(k.to_sym)
      end
    end
  end

  def is_meta_command?(v)
    meta_commands.include? v
  end

  def meta_commands
    []
  end

  def perform_meta_assertion(obj, command, v)
    @@meta_assertions[command].call(obj, v) if @@meta_assertions[command]
  end
end