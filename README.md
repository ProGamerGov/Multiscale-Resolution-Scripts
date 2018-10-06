# Multiscale Resolution Scripts 

These scripts make use of a technique described in the paper [Controlling Perceptual Factors in Neural Style Transfer](https://arxiv.org/abs/1611.07865) by Leon A. Gatys, Alexander S. Ecker, Matthias Bethge, Aaron Hertzmann and Eli Shechtman. While the multiscale effect with style transfer had already been discovered, it was only after the paper that people realized the significance of it. 

The Multiscale Resolution technique makes use of ever increasing image sizes to create larger stylized output images, without the problems that starting at such a large size would have.  

## Setup

First download the linear-color-transfer.py, and lum-transfer.py scripts from [Neural-Tools](https://github.com/ProGamerGov/Neural-Tools):

```
wget -c https://raw.githubusercontent.com/ProGamerGov/Neural-Tools/master/linear-color-transfer.py

wget -c https://raw.githubusercontent.com/ProGamerGov/Neural-Tools/master/lum-transfer.py
```

## Usage

By default these scripts likely won't produce good results, so you are encouraged to modify the script parameters to you liking. Though there are some things to keep in mind:

* For the step 1 image size, keep in mind that the amount of change is related to how close the image size is to the size of the images used to train the model (ex: 224, 512). 

* As per Justin Johnson (creator of Neural-Style)'s suggestions, setting `-tv_weight` to `0` can improve results when using a multiscale resolution script like this. Though this dependent on what you want the output to look like.

* More steps seem to let smaller details develop more than when just simply using as few steps as possible. 

* These scripts are designed to use [jcjohnson's neural-style](https://github.com/jcjohnson/neural-style), [neural-style-pt](https://github.com/ProGamerGov/neural-style-pt), and any similar style transfer scripts.

To run the scripts, you can use: 

```
sh multires_style2content_hist.sh
```

```
sh multires_style2content.sh
```

```
sh multires_style2content_hist_large_cp.sh
```

```
sh multires_content2style.sh
```

```
sh multires_style2content_large.sh
```

```
sh multires_seg.sh
```

```
sh multires_seg_large_cp.sh
```

## Troubleshooting

You can easily fix permission errors using `chmod` like this: 

```
chmod u+x ./multires_style2content_hist.sh
chmod u+x ./multires_style2content_hist_large_cp.sh
chmod u+x ./multires_style2content.sh
chmod u+x ./multires_content2style.sh
chmod u+x ./multires_style2content_large.sh
chmod u+x ./multires_seg.sh
chmod u+x ./multires_seg_large_cp.sh
chmod u+x ./lum-transfer.py
chmod u+x ./linear-color-transfer.py
```
