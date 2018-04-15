function tcon
  if test -e bin/rails
    bash -c "RAILS_ENV=test bin/rails c"
  else
    irb -I"lib" -r(basename (pwd))
  end
end

