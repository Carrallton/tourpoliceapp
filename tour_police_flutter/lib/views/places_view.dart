import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tour_police_flutter/models/place_model.dart';
import 'package:tour_police_flutter/services/places_service.dart';
import 'package:geolocator/geolocator.dart';

class PlacesView extends StatefulWidget {
  const PlacesView({super.key});

  @override
  State<PlacesView> createState() => _PlacesViewState();
}

class _PlacesViewState extends State<PlacesView> {
  late Future<List<PlaceModel>> _placesFuture;
  LatLng? _userLocation;

  @override
  void initState() {
    super.initState();
    _placesFuture = PlacesService().getPlaces();
    getLocation();
  }

  Future<void> getLocation() async {
    try {
      // Проверка, включена ли служба геолокации
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Геолокация отключена')),
        );
        return;
      }

      // Проверка разрешений
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Разрешение на геолокацию отклонено')),
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Доступ к геолокации заблокирован')),
        );
        return;
      }

      // Получаем позицию
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _userLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print("Ошибка получения местоположения: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось получить ваше местоположение')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Интересные места'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<PlaceModel>>(
        future: _placesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет данных о местах'));
          }

          List<PlaceModel> places = snapshot.data!;

          return FlutterMap(
            mapController: MapController(),
            options: MapOptions(
              initialCenter: _userLocation ?? LatLng(55.7558, 37.6173), // Москва по умолчанию
              initialZoom: 12.0,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  ..._buildPlaceMarkers(places),
                  if (_userLocation != null)
                    Marker(
                      width: 40,
                      height: 40,
                      point: _userLocation!,
                      child: GestureDetector(
                        onTap: () {
                          print("Нажато на ваше местоположение");
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          child: Icon(Icons.my_location, color: Colors.blue),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  List<Marker> _buildPlaceMarkers(List<PlaceModel> places) {
    return places.map((place) {
      return Marker(
        width: 40,
        height: 40,
        point: LatLng(place.latitude, place.longitude),
        child: GestureDetector(
          onTap: () {
            print('Нажато на место: ${place.name}');
          },
          child: Container(
            padding: EdgeInsets.all(4),
            child: Icon(Icons.place, color: Colors.green),
          ),
        ),
      );
    }).toList();
  }
}