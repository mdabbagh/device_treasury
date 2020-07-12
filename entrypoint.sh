#!/bin/sh

set -e

if [ -f tmp/pids/server.pid ]; then
  rm -f /myapp/tmp/pids/server.pid
fi

bundle exec rails s -b 0.0.0.0