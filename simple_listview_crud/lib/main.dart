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
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerNumber = TextEditingController();

  int selectedIndex = -1;
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
                        if (selectedIndex != -1) {
                          return;
                        }
                        _controllerName.text = "";
                        _controllerNumber.text = "";

                        contactList.add(Contact(name: name, number: number));
                      });
                    }
                  },
                  child: const Text(" Save "),
                ),
                ElevatedButton(
                  onPressed: () {
                    String name = _controllerName.text.trim();
                    String number = _controllerNumber.text.trim();
                    if (name.isNotEmpty && number.isNotEmpty) {
                      setState(() {
                        _controllerName.text = '';
                        _controllerNumber.text = '';
                        contactList[selectedIndex].name = name;
                        contactList[selectedIndex].number = number;
                        selectedIndex = -1;
                      });
                    }
                  },
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
            backgroundColor: (index % 2 == 0)
                ? Colors.blue
                : const Color.fromARGB(255, 2, 29, 52),
            child: Text(
              contactList[index].name[0].toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(contactList[index].name),
              Text(contactList[index].number)
            ],
          ),
          trailing: SizedBox(
            width: 70,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _controllerName.text = contactList[index].name;
                      _controllerNumber.text = contactList[index].number;
                      selectedIndex = index;
                    });
                  },
                  child: const Icon(Icons.edit),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      contactList.removeAt(index);
                    });
                  },
                  child: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ),
      );
}
