import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_together/custom_rect_tween.dart';
import 'package:tennis_together/fakeMatchs.dart';
import 'package:tennis_together/provider/filter_notifier.dart';
import 'package:tennis_together/provider/page_notifier.dart';
import 'package:tennis_together/styles.dart';

import 'drop_down_menu.dart';
import 'hero_dialog_route.dart';
import 'match_filter_options.dart';
import 'models.dart';

class MatchListPage extends Page {
  static final pageName = 'MySchedulePage';

  // var fo = Singleton;

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(settings: this, builder: (context) => MatchList());
  }
}

class MatchList extends StatefulWidget {
  // MatchList({Key key}) : super(key: key);
  static const String pageName = 'MatchList';

  String get _pageName => pageName;

  @override
  _MatchListState createState() => _MatchListState();
}

class _MatchListState extends State<MatchList> {

  //오늘 날짜, 거주지역에 해당하는 경기일정을 우선 가져
  var filterOptions = List.of(IntType.values);
  final items = List.generate(1000, (index) => '$index');

  List<int> top = <int>[];
  List<int> bottom = <int>[0];

  late final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    print('_MatchListState');
    UniqueKey _accKey = UniqueKey();
    // return Consumer2<FilterNotifier, PageNotifier>(builder: (context, FilterNotifier,PageNotifier, child) {
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            // Add the app bar to the CustomScrollView.
            _BuildSilverAppBar(),
            // Next, create a SliverList
            _BuildSilverBody(),
          ],
        ),
      );
    // });
  }

  SliverAppBar _BuildSilverAppBar() {
    print('_BuildSilverAppBar');
    return SliverAppBar(
      backgroundColor: AppColors.backgroundColor,
      // Provide a standard title.
      // title: Text('title'),
      // Allows the user to reveal the app bar if they begin scrolling
      // back up the list of items.
      // floating: true,
      // Display a placeholder widget to visualize the shrinking size.
      pinned: true,
      flexibleSpace: //Placeholder(),
          _BuildFlexibleSpaceBar(),
      // Make the initial height of the SliverAppBar larger than normal.
      expandedHeight: 200,
      bottom: _BuildAppBarBottom(),
    );
  }

  SliverList _BuildSilverBody() {
    print('_BuildSilverBody');
    Todo a = Todo(
      memberCapacity: 3,
      host: UserData(
          uid: 'test_uid',
          email: 'a@a.com',
          nickName: 'ttt',
          location: '서울시 서초구',
          selfIntro: '하이요',
          ntrp: 4.0,
          gender: '남'),
      starttime: DateTime.parse("2021-07-20 20:00:00Z"),
      endtime: DateTime.parse("2021-07-20 22:00:00Z"),
      location: '시민의숲 테니스장',
      id: 'test_id',
      description: 'hihi',
    );
    List<Todo> _todos = [
      a,
      a,
      a,
      a,
      a,
    ];
    return SliverList(
      // Use a delegate to build items as they're scrolled on screen.
      delegate: SliverChildBuilderDelegate(
        // The builder function returns a ListTile with a title that
        // displays the index of the current item.
        (context, index) =>
            //_TodoListContent(todos: _todos,),
            //     Container(
            //   alignment: Alignment.center,
            //   color: Colors.green[200 + top[index] % 4 * 100],
            //   height: 100 + top[index] % 4 * 20.0,
            //   child: Text('Item: ${top[index]}'),
            // ),
            _TodoCard(todo: _todos[index]),

        // ListTile(title: Text('Item #$index')),
        // Builds 1000 ListTiles
        childCount: _todos.length, //   //   IconButton(
        //   //     icon: Icon(Icons.add),
        //   //     tooltip: 'Wow',
        //   //     onPressed: () => {},
      ),
    );
  }

  FlexibleSpaceBar _BuildFlexibleSpaceBar() {
    return FlexibleSpaceBar(
      stretchModes: const <StretchMode>[
        StretchMode.zoomBackground,
        StretchMode.blurBackground,
        StretchMode.fadeTitle,
      ],
      centerTitle: true,
      // title: const Text('Flight Report'),
      background: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Image.network(
          //   'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
          //   fit: BoxFit.cover,
          // ),
          Image.asset(
            'assets/bg_tennis.jpeg',
            fit: BoxFit.cover,
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.0, 0.5),
                end: Alignment.center,
                colors: <Color>[
                  Color(0x60000000),
                  Color(0x00000000),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return Scrollbar(
      // second question
      child: ListView.builder(
        // shrinkWrap:,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          if (filterOptions.any((option) => option.length == item.length)) {
            return ListTile(title: Text(item));
          }

          return Container(height: 0.0001); // first question
        },
      ),
    );
  }

  PreferredSizeWidget _BuildAppBarBottom() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(10),
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(children: [
            // Row(
            //   children:
            //   IntType.values.map((option) {
            //     return Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 4),
            //       child: FilterChip(
            //         selectedColor: Colors.white,
            //         selected: filterOptions.contains(option),
            //         onSelected: (isSelected) {
            //           setState(() {
            //             if (isSelected) {
            //               filterOptions.add(option);
            //             } else {
            //               filterOptions.remove(option);
            //             }
            //           });
            //         },
            //         label: Text(option.name),
            //       ),
            //     );
            //   }).toList(),
            // ),
            // const _FilterButton(),
            _filterBtn_ntrp(),
            IconButton(
              icon: const Icon(Icons.add_outlined),
              onPressed: () {
                setState(() {
                  top.add(-top.length - 1);
                  bottom.add(bottom.length);
                });
              },
            ),
          ])),
    );
  }
}

