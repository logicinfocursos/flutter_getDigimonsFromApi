class Digimon {
  String? name;
  String? img;
  String? level;

  Digimon({this.name, this.img, this.level});

  get getName => this.name;

  set setName(name) => this.name = name;

  get getImg => this.img;

  set setImg(img) => this.img = img;

  get getLevel => this.level;

  set setLevel(level) => this.level = level;
}
