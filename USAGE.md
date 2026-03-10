# Claude Code Skills 使用指南

## 安装

### 快速安装

```bash
# 方式一：使用安装脚本（推荐）
./install.sh

# 方式二：手动复制
cp -r skills/* ~/.claude/skills/
```

验证安装：
```bash
# 在 Claude Code 中输入 / 查看可用 skills
# 或使用 ls 查看
ls ~/.claude/skills/
```

### 安装单个 skill

```bash
# 只安装 yocto skill
cp -r skills/yocto ~/.claude/skills/
```

### 项目级安装

```bash
# 在项目根目录
mkdir -p .claude/skills
cp -r /path/to/skills/* .claude/skills/
```

## 使用方式

### 方式一：显式调用

在 Claude Code 提示符中输入：
```
/yocto
```

输入 `/` 可以看到所有可用 skills 的列表。

### 方式二：自动触发

直接提问，Claude 会根据 skill 的 `description` 字段自动判断是否加载：

**示例：**
```
如何创建 BitBake recipe？         # 自动触发 yocto skill
我的 .bbappend 文件不生效          # 自动触发 yocto skill
```

## 管理 Skills

### 更新 skills

```bash
# 拉取最新版本
cd /path/to/skills-repo
git pull

# 更新到配置目录
cp -r skills/* ~/.claude/skills/

# 无需重启，Claude Code 会自动检测
```

### 查看已安装的 skills

```bash
# 列出所有已安装的 skills
ls -la ~/.claude/skills/

# 查看某个 skill 的内容
cat ~/.claude/skills/yocto/SKILL.md
```

### 卸载 skills

```bash
# 卸载单个 skill
rm -rf ~/.claude/skills/yocto/

# 卸载所有 skills
rm -rf ~/.claude/skills/*/
```

### 临时禁用 skill

重命名目录即可：
```bash
mv ~/.claude/skills/yocto ~/.claude/skills/yocto.disabled
```

恢复：
```bash
mv ~/.claude/skills/yocto.disabled ~/.claude/skills/yocto
```

## Skill 工作原理

### 触发机制

Claude 通过以下方式决定是否加载 skill：

1. **显式调用**：你输入 `/skill-name`
2. **自动触发**：Claude 分析你的问题和 skill 的 `description`，智能判断是否相关

### Skill 作用域

| 位置 | 作用域 | 优先级 |
|:-----|:-------|:-------|
| `~/.claude/skills/` | 全局，所有项目 | 低 |
| `.claude/skills/` | 当前项目 | 高 |

项目级 skill 会覆盖同名的全局 skill。

### Skill 格式

```yaml
---
name: skill-name          # skill 名称（lowercase, hyphens）
description: 描述         # Claude 用此判断是否加载
user-invocable: true      # 是否可以用 / 调用（默认 true）
disable-model-invocation: false  # 禁止 Claude 自动加载（默认 false）
---

# Skill 内容

你的指令...
```

## 提问技巧

### ✅ 好的提问方式

**包含上下文：**
```
使用 Yocto Kirkstone，编译自定义应用时报错：
ERROR: Task do_compile failed
日志显示：error: xxx.h: No such file or directory

我的 recipe：
DEPENDS = "libxxx"
SRC_URI = "git://..."

目标：成功编译并打包到镜像中
```

**清晰的需求：**
```
如何在 BitBake recipe 中添加 systemd 服务？
需要在启动时自动运行我的应用。
```

### ❌ 不好的提问方式

**缺少上下文：**
```
出错了
不工作
报错
```

**过于宽泛：**
```
怎么用 Yocto？
BitBake 是什么？
```

### 提问建议

好的提问应包含：

1. **环境信息**
   - 工具版本（Yocto Kirkstone, Python 3.10 等）
   - 操作系统

2. **问题描述**
   - 具体错误信息或日志
   - 期望行为 vs 实际行为

3. **相关代码或配置**
   - Recipe 内容
   - 配置文件
   - 命令输出

4. **已尝试的方案**
   - 已经试过什么
   - 为什么没有解决

## 高级用法

### 组合使用多个 skills

当问题涉及多个领域时，你可以：

```
/yocto

我需要在 Yocto 中集成 Docker 容器...
```

Claude 会加载 yocto skill，然后你可以继续提问。

### 查看 skill 是否被加载

使用 `/context` 命令查看当前会话中加载了哪些 skills。

### 强制使用特定 skill

如果 Claude 没有自动加载你期望的 skill：

```
/yocto

请用 Yocto 的方式解释...
```

## 故障排除

### Skill 没有出现在列表中

1. **检查文件结构**
   ```bash
   # 正确：
   ~/.claude/skills/yocto/SKILL.md

   # 错误：
   ~/.claude/skills/yocto.md
   ~/.claude/skills/yocto/yocto.md
   ```

2. **检查文件名**
   - 必须是 `SKILL.md`（大写）

3. **检查 YAML frontmatter**
   ```yaml
   ---
   name: yocto
   description: ...
   ---
   ```

4. **验证文件内容**
   ```bash
   head -n 5 ~/.claude/skills/yocto/SKILL.md
   # 应该看到 YAML frontmatter
   ```

### Skill 加载但不起作用

1. 检查 `description` 是否准确描述了 skill 的用途
2. 尝试显式调用：`/skill-name`
3. 检查是否有冲突的项目级 skill

### Skill 被意外触发

1. 调整 `description`，使其更具体
2. 或设置 `disable-model-invocation: true`，只允许手动调用

## 参考

- 详细格式规范：[docs/skill-format.md](./docs/skill-format.md)
- 创建 skill 指南：[docs/create-skill.md](./docs/create-skill.md)
- 每个 skill 的具体用法：查看 `skills/*/README.md`
