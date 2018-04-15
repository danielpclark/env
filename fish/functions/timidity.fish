function timidity
  padsp timidity -B 32 -f -m 3000 -EFchorus=1 -Od1S -s 33075 -U -t nocnv -int -EFreverb=1,63 $argv[1]
end
