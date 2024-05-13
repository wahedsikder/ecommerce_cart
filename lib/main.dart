import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFf2efef),
      ),
      title: 'Shopping Cart',
      home: MyBagPage(),
    );
  }
}

class MyBagPage extends StatefulWidget {

  @override
  _MyBagPageState createState() => _MyBagPageState();
}

class _MyBagPageState extends State<MyBagPage> {
  final List<Map<String, dynamic>> _items = [
    {'name': 'Casual T-Shirt', 'color': 'Black', 'size': 'L', 'price': 61, 'quantity': 1, 'image' : 1},
    {'name': 'V T-Shirt', 'color': 'Black', 'size': 'M', 'price': 50, 'quantity': 1, 'image' : 2},
    {'name': 'Oversized T-Shirt', 'color': 'Red', 'size': 'M', 'price': 48, 'quantity': 1, 'image' : 3},
  ];

  double get totalAmount => _items.fold(0, (total, item) => total + (item['price'] * item['quantity']));

  void updateQuantity(int index, int change) {
    setState(() {
      _items[index]['quantity'] += change;
      if (_items[index]['quantity'] == 5) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(20)),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Congratulation!', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(
                  height: 20,
                ),
                Text('You have added 5 ${_items[index]['name']} to your bag!', style: TextStyle(
                  fontSize: 20,
                ),),
              ],
            ),
            actions: [
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(239, 46)),
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text('OKAY'),
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  void checkout() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Congratulations! Your order has been placed.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bag', style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold
        ),),
        backgroundColor: Color(0xFFf2efef),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ListView.separated(
          itemCount: _items.length,
          itemBuilder: (context, index) {
            final item = _items[index];
            return Container(
              width: 343,
              height: 104,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: ListTile(
                leading: Image.asset('assets/images/${item['image']}.png'),
                title: Text(item['name'], style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text('Color: ', style: TextStyle(
                          color: Colors.grey
                        ),),
                        Text('${item['color']}  '),
                        Text('Size: ', style: TextStyle(
                          color: Colors.grey
                        ),),
                        Text('${item['size']}')
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            elevation: MaterialStateProperty.all(3),
                            shadowColor: MaterialStateProperty.all(Colors.black),
                          ),
                          icon: Icon(Icons.remove),
                          onPressed: () => updateQuantity(index, -1),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text('${item['quantity']}', style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),),
                        SizedBox(
                          width: 15,
                        ),
                        IconButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            elevation: MaterialStateProperty.all(3),
                            shadowColor: MaterialStateProperty.all(Colors.black),
                          ),
                          icon: Icon(Icons.add),
                          onPressed: () => updateQuantity(index, 1),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: Column(
                  children: [
                    Expanded(
                        child: IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
                    ),
                    Text(
                        '\$${_items[index]['price']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                    ),
                  ],
                ),
              ),
            );
          },
            separatorBuilder: (context, index) => SizedBox(
              height: 10,
            )
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total amount:', style: TextStyle(fontSize: 15, color: Colors.grey)),
                Text('\$$totalAmount', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(343, 48)),
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16)),
                ),
                onPressed: checkout, child: Text('CHECKOUT')
            )
          ],
        ),
      ),
    );
  }
}