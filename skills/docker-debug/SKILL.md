---
name: docker-debug
description: 进入指定 docker 容器，以 /workspace/tmp 为工作目录调试项目。用法：/docker-debug <容器名> <项目目录>
argument-hint: <容器名> <项目目录>
user-invocable: true
allowed-tools: Read, Grep, Glob, Bash, Write, Edit, Agent
---

# Docker 容器调试

从用户提供的参数中解析出容器名和项目目录。参数格式为：`<容器名> <项目目录>`

例如：
- `/docker-debug my_container /workspace/DirectStream`
- `/docker-debug build_env /workspace/linux-ddk`

## 工作约定

- **工作目录**：始终以 `/workspace/tmp` 作为 Claude 的工作目录（即你读写文件、执行命令的基准目录）
- **进入容器**：需要在容器内执行命令时，使用 `docker exec -it <容器名> bash -c "<命令>"` 或 `docker exec <容器名> bash -c "<命令>"`
- **项目目录**：用户指定的项目目录是容器内要调试的目标路径

## 调试原则（重要）

**优先静态分析，最后才执行命令。** 按以下优先级排查：

1. **先看日志**：查找项目目录或容器内的 log 文件（`*.log`、`build.log`、`stderr`、`CMakeFiles/*.log` 等），从错误信息入手
2. **再读源码/配置**：根据报错定位到具体文件，用 Read/Grep 阅读相关代码、CMakeLists.txt、脚本、配置文件
3. **静态推断根因**：结合日志 + 代码，尽量在不运行任何命令的情况下分析出问题所在
4. **最后才执行命令**：只有静态分析无法确认时，才用 `docker exec` 在容器内执行命令验证；且每次执行前说明目的，避免盲目重跑构建或测试

> 禁止在未阅读日志/代码的情况下直接重新执行构建/测试命令来"看看报什么错"。

## 调试流程

1. **确认参数**：从用户输入解析容器名和项目目录，如果缺少参数则询问用户
2. **检查容器状态**：运行 `docker ps --filter name=<容器名>` 确认容器正在运行
3. **收集现有信息**：优先读取项目目录下已有的日志文件、构建产物、错误输出；用 Read/Grep 直接读取容器内挂载的文件（如 `/workspace/` 下的文件可直接访问）
4. **静态分析**：根据日志报错定位源码、CMakeLists、脚本，阅读相关文件推断根因
5. **按需执行命令**：仅在静态分析不足以确认问题时，才通过 `docker exec` 执行最小化的验证命令（如检查文件是否存在、查看环境变量、查看依赖版本等），不重跑完整构建
6. **本地辅助**：`/workspace/tmp` 下的文件（日志、配置等）直接用 Read/Grep 读取，无需进容器

## 执行命令的方式

在容器内执行命令统一用：
```bash
docker exec <容器名> bash -c "cd <项目目录> && <你要执行的命令>"
```

如需交互式进入容器，提示用户在终端运行：
```bash
docker exec -it <容器名> bash
```
（Claude 本身无法驱动交互式 TTY，需要用户手动执行）
