import 'coin_data.dart';
import 'package:flutter/material.dart';
class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedCurrency = 'USD';
  int rateInBTC = 47291;
  int rateInETH = 47291;
  int rateInLTC = 47291;
  int counter = 0;

  List<DropdownMenuItem> getDropDownListItem(){
    List<DropdownMenuItem<String>> dropDownList = [];
    var newItem;
    for(String currency in currenciesList){
      newItem = DropdownMenuItem(
          child: Text(currency),
          value: currency
      );
     dropDownList.add(newItem);
    }
    return dropDownList;
  }




  void getData() async {
    try{
    List<double> data = await CoinData(currency: selectedCurrency).getDataFromUrl();
      setState(() {
        rateInBTC = data[0].toInt();
        rateInETH = data[1].toInt();
        rateInLTC = data[2].toInt();

      });
    }catch(e){
      print('error in get data method, error $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
             cryptoCard(
               value: rateInBTC,
               crypto: cryptoList[0],
               currency: selectedCurrency,
             ),
              cryptoCard(
                value: rateInETH,
                crypto: cryptoList[1],
                currency: selectedCurrency,
              ),
              cryptoCard(
                value: rateInLTC,
                crypto: cryptoList[2],
                currency: selectedCurrency,
              )
              ]
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              value: selectedCurrency,
              items: getDropDownListItem(),
              onChanged: (value) {
                setState(()  {
                  selectedCurrency = value;
                   getData();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
class cryptoCard extends StatelessWidget{
  cryptoCard({this.value,this.currency,this.crypto,this.url});
  final value;
  final currency;
  final crypto;
  final url;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = $value $currency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

}

