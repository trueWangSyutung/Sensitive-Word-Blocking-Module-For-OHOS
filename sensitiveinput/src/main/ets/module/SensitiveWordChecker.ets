import fs from '@ohos.file.fs';
import util from '@ohos.util';
import { HashMap, List } from '@kit.ArkTS';
import jsonData from "../../resources/rawfile/vocabulary.json"
import {
  mode2list, SensitiveWordMode
} from "../enmu/type"

/**
 * Trie树节点类
 */
class TrieNode {
  children: Map<string, TrieNode> = new Map();
  isEndOfWord: boolean = false;
  wordType: string = ''; // 敏感词类型
}

interface GeneratedTypeLiteralInterface_3 {
  word: string;
  type: string;
}

interface GeneratedTypeLiteralInterface_2 {
  word: string;
  type: string;
}

export class SensitiveWordChecker {
  private root: TrieNode = new TrieNode();
  private types: Array<string> = [];

  constructor(
    mode : SensitiveWordMode
  ) {
    this.init(mode);
  }

  private init( mode : SensitiveWordMode): void {
    try {
      // 在实际鸿蒙应用中，需要通过资源管理器读取rawfile中的文件
      // 这里我们使用模拟数据来演示功能
      this.loadVocabulary();
      this.loadTypes(mode);
    } catch (error) {
      console.error('SensitiveWordChecker: Failed to initialize', error);
    }
  }

  /**
   * 加载敏感词类型
   */
  private loadTypes(mode : SensitiveWordMode): void {
    try {
      this.types = mode2list(mode);
      // 注意：在实际应用中，需要使用正确的资源路径加载文件
      // 这里暂时使用模拟数据
      console.info('SensitiveWordChecker: Types loaded');
    } catch (error) {
      console.error('Failed to load types:', error);
    }
  }

  private buildTrie(words: string[], type: string): void {
    for (const word of words) {
      let currentNode = this.root;

      // 遍历敏感词的每个字符
      for (let i = 0; i < word.length; i++) {
        const char = word[i];

        // 如果当前字符不存在于子节点中，则创建新节点
        if (!currentNode.children.has(char)) {
          currentNode.children.set(char, new TrieNode());
        }

        // 移动到下一个节点
        currentNode = currentNode.children.get(char)!;
      }

      // 标记单词结尾，并记录类型
      currentNode.isEndOfWord = true;
      currentNode.wordType = type;
    }
  }

  private loadVocabulary(): void {
    try {
      const vocabulary = jsonData;
      // 注意：在实际应用中，需要使用正确的资源路径加载文件
      // 构建Trie树
      for (const category of vocabulary) {
        this.buildTrie(category.words, category.type);
      }
      console.info('SensitiveWordChecker: Vocabulary loaded');
    } catch (error) {
      console.error('Failed to load vocabulary:', error);
    }
  }

  /**
   * 检查文本中是否包含敏感词
   * @param text 待检查的文本
   * @returns 如果包含敏感词返回true，否则返回false
   */
  public checkSensitiveWords(text: string): boolean {
    // 从文本的每个位置开始查找
    for (let i = 0; i < text.length; i++) {
      if (this.searchFromPosition(text, i)) {
        return true;
      }
    }
    return false;
  }

  private searchFromPosition(text: string, startPos: number): boolean {
    let currentNode = this.root;

    for (let i = startPos; i < text.length; i++) {
      const char = text[i];

      // 如果当前节点没有该字符的子节点，说明不匹配
      if (!currentNode.children.has(char)) {
        return false;
      }

      // 移动到下一个节点
      currentNode = currentNode.children.get(char)!;

      // 如果到达某个敏感词的结尾，说明找到了匹配的敏感词
      if (currentNode.isEndOfWord) {
        return true;
      }
    }

    return false;
  }

  /**
   * 获取文本中的敏感词
   * @param text 待检查的文本
   * @returns 包含的敏感词列表
   */
  public getSensitiveWords(text: string): Array<GeneratedTypeLiteralInterface_3> {
    const sensitiveWords: Array<GeneratedTypeLiteralInterface_3> = [];
    const foundWords: Set<string> = new Set(); // 避免重复

    // 从文本的每个位置开始查找
    for (let i = 0; i < text.length; i++) {
      const result = this.extractFromPosition(text, i);
      if (result && !foundWords.has(result.word)) {
        sensitiveWords.push(result);
        foundWords.add(result.word);
      }
    }

    return sensitiveWords;
  }

  /**
   * 从指定位置开始提取敏感词
   * @param text 文本
   * @param startPos 起始位置
   * @returns 找到的敏感词及类型
   */
  private extractFromPosition(text: string, startPos: number): GeneratedTypeLiteralInterface_3 | null {
    let currentNode = this.root;
    let matchedWord = '';

    for (let i = startPos; i < text.length; i++) {
      const char = text[i];
      matchedWord += char;

      // 如果当前节点没有该字符的子节点，说明不匹配
      if (!currentNode.children.has(char)) {
        return null;
      }

      // 移动到下一个节点
      currentNode = currentNode.children.get(char)!;

      // 如果到达某个敏感词的结尾，说明找到了匹配的敏感词
      if (currentNode.isEndOfWord) {
        return {
          word: text.substring(startPos, i + 1),
          type: currentNode.wordType
        };
      }
    }

    return null;
  }

  /**
   * 替换文本中的敏感词
   * @param text 待处理的文本
   * @param replacement 替换字符，默认为'*'
   * @returns 处理后的文本
   */
  public replaceSensitiveWords(text: string, replacement: string = '*'): string {
    let result = text;
    let offset = 0;

    // 从文本的每个位置开始查找
    for (let i = 0; i < result.length; i++) {
      const resultWord = this.extractFromPosition(result, i);
      if (resultWord) {
        // 计算替换位置（考虑之前替换造成的位置偏移）
        const actualStartPos = i + offset;
        const actualEndPos = actualStartPos + resultWord.word.length;

        // 创建替换字符串
        const replacementStr = replacement.repeat(resultWord.word.length);

        // 执行替换
        result = result.substring(0, actualStartPos) +
          replacementStr +
        result.substring(actualEndPos);

        // 更新偏移量
        offset += replacementStr.length - resultWord.word.length;

        // 跳过已处理的部分
        i += resultWord.word.length - 1;
      }
    }

    return result;
  }

  /**
   * 获取支持的敏感词类型
   * @returns 类型列表
   */
  public getTypes(): Array<string> {
    return this.types;
  }

  /**
   * 根据类型获取敏感词
   * @param type 类型
   * @returns 该类型下的敏感词列表
   */
  public getWordsByType(type: string): Array<string> {
    // 这个方法在Trie树结构中较难实现，需要遍历整个树
    // 在实际应用中，可以考虑在构建Trie树时同时维护一个类型到词的映射
    return [];
  }
}