class _TodoListContent extends StatelessWidget {
  const _TodoListContent({
    Key? key,
    required this.todos,
  }) : super(key: key);

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    // print('build_');
    // print(todos[0].memberCapacity);
    // print(todos.length);
    return ListView.builder(
      itemCount: todos.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final _todo = todos[index];
        return _TodoCard(todo: _todo);
      },
    );
  }
}

class IntType {
  static const IntType ones = IntType._('Ones', 1);
  static const IntType tens = IntType._('Tens', 2);
  static const IntType hundreds = IntType._('Hundreds', 3);

  final String name;
  final int length;

  const IntType._(this.name, this.length);

  static const values = [
    IntType.ones,
    IntType.tens,
    IntType.hundreds,
  ];
}
//
// Card buildCard() {
//   var heading = '\$2300 per month';
//   var subheading = '2 bed, 1 bath, 1300 sqft';
//   var cardImage =
//       NetworkImage('https://source.unsplash.com/random/800x600?house');
//   var supportingText =
//       'Beautiful home to rent, recently refurbished with modern appliances...';
//   return Card(
//       elevation: 4.0,
//       child: Row(children: [
//         SizedBox(
//           height: 30,
//           width: 30,
//           child: Text('sdf'),
//         ),
//         Column(
//           children: [
//             ListTile(
//               title: Text(heading),
//               subtitle: Text(subheading),
//               // trailing: Icon(Icon.favorite_outline),
//             ),
//             // Container(
//             //   height: 200.0,
//             //   child: Ink.image(
//             //     image: cardImage,
//             //     fit: BoxFit.cover,
//             //   ),
//             // ),
//             Container(
//               padding: EdgeInsets.all(16.0),
//               alignment: Alignment.centerLeft,
//               child: Text(supportingText),
//             )
//             // ButtonBar(
//             //   children: [
//             //     TextButton(
//             //       child: const Text('CONTACT AGENT'),
//             //       onPressed: () {/* ... */},
//             //     ),
//             //     TextButton(
//             //       child: const Text('LEARN MORE'),
//             //       onPressed: () {/* ... */},
//             //     )
//             //   ],
//             // )
//           ],
//         )
//       ]));
// }

