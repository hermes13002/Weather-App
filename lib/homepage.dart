// import 'dart:convert';

// import 'package:excweatherapp/model/weather_model.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:http/http.dart' as http;

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   TextEditingController locationController = TextEditingController();


//   Future<String> getCurrentCity() async{
//     // get permission from user
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied){
//       permission = await Geolocator.requestPermission();
//     }
//     // fetch the current location
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high
//     );
//     // convert the location into a list of placemark objects
//     List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
//     // extract the city name from the first placemark
//     String? city = placemarks[0].locality;
  
//     print(city);

//     print(position.latitude);

//     return city ?? "";
    
//   }

//   static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
//   String apiKey = "5bc1c678a5662a0ad445d915b6a4532f";

//   Future<Weather> getWeatherData(String cityName) async{
//     final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

//     if (response.statusCode == 200){
//       return Weather.fromJson(jsonDecode(response.body));
//     }else{
//       throw Exception('Failed to load data');
//     }
//   }

//   Weather? _weather;

//   _fetchWeatherData(location) async{
//     // String cityName = await getCurrentCity();
//     String cityName = location.isEmpty ? await getCurrentCity() : location;

//     final weather = await getWeatherData(cityName);
//       setState(() {
//         _weather = weather;
//       });
//   }

//   // weather images
//   String fetchWeatherImages(String? mainCondition){
//     if (mainCondition == null) return 'assets/image/sunny_cloud.png'; // default to sunny

//     switch (mainCondition.toLowerCase()) {
//       case 'clouds':
//         return 'assets/image/cloud.png';
//       case 'mist':
//       case 'smoke':
//       case 'haze':
//       case 'dust':
//       case 'fog':
//       case 'rain':
//         return 'assets/image/rain.png';
//       case 'drizzle':
//         return 'assets/image/shower_rain.png';
//       case 'shower rain':
//         return 'assets/image/shower_rain.png';
//       case 'thunderstorm':
//         return 'assets/image/thunderstorm.png';
//       case 'clear':
//         return 'assets/image/sunny_cloud.png';
//       default:
//         return '';
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _fetchWeatherData('');
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//          child: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment(0.8, 1),
//               colors: <Color>[
//                 Color(0xFF1e3c72),
//                 Color.fromARGB(255, 65, 89, 224),
//                 Color.fromARGB(255, 83, 92, 215),
//                 Color.fromARGB(255, 86, 88, 177),

//               ],
//               tileMode: TileMode.mirror,
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.only(top: 20, right: 12, left: 12, bottom: 0),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(
//                       width: 300,
//                       child: TextFormField(
//                         cursorColor: Colors.white,
//                         style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 17, color: Colors.white),
//                         controller: locationController,
//                         decoration: InputDecoration(
//                           labelText: 'Your Location',
//                           labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 17, color: Colors.white),
//                           enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1), borderRadius: BorderRadius.all(Radius.circular(30))),
//                           focusedBorder: const OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white, width: 1),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10,),
          
//                     InkWell(
//                       onTap: () {
//                         String location = locationController.text;
//                         _fetchWeatherData(location);
//                       },
//                       child: Container(
//                         width: 50,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(50)
//                         ),
//                         child: const Icon(Icons.search, color: Colors.blue,)
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 20),
          
//                 // current location, with longitude and latitude
//                 Center(child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(_weather?.cityName ?? "Loading city...", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 30, color: Colors.white),),
          
//                     const SizedBox(width: 20,),
          
//                     const Icon(Icons.location_on, color: Colors.white,),
//                     Text("Lat: ", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 17, color: const Color.fromRGBO(255, 255, 255, 1)),),
//                     Text(_weather?.latitude.round().toString() ?? "", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.white),),
//                     const SizedBox(width: 7,),
//                     Text("Long: ", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.white),),
//                     Text(_weather?.longitude.round().toString() ?? "", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.white),),
//                   ],
//                 )),
          
//                 const SizedBox(height: 20,),
//                 Center(child: Text(_weather?.description ?? 'Loading', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),)),
          
//                 // image of the current weather condition
//                 Image.asset(fetchWeatherImages(_weather?.mainCondition)),
          
//                 // current temperature
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(_weather?.temperature.round().toString() ?? "", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 55, color: Colors.white),),
//                     Text('°C', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 55, color: Colors.white),),
//                     const SizedBox(width: 20),
//                     Text(_weather?.mainCondition ?? "", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.white),),
//                   ],
//                 ),
          
//                 // other weather conditions
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     // humidity 
//                     Column(
//                       children: [
//                         const Icon(Icons.cloud, color: Colors.white),
//                         Row(
//                           children: [
//                             Text(_weather?.humidity.toString() ?? "", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),),
//                             Text("%", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),)
//                           ],
//                         ),
//                       ],
//                     ),

