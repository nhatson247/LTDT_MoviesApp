import 'package:flutter/material.dart';
import 'package:testing/api/api.dart';
import 'package:testing/models/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/constants.dart';
import '../../utils/colors.dart';
import '../Movies/details_screen.dart';

class SearchMovies extends StatefulWidget {
  const SearchMovies({super.key});

  @override
  _SearchMoviesState createState() => _SearchMoviesState();
}

class _SearchMoviesState extends State<SearchMovies> {
  TextEditingController _searchController = TextEditingController();
  List<Movie> _searchResults = [];
  bool _isSearching = false; // trang thai tim kiem
  bool _searchComplete = false; // kiem tra da hoan thanh tim kiem chua

  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    String savedKeyword = _prefs.getString('searchKeyword') ?? '';
    _searchController.text = savedKeyword;
    _onSearchTextChanged(savedKeyword);
  }

  _saveSearchKeyword(String keyword) {
    _prefs.setString('searchKeyword', keyword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        automaticallyImplyLeading: false,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey[500],
            ),
            hintText: 'Search',
            hintStyle: TextStyle(
              color: Colors.grey[500],
              fontWeight: FontWeight.w300,
            ),
            filled: true,
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (text) {
            _onSearchTextChanged(text);
            _saveSearchKeyword(text);
          },
        ),
      ),
      body: _buildSearchResults(),
    );
  }

  Widget _buildSearchResults() {
    if (_isSearching) {
      if (_searchResults.isEmpty) {
        // Trường hợp tìm kiếm đã hoàn thành và không có kết quả
        if (_searchComplete) {
          return Center(
            child: Text(
              'No result found',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(), // loading
          );
        }
      } else {
        // Trường hợp có kết quả
        return ListView.builder(
          itemCount: _searchResults.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                      movie: _searchResults[index],
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: kColorDF,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 150,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage('${Constanst.imagePath}${_searchResults[index].backDropPath}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _searchResults[index].title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey,
                                    ),
                                    child: Text(
                                      _searchResults[index].releaseDate.split("-").first,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 18,
                                        color: Colors.redAccent,
                                      ),
                                      Text(
                                        _searchResults[index].voteAverage.toStringAsFixed(1),
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                _searchResults[index].overview,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    } else {
      // Trường hợp chưa tìm kiếm
      return Center(
        child: Text(
          'Find your movies',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }

  void _onSearchTextChanged(String text) {
    if (text.isEmpty) {
      // Không có kết quả nếu ô tìm kiếm trống
      setState(() {
        _searchResults = [];
        _isSearching = false;
        _searchComplete = true; // Đã hoàn thành tìm kiếm
      });
    } else {
      setState(() {
        _isSearching = true; // Đang tìm kiếm
      });
      Api().searchMovies(text).then((movies) {
        setState(() {
          _searchResults = movies;
          _searchComplete = true; // Đã hoàn thành tìm kiếm
        });
      });
    }
  }
}

