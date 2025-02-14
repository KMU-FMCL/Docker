import cv2
import numpy as np
import time

height, width = 4096, 4096
image = np.zeros((height, width, 3), dtype=np.uint8)

cv2.line(image, (0,0), (width, height), (255, 255, 255), 10)
cv2.line(image, (width, 0), (0, height), (255, 255, 255), 10)

gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

edges = cv2.Canny(gray_image, 50, 150, apertureSize = 3)


# CPU
start_cpu = time.time()
lines_cpu = cv2.HoughLines(edges, 1, np.pi / 180, 200)
end_cpu = time.time()

print(f"CPU Huff Conversion Time : {end_cpu - start_cpu} seconds")


# CUDA
if not cv2.cuda.getCudaEnabledDeviceCount():
    print("No devices are CUDA-enabled.")
else:
    gpu_image = cv2.cuda_GpuMat()
    gpu_image.upload(gray_image)

    gpu_edges = cv2.cuda.createCannyEdgeDetector(50, 150, 3)
    gpu_edge_output = gpu_edges.detect(gpu_image)

    start_gpu = time.time()
    hough_detector = cv2.cuda.createHoughSegmentDetector(1, np.pi / 180, 200, 10)
    result_gpu = hough_detector.detect(gpu_edge_output)
    end_gpu = time.time()
    print(f"GPU Huff Conversion Time : {end_gpu - start_gpu} seconds")
