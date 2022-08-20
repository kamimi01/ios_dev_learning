# クロージャを理解する

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
目次

- [クロージャとはなんでしょうか？](#%E3%82%AF%E3%83%AD%E3%83%BC%E3%82%B8%E3%83%A3%E3%81%A8%E3%81%AF%E3%81%AA%E3%82%93%E3%81%A7%E3%81%97%E3%82%87%E3%81%86%E3%81%8B)
- [関数との違いはなんでしょうか？](#%E9%96%A2%E6%95%B0%E3%81%A8%E3%81%AE%E9%81%95%E3%81%84%E3%81%AF%E3%81%AA%E3%82%93%E3%81%A7%E3%81%97%E3%82%87%E3%81%86%E3%81%8B)
- [どのようなメリットがあるでしょうか？](#%E3%81%A9%E3%81%AE%E3%82%88%E3%81%86%E3%81%AA%E3%83%A1%E3%83%AA%E3%83%83%E3%83%88%E3%81%8C%E3%81%82%E3%82%8B%E3%81%A7%E3%81%97%E3%82%87%E3%81%86%E3%81%8B)
- [使用するときに注意すべきことはなんでしょうか？](#%E4%BD%BF%E7%94%A8%E3%81%99%E3%82%8B%E3%81%A8%E3%81%8D%E3%81%AB%E6%B3%A8%E6%84%8F%E3%81%99%E3%81%B9%E3%81%8D%E3%81%93%E3%81%A8%E3%81%AF%E3%81%AA%E3%82%93%E3%81%A7%E3%81%97%E3%82%87%E3%81%86%E3%81%8B)
- [エスケープクロージャとオートクロージャの違いはなんでしょうか？](#%E3%82%A8%E3%82%B9%E3%82%B1%E3%83%BC%E3%83%97%E3%82%AF%E3%83%AD%E3%83%BC%E3%82%B8%E3%83%A3%E3%81%A8%E3%82%AA%E3%83%BC%E3%83%88%E3%82%AF%E3%83%AD%E3%83%BC%E3%82%B8%E3%83%A3%E3%81%AE%E9%81%95%E3%81%84%E3%81%AF%E3%81%AA%E3%82%93%E3%81%A7%E3%81%97%E3%82%87%E3%81%86%E3%81%8B)
- [その他の整理](#%E3%81%9D%E3%81%AE%E4%BB%96%E3%81%AE%E6%95%B4%E7%90%86)
  - [インアウト引数と普通の引数の違い](#%E3%82%A4%E3%83%B3%E3%82%A2%E3%82%A6%E3%83%88%E5%BC%95%E6%95%B0%E3%81%A8%E6%99%AE%E9%80%9A%E3%81%AE%E5%BC%95%E6%95%B0%E3%81%AE%E9%81%95%E3%81%84)
- [参考](#%E5%8F%82%E8%80%83)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## クロージャとはなんでしょうか？

- 再利用可能なひとまとまりの処理

## 関数との違いはなんでしょうか？

- **関数はクロージャの一種**
- 関数よりも手軽に利用することができる
  - 関数では`func`が必要だったが、クロージャでは不要
  - クロージャは名前が不要
  - 変数の型が事前に決まっている場合は、型の記載を省略することができる
  
    ```swift
    var closure1: (String) -> Int

    closure1 = { string in
    return string.count * 2
    }

    print(closure1("abc"))
    ```

  - 引数の仕様が関数とクロージャでは少し違う
    - クロージャでは、外部引数名とデフォルト引数が利用できない
    - 関数では、簡略引数名が利用できない
    
    |利用可能な機能|説明|関数|クロージャ式|
    |---|---|---|---|
    |外部引数名|関数の呼び出し時に仕様する名前<br> `func invite(user: String, to group: String)` |🟢|❌|
    |デフォルト引数|引数に指定できるデフォルト値<br> `func greet(user: String = "Anonymous")`|🟢|❌|
    |インアウト引数|関数内での引数への再代入を関数外へ反映させる<br> `func greet(user: inout String)`<br> 詳細は[【Swift 5.5】inout 引数とは](https://qiita.com/kamimi01/items/64b54264011f8ba2ddc0)へ|🟢|🟢|
    |可変長引数|任意の個数の値を受け取ることができる<br>`func print(strings: String...)`|🟢|🟢|
    |簡略引数名|クロージャの型が推論できる場合、型を省略することができるが、その場合は引数名の定義を省略することもできる<br>`let isEqual: (Int, Int) -> Bool { return $0 == $1 }`<br>`isEqual(1, 1)  // true`<br>可読性が低くなるため、むやみに使用すべきではないが、例えば`filter(_:)`メソッドのようなシンプルな処理を行う場合は積極的に利用すべき<br>`let moreThanTwenty = numbers.filter { $0 > 20 }`|❌|🟢|

## どのようなメリットがあるでしょうか？

## 使用するときに注意すべきことはなんでしょうか？

# キャプチャとはなんでしょうか？

- クロージャが実行されるスコープが、変数や定数が定義されたローカルスコープ外であっても、クロージャの実行時に利用できる
  - 理由：クロージャが、自身が定義されたスコープの変数や定数への参照を保持しているため

```swift
let greeting: (String) -> String
// doはcatchと一緒に使うが、新しいスコープを作成するために使うこともできる
do {
    let symbol = "!"
    greeting = { user in
        return "Hello, \(user)\(symbol)"  // symbolはgreetingのスコープ外だが、利用できる
    }
}
greeting("Ishikawa")
//symbol  cannot find symbol in scopeのエラー
```

- 変数や定数に入っている値ではなく、変数や定数自身を保持する（= キャプチャ）。そのため、キャプチャされている変数への変更は、クロージャの実行時にも反映される

```swift
let counter: () -> Int
do {
    var count = 0
    counter = {
        count += 1
        return count
    }
}
counter()  // 1になる
counter()  // 2になる
```

### `self`のキャプチャとはなんでしょうか？

## エスケープクロージャとオートクロージャの違いはなんでしょうか？

## その他の整理

### 戻り値がないクロージャ

- Swiftでは`()`と`Void`は同じ
- クロージャでは戻り値がない場合は、`() -> Void`と記述する

```swift
// 戻り値のないクロージャ
let emptyReturnValueClosure: () -> Void = {}
```

## 参考
