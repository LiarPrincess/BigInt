// This file was written by LiarPrincess for Violet - Python VM written in Swift.
// https://github.com/LiarPrincess/Violet

@testable import BigInt

// swiftlint:disable number_separator
// swiftlint:disable line_length
// swiftformat:disable numberFormatting

internal enum StringTestCases {

  internal typealias TestCase = (words: [BigInt.Word], string: String)

  // MARK: - Binary

  internal enum Binary {

    internal static let singleWord: [TestCase] = [
      ([14910680400771486431], "1100111011101101011000001101001100000111010111010001001011011111"),
      ([18049321082763878571], "1111101001111100000100011110010100110111000111000010000010101011"),
      ([12249888203312320543], "1010101000000000010110000110101100010000101011011101000000011111"),
      ([5681400955737104992], "100111011011000011001000001000101100001010001100110001001100000"),
      ([5443681076643081875], "100101110001011110101110001100011101011110100111010111010010011"),
      ([14552388604195006632], "1100100111110100011110000101010101101010011111000110100010101000"),
      ([1419335438964437885], "1001110110010011111100000111111010000100110010011001101111101"),
      ([5793822662808745003], "101000001100111110010110000001111001100010100101011010000101011"),
      ([12890732459758397853], "1011001011100101000101001101111111000110011111110010100110011101"),
      ([7083049658624145887], "110001001001100000011000010001100001100101111100111100111011111")
    ]

    internal static let twoWords: [TestCase] = [
      ([7709943161734646411, 5395369061329276990], "1001010111000000011001110010011010011001010101000010000001111100110101011111111001110000111010011100001101001010100101010001011"),
      ([10068833863126163291, 13055573661232751314], "10110101001011101011011100010010110100001011100101100010110100101000101110111011101011110000110100110010000011110001111101011011"),
      ([9711191595782958759, 11873224468820222032], "10100100110001100010101010111111010100101000000101100000010100001000011011000101000101010100110111100100011001101110111010100111"),
      ([296585062226257478, 2962206244791346445], "101001000110111101111011100010100111000011101101100101000011010000010000011101101011101000101011101111101011101110011001000110"),
      ([4355337989126379704, 6250400716541368070], "1010110101111011110001001010101111011010100101110010111000001100011110001110001010001001101001101010110101001000101100010111000"),
      ([17238825691124781481, 1405444159956169195], "10011100000010010010000000100011000011101010110110001111010111110111100111100100111001010000110000000010111101101000110101001"),
      ([11973739651872522223, 129380782069776498], "1110010111010011100100010110001000000100000000000011100101010011000101011010001001100011000010110110111101111111111101111"),
      ([436399990275061456, 15571848279703918830], "11011000000110100101000110000001110110000000011110011000111011100000011000001110011001110111101010100000010101000011011011010000"),
      ([11416727460569207084, 13468612935669712839], "10111010111010100010000000011010111011111101001100000111110001111001111001110000010111010010001100010000101011001101000100101100"),
      ([16704995536835670836, 18305786541461137992], "11111110000010110011011111011111000010011110101011101010010010001110011111010100000100001110111100010011100100110111001100110100")
    ]
  }

  // MARK: - Quinary

  internal enum Quinary {

    internal static let singleWord: [TestCase] = [
      ([10195599536115211853], "1141011330110244430443234403"),
      ([11148293617344187171], "1222004313120111310102442141"),
      ([16581359024097057841], "2103043303342222322321322331"),
      ([1963548865060307269], "112432412234101120414313034"),
      ([4650830292194358338], "303003222112001403223431323"),
      ([5923527504604717564], "344142232044113412301430224"),
      ([11032004014403237700], "1220020343312232444212101300"),
      ([17731643299662006016], "2142220433422310201433143031"),
      ([8974493917839354209], "1100240414331322213333313314"),
      ([10284022934724793689], "1142232034423230304021344224")
    ]

    internal static let twoWords: [TestCase] = [
      ([7166946866828356326, 1283328998154523208], "203123203032243200414100331344240044242020031202313304"),
      ([17746844892252647709, 7729270025137380738], "2241012313012133231212400333342433431343403034400222232"),
      ([3117040153726440296, 13330676859597655378], "4203331403433210032231444444420301011232202040320244034"),
      ([9389283096438931568, 16660274568627612047], "10232010021201310022422112231324444321204423440331141040"),
      ([10151668648408986613, 18099786241267349540], "11001404212423031440100214040300432233323022042011441003"),
      ([1888399307037804872, 385298439426531010], "31000242443014011010113041320310341223011340044321112"),
      ([6144037938277486548, 721424258481946865], "104440411024104113410312042432323043144001330034323023"),
      ([14314271871241051703, 14038673589000308396], "4313032440022022004204011201231102003140212144013012024"),
      ([1610709691090591847, 1506362658927364202], "222241220112410000313023011200201140300201034000223104"),
      ([1877780960810668148, 13192324888935710577], "4142443213143020430040201142133120302113431131300414310")
    ]
  }

