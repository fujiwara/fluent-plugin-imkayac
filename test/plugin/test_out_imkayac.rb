# -*- coding: utf-8 -*-
require 'helper'

class ImKayacOutputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  CONFIG = %[
    username   test_fluentd
    password   test
    secret_key secret
    handler    http://example.com
#    api_url    http://127.0.0.1:5000/api/post/
  ]

  def create_driver(conf = CONFIG, tag='test')
    Fluent::Test::OutputTestDriver.new(Fluent::ImKayacOutput, tag).configure(conf)
  end

  def test_write
#    d = create_driver
#    d.emit({"foo" => "test value of foo"})
  end
end
