#!/bin/bash

# Claude Code Skills 安装脚本

set -e

SKILLS_DIR="$HOME/.claude/skills"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_SKILLS_DIR="$SCRIPT_DIR/skills"

# 颜色定义
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 显示帮助信息
show_help() {
    cat << EOF
Claude Code Skills 安装脚本

用法:
  $0 [选项]

选项:
  --skill <name>      只安装指定的 skill（可多次使用）
  --list              列出所有可用的 skills
  --global            安装到全局目录（默认：~/.claude/skills）
  --project           安装到当前项目（.claude/skills）
  --help              显示此帮助信息

示例:
  $0                           # 安装所有 skills
  $0 --skill yocto             # 只安装 yocto skill
  $0 --skill yocto --skill ai  # 安装多个指定的 skills
  $0 --list                    # 列出所有可用的 skills
  $0 --project                 # 安装到当前项目
EOF
}

# 列出所有可用的 skills
list_skills() {
    echo -e "${BLUE}可用的 Skills:${NC}"
    echo ""

    if [ ! -d "$SOURCE_SKILLS_DIR" ]; then
        echo "错误: skills 目录不存在"
        exit 1
    fi

    for skill_dir in "$SOURCE_SKILLS_DIR"/*/ ; do
        if [ -d "$skill_dir" ]; then
            skill_name=$(basename "$skill_dir")
            skill_file="$skill_dir/SKILL.md"

            if [ -f "$skill_file" ]; then
                # 提取 description
                desc=$(grep "^description:" "$skill_file" | head -1 | cut -d':' -f2- | xargs)
                echo -e "  ${GREEN}$skill_name${NC}"
                if [ -n "$desc" ]; then
                    echo "    $desc"
                fi
                echo ""
            fi
        fi
    done
}

# 安装单个 skill
install_skill() {
    local skill_name="$1"
    local target_dir="$2"
    local source_skill="$SOURCE_SKILLS_DIR/$skill_name"

    if [ ! -d "$source_skill" ]; then
        echo -e "${YELLOW}警告: skill '$skill_name' 不存在，跳过${NC}"
        return 1
    fi

    if [ ! -f "$source_skill/SKILL.md" ]; then
        echo -e "${YELLOW}警告: skill '$skill_name' 缺少 SKILL.md 文件，跳过${NC}"
        return 1
    fi

    echo -e "  ${GREEN}✓${NC} 安装 $skill_name"
    mkdir -p "$target_dir"
    cp -r "$source_skill" "$target_dir/"

    return 0
}

# 安装所有 skills
install_all_skills() {
    local target_dir="$1"
    local count=0

    for skill_dir in "$SOURCE_SKILLS_DIR"/*/ ; do
        if [ -d "$skill_dir" ]; then
            skill_name=$(basename "$skill_dir")
            if install_skill "$skill_name" "$target_dir"; then
                ((count++))
            fi
        fi
    done

    echo "$count"
}

# 显示安装的 skills 信息
show_installed_skills() {
    local target_dir="$1"

    echo ""
    echo -e "${BLUE}已安装的 Skills:${NC}"

    for skill_dir in "$target_dir"/*/ ; do
        if [ -d "$skill_dir" ] && [ -f "$skill_dir/SKILL.md" ]; then
            skill_name=$(basename "$skill_dir")
            # 提取 name 和 description
            name=$(grep "^name:" "$skill_dir/SKILL.md" | head -1 | cut -d':' -f2- | xargs)
            desc=$(grep "^description:" "$skill_dir/SKILL.md" | head -1 | cut -d':' -f2- | xargs)

            echo -e "  ${GREEN}/$name${NC}"
            if [ -n "$desc" ]; then
                echo "    $desc"
            fi
        fi
    done
}

# 主程序
main() {
    local install_mode="global"
    local specific_skills=()
    local install_all=true

    # 解析命令行参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            --help|-h)
                show_help
                exit 0
                ;;
            --list|-l)
                list_skills
                exit 0
                ;;
            --skill|-s)
                if [ -z "$2" ] || [[ "$2" == --* ]]; then
                    echo "错误: --skill 需要指定 skill 名称"
                    exit 1
                fi
                specific_skills+=("$2")
                install_all=false
                shift 2
                ;;
            --global)
                install_mode="global"
                shift
                ;;
            --project|-p)
                install_mode="project"
                shift
                ;;
            *)
                echo "错误: 未知选项 '$1'"
                echo "使用 --help 查看帮助"
                exit 1
                ;;
        esac
    done

    # 确定目标目录
    if [ "$install_mode" = "project" ]; then
        TARGET_DIR=".claude/skills"
        echo -e "${BLUE}安装到项目目录: $TARGET_DIR${NC}"
    else
        TARGET_DIR="$SKILLS_DIR"
        echo -e "${BLUE}安装到全局目录: $TARGET_DIR${NC}"
    fi

    echo ""
    echo "========================================"
    echo "  Claude Code Skills 安装"
    echo "========================================"
    echo ""

    # 创建目标目录
    if [ ! -d "$TARGET_DIR" ]; then
        echo "创建目录: $TARGET_DIR"
        mkdir -p "$TARGET_DIR"
    fi

    # 执行安装
    if [ "$install_all" = true ]; then
        echo "安装所有 skills..."
        echo ""
        count=$(install_all_skills "$TARGET_DIR")
        echo ""
        echo -e "${GREEN}成功安装 $count 个 skills${NC}"
    else
        echo "安装指定的 skills..."
        echo ""
        success_count=0
        for skill in "${specific_skills[@]}"; do
            if install_skill "$skill" "$TARGET_DIR"; then
                ((success_count++))
            fi
        done
        echo ""
        echo -e "${GREEN}成功安装 $success_count 个 skills${NC}"
    fi

    # 显示已安装的 skills
    show_installed_skills "$TARGET_DIR"

    echo ""
    echo "========================================"
    echo -e "${GREEN}安装完成！${NC}"
    echo "========================================"
    echo ""
    echo "使用方式："
    echo "  1. 在 Claude Code 中输入 / 查看所有可用 skills"
    echo "  2. 输入 /skill-name 显式调用某个 skill"
    echo "  3. 直接提问，Claude 会自动判断是否需要加载 skill"
    echo ""
    echo "更多信息："
    echo "  README.md  - 项目说明"
    echo "  USAGE.md   - 详细使用指南"
    echo "  ./install.sh --list  - 列出所有可用 skills"
}

# 运行主程序
main "$@"
