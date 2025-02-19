
import 'package:json_annotation/json_annotation.dart';
part '../generated/Cocktail.g.dart';


@JsonSerializable()
class Cocktail {
  String? idDrink;
  String? strDrink;
  String? strCategory;
  String? strAlcoholic;
  String? strGlass;
  String? strInstructions;
  String? strInstructionsDE;
  String? strInstructionsIT;
  String? strDrinkThumb;
  String? strIngredient1;
  String? strIngredient2;
  String? strIngredient3;
  String? strIngredient4;
  String? strIngredient5;
  String? strMeasure1;
  String? strMeasure2;
  String? strMeasure3;
  String? strMeasure4;
  String? strMeasure5;
  String? strCreativeCommonsConfirmed;
  String? dateModified;

  Cocktail({
    this.idDrink,
    this.strDrink,
    this.strCategory,
    this.strAlcoholic,
    this.strGlass,
    this.strInstructions,
    this.strInstructionsDE,
    this.strInstructionsIT,
    this.strDrinkThumb,
    this.strIngredient1,
    this.strIngredient2,
    this.strIngredient3,
    this.strIngredient4,
    this.strIngredient5,
    this.strMeasure1,
    this.strMeasure2,
    this.strMeasure3,
    this.strMeasure4,
    this.strMeasure5,
    this.strCreativeCommonsConfirmed,
    this.dateModified,
  });

 
  factory Cocktail.fromJson(Map<String, dynamic> json) => _$CocktailFromJson(json);
  Map<String, dynamic> toJson() => _$CocktailToJson(this);
}