class _filterBtn_datetime extends StatefulWidget {
  @override
  _filterBtn_datetimeState createState() => _filterBtn_datetimeState();
}

class _filterBtn_datetimeState extends State<_filterBtn_datetime> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _filterBtn_ntrp extends StatefulWidget {
  @override
  _filterBtn_ntrpState createState() => _filterBtn_ntrpState();
}

class _filterBtn_ntrpState extends State<_filterBtn_ntrp> {
  refresh(){
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    RangeValues? rv = Provider.of<FilterNotifier>(context, listen: false).currentRangeValues;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          HeroDialogRoute(
            builder: (context) => Center(
              child: _FilterButtonPopup2(notifyParent: refresh,),
            ),
            settings: RouteSettings(),
          ),
        );
      },
      child: Hero(
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin, end: end);
        },
        tag: 'filter_button_tag',
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.sp,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  rv == null ? 'Filter' : 'NTRP : ${rv.start.toStringAsFixed(1)}-${rv.end.toStringAsFixed(1)}',
                  style: TextStyle(color: Colors.black),
                ),
                Icon(Icons.keyboard_arrow_down),
              ]),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}

class _FilterButtonPopup2 extends StatefulWidget {
  static String pageName = '_FilterButtonPopup';
  String get _pageName => pageName;

  final Function() notifyParent;
  _FilterButtonPopup2({Key? key, required this.notifyParent}) : super(key: key);

  @override
  _FilterButtonPopupState2 createState() => _FilterButtonPopupState2(notifyParent:notifyParent);
}

class _FilterButtonPopupState2 extends State<_FilterButtonPopup2> {
  final Function() notifyParent;
  _FilterButtonPopupState2({Key? key, required this.notifyParent});

  bool _isFirst = true;
  RangeValues _currentRangeValues = const RangeValues(2.0,3.5);// : tmp;

  @override
  Widget build(BuildContext context) {
    print('_FilterButtonPopupState ${_currentRangeValues.start}_${_currentRangeValues.end}');
    RangeValues tmp =  Provider.of<FilterNotifier>(context, listen: false).currentRangeValues;
    print('tmp ${tmp.start}_${tmp.end}');

    return Hero(
      tag: 'filter_button_tag',
      createRectTween: (begin, end) {
        return CustomRectTween(begin: begin, end: end);
      },
      // child: Padding(
      //   padding: const EdgeInsets.all(50.0),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.cardColor,
        child: SizedBox(
          height: 130,
          width: 300,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(children: [
              Row(children: [
                Text('NTRP : '),
                RangeSlider(
                  values: _currentRangeValues,
                  max: 7.0,
                  min: 1.0,
                  divisions: 12,
                  labels: RangeLabels(
                    _currentRangeValues.start.toStringAsFixed(1),
                    _currentRangeValues.end.toStringAsFixed(1),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                      // _isFirst=false;
                    });
                  },
                ),
              ]),
              ElevatedButton(
                  onPressed: () {
                    print('btn');
                    Provider.of<FilterNotifier>(context, listen: false).SetNtrpRange(_currentRangeValues);
                    // _isFirst = false;
                    // Provider.of<PageNotifier>(context, listen: false).refreshPage();
                    notifyParent();
                    Navigator.pop(context);
                  },
                  child: Text('적용하기'))
            ]),
            // ),
          ),
        ),
      ),
    );
  }
}






