import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:objek_wisata1/screen/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _sunController;
  late AnimationController _cloudController;

  @override
  void initState() {
    super.initState();
    _sunController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _cloudController = AnimationController(
      duration: const Duration(seconds: 60),
      vsync: this,
    )..repeat();

    // Menunggu 4 detik dan kemudian navigasi ke HomeScreen
    Future.delayed(const Duration(seconds: 4)).then((value) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false,
      );
    });
  }

  @override
  void dispose() {
    _sunController.dispose();
    _cloudController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.lightBlue[300]!, Colors.blue[600]!],
              ),
            ),
          ),
          // Sun
          Positioned(
            top: -50,
            left: -50,
            child: AnimatedBuilder(
              animation: _sunController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _sunController.value * 2 * math.pi,
                  child: child,
                );
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.yellow[300],
                ),
              ),
            ),
          ),
          // Animated clouds
          ..._buildAnimatedClouds(),
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 180,
                  height: 180,
                ),
                SizedBox(height: 50),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow[300]!),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAnimatedClouds() {
    return List.generate(5, (index) {
      final top = 50.0 + (index * 100);
      final left = (index % 2 == 0) ? -100.0 : 400.0;
      final moveLeft = index % 2 == 0;

      return AnimatedBuilder(
        animation: _cloudController,
        builder: (context, child) {
          final dx = moveLeft
              ? left + (_cloudController.value * MediaQuery.of(context).size.width)
              : left - (_cloudController.value * MediaQuery.of(context).size.width);
          return Positioned(
            top: top,
            left: dx,
            child: _buildCloud(80 + (index * 20).toDouble()),
          );
        },
      );
    });
  }

  Widget _buildCloud(double size) {
    return Container(
      width: size,
      height: size * 0.6,
      child: Stack(
        children: [
          Positioned(
            left: size * 0.2,
            child: Container(
              width: size * 0.5,
              height: size * 0.5,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: size * 0.1,
            top: size * 0.2,
            child: Container(
              width: size * 0.4,
              height: size * 0.4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: size * 0.4,
            top: size * 0.1,
            child: Container(
              width: size * 0.5,
              height: size * 0.5,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
