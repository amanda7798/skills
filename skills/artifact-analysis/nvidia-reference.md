# NVIDIA CUDA 13.2 软件包参考

## 仓库信息

- **路径:** `/workspace/tmp/cuda_package/var/cuda-repo-ubuntu2404-13-2-local`
- **目标系统:** Ubuntu 24.04 (Noble)
- **CUDA 版本:** 13.2.x
- **驱动版本:** 595.45.04
- **包总数:** 145 个 .deb 包
- **仓库大小:** ~3.9 GB

---

## 驱动类包（约 55 个）

### 内核驱动与固件
- nvidia-kernel-source (78MB), nvidia-kernel-source-open (8MB)
- nvidia-dkms, nvidia-dkms-open
- nvidia-kernel-common (741KB)
- nvidia-firmware (73MB)
- dkms (54KB), dh-dkms

### 驱动元包与变体
- nvidia-driver, nvidia-driver-open, nvidia-drivers, nvidia-open
- nvidia-headless, nvidia-headless-open, nvidia-headless-no-dkms, nvidia-headless-no-dkms-open
- nvidia-driver-pinning-595, nvidia-driver-pinning-595.45.04
- nvidia-driver-assistant

### 用户态驱动库
- libnvidia-compute (amd64: 80MB, i386: 35MB)
- libnvidia-gl (amd64: 113MB, i386: 19MB)
- libnvidia-gpucomp (amd64: 24MB, i386: 27MB)
- libnvidia-encode (amd64/i386)
- libnvidia-decode (amd64: 2.6MB, i386: 2.4MB)
- libnvidia-fbc1 (amd64/i386)
- libnvidia-cfg1 (146KB)
- libnvidia-common (27KB)
- libnvidia-extra (amd64/i386)
- libnvidia-nscq (428KB)
- libnvsdm (555KB), libnvsdm-dev

### EGL 与显示
- libnvidia-egl-wayland21 (amd64/i386)
- libnvidia-egl-gbm1 (amd64/i386)
- libnvidia-egl-xcb1 (amd64/i386)
- libnvidia-egl-xlib1 (amd64/i386)
- xserver-xorg-video-nvidia
- libxnvctrl0 (36KB), libxnvctrl-dev (297KB)
- eglexternalplatform-dev

### 管理工具
- nvidia-settings (883KB)
- nvidia-modprobe (46KB)
- nvidia-persistenced (81KB)
- nvidia-xconfig (261KB)

### 数据中心与互联
- nvidia-fabricmanager (9.4MB), nvidia-fabricmanager-dev
- nvlink5 (2.8MB)
- nvidia-imex (8.4MB)
- nvidia-fs, nvidia-fs-dkms
- nvlsm (10MB)

### 网络与诊断
- mft (46MB), mft-autocomplete, mft-oem (3MB)
- collectx-bringup (140MB)

---

## SDK/Toolkit 类包（约 90 个）

### 编译器与运行时
- cuda-nvcc, cuda-compiler, cuda-crt, cuda-command-line-tools
- cuda-cudart, cuda-cudart-dev
- libnvrtc, libnvrtc-dev
- libnvjitlink, libnvjitlink-dev (29MB/26MB)
- libnvvm (45MB)
- libnvfatbin, libnvfatbin-dev
- libnvptxcompiler (14MB)
- cuda-opencl, cuda-opencl-dev

### 数学库
- libcublas, libcublas-dev (428MB)
- libcufft, libcufft-dev
- libcusparse, libcusparse-dev
- libcusolver, libcusolver-dev
- libcurand, libcurand-dev
- libnpp, libnpp-dev (113MB/111MB)
- libnvjpeg, libnvjpeg-dev

### 开发工具
- cuda-gdb (27MB), cuda-gdb-src (67MB)
- cuda-nsight (118MB)
- nsight-compute-2026.1.0 (329MB)
- nsight-systems-2025.6.3 (420MB)
- cuda-cupti, cuda-cupti-dev (14MB)
- cuda-sanitizer (10MB)
- cuda-profiler-api
- cuda-nvtx
- cuda-cuobjdump, cuda-nvdisasm, cuda-cuxxfilt
- cuda-nvprune
- cuda-ctadvisor, cuda-tileiras

### 开发头文件与元包
- cuda-driver-dev, cuda-nvml-dev
- cuda-cccl (1.2MB)
- cuda-culibos, cuda-culibos-dev
- cuda-sandbox-dev
- cuda-documentation
- libcufile, libcufile-dev, gds-tools (40MB)
- libcuobjclient, libcuobjclient-dev

### 元包
- cuda, cuda-13-2
- cuda-toolkit, cuda-toolkit-13, cuda-toolkit-13-2
- cuda-runtime-13-2
- cuda-libraries-13-2, cuda-libraries-dev-13-2
- cuda-minimal-build-13-2
- cuda-tools-13-2, cuda-visual-tools-13-2
- cuda-toolkit-config-common, cuda-toolkit-13-config-common, cuda-toolkit-13-2-config-common
- cuda-compat-13-2
- nvidia-gds, nvidia-gds-13-2
- cuda-nsight-compute-13-2, cuda-nsight-systems-13-2