  // MARK: - Octal

  internal enum Octal {

    internal static let singleWord: [TestCase] = [
      ([9027730909523848476], "765107426714576726434"),
      ([3297038718702367055], "267013363740675530517"),
      ([10639603696146990864], "1116473563031361443420"),
      ([4650451613422864026], "402115621515715443232"),
      ([8992000964025095465], "763120023606053712451"),
      ([13147777551363676744], "1331662240274670615110"),
      ([891205320620556160], "61361450215541537600"),
      ([7922149813937273486], "667611024411512075216"),
      ([18280073147257698292], "1766576732635234733764"),
      ([377816299772228753], "24762136610221532221")
    ]

    internal static let twoWords: [TestCase] = [
      ([15585287516344763483, 2355014894934463518], "405353062163251224075541120406576603642133"),
      ([3189184062842169181, 5599482567064088057], "1155525567215754355762261022040102502663535"),
      ([3964041246558262276, 2846008895404346873], "473760700275426615762334030650135006412004"),
      ([1015224584249523628, 17522684300601343280], "3631321221020124075140070266326054733736654"),
      ([2072488601858021864, 10969847613326490834], "2301713511046076774644163027526344262614750"),
      ([219889601707657665, 7052321924236707018], "1416756055467752004624014151506657745444701"),
      ([16227375082796059633, 1724776236223714883], "277372133117223126207604631572452705305761"),
      ([4978561187561123947, 15231695391734886515], "3233035510177647760346424273160270510130153"),
      ([8332793074858625431, 17326254193883183180], "3603463414404503570230716440162341562104627"),
      ([16203117573032797751, 380499378895123004], "52174705323046362171603350231267240463067")
    ]

    internal static let threeWords: [TestCase] = [
      ([681052395112981620, 5524247289861906130, 2210775909268916402], "752710076366767021311145241064414721036644045634530560410662164"),
      ([14856848762854770514, 2965772954907465975, 5661557264032529616], "2351074425357060771500511210531201334130757470561023603752203522"),
      ([6238741308901019224, 4186391981714677073, 4712669703510828451], "2026330410062602113214720620652354122635242532243542521246347130"),
      ([4080341212257558034, 14149341274818351434, 5750469562719205651], "2374670546314622762117042710735422651021224342402213330677717022"),
      ([14875561220749857904, 4580798086887072873, 6118586556778866508], "2516462603442110716460774444162701130544323471604701667527612160"),
      ([2995664394837594456, 15782269881219481458, 11431982845400553019], "4752321765021165454357330136132660667377344246225716247045110530"),
      ([6995545736791051231, 7048114468200063197, 5219807130683247620], "2207017273376155030021416376730413255440672604251274423333345737"),
      ([9935611390414813611, 13907368319050548696, 13881054378609025600], "6012155132310337104403010016271520303605661047423036543777774653"),
      ([16470394236095961112, 7479687647312861488, 5788714898313010536], "2405264541731765272641476323011120172731141622224604547111014030"),
      ([13614001671611405222, 1770540855717814547, 297365776674567548], "102016446227413552760304443460703260141047363565146174776151646")
    ]
  }

  // MARK: - Decimal

  internal enum Decimal {

    internal static let singleWord: [TestCase] = [
      ([7718190171501264284], "7718190171501264284"),
      ([10916363490721922425], "10916363490721922425"),
      ([7933533405371913824], "7933533405371913824"),
      ([10480426996613498135], "10480426996613498135"),
      ([2095192256445644812], "2095192256445644812"),
      ([7419235996356813804], "7419235996356813804"),
      ([1781771517166335135], "1781771517166335135"),
      ([11133038279461172192], "11133038279461172192"),
      ([2130720192200721827], "2130720192200721827"),
      ([14853271410540786435], "14853271410540786435"),
      ([6950267042901794576], "6950267042901794576"),
      ([10411748895426429475], "10411748895426429475"),
      ([9833709291961056769], "9833709291961056769"),
      ([5999039672382756712], "5999039672382756712"),
      ([16110142630232532658], "16110142630232532658"),
      ([12607569496212494176], "12607569496212494176"),
      ([1675868323700977277], "1675868323700977277"),
      ([16806170715214457379], "16806170715214457379"),
      ([16940169654426845777], "16940169654426845777"),
      ([8827990282256005918], "8827990282256005918")
    ]

