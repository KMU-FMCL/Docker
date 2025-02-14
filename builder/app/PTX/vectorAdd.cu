extern "C" __global__ void vectorAdd(const float *A, const float *B, float *C, int N)
{
  int idx = threadIdx.x + blockIdx.x * blockDim.x;

  if (idx < N)
    C[idx] = A[idx] + B[idx];
}
