import 'package:flutter/cupertino.dart';

var list = [1, 2, 3];
const String name = "lee";
const num age = 10;
const dynamic people = "$name$age";

var names = <String>{};
// Set<String> names = {}; // 这样也是可以的。
var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};

class Test {
  var constantList = const [1, 2, 3];

  void main(List<String> arguments) {
    listTest();

    // .. 语法为 级联调用 （cascade）。 使用级联调用， 可以简化在一个对象上执行的多个操作。
    Test()
      ..listTest()
      ..isNoble(1);
  }

  listTest() {
    list[0] = 1;
//    constantList[1] = 1; // 取消注释会引起错误。
  }

  setTest() {
    var elements = <String>{};
    elements.add('fluorine');
    elements.addAll(halogens);
  }

  mapTest() {
    var gifts = Map();
    gifts['first'] = 'partridge';
    gifts['second'] = 'turtledoves';
    gifts['fifth'] = 'golden rings';
    gifts['fourth'] = 'calling birds'; // Add a key-value pair
    assert(gifts['fifth'] == null);
    assert(gifts.length == 2);

    var nobleGases = {
      2: 'helium',
      10: 'neon',
      18: 'argon',
    };
  }

  bool isNoble(int atomicNumber) {
    return atomicNumber > 0;
  }

  isNobles(int atomicNumber) =>
      atomicNumber > 0; // => expr 语法是 { return expr; } 的简写。 => 符号 有时也被称为 箭头 语法
//  在箭头 (=>) 和分号 (;) 之间只能使用一个 表达式 ，不能是 语句 。 例如：不能使用 if 语句 ，但是可以是用 条件表达式.

// 函数有两种参数类型: required 和 optional。 required 类型参数在参数最前面， 随后是 optional 类型参数。
// 命名的可选参数也可以标记为 “@ required”
// 使用 @required 注释表示参数是 required 性质的命名参数， 该方式可以在任何 Dart 代码中使用（不仅仅是Flutter）
  scrollbar({Key key, @required dynamic child}) {}

  // 将参数放到 [] 中来标记参数是可选的：
  String say(String from, String msg, [String device]) {
    var result = '$from says $msg';
    if (device != null) {
      result = '$result with a $device';
    }
    return result;
  }

  // 默认参数值
  void enableFlags({bool bold = false, bool hidden = false}) {}

  // 匿名函数
  testLambda() {
    var list = ['apples', 'bananas', 'oranges'];
    list.forEach((item) {
      print('${list.indexOf(item)}: $item');
    });
  }

// 闭包 即一个函数对象，即使函数对象的调用在它原始作用域之外， 依然能够访问在它词法作用域内的变量。
  /// 返回一个函数，返回的函数参数与 [addBy] 相加。
  Function makeAdder(num addBy) {
    return (num i) => addBy + i;
  }

  void testClosure() {
    // 创建一个加 2 的函数。
    var add2 = makeAdder(2);

    // 创建一个加 4 的函数。
    var add4 = makeAdder(4);

    assert(add2(3) == 5);
    assert(add4(3) == 7);
  }

  // as， is， 和 is! 运算符用于在运行时处理类型检查
  testType() {
    var emp = Person();
    if (emp is Person) {
      // Type check
      emp.firstName = 'Bob';
    }
    (emp as Person).firstName = 'Bob';
  }

