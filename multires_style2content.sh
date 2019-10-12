CONTENT_IMAGE=content_image.jpg
STYLE_IMAGE=style_image.png

INTERPRETER=python3 # Replace with 'th' for neural_style.lua or 'python' for python 2
SCRIPT=neural_style.py # Replace with 'neural_style.lua' for the original neural-style

NEURAL_STYLE=$INTERPRETER
NEURAL_STYLE+=" "
NEURAL_STYLE+=$SCRIPT

# Uncomment if using pip package
#NEURAL_STYLE=neural-style


# Histogram Matching from style image to content image
python linear-color-transfer.py --target_image $CONTENT_IMAGE --source_image $STYLE_IMAGE --output_image content_colored_pca.png

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image \
  -tv_weight 0 -seed 876 -save_iter 500 -print_iter 50 -init image -backend cudnn -cudnn_autotune \
  -output_image out1.png \
  -image_size 640 \
  -num_iterations 1500 
  
$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out1.png \
  -tv_weight 0 -seed 876 -save_iter 500 -print_iter 50 -init image -backend cudnn -cudnn_autotune \
  -output_image out2.png \
  -image_size 768 \
  -num_iterations 1000
 
$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out2.png \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -backend cudnn -cudnn_autotune \
  -image_size 1024 \
  -num_iterations 500 \
  -output_image out3.png \

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out3.png \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -backend cudnn -cudnn_autotune \
  -image_size 1152 \
  -num_iterations 200 \
  -output_image out4.png \

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out4.png \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -backend cudnn -cudnn_autotune \
  -image_size 1536 \
  -num_iterations 200 \
  -output_image out5.png \

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out5.png \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -backend cudnn -cudnn_autotune \
  -image_size 1664 \
  -num_iterations 200 \
  -output_image out6.png \

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out6.png \
  -tv_weight 0 -seed 876 -save_iter 100 -print_iter 50 -init image -backend cudnn -cudnn_autotune -optimizer adam \
  -image_size 1920 \
  -num_iterations 200 \
  -output_image out7.png

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out7.png \
  -tv_weight 0 -seed 876 -save_iter 100 -print_iter 50 -init image -backend cudnn -cudnn_autotune -optimizer adam \
  -image_size 2125 \
  -num_iterations 200 \
  -output_image out8.png

# Luminance Transfer from histogram matched content image, to the final output
python lum-transfer.py --output_lum2 out8.png --cp_mode lum2 --output_image out8_final.png --org_content content_colored_pca.png

# Luminance Transfer from unmodified content image, to the final output
python lum-transfer.py --output_lum2 out8.png --cp_mode lum2 --output_image out8_final_2.png --org_content $CONTENT_IMAGE