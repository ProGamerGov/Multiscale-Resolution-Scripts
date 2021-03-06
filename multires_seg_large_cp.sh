# This variant of multires uses this modified version of Neural-Style: https://gist.github.com/ProGamerGov/bcbd27a3d2e431adb73ef158d9990d93
# You can download it via: 
# wget https://gist.githubusercontent.com/ProGamerGov/bcbd27a3d2e431adb73ef158d9990d93/raw/1e7ecd1c9aecaead0d92e3eb0027baa3fa2c4f31/neural_style_seg.lua

# The channel prunning can be donwloaded via: 
# wget https://github.com/yihui-he/channel-pruning/releases/download/channel_pruning_5x/channel_pruning.caffemodel
# wget https://github.com/yihui-he/channel-pruning/releases/download/channel_pruning_5x/channel_pruning.prototxt

CONTENT_IMAGE=content_image.jpg
STYLE_IMAGE=style_image.png

CONTENT_MASK=content_mask.jpg
STYLE_MASK=style_mask.png

INTERPRETER=th
NEURAL_STYLE=neural_style_seg.lua

# Remove color(s) not used in the content mask
COLOR_CODES="blue,green,black,white,red,yellow,grey,lightblue,purple"


$INTERPRETER $NEURAL_STYLE \
  -content_image $CONTENT_IMAGE -content_seg $CONTENT_MASK \
  -style_image $STYLE_IMAGE -style_seg $STYLE_MASK \
  -init image -color_codes $COLOR_CODES \
  -tv_weight 0 -seed 876 -save_iter 500 -print_iter 50 -init image -backend cudnn -cudnn_autotune \
  -output_image out1.png \
  -image_size 640 \
  -num_iterations 1500 
  
$INTERPRETER $NEURAL_STYLE \
  -content_image $CONTENT_IMAGE -content_seg $CONTENT_MASK \
  -style_image $STYLE_IMAGE -style_seg $STYLE_MASK \
  -init image -init_image out1.png -color_codes $COLOR_CODES \
  -tv_weight 0 -seed 876 -save_iter 500 -print_iter 50 -init image -backend cudnn -cudnn_autotune \
  -output_image out2.png \
  -image_size 768 \
  -num_iterations 1000
 
$INTERPRETER $NEURAL_STYLE \
  -content_image $CONTENT_IMAGE -content_seg $CONTENT_MASK \
  -style_image $STYLE_IMAGE -style_seg $STYLE_MASK \
  -init image -init_image out2.png -color_codes $COLOR_CODES \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -backend cudnn -cudnn_autotune \
  -image_size 1024 \
  -num_iterations 500 \
  -output_image out3.png \

$INTERPRETER $NEURAL_STYLE \
  -content_image $CONTENT_IMAGE -content_seg $CONTENT_MASK \
  -style_image $STYLE_IMAGE -style_seg $STYLE_MASK \
  -init image -init_image out3.png -color_codes $COLOR_CODES \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -backend cudnn -cudnn_autotune \
  -image_size 1152 \
  -num_iterations 200 \
  -output_image out4.png \

$INTERPRETER $NEURAL_STYLE \
  -content_image $CONTENT_IMAGE -content_seg $CONTENT_MASK \
  -style_image $STYLE_IMAGE -style_seg $STYLE_MASK \
  -init image -init_image out4.png -color_codes $COLOR_CODES \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -backend cudnn -cudnn_autotune \
  -image_size 1536 \
  -num_iterations 200 \
  -output_image out5.png \

$INTERPRETER $NEURAL_STYLE \
  -content_image $CONTENT_IMAGE -content_seg $CONTENT_MASK \
  -style_image $STYLE_IMAGE -style_seg $STYLE_MASK \
  -init image -init_image out5.png -color_codes $COLOR_CODES \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -proto_file models/channel_pruning.prototxt -model_file models/channel_pruning.caffemodel -backend cudnn -cudnn_autotune -optimizer adam \
  -image_size 1664 \
  -num_iterations 200 \
  -output_image out6.png \

$INTERPRETER $NEURAL_STYLE \
  -content_image $CONTENT_IMAGE -content_seg $CONTENT_MASK \
  -style_image $STYLE_IMAGE -style_seg $STYLE_MASK \
  -init image -init_image out6.png -color_codes $COLOR_CODES \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -proto_file models/channel_pruning.prototxt -model_file models/channel_pruning.caffemodel -backend cudnn -cudnn_autotune -optimizer adam \
  -image_size 1920 \
  -num_iterations 200 \
  -output_image out7.png

$INTERPRETER $NEURAL_STYLE \
  -content_image $CONTENT_IMAGE -content_seg $CONTENT_MASK \
  -style_image $STYLE_IMAGE -style_seg $STYLE_MASK \
  -init image -init_image out7.png -color_codes $COLOR_CODES \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -proto_file models/channel_pruning.prototxt -model_file models/channel_pruning.caffemodel -backend cudnn -cudnn_autotune -optimizer adam \
  -image_size 2048 \
  -num_iterations 200 \
  -output_image out8.png

$INTERPRETER $NEURAL_STYLE \
  -content_image $CONTENT_IMAGE -content_seg $CONTENT_MASK \
  -style_image $STYLE_IMAGE -style_seg $STYLE_MASK \
  -init image -init_image out8.png -color_codes $COLOR_CODES \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -proto_file models/channel_pruning.prototxt -model_file models/channel_pruning.caffemodel -backend cudnn -cudnn_autotune -optimizer adam \
  -image_size 2432 \
  -num_iterations 200 \
  -output_image out9.png

$INTERPRETER $NEURAL_STYLE \
  -content_image $CONTENT_IMAGE -content_seg $CONTENT_MASK \
  -style_image $STYLE_IMAGE -style_seg $STYLE_MASK \
  -init image -init_image out9.png -color_codes $COLOR_CODES \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -proto_file models/channel_pruning.prototxt -model_file models/channel_pruning.caffemodel -backend cudnn -cudnn_autotune -optimizer adam \
  -image_size 2560 \
  -num_iterations 200 \
  -output_image out10.png

$INTERPRETER $NEURAL_STYLE \
  -content_image $CONTENT_IMAGE -content_seg $CONTENT_MASK \
  -style_image $STYLE_IMAGE -style_seg $STYLE_MASK \
  -init image -init_image out10.png -color_codes $COLOR_CODES \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -proto_file models/channel_pruning.prototxt -model_file models/channel_pruning.caffemodel -backend cudnn -cudnn_autotune -optimizer adam \
  -image_size 2816 \
  -num_iterations 200 \
  -output_image out11.png

$INTERPRETER $NEURAL_STYLE \
  -content_image $CONTENT_IMAGE -content_seg $CONTENT_MASK \
  -style_image $STYLE_IMAGE -style_seg $STYLE_MASK \
  -init image -init_image out11.png -color_codes $COLOR_CODES \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -proto_file models/channel_pruning.prototxt -model_file models/channel_pruning.caffemodel -backend cudnn -cudnn_autotune -optimizer adam \
  -image_size 2944 \
  -num_iterations 200 \
  -output_image out12.png