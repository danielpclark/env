function trim_trailing_blankspace
  for file in $argv
    sed -i  's/\s*$//' $file
  end
end

