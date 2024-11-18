project(gpu-lib CXX)

add_library(buffered_reader buffer.cpp reader.cpp chunk_reader.cpp)
target_link_libraries(buffered_reader PUBLIC Eigen3::Eigen MPI::MPI_CXX hdf5::hdf5)
target_include_directories(buffered_reader PUBLIC ${CMAKE_SOURCE_DIR}/src/green/gpu/buffered_reader)

add_library(accel-lib cuda_common.cu cuda_check.cpp cublas_routines_prec.cu
        cu_compute_Pq.cu cugw_qpt.cu cu_routines.cu )
set_property(TARGET accel-lib PROPERTY CUDA_ARCHITECTURES ${GPU_ARCHS}) #also check the same parameters in solvers
target_include_directories(accel-lib PUBLIC .)
target_link_libraries(accel-lib CUDA::cudart CUDA::cuda_driver CUDA::cublas CUDA::cusolver)
target_link_libraries(accel-lib GREEN::UTILS GREEN::NDARRAY GREEN::GRIDS buffered_reader)

add_library(gpu gpu_kernel.cpp hf_gpu_kernel.cpp gw_gpu_kernel.cpp)
target_include_directories(gpu PUBLIC .)
target_link_libraries(gpu CUDA::cudart CUDA::cuda_driver CUDA::cublas CUDA::cusolver)
target_link_libraries(gpu accel-lib buffered_reader)
target_link_libraries(gpu GREEN::UTILS GREEN::NDARRAY GREEN::SYMMETRY GREEN::GRIDS GREEN::PARAMS)
set_property(TARGET gpu PROPERTY CUDA_ARCHITECTURES ${GPU_ARCHS}) #also check same parameters in accel
