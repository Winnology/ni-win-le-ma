#!/bin/bash

# 定义输入输出文件路径
INPUT_FILE="./remw.md"
OUTPUT_FILE="questions.json"

# 检查输入文件是否存在
if [ ! -f "$INPUT_FILE" ]; then
  echo "错误：未找到 remw.md 文件"
  exit 1
fi

# 转换函数
convert_md_to_json() {
  echo '[' > "$OUTPUT_FILE"
  
  awk '
  BEGIN { first = 1 }
  /^## / {
    if (!first) print "    ]\n  },"
    gsub(/^## /, "")
    gsub(/"/, "\\\"")
    printf "  {\n    \"question\": \"%s\",\n    \"options\": [", $0
    first = 0
    option_count = 0
  }
  /^- / {
    gsub(/^- /, "")
    gsub(/"/, "\\\"")
    if (option_count++) printf ", "
    printf "\"%s\"", $0
  }
  END {
    if (!first) print "    ]\n  }\n]"
    else print "]"
  }
  ' "$INPUT_FILE" >> "$OUTPUT_FILE"
  
  echo "转换完成，结果已保存到 $OUTPUT_FILE"
}

# 执行转换
convert_md_to_json