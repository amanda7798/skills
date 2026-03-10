# Claude Code Skills 仓库

专业领域 skills 集合，让 Claude 成为你的领域专家助手。

## 安装

```bash
# 1. 克隆仓库
git clone <repository-url>
cd skills

# 2. 复制 skills 到配置目录
cp skills/*/*.md ~/.claude/skills/

# 3. 重启 Claude Code

# 4. 验证安装
/help
```

## 使用

**显式调用：**
```
/skill名
```

**自动触发：**
直接提问，Claude 会根据关键词自动激活对应的 skill

详见 [USAGE.md](./USAGE.md) 和各 skill 的使用说明

## 仓库结构

```
skills/
├── README.md              # 本文件
├── USAGE.md              # 通用使用指南
└── skills/               # Skills 目录
    └── skill名/
        ├── skill名.md    # Skill 本体
        └── 使用说明.md   # 该 skill 的使用说明
```

## 可用 Skills

查看 [skills](./skills/) 目录，每个子目录包含：
- `skill名.md` - skill 本体文件
- `使用说明.md` - 触发条件和使用方法

## 管理

**更新：**
```bash
git pull
cp skills/*/*.md ~/.claude/skills/
# 重启 Claude Code
```

**卸载：**
```bash
rm ~/.claude/skills/skill名.md
# 重启 Claude Code
```

## 贡献

欢迎贡献新 skills！

1. Fork 仓库
2. 在 `skills/` 下创建新目录
3. 添加 `skill名.md` 和 `使用说明.md`
4. 提交 PR

## 问题反馈

- Issues: [提交问题](../../issues)
- PRs: [贡献代码](../../pulls)
