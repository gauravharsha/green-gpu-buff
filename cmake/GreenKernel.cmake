function(init_kernel KERNEL_ENUM KERNEL_LIB KERNEL_HEADER KERNEL_NS)
    if("${KERNEL_ENUM}" IN_LIST CUSTOM_KERNEL_ENUMS)
        message(STATUS "Kernel ${KERNEL_ENUM} has been already added")
    else()
        set(CUSTOM_KERNEL_ENUMS "${KERNEL_ENUM};${CUSTOM_KERNEL_ENUMS}" CACHE INTERNAL "")
        set(CUSTOM_KERNEL_LIBS "${KERNEL_LIB};${CUSTOM_KERNEL_LIBS}" CACHE INTERNAL "")
        set(CUSTOM_KERNEL_HEADERS "${KERNEL_HEADER};${CUSTOM_KERNEL_KERNELS}" CACHE INTERNAL "")
        set(CUSTOM_KERNEL_NAMESPACES "${KERNEL_NS};${CUSTOM_KERNEL_NAMESPACES}" CACHE INTERNAL "")
    endif()
    message(STATUS "Initialized custom kernel")
    message(STATUS "CUSTOM KERNEL ENUMS: ${CUSTOM_KERNEL_ENUMS}")
endfunction()
