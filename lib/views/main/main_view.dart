import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/components/product_card.dart';
import 'package:test_web_app/models/product.dart';
import 'package:test_web_app/services/products_api_provider.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  TextEditingController searchController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var username = 'Username';
  double gridHeight = 0;

  List<Product> recommendations = [];
  List<Product> tops = [];

  @override
  void initState() {
    getInfo();
    gridHeight = 0;
    getRecommendations();
    getTops();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.grey[200]),
          child: Column(
            children: [
              Container(
                height: 100,
                color: Colors.grey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: Image.asset(
                            'assets/images/logo-v2.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10),
                          child: TextFormField(
                            controller: searchController,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                            decoration: InputDecoration(
                                fillColor: Colors.red,
                                border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue[800]!)),
                                hintText: 'Введите слово',
                                labelText: 'Поиск',
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.blue[800],
                                    fontSize: 16),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue[900]!)),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.blue[800],
                                ),
                                hintStyle: TextStyle(
                                    color: Colors.grey[400], fontSize: 16),
                                prefixText: ' ',
                                // suffixText: 'USD',
                                suffixStyle: const TextStyle(
                                    color: Colors.black, fontSize: 16)),
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          print('Search');
                          // Navigator.of(context)
                          // .pushNamed('/');
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blue[700],
                            primary: Colors.white),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 60, vertical: 15),
                          child: Text(
                            'Поиск',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                        )),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.asset(
                                'assets/images/ava.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/profile');
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Row(
                              children: [
                                Text(
                                  username.toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                    color: Colors.blue[800],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: GestureDetector(
                            onTap: () {
                              Alert(
                                context: context,
                                type: AlertType.info,
                                title: "Внимание!",
                                desc: "Вы точно хотите выйти?",
                                buttons: [
                                  DialogButton(
                                    child: const Text(
                                      "Да",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.of(context)
                                        .pushNamed('/login'),
                                    color: Colors.blue[800],
                                  ),
                                  DialogButton(
                                    child: const Text(
                                      "Нет",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    color: Colors.grey,
                                  ),
                                ],
                              ).show();
                            },
                            child: Icon(
                              Icons.exit_to_app,
                              color: Colors.blue[800],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Container(
                    color: Colors.blue[800],
                    child: SizedBox(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              buildNavBarItem('Цены'),
                              const SizedBox(
                                width: 40,
                              ),
                              buildNavBarItem('Новости'),
                              const SizedBox(
                                width: 40,
                              ),
                              buildNavBarItem('Много другое'),
                              const SizedBox(
                                width: 40,
                              ),
                              buildNavBarItem('О нас'),
                              const SizedBox(
                                width: 40,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/AirPodsMax.png'),
                              fit: BoxFit.cover)),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          verticalDirection: VerticalDirection.down,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'AirPods Max',
                                    style: TextStyle(
                                      fontSize: 36,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text(
                                    'Самые лучшие наушники в мире!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        print('Helio');
                                        // Navigator.of(context)
                                        // .pushNamed('/');
                                      },
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.blue[700],
                                          primary: Colors.white),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 60, vertical: 15),
                                        child: Text(
                                          'Подробнее',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white),
                                        ),
                                      ))
                                ],
                              ),
                              flex: 1,
                            ),
                            Expanded(child: Container(), flex: 1),
                          ])),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Рекомендации',
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            print('Helio111');
                            // Navigator.of(context)
                            // .pushNamed('/');
                          },
                          // style: TextButton.styleFrom(
                          //     backgroundColor: Colors.blue[700],
                          //     primary: Colors.white),
                          child: Row(
                            children: const [
                              Text(
                                'More',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black45),
                              ),
                              Icon(
                                Icons.arrow_forward_outlined,
                                color: Colors.black45,
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: gridHeight,
                      child: GridView.count(
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 4,
                        childAspectRatio: 0.85,
                        children:
                            List.generate(recommendations.length, (index) {
                          return ProductCard(product: recommendations[index]);
                        }),
                      ))),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                      decoration: const BoxDecoration(color: Colors.black87),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          verticalDirection: VerticalDirection.down,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                'assets/images/new-point.jpg',
                                              ),
                                              fit: BoxFit.fitHeight)),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Открытие нового магазина!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            print('Helios');
                                            // Navigator.of(context)
                                            // .pushNamed('/');
                                          },
                                          style: TextButton.styleFrom(
                                              side: BorderSide(
                                                  color: Colors.blue[700]!),
                                              backgroundColor:
                                                  Colors.transparent,
                                              primary: Colors.transparent),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 7),
                                            child: Text(
                                              'Подробнее',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.blue[700]),
                                            ),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                              flex: 1,
                            ),
                            Expanded(
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.25,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  decoration:
                                                      const BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                                  image:
                                                                      AssetImage(
                                                                    'assets/images/new-point.jpg',
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  'Открытие нового магазина!',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white70,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.25,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  decoration:
                                                      const BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                                  image:
                                                                      AssetImage(
                                                                    'assets/images/new-point.jpg',
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  'Открытие нового магазина!',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white70,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.25,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  decoration:
                                                      const BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                                  image:
                                                                      AssetImage(
                                                                    'assets/images/new-point.jpg',
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  'Открытие нового магазина!',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white70,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.25,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  decoration:
                                                      const BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                                  image:
                                                                      AssetImage(
                                                                    'assets/images/new-point.jpg',
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  'Открытие нового магазина!',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white70,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                flex: 1),
                          ])),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Самые требуемые',
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            print('Hello!!!');
                            // Navigator.of(context)
                            // .pushNamed('/');
                          },
                          // style: TextButton.styleFrom(
                          //     backgroundColor: Colors.blue[700],
                          //     primary: Colors.white),
                          child: Row(
                            children: const [
                              Text(
                                'More',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black45),
                              ),
                              Icon(
                                Icons.arrow_forward_outlined,
                                color: Colors.black45,
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 450,
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 4,
                        childAspectRatio: 0.85,
                        children: List.generate(tops.length, (index) {
                          return ProductCard(product: tops[index]);
                        }),
                      ))),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Container(
                      decoration: BoxDecoration(color: Colors.blue[700]),
                      width: MediaQuery.of(context).size.width,
                      height: 350,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          verticalDirection: VerticalDirection.down,
                          children: <Widget>[
                            Expanded(
                              child: Container(),
                              flex: 1,
                            ),
                            Expanded(
                              child: Center(
                                child: SizedBox(
                                  width: 300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 100,
                                      ),
                                      Text(
                                        'О компании'.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        'Контакты',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        'Информация о сети',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        'Карьера у нас',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: Center(
                                child: SizedBox(
                                  width: 300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 100,
                                      ),
                                      Text(
                                        'Выгодно'.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        'Контакты',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        'Информация о сети',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        'Карьера у нас',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: Center(
                                child: SizedBox(
                                  width: 300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 100,
                                      ),
                                      Text(
                                        'Аккаунт'.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        'Контакты',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        'Информация о сети',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        'Карьера у нас',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: Center(
                                child: SizedBox(
                                  width: 300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 100,
                                      ),
                                      Text(
                                        'Присоединяйтесь'.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          'Хотите узнавать о новостях первыми?',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: TextFormField(
                                          controller: emailController,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                          decoration: const InputDecoration(
                                              fillColor: Colors.red,
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white70)),
                                              hintText: 'Введите email',
                                              labelText: 'Email',
                                              labelStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              prefixIcon: Icon(
                                                Icons.email,
                                                color: Colors.white,
                                              ),
                                              hintStyle: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 14),
                                              prefixText: ' ',
                                              // suffixText: 'USD',
                                              suffixStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: TextButton(
                                            onPressed: () {
                                              print('ads');
                                            },
                                            style: TextButton.styleFrom(
                                                side: const BorderSide(
                                                    color: Colors.white)),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 15),
                                              child: Text(
                                                'Присоединиться',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: Container(),
                              flex: 1,
                            )
                          ])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString('login')!;
    });
  }

  Widget buildNavBarItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Icon(
            Icons.arrow_drop_down_circle_outlined,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  void getRecommendations() async {
    var response = await ProductsProvider().getRecommendations();
    if (response['status'] == 'ok') {
      List<Product> tempList = [];
      for (var i in response['data']) {
        tempList.add(Product.fromJson(i));
      }
      int lineCount = tempList.length ~/ 4;
      if (tempList.length % 4 != 0) {
        lineCount += 1;
      }
      setState(() {
        recommendations = tempList;
        gridHeight = (450 * lineCount) as double;
      });
    }
  }

  void getTops() async {
    var response = await ProductsProvider().getTops();
    if (response['status'] == 'ok') {
      List<Product> tempList = [];
      for (var i in response['data']) {
        tempList.add(Product.fromJson(i));
      }
      setState(() {
        tops = tempList;
      });
    }
  }
}
