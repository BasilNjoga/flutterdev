import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live Transport App',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(244, 224, 185, 1.0))),
      home: const MyHomePage(),
    );
  }
}



// ...

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const GeneratorPage();
        break;
      case 1:
        page = const MapsPage();
        break;
      case 2:
        page = const Placeholder();
        break;
      case 3:
        page = const Placeholder();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home,
                        color: Color.fromRGBO(46, 56, 64, 1.0)),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.place,
                        color: Color.fromRGBO(46, 56, 64, 1.0)),
                    label: Text('Maps'),
                  ),
                  NavigationRailDestination(
                      icon: Icon(Icons.update,
                          color: Color.fromRGBO(46, 56, 64, 1.0)),
                      label: Text('Activity')),
                  NavigationRailDestination(
                      icon: Icon(Icons.account_circle_outlined,
                          color: Color.fromRGBO(46, 56, 64, 1.0)),
                      label: Text('Account')),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    // var appState = context.watch<MyAppState>();
    final theme = Theme.of(context);
    final style = theme.textTheme.titleLarge!.copyWith(
      color: const Color.fromRGBO(46, 56, 64, 1.0),
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                "Public Transport Tracker",
                style: theme.textTheme.headlineMedium!,
              ),
            ),
          ),
          const Image(
            height: 200,
            image: AssetImage('images/city_bus.jpg'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Convenience and Comfort for Every Ride",
                textAlign: TextAlign.center,
                style: style,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {

  late GoogleMapController mapController;

  final LatLng sourceLocation =
      const LatLng(-1.0909771979474097, 37.01120191308141);
  final LatLng destination =
      const LatLng(-1.1248462242034525, 37.00324046871465);
  final String googleApiKey = "AIzaSyDA5GRgkanc2LJyzcmC62cZ9j82QgVjyKg";

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  void getCurrentLocation() {
    Location location = Location();

    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      polylineCoordinates = result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
      setState(() {});
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    getPolyPoints(); // Call getPolyPoints() after the map controller is initialized.
  }

  @override
  void initState() {
    getCurrentLocation();
    getPolyPoints();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:  const Text('Maps Sample App'),
        elevation: 2,
      ),
      body: currentLocation == null
          ? const Center(child: Text("loading"))
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 14.5,
              ),
              polylines: {
                Polyline(
                  polylineId: const PolylineId("route"),
                  points: polylineCoordinates,
                ),
              },
              markers: {
                Marker(
                  markerId: const MarkerId("currentLocation"),
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                ),
                Marker(
                    markerId: const MarkerId("source"),
                    position: sourceLocation),
                Marker(
                    markerId: const MarkerId("destination"),
                    position: destination),
              },
            ),
    );
  }
}