  /// 赋值运算符
  testFuzhi() {
    var a = 0;
    var b;
    var value = 3;
    // 将值赋值给变量a
    a = value;
// 如果b为空时，将变量赋值给b，否则，b的值保持不变。
    b ??= value;
  }

// 条件表达式
// condition ? expr1 : expr2
//如果条件为 true, 执行 expr1 (并返回它的值)： 否则, 执行并返回 expr2 的值。
// var visibility = isPublic ? 'public' : 'private';

//expr1 ?? expr2
//如果 expr1 是 non-null， 返回 expr1 的值； 否则, 执行并返回 expr2 的值。
// String playerName(String name) => name ?? 'Guest';

// 异常捕获
  // 捕获语句中可以同时使用 on 和 catch ，也可以单独分开使用。
  // 使用 on 来指定异常类型， 使用 catch 来 捕获异常对象。
  testException() {
    try {
      testType();
    } on OutOfMemoryError {
      // 一个特殊的异常

    } on Exception catch (e) {
      // 其他任何异常
      print('Unknown exception: $e');
    } catch (e, s) {
      // 没有指定的类型，处理所有异常
      // catch() 函数可以指定1到2个参数， 第一个参数为抛出的异常对象， 第二个为堆栈信息 ( 一个 StackTrace 对象 )。
      print('Exception details:\n $e');
      print('Stack trace:\n $s');

      rethrow; // 如果仅需要部分处理异常， 那么可以使用关键字 rethrow 将异常重新抛出。
    } finally {
      // 不管是否抛出异常， finally 中的代码都会被执行。 如果 catch 没有匹配到异常， 异常会在 finally 执行完成后，再次被抛出
    }

    // 任何匹配的 catch 执行完成后，再执行 finally ：
    try {
      testType();
    } catch (e) {
      print('Error: $e'); // Handle the exception first.
    } finally {
      // Then clean up.
    }
  }
}

class Point {
  num x, y;

  // 在构造函数体执行前，
  // 语法糖已经设置了变量 x 和 y。
  Point(this.x, this.y);

  // 命名构造函数
  Point.origin() {
    x = 0;
    y = 0;
  }

  // 除了调用超类构造函数之外， 还可以在构造函数体执行之前初始化实例变量。 各参数的初始化用逗号分隔。
  // 初始化程序的右侧无法访问 this 。
  Point.test()
      : x = 0,
        y = 1 {}
}

class Person {
  var firstName;

  Person();

  // 重定向构造函数的函数体为空， 构造函数的调用在冒号 (:) 之后
  Person.fromJson(String data) : this();
}

// 如果该类生成的对象是固定不变的， 那么就可以把这些对象定义为编译时常量。
// 需要定义一个 const 构造函数， 并且声明所有实例变量为 final。
class ImmutablePoint {
  static final ImmutablePoint origin = const ImmutablePoint(0, 0);

  final num x, y;

  const ImmutablePoint(this.x, this.y);
}

class Employee extends Person {
  // 由于父类的构造函数参数在构造函数执行之前执行， 所以参数可以是一个表达式或者一个方法调用：
  // 调用父类构造函数的参数无法访问 this 。 例如，参数可以为静态函数但是不能是实例函数。
  Employee() : super.fromJson(getDefaultData());

  static String getDefaultData() {
    return "";
  }

  static const a = 1;
}

// 工厂构造函数
// 当执行构造函数并不总是创建这个类的一个新实例时，则使用 factory 关键字。
// 例如，一个工厂构造函数可能会返回一个 cache 中的实例， 或者可能返回一个子类的实例。
class Logger {
  final String name;
  bool mute = false;

  // 从命名的 _ 可以知，
  // _cache 是私有属性。
  static final Map<String, Logger> _cache = <String, Logger>{};

  // 工厂构造函数无法访问 this。
  factory Logger(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name];
    } else {
      final logger = Logger._internal(name);
      _cache[name] = logger;
      return logger;
    }
  }

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) print(msg);
  }
}

//  使用 get 和 set 关键字实现 Getter 和 Setter ，能够为实例创建额外的属性。
class Rectangle {
  num left, top, width, height;

  Rectangle(this.left, this.top, this.width, this.height);

  // 定义两个计算属性： right 和 bottom。
  num get right => left + width;

  set right(num value) => left = value - width;

  num get bottom => top + height;

  set bottom(num value) => top = value - height;
}

