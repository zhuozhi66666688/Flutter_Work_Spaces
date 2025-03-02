import os

# 需要删除的目标字符串
target_str = '【微信号 itcodeba 】【更多教程 dashendao.com】'

# 遍历当前目录及其所有子目录
for root, dirs, files in os.walk('.'):
    for filename in files:
        # 检查文件名是否包含目标字符串
        if target_str in filename:
            # 生成新文件名
            new_name = filename.replace(target_str, '')
            
            # 仅当文件名实际发生变化时执行重命名
            if new_name != filename:
                old_path = os.path.join(root, filename)
                new_path = os.path.join(root, new_name)
                
                try:
                    os.rename(old_path, new_path)
                    print(f'成功重命名: {old_path} ➔ {new_path}')
                except Exception as e:
                    print(f'重命名失败: {old_path} | 错误信息: {str(e)}')