## Target Practice

A Ruby library for running Target Practice (.tp) test bundles.

## Installation

Put the following in your Gemfile

    gem 'target_practice'

Cool.

## Writing TargetPractice tests.

TargetPractice tests work by comparing a JSON file to an object that you specify.
This allows you to write simple that are language agnostic. Nifty.

Let's take a look at a hypothetical example, parsing a PSD.

In my Rakefile:

    require 'rubygems'
    require 'rake/testtask'
    require 'test/psdtest'

    TargetPractice.new(:test) do |test|
      test.pattern = "test/psd.tp/**/*.json"
      test.test_class = PSDTest
    end

And a simple test case `test/psd.tp/simple.json`:

    {
      "_title": "CMYK Header",
      "_file": "fixtures/test-cmyk8.psd",
      "psd": {
        "height": 1
      }
    }

And my PSD test harness:

    TP_ROOT = 'test/psd.tp/'

    class PSDTest < TargetPracticeTestCase
      def tests_against_files
        @@files.each do |file|
          @@current_file = file
          do_file_test(file)
        end
      end

      def do_file_test(file)
        puts "Starting test for #{file}"
        test_data = JSON.parse(File.open(file, 'r').read)
        assert test_data["_file"], "Input file was not provided!"
        psd = PSD.from_file(TP_ROOT + test_data["_file"])
        psd.parse

        assert_attributes(psd, test_data["psd"])
      end

      def assert_attributes(obj, hash={})
        return if hash.nil?

        hash.each do |k,v|
          assert obj.send(k.to_sym) if !is_meta_command?(k)

          if v.kind_of? Array
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
        ["_file", "_title"]
      end
    end

A little wordy, but this will ensure that if a PSD-parsing module existed, when parsing the
file defined in the JSON, it should have the height attribute equal to 1. If not, it fails.

## Authors

TargetPractice was developed by [Kelly Sutton](http://github.com/kellysutton) for [LayerVault](http://layervault.com)
