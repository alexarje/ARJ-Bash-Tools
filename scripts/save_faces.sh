# https://github.com/wavexx/facedetect


mkdir face_image

# Check that all images have correct rotation
jhead -autorot *.jpg
jhead -autorot *.JPG


for file in ./*.jpg; do
  name=$(basename "$file")
  i=0
  facedetect "$file" | while read x y w h; do
    convert "$file" -crop ${w}x${h}+${x}+${y} "face_image/${name%.*}_${i}.${name##*.}"
    i=$(($i+1))
  done
done

