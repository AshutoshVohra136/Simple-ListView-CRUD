import 'package:flutter/material.dart';
import 'package:simple_listview_crud/model/contact.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    home: const HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Contact> contactList = List.empty(growable: true);
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(' Contact App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _controllerName,
              decoration: const InputDecoration(
                hoverColor: Colors.red,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                hintText: 'Enter Name',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _controllerNumber,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: const InputDecoration(
                hoverColor: Colors.red,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                hintText: 'Enter Contact',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    String name = _controllerName.text.trim();

                    String number = _controllerNumber.text.trim();

                    if (name.isNotEmpty && number.isNotEmpty) {
                      setState(() {
                        _controllerName.text = "";
                        _controllerNumber.text = "";

                        contactList.add(Contact(name: name, number: number));
                      });
                    }
                  },
                  child: const Text(" Save "),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(" Update "),
                ),
              ],
            ),
            contactList.isEmpty
                ? const Text(
                    "No Contacts Yet",
                    style: TextStyle(fontSize: 20),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: contactList.length,
                        itemBuilder: (context, index) => myWidget(index)),
                  )
          ],
        ),
      ),
    );
  }

  Widget myWidget(int index) => Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(contactList[index].name[0].toUpperCase()),
          ),
          title: Column(
            children: [
              Text(contactList[index].name),
              Text(contactList[index].number)
            ],
          ),
        ),
      );
}