class _FilterButton extends StatelessWidget {
  const _FilterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RangeValues? rv =
        Provider.of<FilterNotifier>(context, listen: false).currentRangeValues;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          HeroDialogRoute(
            builder: (context) => Center(
              child: _FilterButtonPopup(),
            ),
            settings: RouteSettings(),
          ),
        );
      },
      child: Hero(
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin, end: end);
        },
        tag: 'filter_button_tag',
        // child: Padding(
        //   padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          // child: Center(
          // child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
              // crossAxisAlignment: CrossAxisAlignment.sp,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  rv == null ? 'Filter' : 'NTRP : ${rv.start.toStringAsFixed(1)}-${rv.end.toStringAsFixed(1)}',
                  style: TextStyle(color: Colors.black),
                ),
                Icon(Icons.keyboard_arrow_down),
              ]),
          // ),
          // ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blueGrey,
            // border: const Border(
            //   left: BorderSide(
            //     color: Colors.green,
            //     width: 3,
            //   ),
            // ),
          ),
          // height: 40,
          // width: 90,
        ),
        // Material(
        //   color: AppColors.cardColor,
        //
        //   // borderRadius: BorderRadius.circular(12),
        //   child: SizedBox(
        //       child: Padding(
        //           padding: const EdgeInsets.all(16.0),
        //           child: Text('Filter'))),
        // )
        // ),
      ),
    );
  }
}

class _FilterButtonPopup extends StatefulWidget {
  static String pageName = '_FilterButtonPopup';

  String get _pageName => pageName;

  @override
  _FilterButtonPopupState createState() => _FilterButtonPopupState();
}

class _FilterButtonPopupState extends State<_FilterButtonPopup> {
  bool _isFirst = true;
  RangeValues _currentRangeValues = const RangeValues(2.0,3.5);// : tmp;

  @override
  Widget build(BuildContext context) {
    print('_FilterButtonPopupState ${_currentRangeValues.start}_${_currentRangeValues.end}');
    RangeValues tmp =  Provider.of<FilterNotifier>(context, listen: false).currentRangeValues;
    print('tmp ${tmp.start}_${tmp.end}');

    return Hero(
      tag: 'filter_button_tag',
      createRectTween: (begin, end) {
        return CustomRectTween(begin: begin, end: end);
      },
      // child: Padding(
      //   padding: const EdgeInsets.all(50.0),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.cardColor,
        child: SizedBox(
          height: 130,
          width: 300,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(children: [
              Row(children: [
                Text('NTRP : '),
                RangeSlider(
                  values: _currentRangeValues,
                  max: 7.0,
                  min: 1.0,
                  divisions: 12,
                  labels: RangeLabels(
                    _currentRangeValues.start.toStringAsFixed(1),
                    _currentRangeValues.end.toStringAsFixed(1),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                      // _isFirst=false;
                    });
                  },
                ),
              ]),
              ElevatedButton(
                  onPressed: () {
                    print('btn');
                    Provider.of<FilterNotifier>(context, listen: false).SetNtrpRange(_currentRangeValues);
                    // _isFirst = false;
                    // Provider.of<PageNotifier>(context, listen: false).refreshPage();

                    Navigator.pop(context);
                  },
                  child: Text('적용하기'))
            ]),
            // ),
          ),
        ),
      ),
    );
  }
}
//
// class _FilterButtonPopup extends StatelessWidget {
//   const _FilterButtonPopup({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Hero(
//       tag: 'filter_button_tag',
//       createRectTween: (begin, end) {
//         return CustomRectTween(begin: begin, end: end);
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Material(
//           borderRadius: BorderRadius.circular(16),
//           color: AppColors.cardColor,
//           child: SizedBox(
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(children: [
//                 Text('NTRP : '),
//                 Slider(
//                   activeColor: Colors.yellowAccent,
//                   // inactiveColor: Colors.redAccent,
//                   value: 4,
//                   max: 7.0,
//                   min: 1.0,
//                   divisions: 12,
//                   label: 4.toString(),
//                   onChanged: (double value) {
//                     setState(() {
//                       // _currentNTRPValue = value;
//                     });
//                   },
//                 ),
//               ]),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class _TodoCard extends StatelessWidget {
  /// {@macro todo_card}
  const _TodoCard({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          HeroDialogRoute(
            builder: (context) => Center(
              child: _TodoPopupCard(
                todo: todo,
                key: key,
              ),
            ),
            settings: RouteSettings(),
          ),
        );
      },
      child: Hero(
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin, end: end);
        },
        tag: todo.id,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0),
          child: Material(
              color: AppColors.cardColor,
              // borderRadius: BorderRadius.circular(12),
              child: Container(
                  height: 150,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
//         child: SizeTransition(
//           sizeFactor: animation,
//           axisAlignment: -1.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
//             const CircleAvatar(
//               backgroundColor: Colors.amberAccent,
//               child: Text('N'),
//             ),
                        SizedBox(
                            height: 250,
                            width: 100,
                            child: Column(children: const [
                              // const Icon(Icons.favorite, color: Colors.pink),
                              Text('1.3 (월)'),
                              Text('19:00 (2h)'),
                            ])),
//             const SizedBox(
//               width: 16,
//             ),
                        const VerticalDivider(
                            width: 10,
                            indent: 10,
                            endIndent: 10,
                            thickness: 1,
                            color: Colors.black),
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8),
                              child: Column(
//                   mainAxisAlignment:MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('복식하실 분 구합니다~'),
                                  const Text('양재 시민의숲 실외테니스장'),
                                  Row(children: const [
                                    Icon(Icons.person_outlined),
                                    Icon(Icons.person),
                                    Icon(Icons.person),
                                    Icon(Icons.person)
                                  ])
                                ],
                              )),
                        )
                      ],
                    ),
                  ))
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Column(
              //     children: <Widget>[
              //       _TodoTitle(title: todo.description),
              //       const SizedBox(
              //         height: 8,
              //       ),
              //       Container(
              //         margin: const EdgeInsets.all(8),
              //         decoration: BoxDecoration(
              //           color: Colors.black12,
              //           borderRadius: BorderRadius.circular(8),
              //         ),
              //         child:
              //         _MatchBody(item: todo,),
              //         // const TextField(
              //         //   maxLines: 8,
              //         //   cursorColor: Colors.white,
              //         //   decoration: InputDecoration(
              //         //       contentPadding: EdgeInsets.all(8),
              //         //       hintText: 'Write a note...',
              //         //       border: InputBorder.none),
              //         // ),
              //       )
              //     ],
              //   ),
              // ),
              ),
        ),
      ),
    );
  }
}

