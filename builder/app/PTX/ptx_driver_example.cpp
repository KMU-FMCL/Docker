#include <cstdio>
#include <cstdlib>
#include <chrono>
#include <cuda.h>

// Error Check Macro
#define CUDA_SAFE_CALL(call)                                             \
    do {                                                                 \
        CUresult err = call;                                             \
        if (err != CUDA_SUCCESS) {                                       \
            const char *errStr;                                          \
            cuGetErrorName(err, &errStr);                                \
            fprintf(stderr, "CUDA error: %s in file %s at line %d\n",    \
                    errStr, __FILE__, __LINE__);                         \
            exit(EXIT_FAILURE);                                          \
        }                                                                \
    } while (0)

int main() {
  // 1. Initializing the CUDA Driver API
  CUDA_SAFE_CALL(cuInit(0));


  // 2. Create Device & Context
  CUdevice device;
  CUDA_SAFE_CALL(cuDeviceGet(&device, 0));

  CUcontext context;
  CUDA_SAFE_CALL(cuCtxCreate(&context, 0, device));


  // 3. Loading PTX Module
  CUmodule module;
  CUDA_SAFE_CALL(cuModuleLoad(&module, "vectorAdd.ptx"));


  // 4. Get Kernel Handle (Vector Addition Kernel)
  CUfunction vecAddKernel;
  CUDA_SAFE_CALL(cuModuleGetFunction(&vecAddKernel, module, "vectorAdd"));


  // 5. Prepare data to run (vector addition example, N elements)
  int N = 1 << 20; // 1,048,576
  size_t size = N * sizeof(float);

  float *h_A = (float*)malloc(size);
  float *h_B = (float*)malloc(size);
  float *h_C = (float*)malloc(size);

  for (int i = 0; i < N; i++) {
    h_A[i] = 1.0f;
    h_B[i] = 2.0f;
  }


  // 6. Device memory allocation
  CUdeviceptr d_A, d_B, d_C;
  
  CUDA_SAFE_CALL(cuMemAlloc(&d_A, size));
  CUDA_SAFE_CALL(cuMemAlloc(&d_B, size));
  CUDA_SAFE_CALL(cuMemAlloc(&d_C, size));


  // 7. Copying data to a device
  CUDA_SAFE_CALL(cuMemcpyHtoD(d_A, h_A, size));
  CUDA_SAFE_CALL(cuMemcpyHtoD(d_B, h_B, size));


  // 8. Configuring kernel execution: Setting block and grid sizes
  int threadsPerBlock = 256;
  int blocksPerGrid = (N + threadsPerBlock - 1) / threadsPerBlock;


  // 9. Setting kernel arguments
  void *kernelArgs[] = { &d_A, &d_B, &d_C, &N };


  // 10. Start measuring time before kernel execution
  auto start = std::chrono::high_resolution_clock::now();


  // 11. Kernel Launch
  CUDA_SAFE_CALL(cuLaunchKernel(vecAddKernel,
                                blocksPerGrid, 1, 1,      // Grid dimensions
                                threadsPerBlock, 1, 1,    // Block dimensions
                                0,    // Shared memory size
                                0,    // Stream (default stream if NULL)
                                kernelArgs,    // Array of arguments
                                0));


  // 12. Synchronize to kernel execution completion
  CUDA_SAFE_CALL(cuCtxSynchronize());


  // 13. Ending time measurement after kernel execution
  auto end = std::chrono::high_resolution_clock::now();
  std::chrono::duration<double> elapsed = end - start;


  // 14. Copy the results to the host
  CUDA_SAFE_CALL(cuMemcpyDtoH(h_C, d_C, size));


  // 15. Validate the result: print the first 10 values of h_C
  printf("Vector addition result (first 10 elements):\n");

  for (int i = 0; i < 10; i++) {
    printf("%f ", h_C[i]);
  }
  printf("\n");


  // 16. Time spent output
  printf("Kernel Execution Time: %f seconds\n", elapsed.count());


  // 17. Validate the results (all values should be 3.0f)
  int correct = 1;

  for (int i = 0; i < N; i++) {
    if (h_C[i] != 3.0f) {
      correct = 0;
      break;
    }
  }
  
  if (correct)
    printf("Test PASSED\n");
  else
    printf("Test FAILED\n");


  // 15. Cleanup and free memory
  cuMemFree(d_A);
  cuMemFree(d_B);
  cuMemFree(d_C);

  free(h_A);
  free(h_B);
  free(h_C);

  cuModuleUnload(module);
  cuCtxDestroy(context);

  return 0;
}
