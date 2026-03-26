# 摩尔线程软件参考

## 一、Linux DDK（驱动仓库）

- **路径:** `/workspace/linux-ddk`
- **类型:** Driver Development Kit 源码仓库
- **组织形式:** Git monorepo + submodules
- **仓库大小:** ~8.5 GB
- **主构建脚本:** `ddk_build.sh`

### 驱动模块清单

| 模块 | 大小 | 构建系统 | 功能 |
|------|------|---------|------|
| gpu-fw | 64MB | CMake | GPU MCU 固件，支持 GEN1~GEN8 |
| gr-kmd | 906MB | Makefile | 内核驱动（mtgpu/mt-rm/mtvpu/mtsnd/display/kms/dkms） |
| gr-umd | 2.1GB | CMake | 用户态驱动（services/compiler/egl/opengl/opengles/vulkan/opencl） |
| ogl | 838MB | CMake+Python | OpenGL 4.x 驱动 |
| vulkan | 824MB | CMake | Vulkan ICD 驱动 |
| libdrm-mt | 64MB | CMake | 定制 DRM 库 |
| shared_include | 58MB | CMake | 跨模块共享头文件 |
| libgfxc | 96KB | CMake | 图形编译器集成库 |
| mthreads-gmi | 70MB | CMake | GPU 管理接口（支持 x86_64/aarch64/armhf/loongarch64/sw64） |
| mt-media-driver | 849MB | CMake | 媒体编解码驱动 |
| mt-video-drv | 16MB | Build scripts | VPU 驱动 |
| xf86-video-mtgpu | 1.4MB | Autotools | X.org 视频驱动 |
| ci/ | 8KB | - | CI/CD 脚本 |

### 硬件代际

| 代际 | 代号 | 内部标识 |
|------|------|---------|
| GEN1 | SUDI/QY1 | gen1 |
| GEN2 | QY2 | gen2 |
| GEN2_1 | M1000 | gen2_1 |
| GEN3 | PH1 | gen3 |
| GEN4 | PH1S | gen4 |
| GEN7 | LS | gen7 |
| GEN8 | HS | gen8 |

---

## 二、MUSA Toolkit（SDK 仓库）

- **路径:** `/workspace/musa_toolkit`
- **类型:** GPU 计算 SDK 源码仓库
- **版本:** 5.1.0 (develop)

### SDK 模块清单

| 模块 | 类别 | 功能 | NVIDIA 对标 |
|------|------|------|------------|
| MUSA-Runtime | 核心 | 计算运行时（Runtime/Driver API + HAL） | cuda-cudart |
| mtcc | 核心 | LLVM 编译器工具链（含 libdevice/libmusacxx/libmtrtc/libgfxc/libclc） | cuda-nvcc + libnvrtc |
| muBLAS | 数学库 | 线性代数 | libcublas |
| muBLASLt | 数学库 | 轻量 BLAS | libcublasLt |
| muFFT | 数学库 | 快速傅里叶变换 | libcufft |
| muRAND | 数学库 | 随机数生成 | libcurand |
| muSPARSE | 数学库 | 稀疏矩阵 | libcusparse |
| muSOLVER | 数学库 | 线性求解器（基于 rocSOLVER） | libcusolver |
| muPP | 数学库 | 图像处理原语 | libnpp |
| muAlg | 开发库 | 算法库（含 CUB 集成） | cuda-cccl |
| muThrust | 开发库 | Thrust 兼容模板库 | cuda-cccl (Thrust) |
| MUPTI | 工具 | 性能分析接口 | cuda-cupti |
| musify | 工具 | CUDA→MUSA 代码迁移 | 无（MT独有） |
| mtjpeg | 工具 | 硬件 JPEG/视频编解码 | libnvjpeg |
| zluda | 兼容层 | CUDA 兼容层（规划中） | 无 |
| module_version | 工具 | 版本查询模块 | 无 |
