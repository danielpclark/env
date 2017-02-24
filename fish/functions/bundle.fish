function bundle 
  command bundle $argv
  if begin; test (count $argv) -gt 1; and test (string match $argv[1] gem); end
    set -l cmd $argv[1]
    set -l ghuser (git config --get github.user)
    set -l folder $argv[2]
    set -l gemified (ruby -e "puts '$folder'.gsub(/(.)([A-Z])/,'\1_\2').downcase")
    set_color green
    echo "Copying skeleton directory in..."
    cp ~/.bundle/skel/.* $folder/
    echo "Adding CodeClimate hooks..."
    echo >> $folder/Gemfile "\
group :test do
  gem 'simplecov'
  gem 'codeclimate-test-reporter', '~> 1.0.0'
end
"
    echo >> $folder/test/test_helper.rb "\
require 'simplecov'
SimpleCov.start
"
    echo "Rewriting TravisCI defaults..."
    echo > $folder/.travis.yml "\
language: ruby
rvm:
- 2.2.6
- 2.3.3
- 2.4.0
env:
  global:
  - secure: qXpWydxv6DHMrvGL8WH4wNRY4MTY7KV/x308Y5dHkZCrI7k9UOccvznp69KT3Z+tzYEFDXfUix5wA6pgyVcvrsQyiLSjGcyzHhxJKs1gk0gcxAkmhwHmUP9aiXWUe/mzpj7Uoc2DHwpPTpK1wQ5kV6eV+jzQLuN3nhfNr2sL8b4=
addons:
  code_climate:
    repo_token: TODO! UPDATE_THIS!
script: bundle exec rake test
after_success:
  - bundle exec codeclimate-test-reporter
"
    set -l origin "git@github.com:$ghuser/$gemified.git"
    echo "Creating git remote origin $origin ..."
    cd $folder
    git remote add origin $origin
    ..
    set_color yellow
    echo "Fixing github URL in README.md..."
    cat $folder/README.md | \
    ruby -e "puts ARGF.read.gsub(/(github\.com\/)([^\/]+)\/$gemified/,'\1$ghuser/$gemified')" |\
    read -z readme
    set_color green
    echo "Creating Badges for README.md..." 
    set_color normal
    echo > $folder/README.md "\
[![Gem Version](https://badge.fury.io/rb/$gemified.svg)](http://badge.fury.io/rb/$gemified)
[![Code Climate](https://codeclimate.com/github/$ghuser/$folder/badges/gpa.svg)](https://codeclimate.com/github/$ghuser/$folder)
[![Build Status](https://travis-ci.org/$ghuser/$folder.svg)](https://travis-ci.org/$ghuser/$folder)
[![Test Coverage](https://codeclimate.com/github/$ghuser/$folder/badges/coverage.svg)](https://codeclimate.com/github/$ghuser/$folder)
[![Inline docs](http://inch-ci.org/github/$ghuser/$folder.svg?branch=master)](http://inch-ci.org/github/$ghuser/$folder)
[![SayThanks.io](https://img.shields.io/badge/SayThanks.io-%E2%98%BC-1EAEDB.svg)](https://saythanks.io/to/$ghuser)

$readme"   
    set_color brred
    echo "PLEASE LOOKUP CORRECT CODECLIMATE REPORTER TOKEN AND UPDATE .travis.yml!"
    echo "https://codeclimate.com/dashboard"
    set_color green
    echo "Setting up Minitest Reporter..."
    echo >> $folder/Gemfile "\
group :test do
  gem 'minitest', '~> 5.10'
  gem 'minitest-reporters', '~> 1.1'
  gem 'color_pound_spec_reporter', '~> 0.0.6'
end
"
    echo >> $folder/test/test_helper.rb "\
require 'color_pound_spec_reporter'
Minitest::Reporters.use! [ColorPoundSpecReporter.new]   
"
    echo "Adding VIM files to .gitignore..."
    echo >> $folder/.gitignore "\
**/*.swp
"
    set_color bryellow
    echo "Be sure to remove TODOs from $gemified.gemspec first!"
    set_color brgreen
    echo "PROJECT IS READY"
    set_color normal
  end
end
