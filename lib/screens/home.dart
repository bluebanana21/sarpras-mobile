import 'package:flutter/material.dart';
import 'package:sarpras_mobile/controllers/categoryController.dart';
import 'package:sarpras_mobile/controllers/itemController.dart';
import 'package:sarpras_mobile/models/category.dart';
import 'package:sarpras_mobile/models/item.dart';

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Items'),
                Container(
                  width: double.infinity,
                  height: 150,
                  color: Colors.green,
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

            // Items list

            // Scrollable Available Items section with shorter cards
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

                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Image
                                        Center(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: Image.network(
                                              'http://127.0.0.1:8000/${item.image}',
                                              height: 60,
                                              width: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        // Title
                                        Text(
                                          item.name.toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        // Availability
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: Colors.green,
                                              size: 10,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              item.status.toString(),
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            padding: const EdgeInsets.all(4),
                                            child: const Icon(
                                              Icons.arrow_forward,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
