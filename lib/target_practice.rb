#!/usr/bin/env ruby
$LOAD_PATH << '.'

require 'rubygems'

require 'json'
require 'minitest/unit'
require 'target_practice/target_practice_test_case'

TMP_FILE = "./tmp/out.png"
TP_ROOT = "./test/psd.tp/"

class TargetPractice
  attr_accessor :pattern, :test_class

  def initialize(sym)
    @pattern = ""
    @test_class = nil

    yield self

    run_tests
  end

  def run_tests
    files = FileList[@pattern].to_a
    test = @test_class.new(:tests_against_files)
    test.files = files
    MiniTest::Unit.new.run
  end
end
