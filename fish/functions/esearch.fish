function esearch
  for path in $PATH
    find $path -maxdepth 1 -name "$argv[1]" -executable 2>/dev/null
  end
end

