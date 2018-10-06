CONTENT_IMAGE=content_image.jpg
STYLE_IMAGE=style_image.png

INTERPRETER=python
NEURAL_STYLE=neural_style.py


# Histogram Matching from content image to style image
python linear-color-transfer.py --target_image $STYLE_IMAGE --source_image $CONTENT_IMAGE --output_image style_colored_pca.png

$INTERPRETER $NEURAL_STYLE \
  -content_image $CONTENT_IMAGE \
  -style_image style_colored_pca.png \
  -init image \
  -tv_weight 0 -seed 876 -save_iter 500 -print_iter 50 -init image -backend cudnn -cudnn_autotune \
  -output_image out1.png \
  -image_size 640 \
  -num_iterations 1500 
  
$INTERPRETER $NEURAL_STYLE \
  -content_image $CONTENT_IMAGE \
  -style_image style_colored_pca.png \
  -init image -init_image out1.png \
  -tv_weight 0 -seed 876 -save_iter 500 -print_iter 50 -init image -backend cudnn -cudnn_autotune \
  -output_image out2.png \
  -image_size 768 \
  -num_iterations 1000
 
$INTERPRETER $NEURAL_STYLE \
  -content_image $CONTENT_IMAGE \
  -style_image style_colored_pca.png \
  -init image -init_image out2.png \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -backend cudnn -cudnn_autotune \
  -image_size 1024 \
  -num_iterations 500 \
  -output_image out3.png \

$INTERPRETER $NEURAL_STYLE \
  -content_image $CONTENT_IMAGE \
  -style_image style_colored_pca.png \
  -init image -init_image out3.png \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -backend cudnn -cudnn_autotune \
  -image_size 1152 \
  -num_iterations 200 \
  -output_image out4.png \

$INTERPRETER $NEURAL_STYLE \
  -content_image $CONTENT_IMAGE \
  -style_image style_colored_pca.png \
  -init image -init_image out4.png \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -backend cudnn -cudnn_autotune \
  -image_size 1536 \
  -num_iterations 200 \
  -output_image out5.png \

$INTERPRETER $NEURAL_STYLE \
  -content_image $CONTENT_IMAGE \
  -style_image style_colored_pca.png \
  -init image -init_image out5.png \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -backend cudnn -cudnn_autotune \
  -image_size 1664 \
  -num_iterations 200 \
  -output_image out6.png \

$INTERPRETER $NEURAL_STYLE \
  -content_image $CONTENT_IMAGE \
  -style_image style_colored_pca.png \
  -init image -init_image out6.png \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -backend cudnn -cudnn_autotune -optimizer adam \
  -image_size 1920 \
  -num_iterations 200 \
  -output_image out7.png

$INTERPRETER $NEURAL_STYLE \
  -content_image $CONTENT_IMAGE \
  -style_image style_colored_pca.png \
  -init image -init_image out7.png \
  -tv_weight 0 -seed 876 -save_iter 100 -print_iter 50 -init image -backend cudnn -cudnn_autotune -optimizer adam \
  -image_size 2125 \
  -num_iterations 200 \
  -output_image out8.png

# Luminance Transfer from original content image, to the final output
python lum-transfer.py --output_lum2 out8.png --cp_mode lum2 --output_image out8_final.png --org_content $CONTENT_IMAGE