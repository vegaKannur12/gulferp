import 'package:flutter/material.dart';
import 'package:gulferp/controller/controller.dart';
import 'package:provider/provider.dart';

class DynamicPage extends StatefulWidget {
  const DynamicPage({Key? key}) : super(key: key);

  @override
  State<DynamicPage> createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> {
  static const List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];
  final List<String> names = <String>[
    'Aby',
    'Aish',
    'Ayan',
    'Ben',
    'Bob',
    'Charlie',
    'Cook',
    'Carline'
  ];
  final List<int> msgCount = <int>[2, 0, 10, 6, 52, 4, 0, 2];

  TextEditingController nameController = TextEditingController();
  void addItemToList() {
    setState(() {
      names.insert(0, nameController.text);
      msgCount.insert(0, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: size.height * 0.04,
                width: size.width * 0.6,
                child: Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    }
                    return _kOptions.where((String option) {
                      return option
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  onSelected: (String selection) {
                    debugPrint('You just selected $selection');
                    Provider.of<Controller>(context, listen: false).selecttext =
                        selection;
                  },
                ),
              ),
              SizedBox(
                width: size.width * 0.03,
              ),
              ElevatedButton(
                onPressed: () {
                  addItemToList();
                  print(
                      "${Provider.of<Controller>(context, listen: false).selecttext}");
                },
                child: Text("Add"),
              )
            ],
          ),
          SizedBox(
            height: size.height * 0.5,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(top: 90),
            child: Provider.of<Controller>(context, listen: false).selecttext ==
                    null
                ? Container(
                    child: Text("no data"),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: names.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        margin: EdgeInsets.all(2),
                        color: msgCount[index] >= 10
                            ? Colors.blue[400]
                            : msgCount[index] > 3
                                ? Colors.blue[100]
                                : Colors.grey,
                        child: Center(
                            child: Text(
                          '${names[index]} (${msgCount[index]})',
                          style: TextStyle(fontSize: 18),
                        )),
                      );
                    }),
          ))
        ],
      ),
    );
  }
}
