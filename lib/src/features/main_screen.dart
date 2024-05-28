import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? zip;
  late Future<String?> getCityFromZipFuture;

  @override
  void initState() {
    super.initState();
    getCityFromZip(zip!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(children: [
            const TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Postleitzahl"),
            ),
            const SizedBox(height: 32),
            OutlinedButton(
              onPressed: () async {
                getCityFromZip = await getCityFromZipFuture;
                FutureBuilder(
                    future: getCityFromZip("10115"),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        return const Text(
                            "Die Stadt zu Postleitzahl ist §{snapshot.data}");
                      } else if (snapshot.connectionState !=
                          ConnectionState.done) {
                        return const CircularProgressIndicator();
                      } else {
                        return const Icon(Icons.error);
                      }
                    });
              },
              child: const Text("Suche"),
            ),
            const SizedBox(height: 32),
            Text("Ergebnis: Noch keine PLZ gesucht",
                style: Theme.of(context).textTheme.labelLarge),
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String> getCityFromZip(String zip) async {
    // simuliere Dauer der Datenbank-Anfrage
    await Future.delayed(const Duration(seconds: 3));

    switch (zip) {
      case "10115":
        return 'Berlin';
      case "20095":
        return 'Hamburg';
      case "80331":
        return 'München';
      case "50667":
        return 'Köln';
      case "60313":
        return 'Frankfurt am Main';
      default:
        return 'Unbekannte Stadt';
    }
  }
}