    internal static let twoWords: [TestCase] = [
      ([4443533457689204244, 9447717631965633948], "174279629237543296687673032485957064212"),
      ([17900669220997358843, 2570240114532569528], "47412561600764236150769686558222116091"),
      ([7856018056960015278, 563563541832512549], "10395912425457665851645833014443244462"),
      ([16030846250062419557, 8907554407558390165], "164315376478873129818157066650996676197"),
      ([76456108598031866, 574783630844925132], "10602886535953881315042562817407645178"),
      ([16060639402207784427, 447160259735582989], "8248650871275789350502376241754844651"),
      ([6724383833077440728, 1871596841765025634], "34524867949202500042981821345963565272"),
      ([17721423422461386696, 7275905016728549520], "134216757748210966888150667727713411016"),
      ([13753655854536165771, 9275486953311460472], "171102533986768447955502501639763888523"),
      ([16007314175766750326, 2973146718057590835], "54844876601597866882605545088807789686"),
      ([13668675975230855091, 3084207318121013092], "56893583067640428051926870614216611763"),
      ([17634210073973176566, 17582779518830157984], "324345033888321898323997479933055678710"),
      ([1179859661762935910, 16476057228812186700], "303929611043690622871586457595241643110"),
      ([7466570045805584571, 13400632262344301616], "247198033769360767204907027173829796027"),
      ([1307790023500255040, 1180604957065739539], "21778317495144550468861398478632800064"),
      ([10557776168390327892, 4585526828064760774], "84588039840439783849569873830235438676"),
      ([4287714958589154583, 16866189280135533900], "311126277149403728470285334436356936983"),
      ([6956547535360810766, 7583896181036572753], "139898191933164899225423319256353529614"),
      ([3961997723213026888, 110765278953620120], "2043258753110477277143778428409140808"),
      ([16244342368417094884, 18289544018252558769], "337382537729550367819433505076096015588")
    ]

    internal static let threeWords: [TestCase] = [
      ([3788030118483678566, 13587601199963990513, 17878135298378645545], "6083614195465063921457756617643704987757901496806223861094"),
      ([3556988877394908356, 12474154662934588154, 13400076941623863208], "4559809898618458323618774365881241097705852866053722576068"),
      ([6943250440187782281, 16148677006591030242, 17634341583823379554], "6000655493235750363443630214517832475022981384493522723977"),
      ([12051381132750026838, 7772465072843729846, 10134998057705544164], "3448761127815156638054418593304414317156905140903945500758"),
      ([11057770507354506703, 3754418486115532988, 11847945032505514529], "4031646778810151685478902878630817277976717194269043459535"),
      ([4058671830152788248, 17848382429627053213, 15243350683428292588], "5187043450362884349943980736394397527883291975412376418584"),
      ([9506519811871484410, 10336689296818807801, 2548286636764283718], "867137008351148227772945110512985612059866264001066314234"),
      ([8153835003846552590, 6452612927418895754, 1191437178575943052], "405425063163426737085717989265456363407329145867582794766"),
      ([11092524183389504737, 10258419301515066693, 1517546691578291045], "516394380123300269594485907074283812975608688889426642145"),
      ([17450711516373662082, 12266023495873027824, 17081706021512517970], "5812603356047926610460197272765392220238610608713665689986"),
      ([10493740789275983823, 7090478780156208175, 2893210513446379807], "984508521516077779720769747676107292251302380633744113615"),
      ([2584946677711410572, 15582369744544450926, 10600651036904921818], "3607214625740907391200152863690596886095271299895459353996"),
      ([8191223326464221616, 15838770264786859451, 10448195476633736002], "3555336686841570490688168198501982767988360618443302183344"),
      ([9330481725652115023, 17984447776108471806, 15931644148621564667], "5421257579835065546517323313625099317184145652987724078671"),
      ([5834919825408647544, 18291287390831708357, 15545400078801850136], "5289825533547636872288114877966109957241807144779629060472"),
      ([7725628935030398936, 13217523222545559873, 6525293375752710251], "2220442274754652930479991837181424586345958361124409139160"),
      ([11153747151801819771, 12447701429598628384, 7358354431466140957], "2503918262582474917700425110083118534477438840011330691707"),
      ([1305957527465355656, 6634926787110467165, 8618539646621370010], "2932737070354268352744296521741629050767038012966002878856"),
      ([5697551272666427272, 9806098653662596381, 17446402411063414409], "5936703106691826260722357215905339148900071080037029998472"),
      ([13461627091841105866, 15779306612146539460, 1875399779845087415], "638165476008693250974186539568945174625645764897016299466")
    ]

