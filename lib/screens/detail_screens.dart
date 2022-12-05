import 'package:drop_shadow/drop_shadow.dart';
import 'package:responsi_mobile/model/base_network.dart';
import 'package:responsi_mobile/model/detail_matches_model.dart';
import 'package:flutter/material.dart';

class DetailScreens extends StatefulWidget {
  const DetailScreens({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<DetailScreens> createState() => _DetailScreensState();
}

class _DetailScreensState extends State<DetailScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Match Id : ${widget.id}')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: BaseNetwork.get("matches/${widget.id}"),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            DetailMatchesModel match =
                DetailMatchesModel.fromJson(snapshot.data!);
            return _buildSuccessSection(match);
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

  Widget _buildSuccessSection(DetailMatchesModel detailMatch) {
    var homeAccuracy = detailMatch.homeTeam!.statistics!.passesCompleted! /
        detailMatch.homeTeam!.statistics!.passes! *
        100;
    var awayAccuracy = detailMatch.awayTeam!.statistics!.passesCompleted! /
        detailMatch.awayTeam!.statistics!.passes! *
        100;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      DropShadow(
                        blurRadius: 10,
                        offset: const Offset(3, 3),
                        spread: 1,
                        child: Image.network(
                            "https://countryflagsapi.com/png/${detailMatch.homeTeam!.name}"),
                      ),
                      Text(detailMatch.homeTeam!.name.toString()),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "${detailMatch.homeTeam!.goals}  -  ${detailMatch.awayTeam!.goals}",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    children: [
                      DropShadow(
                        blurRadius: 10,
                        offset: const Offset(3, 3),
                        spread: 1,
                        child: Image.network(
                            "https://countryflagsapi.com/png/${detailMatch.awayTeam!.name}"),
                      ),
                      Text(detailMatch.awayTeam!.name.toString()),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text("Stadium : ${detailMatch.venue}"),
            Text("Location : ${detailMatch.location}"),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black87)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Statistic",
                        style: TextStyle(fontSize: 30),
                      ),
                      statText(
                          "Ball Possesion",
                          detailMatch.homeTeam!.statistics!.ballPossession
                              .toString(),
                          detailMatch.awayTeam!.statistics!.ballPossession
                              .toString()),
                      statText(
                          "Shot",
                          detailMatch.homeTeam!.statistics!.attemptsOnGoal
                              .toString(),
                          detailMatch.awayTeam!.statistics!.attemptsOnGoal
                              .toString()),
                      statText(
                          "Shot on goal",
                          detailMatch.homeTeam!.statistics!.kicksOnTarget
                              .toString(),
                          detailMatch.awayTeam!.statistics!.kicksOnTarget
                              .toString()),
                      statText(
                          "Corners",
                          detailMatch.homeTeam!.statistics!.corners.toString(),
                          detailMatch.awayTeam!.statistics!.corners.toString()),
                      statText(
                          "Offside",
                          detailMatch.homeTeam!.statistics!.offsides.toString(),
                          detailMatch.awayTeam!.statistics!.offsides
                              .toString()),
                      statText(
                          "Fouls",
                          detailMatch.homeTeam!.statistics!.foulsCommited
                              .toString(),
                          detailMatch.awayTeam!.statistics!.foulsCommited
                              .toString()),
                      statText("Pass Accuracy", "${homeAccuracy.ceil()}%",
                          "${awayAccuracy.ceil()}%"),
                    ]),
              ),
            ),
            Text(
              "Referees",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: detailMatch.officials!.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black87)),
                    child: Column(children: [
                      Expanded(
                        child: Image.network(
                            "https://img.inews.co.id/media/822/files/inews_new/2022/10/21/pierluigi_collina_wasit_terbaik_dalam_sejarah_sep.jpg"),
                      ),
                      Text(detailMatch.officials![index].name.toString()),
                      Text(detailMatch.officials![index].role.toString()),
                    ]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget statText(String statistic, String dataHome, String dataAway) {
    return Column(
      children: [
        Text(statistic),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text(dataHome), Text("-"), Text(dataAway)],
        )
      ],
    );
  }
}
