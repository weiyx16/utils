# Python 3.6.5
# Opencv 3.4.1
# Author: Eason
# 2018.11

import cv2
import os
import math

img_size = 256
doc_path = r'/home/weiyx/Desktop/data_source/web'
remove_source = True

filenames = os.listdir(doc_path)
for filename in filenames:
    
    file_path = doc_path+'/'+filename
    print('load img from {}'.format(file_path))
    img = cv2.imread(file_path)
    height, width = img.shape[:2]
    if height > width:
        block_pad = height - width
        left_pad = math.floor(block_pad/2)
        right_pad = math.ceil(block_pad/2)
        img_pad = cv2.copyMakeBorder(img , 0, 0, left_pad, right_pad ,cv2.BORDER_CONSTANT,value=[0,0,0])
    else:
        block_pad = width - height
        top_pad = math.floor(block_pad/2)
        bottom_pad = math.ceil(block_pad/2)
        img_pad = cv2.copyMakeBorder(img , top_pad, bottom_pad, 0, 0, cv2.BORDER_CONSTANT,value=[0,0,0])
    
    if remove_source:
        os.remove(file_path) # remove the source img

    img_resize = cv2.resize(img_pad, (img_size, img_size), interpolation=cv2.INTER_CUBIC)
    file_path = file_path + '_new.png'
    print('Save img to {}'.format(file_path))
    cv2.imwrite(file_path, img_resize)
    