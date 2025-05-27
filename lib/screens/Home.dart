import 'package:flutter/material.dart';
import 'package:sarpras_mobile/controllers/categoryController.dart';
import 'package:sarpras_mobile/controllers/itemController.dart';
import 'package:sarpras_mobile/models/category.dart';
import 'package:sarpras_mobile/models/item.dart';
import 'package:sarpras_mobile/widgets/ItemCard.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ItemModel> _items = [];
  final List<CategoryModel> _categories = [];

  bool _itemIsLoading = false;
  String _itemResponseMessage = "fetching data...";

  bool _catIsLoading = false;
  String _catResponseMessage = "fetching data...";

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _itemIsLoading = true;
    });
    try {
      final categories = await fetchCategories();

      final items = await fetchItems();

      setState(() {
        _categories.clear();
        _categories.addAll(categories);
        _items.clear();
        _items.addAll(items);
        _catResponseMessage = 'catssssssssss';
        _catIsLoading = false;
        _itemResponseMessage = 'items fetched cummmsas';
        _itemIsLoading = false;
      });
    } catch (e) {
      setState(() {
        _itemResponseMessage = 'error fetching items shit: $e';
        _itemIsLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            //This is for top part
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 20),
                  Text(
                    'Sisfo Sarpras',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () {
                      print('Go to icon page');
                    },
                    icon: Icon(Icons.person),
                  ),
                ],
              ),
            ),

            //search Bar
            Container(
              child: SearchBar(
                leading: const Icon(Icons.search),
                hintText: 'Search any item ...',
              ),
            ),

            //category scroll
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Items'),
                  Container(
                    width: double.infinity,
                    height: 150,
                    child: ListView.separated(
                      itemCount: _categories.length,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 12,
                        bottom: 12,
                      ),
                      separatorBuilder: (context, index) => SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text("amongus")],
                              ),
                            ),
                            Text(_categories[index].name.toString()),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Items list
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Available Items",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child:
                          _itemIsLoading
                              ? Center(child: CircularProgressIndicator())
                              : _items.isEmpty
                              ? Center(child: Text("items is empty"))
                              : GridView.builder(
                                itemCount: _items.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                      childAspectRatio:
                                          1.2, // Higher ratio = shorter cards
                                    ),
                                itemBuilder: (context, index) {
                                  print('Rendering items: ${_items.length}');
                                  final item = _items[index];

                                  return ItemCard(
                                    name: item.name.toString(),
                                    desc: item.description.toString(),
                                    image: item.image.toString(),
                                    assignedNum: item.assignedNum.toString(),
                                    status: item.status.toString(),
                                    id: item.id?.toInt() ?? 0,
                                    itemTypeId: item.itemTypeId?.toInt() ?? 0,
                                    subCatId: item.subcategoryId?.toInt() ?? 0,
                                  );
                                },
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