//                     // wind speed
//                     Column(
//                       children: [
//                         const Icon(Icons.air, color: Colors.white),
//                         Row(
//                           children: [
//                             Text(_weather?.windspeed.toString() ?? "", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),),
//                             Text(' km/h', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),),
//                           ],
//                         )
//                       ],
//                     ),

//                     // rain
//                     // Column(
//                     //   children: [
//                     //     const Icon(Icons.water_drop, color: Colors.white),
//                     //     // Text(_weather?.rain ?? "", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),)
//                     //   ],
//                     // )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }









import 'dart:convert';
import 'package:excweatherapp/model/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController locationController = TextEditingController();

  Future<String> getCurrentCity() async {
    // Get permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    // Fetch the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    // Convert the location into a list of placemark objects
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    // Extract the city name from the first placemark
    String? city = placemarks[0].locality;

    print(city);
    print(position.latitude);

    return city ?? "";
  }

  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  String apiKey = "5bc1c678a5662a0ad445d915b6a4532f";

  Future<Weather> getWeatherData(String cityName) async {
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Weather? _weather;

  Future<void> _fetchWeatherData(String location) async {
    String cityName = location.isEmpty ? await getCurrentCity() : location;

    final weather = await getWeatherData(cityName);
    setState(() {
      _weather = weather;
    });
  }

  // Weather images
  String fetchWeatherImages(String? mainCondition) {
    if (mainCondition == null) return 'assets/image/sunny_cloud.png'; // Default to sunny

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/image/cloud.png';
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'rain':
        return 'assets/image/rain.png';
      case 'drizzle':
        return 'assets/image/shower_rain.png';
      case 'shower rain':
        return 'assets/image/shower_rain.png';
      case 'thunderstorm':
        return 'assets/image/thunderstorm.png';
      case 'clear':
        return 'assets/image/sunny_cloud.png';
      default:
        return 'assets/image/sunny_cloud.png';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeatherData('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 1),
              colors: <Color>[
                Color(0xFF1e3c72),
                Color.fromARGB(255, 65, 89, 224),
                Color.fromARGB(255, 83, 92, 215),
                Color.fromARGB(255, 86, 88, 177),
              ],
              tileMode: TileMode.mirror,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        cursorColor: Colors.white,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.white,
                        ),
                        controller: locationController,
                        decoration: InputDecoration(
                          labelText: 'Your Location',
                          labelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: Colors.white,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        String location = locationController.text;
                        _fetchWeatherData(location);
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(Icons.search, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: _weather != null
                    ? buildWeatherContent()
                    : CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildWeatherContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // current location, with longitude and latitude
            Center(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_weather?.cityName ?? "Loading city...", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 30, color: Colors.white),),
      
                const SizedBox(width: 20,),
      
                const Icon(Icons.location_on, color: Colors.white,),
                Text("Lat: ", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 17, color: const Color.fromRGBO(255, 255, 255, 1)),),
                Text(_weather?.latitude.round().toString() ?? "", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.white),),
                const SizedBox(width: 7,),
                Text("Long: ", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.white),),
                Text(_weather?.longitude.round().toString() ?? "", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.white),),
              ],
            )),
      
            const SizedBox(height: 20,),
            Center(child: Text(_weather?.description ?? 'Loading', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),)),
      
            // image of the current weather condition
            Image.asset(fetchWeatherImages(_weather?.mainCondition)),
      
            // current temperature
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_weather?.temperature.round().toString() ?? "", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 55, color: Colors.white),),
                Text('°C', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 55, color: Colors.white),),
                const SizedBox(width: 20),
                Text(_weather?.mainCondition ?? "", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.white),),
              ],
            ),
      
            // other weather conditions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // humidity 
                Column(
                  children: [
                    const Icon(Icons.cloud, color: Colors.white),
                    Row(
                      children: [
                        Text(_weather?.humidity.toString() ?? "", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),),
                        Text("%", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),)
                      ],
                    ),
                  ],
                ),

                // wind speed
                Column(
                  children: [
                    const Icon(Icons.air, color: Colors.white),
                    Row(
                      children: [
                        Text(_weather?.windspeed.toString() ?? "", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),),
                        Text(' km/h', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),),
                      ],
                    )
                  ],
                ),

                // rain
                // Column(
                //   children: [
                //     const Icon(Icons.water_drop, color: Colors.white),
                //     // Text(_weather?.rain ?? "", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),)
                //   ],
                // )
              ],
            )
        ],
      ),
    );
  }
}

