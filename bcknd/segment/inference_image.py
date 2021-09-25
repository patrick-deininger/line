# ------------------------------------------------------------------------------
# 	Libraries
# ------------------------------------------------------------------------------
import os

import cv2
import torch, argparse
from time import time
import numpy as np
from torch.nn import functional as F

from models import UNet
from dataloaders import transforms
from utils import utils


# ------------------------------------------------------------------------------
#   Argument parsing
# ------------------------------------------------------------------------------
# parser = argparse.ArgumentParser(description="Arguments for the script")

# parser.add_argument('--use_cuda', action='store_true', default=False,
#                     help='Use GPU acceleration')

# parser.add_argument('--bg', type=str, default=None,
#                     help='Path to the background image file')

# parser.add_argument('--watch', action='store_true', default=False,
#                     help='Indicate show result live')

# parser.add_argument('--input_sz', type=int, default=320,
#                     help='Input size')

# parser.add_argument('--checkpoint', type=str, default="/media/antiaegis/storing/FORGERY/segmentation/checkpoints/HumanSeg/UNet_MobileNetV2/model_best.pth",
#                     help='Path to the trained model file')

# parser.add_argument('--video', type=str, default="/media/antiaegis/storing/FORGERY/segmentation/videos/Directions.54138969.mp4",
#                     help='Path to the input video')

# parser.add_argument('--output', type=str, default="/media/antiaegis/storing/FORGERY/segmentation/videos/Directions.54138969.output.mp4",
#                     help='Path to the output video')

# args = parser.parse_args()


# ------------------------------------------------------------------------------
# 	Parameters
# ------------------------------------------------------------------------------
# Video input
# cap = cv2.VideoCapture(args.video)


# frame = cv2.imread("/home/david/Downloads/squat/img02055.png")

# # _, frame = cap.read()
# H, W = frame.shape[:2]

# # Video output
# fourcc = cv2.VideoWriter_fourcc(*'DIVX')
# out = cv2.VideoWriter(args.output, fourcc, 30, (W,H))
# font = cv2.FONT_HERSHEY_SIMPLEX

# # Background
# if args.bg is not None:
# 	BACKGROUND = cv2.imread(args.bg)[...,::-1]
# 	BACKGROUND = cv2.resize(BACKGROUND, (W,H), interpolation=cv2.INTER_LINEAR)
# 	KERNEL_SZ = 25
# 	SIGMA = 0

# Alpha transperency
COLOR1 = [255, 0, 0]
COLOR2 = [0, 0, 255]


# ------------------------------------------------------------------------------
# 	Create model and load weights
# ------------------------------------------------------------------------------
model = UNet(backbone="mobilenetv2", num_classes=2, pretrained_backbone=None)


trained_dict = torch.load(
    "/home/david/Documents/ws/Human-Segmentation-PyTorch/ckpts/UNet_MobileNetV2.pth", map_location="cpu"
)["state_dict"]
model.load_state_dict(trained_dict, strict=False)
model.eval()


# ------------------------------------------------------------------------------
#   Predict frames
# ------------------------------------------------------------------------------
i = 0

img_dir = "/home/david/Downloads/line/in"
output_dir = "/home/david/Downloads/line/out1"

for img_fn in os.listdir(img_dir):
    img_fl = os.path.join(img_dir, img_fn)

    frame = cv2.imread(img_fl)

    # _, frame = cap.read()
    H, W = frame.shape[:2]

    image = frame[..., ::-1]
    h, w = image.shape[:2]

    # Predict mask
    X, pad_up, pad_left, h_new, w_new = utils.preprocessing(image, expected_size=320, pad_value=0)
    with torch.no_grad():
        mask = model(X)
        mask = mask[..., pad_up : pad_up + h_new, pad_left : pad_left + w_new]
        mask = F.interpolate(mask, size=(h, w), mode="bilinear", align_corners=True)
        mask = F.softmax(mask, dim=1)
        mask = mask[0, 1, ...].numpy()

    # Draw result
    image_alpha = utils.draw_matting(image, mask)
    # image_alpha = utils.draw_transperency(image, mask, COLOR1, COLOR2)

    # cv2.imwrite("/home/david/Downloads/line/out/test.png", image_alpha[..., ::-1])

    from scipy.ndimage import gaussian_filter

    mask_filtered = gaussian_filter(mask, sigma=20)

    inverted_mask = 1 - mask_filtered
    white_bg = np.zeros_like(image) + 255

    filtered_image = (
        (image.transpose(2, 0, 1) * mask_filtered + white_bg.transpose(2, 0, 1) * inverted_mask).transpose(1, 2, 0)[
            ..., ::-1
        ]
    ).astype(np.int)

    cv2.imwrite(os.path.join(output_dir, img_fn), filtered_image)
