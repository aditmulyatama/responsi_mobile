class MatchesModel {
  final String? id;
  final String? venue;
  final String? location;
  final String? status;
  final String? stageName;
  final String? time;
  final TimeExtraInfo? timeExtraInfo;
  final HomeTeam? homeTeam;
  final AwayTeam? awayTeam;
  final List<Officials>? officials;
  final String? createdAt;
  final String? date;
  final String? updatedAt;
  final String? winner;

  MatchesModel({
    this.id,
    this.venue,
    this.location,
    this.status,
    this.stageName,
    this.time,
    this.timeExtraInfo,
    this.homeTeam,
    this.awayTeam,
    this.officials,
    this.createdAt,
    this.date,
    this.updatedAt,
    this.winner,
  });

  MatchesModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      venue = json['venue'] as String?,
      location = json['location'] as String?,
      status = json['status'] as String?,
      stageName = json['stageName'] as String?,
      time = json['time'] as String?,
      timeExtraInfo = (json['timeExtraInfo'] as Map<String,dynamic>?) != null ? TimeExtraInfo.fromJson(json['timeExtraInfo'] as Map<String,dynamic>) : null,
      homeTeam = (json['homeTeam'] as Map<String,dynamic>?) != null ? HomeTeam.fromJson(json['homeTeam'] as Map<String,dynamic>) : null,
      awayTeam = (json['awayTeam'] as Map<String,dynamic>?) != null ? AwayTeam.fromJson(json['awayTeam'] as Map<String,dynamic>) : null,
      officials = (json['officials'] as List?)?.map((dynamic e) => Officials.fromJson(e as Map<String,dynamic>)).toList(),
      createdAt = json['createdAt'] as String?,
      date = json['date'] as String?,
      updatedAt = json['updatedAt'] as String?,
      winner = json['winner'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'venue' : venue,
    'location' : location,
    'status' : status,
    'stageName' : stageName,
    'time' : time,
    'timeExtraInfo' : timeExtraInfo?.toJson(),
    'homeTeam' : homeTeam?.toJson(),
    'awayTeam' : awayTeam?.toJson(),
    'officials' : officials?.map((e) => e.toJson()).toList(),
    'createdAt' : createdAt,
    'date' : date,
    'updatedAt' : updatedAt,
    'winner' : winner
  };
}

class TimeExtraInfo {
  final String? current;
  final dynamic firstHalfTime;
  final dynamic firstHalfExtraTime;
  final dynamic secondHalfTime;
  final dynamic secondHalfExtraTime;

  TimeExtraInfo({
    this.current,
    this.firstHalfTime,
    this.firstHalfExtraTime,
    this.secondHalfTime,
    this.secondHalfExtraTime,
  });

  TimeExtraInfo.fromJson(Map<String, dynamic> json)
    : current = json['current'] as String?,
      firstHalfTime = json['firstHalfTime'],
      firstHalfExtraTime = json['firstHalfExtraTime'],
      secondHalfTime = json['secondHalfTime'],
      secondHalfExtraTime = json['secondHalfExtraTime'];

  Map<String, dynamic> toJson() => {
    'current' : current,
    'firstHalfTime' : firstHalfTime,
    'firstHalfExtraTime' : firstHalfExtraTime,
    'secondHalfTime' : secondHalfTime,
    'secondHalfExtraTime' : secondHalfExtraTime
  };
}

class HomeTeam {
  final String? country;
  final int? goals;
  final String? name;
  final int? penalties;

  HomeTeam({
    this.country,
    this.goals,
    this.name,
    this.penalties,
  });

  HomeTeam.fromJson(Map<String, dynamic> json)
    : country = json['country'] as String?,
      goals = json['goals'] as int?,
      name = json['name'] as String?,
      penalties = json['penalties'] as int?;

  Map<String, dynamic> toJson() => {
    'country' : country,
    'goals' : goals,
    'name' : name,
    'penalties' : penalties
  };
}

class AwayTeam {
  final String? country;
  final int? goals;
  final String? name;
  final int? penalties;

  AwayTeam({
    this.country,
    this.goals,
    this.name,
    this.penalties,
  });

  AwayTeam.fromJson(Map<String, dynamic> json)
    : country = json['country'] as String?,
      goals = json['goals'] as int?,
      name = json['name'] as String?,
      penalties = json['penalties'] as int?;

  Map<String, dynamic> toJson() => {
    'country' : country,
    'goals' : goals,
    'name' : name,
    'penalties' : penalties
  };
}

class Officials {
  final String? name;
  final String? role;
  final String? country;

  Officials({
    this.name,
    this.role,
    this.country,
  });

  Officials.fromJson(Map<String, dynamic> json)
    : name = json['name'] as String?,
      role = json['role'] as String?,
      country = json['country'] as String?;

  Map<String, dynamic> toJson() => {
    'name' : name,
    'role' : role,
    'country' : country
  };
}