function git-pr
  set -l id $argv[1]
  if test -z $id
    echo "Need Pull request number as argument"
    return 1
  end
  git fetch origin pull/$id/head:pr_$id
  git checkout pr_$id
end

