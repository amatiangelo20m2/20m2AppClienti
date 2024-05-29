import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../theme/colors.dart';

const List<TabItem> items = [
  TabItem(
    icon: Icons.home,
    title: 'Home',
  ),
  TabItem(
    icon: Icons.search_sharp,
    title: 'Shop',
  ),
  TabItem(
    icon: Icons.add,
    title: 'Wishlist',
  ),
  TabItem(
    icon: Icons.shopping_cart_outlined,
    title: 'Cart',
  ),
  TabItem(
    icon: Icons.account_box,
    title: 'profile',
  ),
];

int visit = 0;

class Home extends StatefulWidget {
  const Home({super.key});

  static String routeName = 'home_page';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBarInspiredFancy(
        items: items,
        backgroundColor: Colors.transparent,
        color: grey,
        colorSelected: brown,
        styleIconFooter: StyleIconFooter.dot,
        indexSelected: visit,
        onTap: (int index) => setState(() {
          visit = index;
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: FloatingActionButton(
          backgroundColor: brown,
          onPressed: () {
            Navigator.pushNamed(context, Home.routeName);
          },
          child: Icon(Icons.menu, color: white),
        ),
      ),
      body: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 150),
          child: CreditCardWidget(
            enableFloatingCard: true,
            cardNumber: '333',
            expiryDate: '',
            cardHolderName: 'ngelo amam',
            cvvCode: '',
            showBackView: true, //true when you want to show cvv(back) view
            onCreditCardWidgetChange: (CreditCardBrand brand) {}, // Callback for anytime credit card brand is changed
          ),
        ),
      ),
    );
  }
}


