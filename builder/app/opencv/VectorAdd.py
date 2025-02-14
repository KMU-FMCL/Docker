import cv2
import numpy as np
import time

# Vecotr Size (Ex. 1,048,576)
N = 1 << 20


# Create an input vector (float32 type)
A = np.ones((N,), dtype=np.float32)      # All elements 1.0
B = np.full((N,), 2.0, dtype=np.float32) # All elements 2.0


# Vector addition (using numpy) and timing on the CPU
start_cpu = time.time()
C_cpu = A + B
end_cpu = time.time()
cpu_time = end_cpu - start_cpu

print("CPU vector addition time: {:.6f} seconds".format(cpu_time))
print("CPU results (first 10):", C_cpu[:10])

if np.allclose(C_cpu, 3.0):
    print("CPU test PASSED")
else:
    print("CPU test FAILED")


# Check if CUDA is enabled
if cv2.cuda.getCudaEnabledDeviceCount() == 0:
    print("Not CUDA")
else:
    gpu_A = cv2.cuda_GpuMat()
    gpu_B = cv2.cuda_GpuMat()

    gpu_A.upload(A)
    gpu_B.upload(B)


    start_gpu = time.time()
    gpu_C = cv2.cuda.add(gpu_A, gpu_B)

    end_gpu = time.time()
    gpu_time = end_gpu - start_gpu


    C_gpu = gpu_C.download()

    print("GPU vector addition time: {:.6f} seconds".format(gpu_time))
    print("GPU results (first 10):", C_gpu[:10])

    if np.allclose(C_gpu, 3.0):
        print("GPU test PASSED")
    else:
        print("GPU test FAILED")
