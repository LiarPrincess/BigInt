# BigInt

* [Overview](#overview)
* [API Documentation](#api)
* [License](#license)
* [Implementation Notes](#notes)
    * [Full-width multiplication and division primitives](#fullwidth)
    * [Why is there no generic `BigInt<Digit>` type?](#generics)
* [Calculation Samples](#samples)
	* [Obligatory factorial demo](#factorial)
	* [RSA Cryptography](#rsa)
	* [Calculating the Digits of π](#pi)

## <a name="overview">Overview</a>

This repository provides [integer types of arbitrary width][wiki] implemented
in 100% pure Swift. The underlying representation is in base 2^64, using `Array<UInt64>`.
                                                                  
[wiki]: https://en.wikipedia.org/wiki/Arbitrary-precision_arithmetic

This module is handy when you need an integer type that's wider than `UIntMax`, but 
you don't want to add [The GNU Multiple Precision Arithmetic Library][GMP] 
as a dependency.

[GMP]: https://gmplib.org

Two big integer types are included: [`BigUInt`][BigUInt] and [`BigInt`][BigInt], 
the latter being the signed variant.
Both of these are Swift structs with copy-on-write value semantics, and they can be used much 
like any other integer type.

The library provides implementations for some of the most frequently useful functions on 
big integers, including

- All functionality from [`Comparable`][comparison] and [`Hashable`][hashing]

- [The full set of arithmetic operators][addition]: `+`, `-`, `*`, `/`, `%`, `+=`, `-=`, `*=`, `/=`, `%=`
  - [Addition][addition] and [subtraction][subtraction] have variants that allow for 
    shifting the digits of the second operand on the fly.
  - Unsigned subtraction will trap when the result would be negative. 
    ([There are variants][subtraction] that return an overflow flag.)
  - [Multiplication][star] uses brute force for numbers up to 1024 digits, then switches to Karatsuba's recursive method. 
    (This limit is configurable, see `BigUInt.directMultiplicationLimit`.) 
  - A [fused multiply-add][fused] method is also available, along with other [special-case variants][multiplication].
  - Division uses Knuth's Algorithm D, with its 3/2 digits wide quotient approximation. 
    It will trap when the divisor is zero. 
  - [`BigUInt.divide`][divide] returns the quotient and
    remainder at once; this is faster than calculating them separately.

- [Bitwise operators][bitwise]: `~`, `|`, `&`, `^`, `|=`, `&=`, `^=`, plus the following read-only properties:
  - [`width`][width]: the minimum number of bits required to store the integer,
  - [`trailingZeroes`][trailingZeroes]: the number of trailing zero bits in the binary representation,
  - [`leadingZeroes`][leadingZeroes]: the number of leading zero bits (when the last digit isn't full),

- [Shift operators][shift]: `>>`, `<<`, `>>=`, `<<=`

- Methods to [convert `NSData` to big integers][data] and vice versa.

- Support for [generating random integers][random] of specified maximum width or magnitude.

- Radix conversion to/from [`String`s][radix1] and [big integers][radix2] up to base 36 (using repeated divisions).
  - Big integers use this to implement `StringLiteralConvertible` (in base 10).
  
- [`sqrt(n)`][sqrt]: The square root of an integer (using Newton's method).

- [`BigUInt.gcd(n, m)`][GCD]: The greatest common divisor of two integers (Stein's algorithm).
  
- [`BigUInt.powmod(base, exponent, modulus)`][powmod]: Modular exponentiation (right-to-left binary method).
- [`BigUInt.inverse(modulus)`][inverse]: Multiplicative inverse in modulo arithmetic (extended Euclidean algorithm).
- [`BigUInt.isPrime()`][prime]: Miller–Rabin primality test.

The implementations are intended to be reasonably efficient, but they are unlikely to be
competitive with GMP at all, even when I happened to implement an algorithm with same asymptotic
behavior as GMP. (I haven't performed a comparison benchmark, though.)

The library has 100% unit test coverage. Sadly this does not imply that there are no bugs
in it.

## <a name="api">API Documentation</a>

Generated API docs are available at http://lorentey.github.io/BigInt/api.

## <a name="license">License</a>

BigInt can be used, distributed and modified under [the MIT license][license].

## <a name="notes">Implementation notes</a>

[`BigInt`][BigInt] is just a tiny wrapper around a `BigUInt` [absolute value][abs] and a 
[sign bit][negative], both of which are accessible as public read-write properties. 

[`BigUInt`][BigUInt] is a `MutableCollectionType` of its 64-bit digits, with the least significant 
digit at index 0. As a convenience, [`BigUInt`][BigUInt] allows you to subscript it with indexes at
or above its `count`. [The subscript operator][subscript] returns 0 for out-of-bound `get`s and
automatically extends the array on out-of-bound `set`s. This makes memory management simpler.

### <a name="fullwidth">Full-width multiplication and division primitives</a>

I haven't found (64,64)->128 multiplication or (128,64)->64 division operations
in Swift, so [the module has generic implementations for them][fullmuldiv] in terms of the standard
single-width `*` and `/` operators. I suspect there are LLVM intrinsics for full-width 
arithmetics that are probably accessible somehow, though. ([Let me know][twitter] if you know how!)

This sounds slow, but 64-bit digits are
still considerably faster than 32-bit, even though the latter can use direct 64-bit arithmetic to
implement these primitives.

[fullmuldiv]: https://github.com/lorentey/BigInt/blob/v1.0.0/Sources/BigDigit.swift#L104-L177

### <a name="generics">Why is there no generic `BigInt<Digit>` type?</a>

The types provided by `BigInt` are not parametric—this is very much intentional, as 
Swift 2.2.1 generics cost us dearly at runtime in this use case. In every approach I tried,
making arbitrary-precision arithmetic operations work with a generic `Digit` type parameter 
resulted in code that was literally *ten times slower*. If you can make the algorithms generic
without such a huge performance hit, [please enlighten me][twitter]!

This is an area that I plan to investigate more, as it would be useful to have generic
implementations for arbitrary-width arithmetic operations. (Polynomial division and decimal bases
are two examples.) The library already implements double-digit multiplication and division as 
extension methods on a protocol with an associated type requirement; this has not measurably affected
performance. Unfortunately, the same is not true for `BigUInt`'s methods.

Of course, as a last resort, we could just duplicate the code to create a separate
generic variant that was slower but more flexible.

[license]: https://github.com/lorentey/BigInt/blob/master/LICENSE.md
[twitter]: https://twitter.com/lorentey
[BigUInt]: http://lorentey.github.io/BigInt/api/Structs/BigUInt.html
[BigInt]: http://lorentey.github.io/BigInt/api/Structs/BigInt.html
[comparison]: http://lorentey.github.io/BigInt/api/Functions.html#/Comparison
[hashing]: http://lorentey.github.io/BigInt/api/Structs/BigUInt.html#/Hashing
[addition]: http://lorentey.github.io/BigInt/api/Structs/BigUInt.html#/Addition
[subtraction]: http://lorentey.github.io/BigInt/api/Structs/BigUInt.html#/Subtraction
[star]: http://lorentey.github.io/BigInt/api/Functions.html#/s:ZF6BigIntoi1mFTVS_7BigUIntS0__S0_
[fused]: http://lorentey.github.io/BigInt/api/Structs/BigUInt.html#/s:FV6BigInt7BigUInt21multiplyAndAddInPlaceFRS0_FTS0_VSs6UInt645shiftSi_T_
[multiplication]: http://lorentey.github.io/BigInt/api/Structs/BigUInt.html#/Multiplication
[division]: http://lorentey.github.io/BigInt/api/Structs/BigUInt.html#/Division
[divide]: http://lorentey.github.io/BigInt/api/Structs/BigUInt.html#/s:FV6BigInt7BigUInt6divideFS0_FS0_T3divS0_3modS0__
[bitwise]: http://lorentey.github.io/BigInt/api/Functions.html#/Bitwise%20Operators
[width]: http://lorentey.github.io/BigInt/api/Structs/BigUInt.html#/s:vV6BigInt7BigUInt5widthSi
[leadingZeroes]: http://lorentey.github.io/BigInt/api/Structs/BigUInt.html#/s:vV6BigInt7BigUInt13leadingZeroesSi
[trailingZeroes]: http://lorentey.github.io/BigInt/api/Structs/BigUInt.html#/s:vV6BigInt7BigUInt14trailingZeroesSi
[shift]: http://lorentey.github.io/BigInt/api/Functions.html#/Shift%20Operators
[data]: http://lorentey.github.io/BigInt/api/Structs/BigUInt.html#/NSData%20Conversion
[random]: http://lorentey.github.io/BigInt/api/Structs/BigUInt.html#/Random%20Integers
[radix1]: http://lorentey.github.io/BigInt/api/Extensions/String.html#/s:FE6BigIntSScFMSSFTVS_7BigUInt5radixSi9uppercaseSb_SS
[radix2]: http://lorentey.github.io/BigInt/api/Structs/BigUInt.html#/s:FV6BigInt7BigUIntcFMS0_FTSS5radixSi_GSqS0__
[sqrt]: http://lorentey.github.io/BigInt/api/Functions.html#/s:F6BigInt4sqrtFVS_7BigUIntS0_
[GCD]: http://lorentey.github.io/BigInt/api/Structs/BigUInt.html#/s:ZFV6BigInt7BigUInt3gcdFMS0_FTS0_S0__S0_
[powmod]: http://lorentey.github.io/BigInt/api/Structs/BigUInt.html#/s:ZFV6BigInt7BigUInt6powmodFMS0_FTS0_S0_7modulusS0__S0_
[inverse]: http://lorentey.github.io/BigInt/api/Structs/BigUInt.html#/s:FV6BigInt7BigUInt7inverseFS0_FS0_GSqS0__
[prime]: http://lorentey.github.io/BigInt/api/Structs/BigUInt.html#/Primality%20Testing
[abs]: http://lorentey.github.io/BigInt/api/Structs/BigInt.html#/s:vV6BigInt6BigInt3absVS_7BigUInt
[negative]: http://lorentey.github.io/BigInt/api/Structs/BigInt.html#/s:vV6BigInt6BigInt8negativeSb
[subscript]: https://github.com/lorentey/BigInt/blob/v1.0.0/Sources/BigUInt.swift#L127-L150


## <a name="samples">Calculation Samples</a>

### <a name="factorial">Obligatory Factorial Demo</a>

It is easy to use `BigInt` to calculate the factorial function for any integer:

```Swift
import BigInt

func factorial(n: Int) -> BigInt {
    guard n > 1 else { return 1 }
    var result: BigInt = 1    
	for i in 2...n {
        result *= Digit(i)
    }
    return result
}

print(factorial(10))
==> 362880

print(factorial(100))
==> 93326215443944152681699238856266700490715968264381621468592963895217599993229915
    6089414639761565182862536979208272237582511852109168640000000000000000000000

print(factorial(1000))
==> 40238726007709377354370243392300398571937486421071463254379991042993851239862902
    05920442084869694048004799886101971960586316668729948085589013238296699445909974
    24504087073759918823627727188732519779505950995276120874975462497043601418278094
    64649629105639388743788648733711918104582578364784997701247663288983595573543251
    31853239584630755574091142624174743493475534286465766116677973966688202912073791
    43853719588249808126867838374559731746136085379534524221586593201928090878297308
    43139284440328123155861103697680135730421616874760967587134831202547858932076716
    91324484262361314125087802080002616831510273418279777047846358681701643650241536
    91398281264810213092761244896359928705114964975419909342221566832572080821333186
    11681155361583654698404670897560290095053761647584772842188967964624494516076535
    34081989013854424879849599533191017233555566021394503997362807501378376153071277
    61926849034352625200015888535147331611702103968175921510907788019393178114194545
    25722386554146106289218796022383897147608850627686296714667469756291123408243920
    81601537808898939645182632436716167621791689097799119037540312746222899880051954
    44414282012187361745992642956581746628302955570299024324153181617210465832036786
    90611726015878352075151628422554026517048330422614397428693306169089796848259012
    54583271682264580665267699586526822728070757813918581788896522081643483448259932
    66043367660176999612831860788386150279465955131156552036093988180612138558600301
    43569452722420634463179746059468257310379008402443243846565724501440282188525247
    09351906209290231364932734975655139587205596542287497740114133469627154228458623
    77387538230483865688976461927383814900140767310446640259899490222221765904339901
    88601856652648506179970235619389701786004081188972991831102117122984590164192106
    88843871218556461249607987229085192968193723886426148396573822911231250241866493
    53143970137428531926649875337218940694281434118520158014123344828015051399694290
    15348307764456909907315243327828826986460278986432113908350621709500259738986355
    42771967428222487575867657523442202075736305694988250879689281627538488633969099
    59826280956121450994871701244516461260379029309120889086942028510640182154399457
    15680594187274899809425474217358240106367740459574178516082923013535808184009699
    63725242305608559037006242712434169090041536901059339838357779394109700277534720
    00000000000000000000000000000000000000000000000000000000000000000000000000000000
    00000000000000000000000000000000000000000000000000000000000000000000000000000000
    00000000000000000000000000000000000000000000000000000000000000000000000000000000
    00000
```

Well, I guess that's all right, but it's not very interesting. Let's try something more useful.

### <a name="rsa">RSA Cryptography</a>

The `BigInt` module provides all necessary parts to implement an (overly)
simple [RSA cryptography system][RSA].

[RSA]: https://en.wikipedia.org/wiki/RSA_(cryptosystem)

Let's start with a simple function that generates a random n-bit prime. The module 
includes a function to generate random integers of a specific size, and also an 
`isPrime` method that performs the Miller–Rabin primality test. These are all we need:

```Swift
func generatePrime(width: Int) -> BigUInt {
    while true {
        var random = BigUInt.randomIntegerWithExactWidth(width)
        random |= BigUInt(1)
        if random.isPrime() {
            return random
        }
    }
}

let p = generatePrime(1024)
==> 13308187650642192396256419911012544845370493728424936791561478318443071617242872
    81980956747087187419914435169914161116601678883358611076800743580556055714173922
    08406194264346635072293912609713085260354070700055888678514690878149253177960273
    775659537560220378850112471985434373425534121373466492101182463962031

let q = generatePrime(1024)
==> 17072954422657145489547308812333368925007949054501204983863958355897172093173783
    10108226596943999553784252564650624766276133157586733504784616138305701168410157
    80784336308507083874651158029602582993233111593356512531869546706885170044355115
    669728424124141763799008880327106952436883614887277350838425336156327
```

Cool! Now that we have two large primes, we can produce an RSA public/private keypair
out of them.

```Swift
typealias Key = (modulus: BigUInt, exponent: BigUInt)

let n = p * q
==> 22721008120758282530010953362926306641542233757318103044313144976976529789946696
    15454966720907712515917481418981591379647635391260569349099666410127279690367978
    81184375533755888994370640857883754985364288413796100527262763202679037134021810
    57933883525572232242690805678883227791774442041516929419640051653934584376704034
    63953169772816907280591934423237977258358097846511079947337857778137177570668391
    57455417707100275487770399281417352829897118140972240757708561027087217205975220
    02207275447810167397968435583004676293892340103729490987263776871467057582629588
    916498579594964478080508868267360515953225283461208420137

let e: BigUInt = 65537
let phi = (p - 1) * (q - 1)
let d = e.inverse(phi)!     // d * e % phi == 1
==> 13964664343869014759736350480776837992604500903989703383202366291905558996277719
    77822086142456362972689566985925179681282432115598451765899180050962461295573831
    37069237934291884106584820998146965085531433195106686745474222222620986858696591
    69836532468835154412554521152103642453158895363417640676611704542784576974374954
    45789456921660619938185093118762690200980720312508614337759620606992462563490422
    76669559556568917533268479190948959560397579572761529852891246283539604545691244
    89999692877158676643042118662613875863504016129837099223040687512684532694527109
    80742873307409704484365002175294665608486688146261327793

let publicKey: Key = (n, e)
let privateKey: Key = (n, d)
```

In RSA, modular exponentiation is used to encrypt (and decrypt) messages.

```Swift
func encrypt(message: BigUInt, key: Key) -> BigUInt {
    return BigUInt.powmod(message, key.exponent, modulus: key.modulus)
}
```

Let's try out our new keypair by converting a string into UTF-8, interpreting
the resulting binary representation as a big integer, and encrypting it with the
public key. `BigUInt` has an initializer that takes an `NSData`, so this is pretty 
easy to do:

```Swift
let secret: BigUInt = BigUInt("Arbitrary precision arithmetic is fun!".dataUsingEncoding(NSUTF8StringEncoding)!)
==> 83323446846105976078466731524728681905293067701804838925389198929123912971229457
    68818568737

let cyphertext = encrypt(secret, key: publicKey)
==> 95186982543485985200666516508066093880038842892337880561554910904277290917831453
    54854954722744805432145474047391353716305176389470779020645959135298322520888633
    61674945129099575943384767330342554525120384485469428048962027149169876127890306
    77028183904699491962050888974524603226290836984166164759586952419343589385279641
    47999991283152843977988979846238236160274201261075188190509539751990119132013021
    74866638595734222867005089157198503204192264814750832072844208520394603054901706
    06024394731371973402595826456435944968439153664617188570808940022471990638468783
    49208193955207336172861151720299024935127021719852700882
```

Well, it looks encrypted all right, but can we get the original message back? 
In theory, encrypting the cyphertext with the private key returns the cleartext.
Let's see:

```Swift
let plaintext = encrypt(cyphertext, key: privateKey)
==> 83323446846105976078466731524728681905293067701804838925389198929123912971229457
    68818568737

let received = String(data: plaintext.serialize(), encoding: NSUTF8StringEncoding)
==> "Arbitrary precision arithmetic is fun!"
```

Yay! This is truly terrific, but please don't use this example code in an actual 
cryptography system. RSA has lots of subtle (and some not so subtle) complications
that we ignored to keep this example short.

### <a name="pi">Calculating the Digits of π</a>

Another fun activity to try with `BigInt`s is to generate the digits of π.
Let's try implementing [Jeremy Gibbon's spigot algorithm][spigot]. 
This is a rather slow algorithm as π-generators go, but it makes up for it with its grooviness
factor: it's remarkably short, it only uses (big) integer arithmetic, and every iteration
produces a single new digit in the base-10 representation of π. This naturally leads to an
implementation as an infinite `GeneratorType`:

[spigot]: http://www.cs.ox.ac.uk/jeremy.gibbons/publications/spigot.pdf

```Swift
func digitsOfPi() -> AnyGenerator<Int> {
    var q: BigUInt = 1
    var r: BigUInt = 180
    var t: BigUInt = 60
    var i: UInt64 = 2 // Does not overflow until digit #826_566_842
    return anyGenerator {
        let u: UInt64 = 3 * (3 * i + 1) * (3 * i + 2)
        let y = (q.multiplyByDigit(27 * i - 12) + 5 * r) / (5 * t)
        (q, r, t) = (
            10 * q.multiplyByDigit(i * (2 * i - 1)),
            10 * (q.multiplyByDigit(5 * i - 2) + r - y * t).multiplyByDigit(u),
            t.multiplyByDigit(u))
        i += 1
        return Int(y[0])
    }
}
```

Well, that was surprisingly easy. But does it work? Of course it does!

```Swift
var digits = "π ≈ "
var count = 0
for digit in digitsOfPi() {
    assert(digit < 10)
    digits += String(digit)
    count += 1
    if count == 1 { digits += "." }
    if count == 1000 { break }
}

digits
==> π ≈ 3.14159265358979323846264338327950288419716939937510582097494459230781640628
    62089986280348253421170679821480865132823066470938446095505822317253594081284811
    17450284102701938521105559644622948954930381964428810975665933446128475648233786
    78316527120190914564856692346034861045432664821339360726024914127372458700660631
    55881748815209209628292540917153643678925903600113305305488204665213841469519415
    11609433057270365759591953092186117381932611793105118548074462379962749567351885
    75272489122793818301194912983367336244065664308602139494639522473719070217986094
    37027705392171762931767523846748184676694051320005681271452635608277857713427577
    89609173637178721468440901224953430146549585371050792279689258923542019956112129
    02196086403441815981362977477130996051870721134999999837297804995105973173281609
    63185950244594553469083026425223082533446850352619311881710100031378387528865875
    33208381420617177669147303598253490428755468731159562863882353787593751957781857
    780532171226806613001927876611195909216420198
```

Now go and have some fun with big integers on your own!