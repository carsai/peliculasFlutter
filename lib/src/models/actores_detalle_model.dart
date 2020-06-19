class ActorDetalle {

  String birthday;
  String knownForDepartment;
  String deathday;
  int id;
  String name;
  List<dynamic> alsoKnownAs;
  int gender;
  String biography;
  double popularity;
  String placeOfBirth;
  String profilePath;
  bool adult;
  String imdbId;
  String homepage;

  ActorDetalle({
    this.birthday,
    this.knownForDepartment,
    this.deathday,
    this.id,
    this.name,
    this.alsoKnownAs,
    this.gender,
    this.biography,
    this.popularity,
    this.placeOfBirth,
    this.profilePath,
    this.adult,
    this.imdbId,
    this.homepage,
  });

  ActorDetalle.fromJsonMap(Map<String, dynamic> json) {
    birthday           = json['birthday'];
    knownForDepartment = json['known_for_department'];
    deathday           = json['deathday'];
    id                 = json['id'];
    name               = json['name'];
    alsoKnownAs        = json['also_known_as'];
    gender             = json['gender'];
    biography          = json['biography'];
    popularity         = json['popularity'];
    placeOfBirth       = json['place_of_birth'];
    profilePath        = json['profile_path'];
    adult              = json['adult'];
    imdbId             = json['imdb_id'];
    homepage           = json['homepage'];
  }
}
