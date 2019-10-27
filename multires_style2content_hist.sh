# Multiscale Generation With Histogram Matching

INTERPRETER=python3 # Replace with 'th' for neural_style.lua or 'python' for python 2
SCRIPT=neural_style.py # Replace with 'neural_style.lua' for the original neural-style

NEURAL_STYLE=$INTERPRETER
NEURAL_STYLE+=" "
NEURAL_STYLE+=$SCRIPT

# Uncomment if using pip package
#NEURAL_STYLE=neural-style


# Input Images
CONTENT_IMAGE=content_image.jpg
STYLE_IMAGE="style_image.png"

# Basic Parameters
CONTENT_WEIGHT=5
STYLE_WEIGHT=100
STYLE_SCALE=1
MODEL_FILE='models/vgg19-d01eb7cb.pth'

# Histogram Matching from style image to content image
python linear-color-transfer.py --target_image $CONTENT_IMAGE --source_image $STYLE_IMAGE --output_image content_colored_pca.png

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image \
  -tv_weight 0 -seed 876 -save_iter 500 -print_iter 50 -backend cudnn -cudnn_autotune \
  -content_weight $CONTENT_WEIGHT -style_weight $STYLE_WEIGHT -style_scale $STYLE_SCALE -model_file $MODEL_FILE \
  -output_image out1.png \
  -image_size 640 \
  -num_iterations 1500

python linear-color-transfer.py --target_image out1.png --source_image $STYLE_IMAGE --output_image out1_hist_colored_pca.png

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out1_hist_colored_pca.png \
  -tv_weight 0 -seed 876 -save_iter 500 -print_iter 50 -backend cudnn -cudnn_autotune \
  -content_weight $CONTENT_WEIGHT -style_weight $STYLE_WEIGHT -style_scale $STYLE_SCALE -model_file $MODEL_FILE \
  -output_image out2.png \
  -image_size 768 \
  -num_iterations 1000

python linear-color-transfer.py --target_image out2.png --source_image $STYLE_IMAGE --output_image out2_hist_colored_pca.png

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out2_hist_colored_pca.png \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -backend cudnn -cudnn_autotune \
  -content_weight $CONTENT_WEIGHT -style_weight $STYLE_WEIGHT -style_scale $STYLE_SCALE -model_file $MODEL_FILE \
  -image_size 1024 \
  -num_iterations 500 \
  -output_image out3.png \

python linear-color-transfer.py --target_image out3.png --source_image $STYLE_IMAGE --output_image out3_hist_colored_pca.png

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out3_hist_colored_pca.png \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -backend cudnn -cudnn_autotune \
  -content_weight $CONTENT_WEIGHT -style_weight $STYLE_WEIGHT -style_scale $STYLE_SCALE -model_file $MODEL_FILE \
  -image_size 1152 \
  -num_iterations 200 \
  -output_image out4.png \

python linear-color-transfer.py --target_image out4.png --source_image $STYLE_IMAGE --output_image out4_hist_colored_pca.png

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out4_hist_colored_pca.png \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -backend cudnn -cudnn_autotune \
  -content_weight $CONTENT_WEIGHT -style_weight $STYLE_WEIGHT -style_scale $STYLE_SCALE -model_file $MODEL_FILE \
  -image_size 1536 \
  -num_iterations 200 \
  -output_image out5.png \

python linear-color-transfer.py --target_image out5.png --source_image $STYLE_IMAGE --output_image out5_hist_colored_pca.png

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out5_hist_colored_pca.png \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -backend cudnn -cudnn_autotune \
  -content_weight $CONTENT_WEIGHT -style_weight $STYLE_WEIGHT -style_scale $STYLE_SCALE -model_file $MODEL_FILE \
  -image_size 1664 \
  -num_iterations 200 \
  -output_image out6.png \

python linear-color-transfer.py --target_image out6.png --source_image $STYLE_IMAGE --output_image out6_hist_colored_pca.png

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out6_hist_colored_pca.png \
  -tv_weight 0 -seed 876 -save_iter 100 -print_iter 50 -backend cudnn -cudnn_autotune -optimizer adam \
  -content_weight $CONTENT_WEIGHT -style_weight $STYLE_WEIGHT -style_scale $STYLE_SCALE -model_file $MODEL_FILE \
  -image_size 1920 \
  -num_iterations 200 \
  -output_image out7.png

python linear-color-transfer.py --target_image out7.png --source_image $STYLE_IMAGE --output_image out7_hist_colored_pca.png

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out7_hist_colored_pca.png \
  -tv_weight 0 -seed 876 -save_iter 100 -print_iter 50 -backend cudnn -cudnn_autotune -optimizer adam \
  -content_weight $CONTENT_WEIGHT -style_weight $STYLE_WEIGHT -style_scale $STYLE_SCALE -model_file $MODEL_FILE \
  -image_size 2125 \
  -num_iterations 200 \
  -output_image out8.png

python linear-color-transfer.py --target_image out8.png --source_image $STYLE_IMAGE --output_image out8_hist_colored_pca.png

# Luminance Transfer from histogram matched content image, to the final output
python lum-transfer.py --output_lum2 out8.png --cp_mode lum2 --output_image out8_final.png --org_content content_colored_pca.png

# Luminance Transfer from unmodified content image, to the final output
python lum-transfer.py --output_lum2 out8.png --cp_mode lum2 --output_image out8_final_2.png --org_content $CONTENT_IMAGE
