# -- coding: utf-8

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
require "rubygems"
require "benchmark"
require 'kyoto_tycoon.rb'

kt = KyotoTycoon.new
bulk={}
100000.times.map{|n|
  bulk[n.to_s] = "#{n}-#{rand}"
}
job = lambda {|kt|
  kt.set_bulk(bulk)
  kt.get_bulk(bulk.keys)
  kt.clear
}
Benchmark.bm do |x|
  x.report('default') {
    kt.serializer=:default
    job.call(kt)
  }
  x.report('msgpack') {
    kt.serializer=:msgpack
    job.call(kt)
  }
end
