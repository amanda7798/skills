# Claude Code Skills 仓库

专业领域 skills 集合，让 Claude 成为你的领域专家助手。

## 安装

### 方式一：全局安装（推荐）

```bash
# 1. 克隆仓库
git clone <repository-url>
cd skills

# 2. 安装所有 skills
./install.sh

# 或手动复制
cp -r skills/* ~/.claude/skills/

# 3. 验证安装（Claude Code 会自动检测，无需重启）
# 在 Claude Code 中输入 / 查看可用 skills
```

### 方式二：项目级安装

```bash
# 在项目根目录
cp -r /path/to/this/repo/skills .claude/skills/
```

## 使用

**显式调用：**
```
/yocto    # 调用 Yocto skill
```

**自动触发：**
直接提问，Claude 会根据 description 自动激活对应的 skill
```
如何创建 BitBake recipe？  # 自动触发 yocto skill
```

详见 [USAGE.md](./USAGE.md) 和各 skill 的使用说明

## 仓库结构

```
skills/
├── README.md              # 本文件
├── USAGE.md              # 通用使用指南
├── install.sh            # 安装脚本
├── docs/                 # 文档
│   ├── create-skill.md   # 如何创建 skill
│   └── skill-format.md   # Skill 格式规范
└── skills/               # Skills 目录
    └── yocto/            # Skill 名称
        ├── SKILL.md      # Skill 本体（必需，固定名称）
        └── README.md     # 该 skill 的使用说明
```

## 可用 Skills

| Skill | 描述 | 调用方式 |
|:------|:-----|:---------|
| yocto | Yocto/BitBake 开发专家 | `/yocto` |

查看 [skills](./skills/) 目录了解更多。

## Skill 文件格式

每个 skill **必须**遵循以下格式：

```
skills/
└── skill-name/
    └── SKILL.md       # 文件名必须是 SKILL.md（大写）
```

`SKILL.md` 格式：

```yaml
---
name: skill-name
description: 简短描述，Claude 根据此决定何时自动加载
---

# Skill 内容

你的 skill 指令...
```

## 管理

**更新：**
```bash
git pull
cp -r skills/* ~/.claude/skills/
# 无需重启，Claude Code 会自动检测
```

**卸载某个 skill：**
```bash
rm -rf ~/.claude/skills/skill-name/
```

**卸载全部：**
```bash
rm -rf ~/.claude/skills/*/
```

## 创建新 Skill

查看 [docs/create-skill.md](./docs/create-skill.md) 了解详细步骤。

**快速开始：**

```bash
# 1. 创建 skill 目录
mkdir -p skills/my-skill

# 2. 创建 SKILL.md（注意大写）
cat > skills/my-skill/SKILL.md << 'EOF'
---
name: my-skill
description: 你的 skill 描述
---

# My Skill

你的 skill 指令内容...
EOF

# 3. 测试
cp -r skills/my-skill ~/.claude/skills/
# 在 Claude Code 中输入 / 查看是否出现
```

## 贡献

欢迎贡献新 skills！

1. Fork 仓库
2. 在 `skills/` 下创建新目录，遵循 [Skill 格式规范](./docs/skill-format.md)
3. 创建 `SKILL.md`（必需）和 `README.md`（推荐）
4. 测试你的 skill
5. 提交 PR

## 常见问题

**Q: Skill 没有显示在列表中？**

A: 检查：
1. 文件名必须是 `SKILL.md`（大写）
2. 目录结构：`~/.claude/skills/skill-name/SKILL.md`
3. 必须有 YAML frontmatter（`---` 包围的部分）

**Q: 需要重启 Claude Code 吗？**

A: 不需要，Claude Code 会自动检测 skills 变化。

**Q: 全局 skill 和项目 skill 的区别？**

A:
- 全局：`~/.claude/skills/` - 所有项目可用
- 项目：`.claude/skills/` - 仅当前项目可用

## 问题反馈

- Issues: [提交问题](../../issues)
- PRs: [贡献代码](../../pulls)

## 许可

MIT License
