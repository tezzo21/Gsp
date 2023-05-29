import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:gsp/Controller/control.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({Key? key}) : super(key: key);

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(
      init: Controller(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Gossip"),
          ),
          body: ListView.builder(
            itemCount: _.talksList.length,
            itemBuilder: (context, index) => Dismissible(
              onDismissed: (direction) => _.deletData(_.talksList[index].id),
              background: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.delete, color: Colors.red),
                ],
              ),
              key: ValueKey(_.talksList[index].id),
              child: _.talksList.isNotEmpty
                  ? Card(
                      child: ListTile(
                        title: Text(_.talksList[index].Chat),
                        trailing: Checkbox(
                          onChanged: (value) =>
                              _.updateData(_.talksList[index].id, value),
                          value: _.talksList[index].Nature,
                        ),
                      ),
                    )
                  : Center(child: Text("No Talk")),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add_link_sharp),
            onPressed: () => showModalBottomSheet(
                context: context,
                builder: (context) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextField(controller: _taskController),
                          ElevatedButton(
                              onPressed: () => {
                                    _.addData(_taskController.text.trim()),
                                    Navigator.pop(context),
                                _taskController.clear(),
                                  },
                              child: Text("ADD"))
                        ],
                      ),
                    )),
          ),
        );
      },
    );
  }
}
