#!/bin/sh
cd $(git rev-parse --show-toplevel)
rake build
gem install pkg/twiruby-*.gem
