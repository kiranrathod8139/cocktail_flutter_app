import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/Cocktail.dart';
import '../service/api_service.dart';

class CocktailPage extends StatefulWidget {
  const CocktailPage({super.key});
  @override
  _CocktailPageState createState() => _CocktailPageState();
}

class _CocktailPageState extends State<CocktailPage> {
   List<Cocktail> _cocktailList = [];
   

  @override
  void initState() {
    super.initState();
    _loadCocktails();
  }

  Future<void> _loadCocktails() async {
    var box = await Hive.openBox('cocktailList');
    List storedList = box.get('cocktails', defaultValue: []);

    if (storedList.isNotEmpty) {
      setState(() {
        _cocktailList = List<Cocktail>.from(
          storedList.map((e) => Cocktail.fromJson(Map<String, dynamic>.from(e)))
        );
      });
    } else {
      ApiService().fetchCocktails().then((cocktails) {
        setState(() {
          _cocktailList = cocktails;
        });
        _saveCocktails();
      }).catchError((e) {
       
        print(e);
      });
    }
  }

  void _saveCocktails() async {
    var box = await Hive.openBox('cocktailList');
    box.put(
      'cocktails', 
      _cocktailList.map((cocktail) => cocktail.toJson()).toList()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Cocktail List Page'),
      ),
      body:ReorderableListView(
        padding:const EdgeInsets.all(10),
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final item = _cocktailList.removeAt(oldIndex);
            _cocktailList.insert(newIndex, item);
          });
          _saveCocktails();
        },
        children: List.generate(
          _cocktailList.length, (index) {
            Cocktail cocktail = _cocktailList[index];
            return Container(
              key: Key(cocktail.idDrink!),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
              child: ListTile(
                title: Text(cocktail.strDrink!),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                  child: Image.network(
                    cocktail.strDrinkThumb!, 
                    width: 60, 
                    height: 60
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
