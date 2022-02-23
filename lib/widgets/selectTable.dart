import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:resorapp/screens/cart_screen.dart';
import 'package:resorapp/widgets/customAppBar.dart';

class SelectTable extends StatefulWidget {
  @override
  _SelectTable createState() => _SelectTable();
}

class _SelectTable extends State<SelectTable> {
  int _currentIntValue = 10;
  int currentHorizontalIntValue = 1;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Table'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NumberPicker(
              value: currentHorizontalIntValue,
              minValue: 1,
              maxValue: 20,
              step: 1,
              itemHeight: 20,
              axis: Axis.horizontal,
              onChanged: (value) =>
                  setState(() => currentHorizontalIntValue = value),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black26),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () => setState(() {
                    final newValue = currentHorizontalIntValue - 1;
                    currentHorizontalIntValue = newValue.clamp(0, 20);
                  }),
                ),
                Text('Your Table is: $currentHorizontalIntValue'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => setState(() {
                    final newValue = currentHorizontalIntValue + 1;
                    currentHorizontalIntValue = newValue.clamp(0, 20);
                  }),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CartScreen(
                            tablenumber:
                                currentHorizontalIntValue)), //veriyi yolla unutma!!
                  );
                },
                child: Text('Select Table'))
          ],
        ),
      ),
    );
  }
}


class Coupon extends StatefulWidget {
  

  @override
  _CouponState createState() => _CouponState();
}

class _CouponState extends State<Coupon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}