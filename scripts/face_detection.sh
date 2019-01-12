# https://github.com/wavexx/facedetect

mkdir faces
mkdir no_faces

for file in ./*.jpg; do
    name=$(basename "$file")
    if facedetect -q "$file"; then
      mv "$file" faces
    else
      mv "$file" no_faces
    fi
done