import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> _allCrops = [
    "Wheat",
    "Rice",
    "Corn",
    "Sugarcane",
    "Soybean",
    "Tomato",
    "Potato",
    "Barley",
    "Cotton",
    "Lettuce"
  ];
  List<String> _filteredCrops = [];

  @override
  void initState() {
    super.initState();
    _filteredCrops = List.from(_allCrops);
  }

  void _filterCrops(String query) {
    setState(() {
      _filteredCrops = _allCrops
          .where((crop) => crop.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Crops"),
        backgroundColor: Colors.green.shade700,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search for a crop...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: _filterCrops,
            ),
            SizedBox(height: 10),

            // Crop List
            Expanded(
              child: _filteredCrops.isNotEmpty
                  ? ListView.builder(
                      itemCount: _filteredCrops.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: Icon(Icons.agriculture, color: Colors.green),
                            title: Text(
                              _filteredCrops[index],
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            onTap: () {
                              // Handle Crop Selection
                            },
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "No crops found!",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
