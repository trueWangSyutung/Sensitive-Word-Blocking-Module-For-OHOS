
/*

[
  "livelihood",
  "tencent",
  "gun",
  "sex",
  "ads",
  "reactionary",
  "violent",
  "policy",
  "more",
  "url",
  "other",
  "covid",
  "corruption",
  "net"
]
 */

export enum SensitiveWordMode {
  DEFAULT,
  STRICT,
  MEDIUM,
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
        "other",
        "covid",
        "corruption",
      ];
    case SensitiveWordMode.STRICT:
      return [
        "livelihood",
        "tencent",
        "gun",
        "sex",
        "ads",
        "reactionary",
        "violent",
        "policy",
        "more",
        "url",
        "covid",
        "corruption",
        "net"
      ]
  }
}