import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  Map<String, String> displayRates = {
    'BTCUSD': '0',
    'ETHUSD': '0',
    'LTCUSD': '0'
  };

  CoinData coinData = CoinData();

  Widget androidDropdown() {
    List<DropdownMenuItem> dropdownItems = [];
    currenciesList.forEach((curr) {
      dropdownItems.add(
        DropdownMenuItem(
          child: Text(curr),
          value: curr,
        ),
      );
    });

    return DropdownButton(
        value: selectedCurrency,
        items: dropdownItems,
        underline: Container(
          height: 2,
          color: Colors.tealAccent,
        ),
        onChanged: (value) async {
          Map<String, String> rates =
              await coinData.getCoinData(curr: value);
          setState(() {
            selectedCurrency = value;
            displayRates = rates;
          });
        });
  }

  Widget iosPicker() {
    List<Text> pickerItems = [];
    for (String str in currenciesList) {
      pickerItems.add(Text(str));
    }

    return CupertinoPicker(
      backgroundColor: Colors.grey.shade700,
      itemExtent: 32,
      onSelectedItemChanged: (int ind) async {
        Map<String, String> rates =
        await coinData.getCoinData(curr: currenciesList[ind]);
        setState(() {
          selectedCurrency = currenciesList[ind];
          displayRates = rates;
        });
      },
      children: pickerItems,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
//              color: Colors.teal,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ${displayRates['BTC$selectedCurrency']} $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
//              color: Colors.teal,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = ${displayRates['ETH$selectedCurrency']} $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
//              color: Colors.teal,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = ${displayRates['LTC$selectedCurrency']} $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
//            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
