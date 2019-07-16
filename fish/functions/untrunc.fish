function untrunc
  set -l folder (pwd)
  set -l working_video $argv[1]
  set -l broken_video $argv[2]

  docker run -v "$folder:/files" untrunc "/files/$working_video" "/files/$broken_video"
end

