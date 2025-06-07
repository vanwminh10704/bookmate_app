import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:book_flutter/pages/auth/login_page.dart';
import 'package:book_flutter/services/shared_prefs.dart';

class OnboardingPage extends StatefulWidget {
  @override
  State<OnboardingPage> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'title': 'Chào mừng đến với BookMate!',
      'desc': 'Khám phá hàng ngàn cuốn sách điện tử mọi thể loại.',
      'lottie': 'assets/animations/Animation - 1747930966397.json',
    },
    {
      'title': 'Đánh dấu và ghi chú',
      'desc': 'Lưu lại trang và ý tưởng bạn yêu thích.',
      'lottie': 'assets/animations/Animation - 1747928656488.json',
    },
    {
      'title': 'Tùy chỉnh trải nghiệm đọc',
      'desc': 'Đọc sách theo cách bạn muốn – cả ngày lẫn đêm.',
      'lottie': 'assets/animations/Animation - 1747928365579.json',
    },
  ];

  Future<void> completeOnboarding() async {
    await SharedPrefs().setAccess(true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemBuilder: (context, index) {
                  final data = onboardingData[index];
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 40),
                          Lottie.asset(data['lottie']!, height: 300),
                          SizedBox(height: 20),
                          Text(
                            data['title']!,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 12),
                          Text(
                            data['desc']!,
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[700]),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            buildDotsIndicator(),
            SizedBox(height: 20),

            // Nút điều hướng Trước - Sau
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Nút Trước
                ElevatedButton(
                  onPressed: _currentIndex > 0
                      ? () {
                          _pageController.previousPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                      : null,
                  child: Text("Trước"),
                ),

                // Nút Sau hoặc Bắt đầu
                _currentIndex == onboardingData.length - 1
                    ? ElevatedButton(
                        onPressed: completeOnboarding,
                        child: Text("Bắt đầu"),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Text("Sau"),
                      ),
              ],
            ),

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(onboardingData.length, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: _currentIndex == index ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentIndex == index ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
