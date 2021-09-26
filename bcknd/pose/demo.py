import torch
from torch.autograd import Variable
import torch.nn.functional as F
import torchvision.transforms as transforms

import torch.nn as nn
import torch.utils.data
import numpy as np
from opt import opt

from dataloader import ImageLoader, DetectionLoader, DetectionProcessor, DataWriter, Mscoco
from yolo.util import write_results, dynamic_write_results
from SPPE.src.main_fast_inference import *

import os
import sys
from tqdm import tqdm
import time
from fn import getTime

from pPose_nms import pose_nms, write_json


from SPPE.src.utils.eval import getPrediction, getMultiPeakPrediction


import cv2

args = opt
args.dataset = "coco"
if not args.sp:
    torch.multiprocessing.set_start_method("forkserver", force=True)
    torch.multiprocessing.set_sharing_strategy("file_system")

if args.vis_fast:
    from fn import vis_frame_fast as vis_frame
else:
    from fn import vis_frame

if __name__ == "__main__":
    inputpath = "/home/david/Downloads/line/out33"
    args.outputpath = "/home/david/Downloads/line/out333"

    mode = args.mode
    if not os.path.exists(args.outputpath):
        os.mkdir(args.outputpath)

    im_names = [os.path.join(inputpath, fn_) for fn_ in os.listdir("/home/david/Downloads/line/in3")]
    im_names.sort()

    # Load input images
    data_loader = ImageLoader(im_names, batchSize=args.detbatch, format="yolo").start()

    # Load detection loader
    print("Loading YOLO model..")
    sys.stdout.flush()
    det_loader = DetectionLoader(data_loader, batchSize=args.detbatch).start()
    det_processor = DetectionProcessor(det_loader).start()

    # Load pose model
    pose_dataset = Mscoco()
    if args.fast_inference:
        pose_model = InferenNet_fast(4 * 1 + 1, pose_dataset)
    else:
        pose_model = InferenNet(4 * 1 + 1, pose_dataset)
    pose_model  # .cuda()
    pose_model.eval()

    runtime_profile = {"dt": [], "pt": [], "pn": []}

    # Init data writer
    writer = DataWriter(args.save_video).start()

    data_len = data_loader.length()
    im_names_desc = tqdm(range(data_len))

    batchSize = args.posebatch
    for i in im_names_desc:
        start_time = getTime()
        with torch.no_grad():
            (inps, orig_img, im_name, boxes, scores, pt1, pt2) = det_processor.read()
            if boxes is None or boxes.nelement() == 0:
                writer.save(None, None, None, None, None, orig_img, im_name.split("/")[-1])
                continue

            base_name = im_name.split("/")[-1]
            base_name_id = int(base_name[3:8])

            # if base_name_id > 200:
            #     continue

            # if base_name_id < 50 or base_name_id > 75:
            #     continue

            ckpt_time, det_time = getTime(start_time)
            runtime_profile["dt"].append(det_time)
            # Pose Estimation

            datalen = inps.size(0)
            leftover = 0
            if (datalen) % batchSize:
                leftover = 1
            num_batches = datalen // batchSize + leftover
            hm = []
            for j in range(num_batches):
                inps_j = inps[j * batchSize : min((j + 1) * batchSize, datalen)]
                hm_j = pose_model(inps_j)
                hm.append(hm_j)
            hm = torch.cat(hm)
            ckpt_time, pose_time = getTime(ckpt_time)
            runtime_profile["pt"].append(pose_time)
            hm = hm.cpu()
            # writer.save(boxes, scores, hm, pt1, pt2, orig_img, im_name.split("/")[-1])

            hm_data = hm

            label_color = (255, 0, 0)

            # if base_name_id < 75:
            #     label_color = (0, 0, 255)
            # elif base_name_id < 102:
            #     label_color = (255, 0, 0)
            # elif base_name_id < 115:
            #     label_color = (0, 255, 0)
            # elif base_name_id < 171:
            #     label_color = (255, 0, 0)
            # elif base_name_id < 185:
            #     label_color = (0, 255, 0)
            # else:
            #     label_color = (255, 0, 0)

            preds_hm, preds_img, preds_scores = getPrediction(
                hm_data, pt1, pt2, args.inputResH, args.inputResW, args.outputResH, args.outputResW
            )
            result = pose_nms(boxes, scores, preds_img, preds_scores)
            img = vis_frame(orig_img, result, line_color=label_color)

            cv2.imwrite(os.path.join(args.outputpath, im_name.split("/")[-1]), img)

            ckpt_time, post_time = getTime(ckpt_time)
            runtime_profile["pn"].append(post_time)

        if args.profile:
            # TQDM
            im_names_desc.set_description(
                "det time: {dt:.3f} | pose time: {pt:.2f} | post processing: {pn:.4f}".format(
                    dt=np.mean(runtime_profile["dt"]),
                    pt=np.mean(runtime_profile["pt"]),
                    pn=np.mean(runtime_profile["pn"]),
                )
            )

    print("===========================> Finish Model Running.")
    if (args.save_img or args.save_video) and not args.vis_fast:
        print("===========================> Rendering remaining images in the queue...")
        print(
            "===========================> If this step takes too long, you can enable the --vis_fast flag to use fast rendering (real-time)."
        )
    while writer.running():
        pass
    writer.stop()
    final_result = writer.results()
    write_json(final_result, args.outputpath)
