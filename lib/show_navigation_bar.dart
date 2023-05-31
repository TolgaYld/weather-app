import 'package:flutter/material.dart';
import 'package:weatherapp/provider/weather_manager.dart';
import 'package:weatherapp/screens/favorites_screen.dart';
import 'package:weatherapp/screens/show_weather_screen.dart';

class ShowNavigationBar extends StatefulWidget {
  const ShowNavigationBar({super.key});

  @override
  State<ShowNavigationBar> createState() => _ShowNavigationBarState();
}

class _ShowNavigationBarState extends State<ShowNavigationBar> {
  int currentIndex = 0;

  List<Widget> screens = const [
    ShowWeatherScreen(),
    FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Weather-App"),
            IconButton(
              icon: Icon(
                Icons.search,
              ),
              onPressed: () async {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
            )
          ],
        ),
        centerTitle: true,
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        // type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.green,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.sunny),
            label: "Wetter",
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favoriten",
            backgroundColor: Colors.yellow,
          )
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchResults = [
    "Aachen",
    "Aalen",
    "Aberdeen",
    "Altenburg",
    "Ansbach",
    "Aschaffenburg",
    "Augsburg",
    "Amsterdam",
    "Ankara",
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, null);
    return FutureBuilder(
        future: WeatherManager.getWeather(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            close(context, null);
          }
          return Container();
        });
    // List<String> matchQuery = [];

    // for (int i = 0; i < searchResults.length; i++) {
    //   if (searchResults[i].toLowerCase().contains(query.toLowerCase())) {
    //     matchQuery.add(searchResults[i]);
    //   }
    // }
    // return ListView.builder(
    //     itemCount: matchQuery.length,
    //     itemBuilder: (context, index) {
    //       var result = matchQuery[index];
    //       return ListTile(
    //         title: Text(result),
    //       );
    //     });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return GestureDetector(
      onTap: () {
        close(context, null);
      },
      child: ListTile(
        title: Text(query),
      ),
    );
    // List<String> matchQuery = [];

    // for (int i = 0; i < searchResults.length; i++) {
    //   if (searchResults[i].toLowerCase().contains(query.toLowerCase())) {
    //     matchQuery.add(searchResults[i]);
    //   }
    // }
    // return ListView.builder(
    //     itemCount: matchQuery.length,
    //     itemBuilder: (context, index) {
    //       var result = matchQuery[index];
    //       return ListTile(
    //         title: Text(result),
    //       );
    //     });
  }
}
