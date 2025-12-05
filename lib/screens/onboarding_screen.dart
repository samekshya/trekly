import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  int currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      "title": "Discover Nepal’s Best Treks",
      "subtitle":
          "Explore routes with difficulty levels, maps, and daily plans.",
      "image": "assets/images/onboarding1.png",
    },
    {
      "title": "Follow Routes – Even Offline",
      "subtitle": "Maps, markers, and emergency features.",
      "image": "assets/images/onboarding2.png",
    },
    {
      "title": "Start Your Journey",
      "subtitle": "Login to save favourites and plan faster.",
      "image": "assets/images/onboarding2.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text("Skip"),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ⭐ Show image only on page 1
                        if (page["image"] != null && page["image"]!.isNotEmpty)
                          Image.asset(
                            page["image"]!,
                            height: 300,
                            fit: BoxFit.cover,
                          ),

                        const SizedBox(height: 24),

                        Text(
                          page["title"]!,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 16),

                        Text(
                          page["subtitle"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // ⭐ PAGE INDICATOR
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => Container(
                  margin: const EdgeInsets.all(4),
                  width: currentPage == index ? 12 : 8,
                  height: currentPage == index ? 12 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage == index
                        ? Colors.green
                        : Colors.grey.shade400,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ⭐ NEXT / GET STARTED BUTTON
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    if (currentPage == pages.length - 1) {
                      Navigator.pushReplacementNamed(context, '/login');
                    } else {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    currentPage == pages.length - 1 ? "Get Started" : "Next",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Minor update for Sprint 1 commit tracking
// Minor update for Sprint 1 commit tracking
