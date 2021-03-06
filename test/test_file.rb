require 'pocolog'
require 'test/unit'

class TC_File < Test::Unit::TestCase
    attr_reader :logfile

    def create_fixture
        logfile = Pocolog::Logfiles.create('test')
        all_values = logfile.create_stream('all', 'int', 'test' => 'value', 'test2' => 'value2')
        100.times do |i|
            all_values.write(Time.at(i), Time.at(i * 100), i)
        end
        logfile.close
    end

    def setup
        create_fixture
        @logfile = Pocolog::Logfiles.open('test.0.log')
    end

    def teardown
        FileUtils.rm_f 'test.0.log'
        FileUtils.rm_f 'test.0.idx'
    end

    def test_has_stream
        assert(logfile.has_stream?('all'))
    end
end

