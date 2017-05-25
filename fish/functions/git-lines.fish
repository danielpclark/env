function git-lines
  set banner_line "################################################\n"
  printf "$banner_line"
  printf "            # ~ Lines Committed ~ #\n"
  printf "$banner_line"
  printf "%10s %10s %10s %s\n" "Added" "Deleted" "Remain" "Name"
  git log --no-merges --pretty=format:%an --numstat --all | awk '/./ && !author { author = $0; next } author { ins[author] += $1; del[author] += $2 } /^$/ { author = ""; next } END { for (a in ins) { printf "%10d %10d %10d %s\n", ins[a], del[a], ins[a] - del[a], a } }' | sort -rn
end

