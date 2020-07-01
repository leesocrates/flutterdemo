import 'package:my_flutter_app/test.dart' show Person, testEnum;
import 'package:my_flutter_app/test.dart' deferred as test_lib;
import 'todo.dart';

// 在一个库上你可以多次调用 loadLibrary() 函数。但是该库只是载入一次。
// 延迟加载库的常量在导入的时候是不可用的。 只有当库加载完毕的时候，库中常量才可以使用。
// 在导入文件的时候无法使用延迟库中的类型。 如果你需要使用类型，则考虑把接口类型移动到另外一个库中， 让两个库都分别导入这个接口库。
// Dart 隐含的把 loadLibrary() 函数导入到使用 deferred as 的命名空间 中。 loadLibrary() 方法返回一个 Future。
Future greet() async {
  await test_lib.loadLibrary();
  test_lib.testEnum();
}

// 要使用 await ， 代码必须在 异步函数（使用 async 标记的函数）中：
// 在一个异步函数中可以多次使用 await
// 在 await 表达式 中， 表达式 的值通常是一个 Future 对象； 如果不是，这是表达式的值会被自动包装成一个 Future 对象。
//  Future 对象指明返回一个对象的承诺（promise）。 await 表达式 执行的结果为这个返回的对象
//  await 表达式会阻塞代码的执行，直到需要的对象返回为止。

// 函数体被 async 标示符标记的函数，即是一个_异步函数_
//  将 async 关键字添加到函数使其返回Future
// 如果函数没有返回有效值， 需要设置其返回类型为 Future<void> 。

// 处理 Future
// 可以通过下面两种方式，获得 Future 执行完成的结果：
// 1.使用 async 和 await.
// 2.使用 Future API，具体描述，参考 库概览.


// 当需要从 Stream 中获取数据值时， 可以通过一下两种方式：
//
//1.使用 async 和 一个 异步循环 （await for）。
// 在使用 await for 前，确保代码清晰， 并且确实希望等待所有流的结果。
// 例如，通常不应该使用 await for 的UI事件侦听器， 因为UI框架会发送无穷无尽的事件流。
//2.使用 Stream API, 更多详情，参考 in the library tour。
Future testStream() async {
  Stream requestServer;
  await for (var request in requestServer) {
//    handleRequest(request);
  }
}

// 生成器
// 当您需要延迟生成( lazily produce )一系列值时， 可以考虑使用_生成器函数_。 Dart 内置支持两种生成器函数：
//
//Synchronous 生成器： 返回一个 Iterable 对象。
//Asynchronous 生成器： 返回一个 Stream 对象。
Iterable<int> naturalsTo(int n) sync* {
  int k = 0;
  while (k < n) yield k++;
}

Stream<int> asynchronousNaturalsTo(int n) async* {
  int k = 0;
  while (k < n) yield k++;
}

// 如果生成器是递归的，可以使用 yield* 来提高其性能：
Iterable<int> naturalsDownFrom(int n) sync* {
  if (n > 0) {
    yield n;
    yield* naturalsDownFrom(n - 1);
  }
}


// 函数也是对象，就想字符和数字对象一样。 使用 typedef ，或者 function-type alias 为函数起一个别名， 别名可以用来声明字段及返回值类型。 当函数类型分配给变量时，typedef会保留类型信息。
typedef Compare<T> = int Function(T a, T b);
int sort(int a, int b) => a - b;
/// [Todo.test]
@Todo("who", "what")
void testTypeDef() {
  assert(sort is Compare<int>); // True!
}

// 元数据可以在 library、 class、 typedef、 type parameter、 constructor、 factory、 function、 field、
// parameter 或者 variable 声明之前使用，也可以在 import 或者 export 指令之前使用。
// 使用反射可以在运行时获取元数据信息。


// 命名参数, 可以设置默认值，调用时必须传入对应的参数名称
test({String s, String name="lee"}){
  print(s);
}

test1(){
  test(s: "");
}