import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? getCityFromZip;
  late Future<String?> getCityfromZipFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(60.0),
                child: Column(children: [
                  const TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Postleitzahl"),
                  ),
                  const SizedBox(height: 32),
                  OutlinedButton(
                    onPressed: () async {
                      getCityFromZip = await getCityfromZipFuture;
                      FutureBuilder(
                          future: getCity(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.connectionState ==
                                    ConnectionState.done) {
                              return const Text(
                                  "Die Stadt zur Postleityahl ist: §{snapshot.data}");
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
                  Text(
                    "Ergebnis: Noch keine PLZ gesucht",
                    style: Theme.of(context).textTheme.labelLarge,
                  )
                ]))));
  }

  @override
  void dispose() {
    super.dispose();
    getCityfromZipFuture = getCityFromZip! as Future<String?>;
  }

  Future<String> getCityFromZipFuture(String zip) async {
    await Future.delayed(const Duration(seconds: 3));

    switch (zip) {
      case "10115":
        return 'Berlin';
      case "20095":
        return 'Hamburg';
      case "80331":
        return 'Muenchen';
      case "50667":
        return 'Koeln';
      case "60313":
        return 'Frankfurt am Main';
      default:
        return 'Unbekannte Stadt';
    }
  }
}

getCity() {}