/// {@template todo_title}
/// Title of a [Todo].
/// {@endtemplate}
class _TodoTitle extends StatelessWidget {
  /// {@macro todo_title}
  const _TodoTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }
}

class _MatchBody extends StatelessWidget {
  const _MatchBody({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Todo item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text('Host : ${item.host.nickName}'),
          Text('일시 : ${item.starttime.toString()}'),
          SizedBox(
            height: 8,
          ),
          Text('장소 : ${item.location}'),
          Text('모집인원 : ${item.memberCapacity.toString()}'),
        ],
      ),
    );
  }
}

class _TodoItemsBox extends StatelessWidget {
  /// {@macro todo_items_box}
  const _TodoItemsBox({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final item in items) _TodoItemTile(item: item),
      ],
    );
  }
}

class _TodoItemTile extends StatefulWidget {
  /// {@macro todo_item_template}
  const _TodoItemTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  _TodoItemTileState createState() => _TodoItemTileState();
}

class _TodoItemTileState extends State<_TodoItemTile> {
  void _onChanged(bool? val) {
    setState(() {
      widget.item.completed = val!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        onChanged: _onChanged,
        value: widget.item.completed,
      ),
      title: Text(widget.item.description),
    );
  }
}

class _TodoPopupCard extends StatelessWidget {
  const _TodoPopupCard({required Key? key, required this.todo})
      : super(key: key);
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: todo.id,
      createRectTween: (begin, end) {
        return CustomRectTween(begin: begin, end: end);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.cardColor,
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _TodoTitle(title: todo.description),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
