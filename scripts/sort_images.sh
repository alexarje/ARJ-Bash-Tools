# https://unix.stackexchange.com/questions/294341/shell-script-to-separate-and-move-landscape-and-portrait-images


# make directories
mkdir portraits
mkdir landscapes

# Check that all images have correct rotation
jhead -autorot *.jpg
jhead -autorot *.JPG

# move files
for f in ./*.JPG
do
  r=$(identify -format '%[fx:(h>w)]' "$f")
  if [[ r -eq 1 ]] 
  then
      mv "$f" portraits
  else
      mv "$f" landscapes
  fi
done

for f in ./*.jpg
do
  r=$(identify -format '%[fx:(h>w)]' "$f")
  if [[ r -eq 1 ]] 
  then
      mv "$f" portraits
  else
      mv "$f" landscapes
  fi
done
