import 'package:flutter/material.dart';
import 'package:flutter_staking/screens/wallet/wallet_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My Crypto Wallet',
      home: MyCryptoWallet(),
    );
  }
}
