import 'package:covid19trackerapp/Services/state_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      appBar: AppBar(
        title: Text("Country List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.normal,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontFamily: "QuicksandMedium",
              ),
              decoration: InputDecoration(
                hintText: 'Search with country name',
                hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
                errorStyle: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontFamily: "QuicksandRegular",
                  color: Colors.red,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.white),
                                  title: Container(
                                      height: 10,
                                      width: 80,
                                      color: Colors.white),
                                  subtitle: Container(
                                      height: 10,
                                      width: 80,
                                      color: Colors.white),
                                )
                              ],
                            ),
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100);
                      });
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag'])),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(
                                  snapshot.data![index]['cases'].toString()),
                            )
                          ],
                        );
                      });
                }
              },
              future: stateServices.countriesListApi(),
            ))
          ],
        ),
      ),
    );
  }
}
