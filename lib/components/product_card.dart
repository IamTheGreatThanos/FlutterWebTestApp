import 'package:flutter/material.dart';
import 'package:test_web_app/models/product.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: MediaQuery.of(context).size.width * 0.8,
        width: MediaQuery.of(context).size.width * 0.1,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Image.network(
                  widget.product.image,
                  fit: BoxFit.fitHeight,
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.product.name,
                  softWrap: false,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  'Код товара: ' + widget.product.code,
                  style: const TextStyle(
                      fontSize: 14, fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  'В наличии: ' +
                      (widget.product.in_stock == true ? 'Да' : 'Нет'),
                  style: const TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  'Цена: ' + widget.product.price.toString() + ' ₸',
                  style: const TextStyle(
                      fontSize: 22,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: TextButton(
                          onPressed: () {
                            print('Heelio');
                            // Navigator.of(context)
                            // .pushNamed('/');
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blue[700],
                              primary: Colors.white),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 12),
                            child: Text(
                              'Купить',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: TextButton(
                          onPressed: () {
                            print('Heelio');
                            // Navigator.of(context)
                            // .pushNamed('/');
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.grey,
                              primary: Colors.white),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 12),
                            child: Text(
                              'Подробнее',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
