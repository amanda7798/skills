# Claude Code Skills 使用指南

## 安装

```bash
# 复制 skill 文件到配置目录
cp skills/*/skill名.md ~/.claude/skills/

# 重启 Claude Code
```

验证安装：
```
/help
```

## 使用方式

### 方式一：显式调用
```
/skill名
```

### 方式二：自动触发
直接提问，包含相关关键词即可自动激活对应的 skill

## 管理 Skills

**更新：**
```bash
cp skills/*/skill名.md ~/.claude/skills/
# 重启 Claude Code
```

**卸载：**
```bash
rm ~/.claude/skills/skill名.md
# 重启 Claude Code
```

## 提问技巧

✅ **清晰的提问：**
- 包含版本信息
- 提供错误日志或代码
- 说明当前配置和目标

❌ **不清晰的提问：**
- "出错了"
- "不工作"
- 没有上下文

---

**每个 skill 的详细触发条件和使用方法，请查看对应 skill 目录下的 `使用说明.md`**
