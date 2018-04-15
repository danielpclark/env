function rake
  set -l PROJECT (basename (pwd))
  set -l TIMESTAMP (date +%s)
  set -l ROOT "/mnt/raid/snapshots/"
  set -l BASENAME $ROOT$PROJECT'-'$TIMESTAMP

  bash -c "set -o pipefail; rake $argv |& tee $BASENAME.log"

  set -l STATUS $status

  bash -c "set +o pipefail"

  for file in (git ls-files) (git ls-files --exclude-standard --others)
    if echo $file | grep assets > /dev/null
      continue
    end
                                              
    tar --no-recursion -uf $BASENAME.tar $file
  end

  gzip $BASENAME.tar

  if test "$STATUS" -ne "0" 
    false
  end
end

