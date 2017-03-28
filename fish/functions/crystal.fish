function crystal
  if begin; test (count $argv) -gt 0; and test (string match $argv[1] spec); end
    set -x KEMAL_ENV 'test'
  end
  command crystal $argv
  set -u KEMAL_ENV
end

