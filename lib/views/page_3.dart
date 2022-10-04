import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:raft_assignment/controllers/filter_controller.dart';
import 'package:raft_assignment/controllers/geolocator_controller.dart';
import 'package:raft_assignment/views/widgets/app_button.dart';
import 'package:raft_assignment/views/widgets/loading_button.dart';

import '../data.dart';

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            GreetingsWidget(),
            SizedBox(height: 20),
            InternetConnectionStatusWidget(),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: GeoLocationWidget(),
            ),
            SizedBox(height: 20),
            ClearLocalDatabaseWidget()
          ],
        )
    );
  }

}



class GreetingsWidget extends StatelessWidget {
  const GreetingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Good ${DateTime.now().hour < 12 ? 'Morning' : DateTime.now().hour < 17 ? 'Afternoon' : 'Evening'}', style: Theme.of(context).textTheme.headline5);
  }

}



class InternetConnectionStatusWidget extends StatelessWidget {
  const InternetConnectionStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.active) {
          return Text('Connection   :   ${getConnectionStringBasedOnState(snapshot.data ?? ConnectivityResult.none)}');
        }
        else {
          return const Text('--');
        }
      },
    );
  }

  getConnectionStringBasedOnState(ConnectivityResult result) {
    switch(result) {
      case ConnectivityResult.bluetooth: return 'Bluetooth';
      case ConnectivityResult.wifi: return 'Wifi';
      case ConnectivityResult.ethernet: return 'Ethernet';
      case ConnectivityResult.mobile: return 'Mobile Data';
      case ConnectivityResult.none: return 'No internet connection';
      default: return 'Error';
    }
  }

}



class GeoLocationWidget extends StatefulWidget {

  const GeoLocationWidget({Key? key}) : super(key: key);

  @override
  State<GeoLocationWidget> createState() => _GeoLocationWidgetState();
}

class _GeoLocationWidgetState extends State<GeoLocationWidget> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), spreadRadius: 1, blurRadius: 3)]
      ),
      child: Center(
        child: GetX<GeoLocatorController>(
            init: GeoLocatorController(),
            builder: (controller) {
              return controller.myPos.value == null ? (isLoading == true ? const LoadingButton() : AppButton(title: 'Get my location', callback: getUserLocationCallback)) : Column(
                children: [
                  Text('My Location : (${controller.myPos.value?.latitude}, ${controller.myPos.value?.longitude})'),
                  const SizedBox(height: 10),
                  Text('Distance : ${(Geolocator.distanceBetween(controller.myPos.value!.latitude, controller.myPos.value!.longitude, controller.givenPos.latitude, controller.givenPos.longitude) / 1000).toStringAsFixed(2)} KM')
                ],
              );
            }
        ),
      ),
    );
  }

  getUserLocationCallback() async {

    setState(() { isLoading = true; });
    var status = await Geolocator.requestPermission();
    if(status == LocationPermission.denied) {
      Fluttertoast.showToast(msg: 'Location permission denied');
    }
    else if(status == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Location permission disabled, enable it from app settings');
      await Geolocator.openLocationSettings();
    }
    else if(status == LocationPermission.always || status == LocationPermission.whileInUse){
      Get.put(GeoLocatorController()).myPos.value = await Geolocator.getCurrentPosition();
    }
    setState(() { isLoading = true; });

  }

}



class ClearLocalDatabaseWidget extends StatelessWidget {
  const ClearLocalDatabaseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppButton(title: 'Clear Database', callback: clearDatabaseCallback);
  }

  clearDatabaseCallback() async {
    await DataRepository.apiBox.clear();
    await DataRepository.categoriesBox.clear();
    Get.put(FiltersController()).searchController.text = '';
    Get.put(FiltersController()).selectedCategories.value = [];
    Fluttertoast.showToast(msg: 'Local database cleared');
  }

}
