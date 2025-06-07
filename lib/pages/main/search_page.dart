import '../../models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../components/book_item.dart';
import '../../components/app_dialog.dart';
import '../../controller/book_controller.dart';
import 'package:book_flutter/components/app_text_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final BookController _bookController = BookController();
  List<BookModel> _searchResults = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initBooks();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  Future<void> _initBooks() async {
    await _bookController.loadBookList();
    await _bookController.loadFavoriteBooks();
    setState(() {
      _searchResults = _bookController.getBooks();
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchResults = _bookController.searchBooksByName(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5EF),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20.0,
                left: 16.0,
                right: 16.0),
            child: AppTextField(
                controller: _searchController,
                hintText: "Tìm sách ở đây...",
                prefixIcon: const Icon(Icons.search),
                onChanged: _onSearchChanged),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: _searchResults.isEmpty
                ? const Center(child: Text('Không tìm thấy sách nào'))
                : ListView.separated(
                    itemCount: _searchResults.length,
                    separatorBuilder: (context, idx) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, idx) {
                      final book = _searchResults[idx];
                      return BookItem(
                        book: book,
                        isFavorite: _bookController.isFavorite(book),
                        onAdd: () async {
                          await _bookController.toggleFavorite(book);
                          await _bookController.loadFavoriteBooks();
                          setState(() {});
                        },
                        onDelete: () async {
                          await AppDialog.dialog(
                            title: const Text(
                              "🗑️ Xác nhận xoá sách",
                              style: TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.w300),
                              textAlign: TextAlign.center,
                            ),
                            context,
                            content:
                                "Bạn có chắc chắn muốn xoá sách này không?",
                            confirmText: "Xoá",
                            action: () async {
                              await _bookController.removeBook(book);
                              await _initBooks();
                            },
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
