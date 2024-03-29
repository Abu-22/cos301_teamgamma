import 'dart:math';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/material.dart';
import '../../core/viewmodels/collection_model.dart';
import 'base_view.dart';
import '../widgets/bottom_navigation.dart';

class CollectionView extends StatefulWidget {
  @override
  _CollectionState createState() => _CollectionState();
}

class _CollectionState extends State<CollectionView> {
  int _currentTabIndex = 1;

  @override
   Widget build(BuildContext context) {
    BottomNavigation bottomNavigation = new BottomNavigation();
    bottomNavigation.setIndex(_currentTabIndex);

    return BaseView<CollectionModel>(
      builder: (context, model, child) => Scaffold(
        body: Scaffold(
          body: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              MouthNavigationBar(),
              // CollectionTitle(),
              Expanded(child: CollectionSearchBar()),
              /* MouthCard(),
              MouthCard(),
              MouthCard(), */
            ],
          ), 
        ),
        bottomNavigationBar: BottomNavigation(),
      ),
    );
  }
}

class MouthNavigationBar extends StatefulWidget {
  @override
  _MouthNavigationBarState createState() => _MouthNavigationBarState();
}

class _MouthNavigationBarState extends State<MouthNavigationBar>  {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF303030),
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "collection");
                },
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: 10, // space between underline and text
                  ),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(
                        color: Color(0xFF8ACDEF),  // Text colour here
                        width: 3.0, // Underline width
                      ))
                  ),

                  child: Text(
                    "My Collection",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF8ACDEF),
                      fontFamily: 'Arciform',  // Text colour here
                    ),
                  ),
                ),
              ),
              new GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "mouth-selection");
                },
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: 10, // space between underline and text
                  ),
                  child: Text(
                    "Customise Mouth",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'Arciform',  // Text colour here
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Expanded(child: CollectionSearchBar()),
        ],
      ),
    );
  }
}

class SearchItem {  
  final String imgSrc;
  final String title;
  final String creator;
  final String date;
  final String totalImages;
  final String rating;

  SearchItem(this.imgSrc, this.title, this.creator, this.date, this.totalImages, this.rating);
}

class CollectionSearchBar extends StatefulWidget {
  @override
  _CollectionSearchBarState createState() => _CollectionSearchBarState();
}

class _CollectionSearchBarState extends State<CollectionSearchBar> {
  final SearchBarController<SearchItem> _searchBarController = SearchBarController();

  Future<List<SearchItem>> _getAllSearchItems(String text) async {
    await Future.delayed(Duration(seconds: text.length == 4 ? 10 : 1));

    List<SearchItem> searchItems = [];

    for (int i = 0; i < 3; i++) {
      searchItems.add(SearchItem('assets/images/mouth-packs/mouth-1.png', "Vampire Pack 1", "Peter Davie", "2020/03/01", "24", "4.5"));
    }
    return searchItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SearchBar<SearchItem>(
          searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
          headerPadding: EdgeInsets.symmetric(horizontal: 10),
          listPadding: EdgeInsets.symmetric(horizontal: 0),
          onSearch: _getAllSearchItems,
          searchBarController: _searchBarController,
          hintText: "Search...",
          placeHolder: MouthCard('assets/images/mouth-packs/mouth-1.png', "Vampire Pack 1", "Peter Davie", "2020/03/01", "24", "4.5"), // Collection list
          emptyWidget: Text("empty"),
          indexedScaledTileBuilder: (int index) => ScaledTile.count(1, index.isEven ? 2 : 1),
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          crossAxisCount: 1,
          onItemFound: (SearchItem searchItem, int index) {
            return Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              // height: 330.0,
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                primary: false,
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.all(0.0),
                    sliver: SliverGrid.count(
                      crossAxisSpacing: 0.0,
                      crossAxisCount: 1,
                        children: List.generate(5, (index) {
                          return MouthCard(searchItem.imgSrc, searchItem.title, searchItem.creator, searchItem.date, searchItem.totalImages, searchItem.rating);
                        }),
                    ),
                  ),
                ], 
              ),
            );
          },
        ),
      ),
    );
  }
}

class MouthCard extends StatefulWidget {
  final String imgSrc;
  final String title;
  final String creator;
  final String date;
  final String totalImages;
  final String rating;

  MouthCard(this.imgSrc, this.title, this.creator, this.date, this.totalImages, this.rating);

  @override
  _MouthCardState createState() => _MouthCardState(this.imgSrc, this.title, this.creator, this.date, this.totalImages, this.rating);
}

class _MouthCardState extends State<MouthCard> {
  final String imgSrc;
  final String title;
  final String creator;
  final String date;
  final String totalImages;
  final String rating;

  _MouthCardState(this.imgSrc, this.title, this.creator, this.date, this.totalImages, this.rating);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 3, 10, 3),
      height: 80,
      child: new GestureDetector(
        onTap: (){
          print('pressed card');
        },
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      color: Color(0xFF8ACDEF),
                      width: 80,
                      height: 80,
                      child: new Image.asset(
                        imgSrc,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10),),
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        title,
                                      ),
                                    ),
                                    Text(
                                      creator,
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              new GestureDetector(
                                onTap: (){
                                  print('pressed download');
                                },
                                child: Icon(
                                  Icons.file_download,
                                ),
                              ),
                              new GestureDetector(
                                onTap: (){
                                  print('pressed delete');
                                },
                                child: Icon(
                                  Icons.delete_outline,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  date,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              new BulletPoint(),
                              Container(
                                child: Text(
                                  totalImages + " images",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              new BulletPoint(),
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                                child: Text(
                                  rating + '/5',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  decoration: new BoxDecoration(boxShadow: [
                    new BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                      offset: Offset(
                        4.0, // Move to right 10  horizontally
                        5.0, // Move to bottom 10 Vertically
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}

class BulletPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Text(
      '•',
    );
  }
}