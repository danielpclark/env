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
    echo "Rewriting TravisCI defaults..."
    echo > $folder/.travis.yml "\
language: ruby
rvm:
- 2.3.7
- 2.4.4
- 2.5.1
script: bundle exec rake test
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
[![Build Status](https://travis-ci.org/$ghuser/$folder.svg)](https://travis-ci.org/$ghuser/$folder)
[![Inline docs](http://inch-ci.org/github/$ghuser/$folder.svg?branch=master)](http://inch-ci.org/github/$ghuser/$folder)
[![SayThanks.io](https://img.shields.io/badge/SayThanks.io-%E2%98%BC-1EAEDB.svg)](https://saythanks.io/to/$ghuser)

$readme"   
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