    internal static let fourWords: [TestCase] = [
      ([8069127371757787930, 18298415571011048517, 16815374448153862577, 15664831157880175362], "98329738845668996570124208357521780017272355350396828224707284828351881091866"),
      ([5470742250373313138, 17521113983887669137, 1031109059281010587, 16826745550145797929], "105623193693730296505637022908493828321474575998233295842297319498067956265586"),
      ([7821963600184975391, 1696593353817084268, 18062377089319569726, 4419899561878296347], "27744159210101084003408741123228345882260348087436638008210479865903937724447"),
      ([5034162668176282620, 13810266618081868282, 678065491460384283, 7005674689622930240], "43975332751786641545687151785881018379208099070772924031466259723893919847420"),
      ([948109800916453930, 13254873860379351332, 9460782306108757222, 1161530252760842443], "7291043565309214047592216113421685977429724781349367031290578029129539586602"),
      ([15835724493698649863, 17125118148463518722, 13959435657126725002, 13380134033748730320], "83988462562950544098864456303214580453611103336990060118099235083777904234247"),
      ([4071443539966139976, 11664926414955986211, 16616938295452084138, 5254055772243955785], "32980242605770942006188369357622369959610697780125045082756386640312378695240"),
      ([13537182919290894418, 9915062231487163470, 5294088489907226107, 3571337015533456534], "22417645777855749287001476980921879614161082692816351875309530936088143706194"),
      ([9724782435949804194, 5610697598620232897, 7986759389249900697, 1157166139356361906], "7263649581484524992809489869886295226321246688450694700744863589918010440354"),
      ([3131625851484723186, 8251872111016498371, 5091559339788432642, 3939531212584346483], "24728838211123196082450064688238894776920371466824252419807721449583553632242")
    ]
  }

  internal enum Hex {

    internal static let singleWord: [TestCase] = [
      ([9027730909523848476], "7d48f16e65fbad1c"),
      ([3297038718702367055], "2dc16f3f06f6b14f"),
      ([10639603696146990864], "93a77730cbc64710"),
      ([4650451613422864026], "4089b91a6f36469a"),
      ([8992000964025095465], "7cca013c30af9529"),
      ([13147777551363676744], "b6764a05e6e31a48"),
      ([891205320620556160], "c5e32846d86bf80"),
      ([7922149813937273486], "6df121484d287a8e"),
      ([18280073147257698292], "fdafddacea73b7f4"),
      ([377816299772228753], "53e45ec4246b491")
    ]

    internal static let twoWords: [TestCase] = [
      ([2355014894934463518, 15585287516344763483], "d84a106bf60f445b20aeb191cd52941e"),
      ([5599482567064088057, 3189184062842169181], "2c424202150b675d4db55bba37d8edf9"),
      ([2846008895404346873, 3964041246558262276], "37031a82e81a1404277f0e02f62d8df9"),
      ([17522684300601343280, 1015224584249523628], "e16cd61676fbdacf32d148840a83d30"),
      ([10969847613326490834, 2072488601858021864], "1cc2f56722cb19e8983cba48987dfcd2"),
      ([7052321924236707018, 219889601707657665], "30d346d7f9649c161dee16cdfd404ca"),
      ([1724776236223714883, 16227375082796059633], "e13337a957158bf117efa2d93d265643"),
      ([15231695391734886515, 4978561187561123947], "45176705c520b06bd361da41ff4ff073"),
      ([17326254193883183180, 8332793074858625431], "73a407270dc88997f07338641287784c"),
      ([380499378895123004, 16203117573032797751], "e0dd0995ba8266370547ce2b4c4cf23c")
    ]

    internal static let threeWords: [TestCase] = [
      ([681052395112981620, 5524247289861906130, 2210775909268916402], "1eae40f9edf708b24caa11a433a21ed20973958b84236474"),
      ([14856848762854770514, 2965772954907465975, 5661557264032529616], "4e91e455de30fcd029288aca05b858f7ce2e213c1fa90752"),
      ([6238741308901019224, 4186391981714677073, 4712669703510828451], "4166c420658225a33a190d53b0a59d515694762a8a99ce58"),
      ([4080341212257558034, 14149341274818351434, 5750469562719205651], "4fcdc5999992f913c45c8eec4b52114a38a048b6c6ff9e12"),
      ([14875561220749857904, 4580798086887072873, 6118586556778866508], "54e9960e4448e74c3f92439704b16469ce709c1dbd5f1470"),
      ([2995664394837594456, 15782269881219481458, 11431982845400553019], "9ea68fd42275963bdb05e2d6c36eff722992bce538949158"),
      ([6995545736791051231, 7048114468200063197, 5219807130683247620], "48707aedfc6d0c0461cfeec42d5b20dd61152bc89b6dcbdf"),
      ([9935611390414813611, 13907368319050548696, 13881054378609025600], "c0a3696990df2240c100e5cd418785d889e261eb1ffff9ab"),
      ([16470394236095961112, 7479687647312861488, 5788714898313010536], "5055a587b3f55d6867cd304940f5d930e492984b39241818"),
      ([13614001671611405222, 1770540855717814547, 297365776674567548], "42074992f0bb57c189239870d606113bceea663e7f8d3a6")
    ]
  }
}
