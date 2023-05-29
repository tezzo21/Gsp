import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:get/get.dart';
import 'package:gsp/amplifyconfiguration.dart';

import 'package:gsp/models/ModelProvider.dart';

class Controller extends GetxController {
  var talksList = <Talk>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
    _configureAmplify();

  }

  //condif amplify, it alsways run first

  Future<void> _configureAmplify() async {
    // Add the following lines to your app initialization to add the DataStore plugin
    final datastorePlugin =
        AmplifyDataStore(modelProvider: ModelProvider.instance);

    final api = AmplifyAPI();
    await Amplify.addPlugins([datastorePlugin, api]);

    //await Amplify.addPlugin(datastorePlugin);
   // await Amplify.addPlugins(AmplifyAPI() as List<AmplifyPluginInterface>);

    try {
      await Amplify.configure(amplifyconfig);
      readData();
    } on AmplifyAlreadyConfiguredException {
      print(
          'Tried to reconfigure Amplify; this can occur when your app restarts on Android.');
    }
  }


  //to read data from Aws
  Future<void> readData() async {
    try {
      talksList = RxList(await Amplify.DataStore.query(Talk.classType));
      update();
    } catch (e) {
      print("Could not readData DataStore: $e");
    }
  }


  //to add data to aws

  Future<void> addData(String? Chat) async {
      Talk _newTalk = Talk(Chat: Chat!, Nature: false);

      try{
      await Amplify.DataStore.save(_newTalk);
      readData();
    } on DataStoreException catch (e) {
        safePrint('Something went wrong saving model: ${e.message}');
    }
  }


  // to update the status of data in aws
  Future<void> updateData(String? id, bool? Nature) async {
    try {
      Talk _oldTalk = (await Amplify.DataStore.query(Talk.classType,
          where: Talk.ID.eq(id)))[0];
      Talk _newTalk = _oldTalk.copyWith(id: id!, Chat: _oldTalk.Chat, Nature: Nature!);

      await Amplify.DataStore.save(_newTalk);
      readData();
    } catch (e) {
      print("Could not updateData DataStore: $e");
    }
  }

  //to delete any dat
  Future<void> deletData(String? id) async {
    (await Amplify.DataStore.query(Talk.classType, where: Talk.ID.eq(id)))
        .forEach((element) async {
          try{
            await Amplify.DataStore.delete(element);
          }
          catch(e){
            print("deletData:,$e");
          }
    });
    readData();
  }
}
