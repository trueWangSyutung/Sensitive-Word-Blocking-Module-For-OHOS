

export enum SensitiveWordMode {
  DEFAULT,
  STRICT,
  MEDIUM,
}
/**
 * 替换模式枚举
 * @enum {number}
 */
export enum ReplaceMode{
  /** 使用符号替换敏感词 */
  SYMBOLS,
  /** 使用拼音替换敏感词 */
  PINYIN,
}
export function mode2list (mode: SensitiveWordMode) {
  switch (mode) {
    case SensitiveWordMode.DEFAULT:
      return [
        "gun",
        "sex",
        "ads",
        "reactionary",
        "violent",
      ];
    case SensitiveWordMode.MEDIUM:
      return [
        "livelihood",
        "gun",
        "sex",
        "ads",
        "reactionary",
        "violent",
        "policy",
        "more",
        "url",
      ];
    case SensitiveWordMode.STRICT:
      return [
        "livelihood",
        "gun",
        "sex",
        "ads",
        "reactionary",
        "violent",
        "policy",
        "more",
        "url",
        "covid",
      ]
  }
}