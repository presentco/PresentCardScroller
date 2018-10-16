ffmpeg -ss 0.5 -i screens1.mp4 -filter_complex "[0:v] fps=30,scale=320:-1,split [a][b];[a] palettegen [p];[b][p] paletteuse" out.gif
