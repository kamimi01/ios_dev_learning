let double = { (x: Int) -> Int in
    // クロージャの中の文が1つしかない場合、`return`を省略可能 = 暗黙的なreturn(Implicit Returns)
    x * 2
}

print(double(10))

// クロージャを変数や定数の型に利用することができる
let closure: (Int) -> Int
// 関数の引数の方にすることもできる
func someFunction(x: (Int) -> Int) {
    print("do nothing")
}

// 変数の型が事前に決まっている場合は、型の記載を省略することができる
var closure1: (String) -> Int

closure1 = { string in
    return string.count * 2
}

print(closure1("abc"))


// インアウト引数と普通の引数の違い
// 普通の引数の場合
func greetUsual(user: String) {
    if user.isEmpty {
//        user = "Anonymous" // 引数の値は定数扱いなので、変えることができない。「Cannot assign to value: 'user' is a 'let' constant」のエラー発生
    }
    print("Hello, \(user)")
}

// インアウト引数の場合
func greet(user: inout String) {
    if user.isEmpty {
        user = "Anonymous"  // 引数を変更することができる。エラーは発生しない。
    }
    print("Hello, \(user)")
}

var user1: String = ""
print("user1（変更前）：\(user1)")
greet(user: &user1)
print("user1（変更後）: \(user1)")  // user1 の値は `not empty`に変わる。引数への再代入を関数外の user1 に反映させている

// 戻り値のないクロージャ
let emptyReturnValueClosure: () -> Void = {}

// 1つの戻り値をもつクロージャ
let singleReturnValueClosure: () -> Int = {
    return 1
}

// キャプチャ
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

// キャプチャするのは、変数や定数に入っている値ではなく、変数や定数自身
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
