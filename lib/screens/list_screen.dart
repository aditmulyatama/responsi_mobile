import 'package:flutter/material.dart';
import 'package:responsi_mobile/network/list_client.dart';
import 'package:responsi_mobile/model/matches_model.dart';
import 'package:responsi_mobile/model/base_network.dart';
import 'package:responsi_mobile/screens/detail_screens.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late Future<List<dynamic>> matches;
  @override
  void initState() {
    matches = BaseNetwork.getList('matches');
    super.initState();
  }

  // final MatchesListClient _matchList = MatchesListClient();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Pertandingan"),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: BaseNetwork.getList('matches'),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            var data = snapshot.data;
            return _buildSuccessSection(snapshot.data!);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return const Text("Error");
  }

  Widget _buildLoadingSection() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(List<dynamic> matches) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 48,
            itemBuilder: (context, index) {
              MatchesModel match = MatchesModel.fromJson(matches[index]);
              return InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return DetailScreens(id: match.id.toString());
                })),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Image.network(
                                    "https://countryflagsapi.com/png/${match.homeTeam!.name}"),
                                Text("${match.homeTeam!.name}")
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text("${match.homeTeam!.goals}"),
                          Text("  -  "),
                          Text("${match.awayTeam!.goals}"),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Image.network(
                                    "https://countryflagsapi.com/png/${match.awayTeam!.name}"),
                                Text("${match.awayTeam!.name}")
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