// 使用 abstract 修饰符来定义 抽象类 — 抽象类不能实例化。 抽象类通常用来定义接口，以及部分实现
// 如果希望抽象类能够被实例化，那么可以通过定义一个 工厂构造函数 来实现。
// 这个类被定义为抽象类，
// 所以不能被实例化。
abstract class AbstractContainer {
  // 定义构造行数，字段，方法...

  void updateChildren(); // 抽象方法。
}

// 隐式接口
// 每个类都隐式的定义了一个接口，接口包含了该类所有的实例成员及其实现的接口。
//  如果要创建一个 A 类，A 要支持 B 类的 API ，但是不需要继承 B 的实现， 那么可以通过 A 实现 B 的接口。
// person 类。 隐式接口里面包含了 greet() 方法声明。
class Persons {
  // 包含在接口里，但只在当前库中可见。
  final _name;

  // 不包含在接口里，因为这是一个构造函数。
  Persons(this._name);

  // 包含在接口里。
  String greet(String who) => 'Hello, $who. I am $_name.';
}

// person 接口的实现。
class Impostor implements Persons {
  get _name => '';

  @override
  String greet(String who) => 'Hi $who. Do you know who I am?';
}

// 重写运算符
class Vector {
  final int x, y;

  Vector(this.x, this.y);

  Vector operator +(Vector v) => Vector(x + v.x, y + v.y);

  Vector operator -(Vector v) => Vector(x - v.x, y - v.y);

// 运算符 == 和 hashCode 部分没有列出。 有关详情，请参考下面的注释。
// ···
}

// 当代码尝试使用不存在的方法或实例变量时， 通过重写 noSuchMethod() 方法，来实现检测和应对处理：
class A {
  // 如果不重写 noSuchMethod，访问
  // 不存在的实例变量时会导致 NoSuchMethodError 错误。
  @override
  void noSuchMethod(Invocation invocation) {
    print('You tried to use a non-existent member: ' +
        '${invocation.memberName}');
  }
}

// 枚举中的每个值都有一个 index getter 方法， 该方法返回值所在枚举类型定义中的位置（从 0 开始）
// 枚举不能被子类化，混合或实现。
// 枚举不能被显式实例化。
enum Color { red, green, blue }

testEnum() {
  assert(Color.red.index == 0);

  List<Color> colors = Color.values;
  assert(colors[2] == Color.blue);
}

// 对于常见或广泛使用的工具和函数， 应该考虑使用顶级函数而不是静态方法。
// 类变量和方法
class Queue {
  // 静态变量只到它们被使用的时候才会初始化。
  static const initialCapacity = 16;
  num i = 0;

  static test(){
    print("i is $initialCapacity");
//    print("i is $i");
  }

}

// 使用集合字面量
// List , Set 和 Map 字面量也是可以参数化的。
var nameList = <String>['Seth', 'Kathy', 'Lars'];
var nameSet = <String>{'Seth', 'Kathy', 'Lars'};
var pagesMap = <String, String>{
  'index.html': 'Homepage',
  'robots.txt': 'Hints for web robots',
  'humans.txt': 'We are people, not machines'
};
// 使用泛型类型的构造函数
var nameSets = Set<String>.from(names);
var views = Map<int, String>();
// 运行时中的泛型集合
// Dart 中泛型类型是 固化的，也就是说它们在运行时是携带着类型信息的。
_testFanxin(){
  var names = List<String>();
  names.addAll(['Seth', 'Kathy', 'Lars']);
  print(names is List<String>); // true
}

// 这里的 first (<T>) 泛型可以在如下地方使用参数 T ：
// 1.函数的返回值类型 (T).
// 2.参数的类型 (List<T>).
// 3.局部变量的类型 (T tmp).
T first<T>(List<T> ts) {
  // Do some initial work or error checking, then...
  T tmp = ts[0];
  // Do some additional checking or processing...
  return tmp;
}
