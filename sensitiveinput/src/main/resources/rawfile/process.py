import os
import json


def process_vocabulary_to_json(vocabulary_folder, output_file):
    """
    处理词汇敏感词词库，将每个分类文件中的词汇保存到JSON文件中

    Args:
        vocabulary_folder (str): 包含分类词汇文件的文件夹路径
        output_file (str): 输出的JSON文件路径
    """
    vocabulary_data = []
    types =[]
    # 遍历词汇文件夹中的所有文件
    for filename in os.listdir(vocabulary_folder):
        file_path = os.path.join(vocabulary_folder, filename)

        # 确保是文件而不是目录
        if os.path.isfile(file_path):
            # 获取文件名作为类型（不包含扩展名）
            file_type = os.path.splitext(filename)[0]

            # 读取文件中的所有词汇
            with open(file_path, 'r', encoding='utf-8') as f:
                words = [line.strip() for line in f.readlines() if line.strip()]

            # 添加到词汇数据中
            vocabulary_data.append({
                "type": file_type,
                "words": words
            })
            types.append(file_type)

    # 保存到JSON文件
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(vocabulary_data, f, ensure_ascii=False, indent=2)
    with open("types.json", 'w', encoding='utf-8') as f:
        json.dump(types, f, ensure_ascii=False, indent=2)
    print(f"已处理 {len(vocabulary_data)} 个词汇分类，保存到 {output_file}")


# 使用示例
if __name__ == "__main__":
    # 设置词汇文件夹路径和输出文件路径
    vocabulary_folder = "/Users/wxd2zrx/PycharmProjects/PythonProject/Vocabulary"
    output_file = "vocabulary.json"

    # 处理词汇并保存到JSON文件
    process_vocabulary_to_json(vocabulary_folder, output_file)
