import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Expanded(
            child: Shimmer(
              duration: const Duration(seconds: 1),
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width - 120,
                  height: MediaQuery.of(context).size.height * .25,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 2,
                      color: Colors.grey[600]!,
                      strokeAlign: BorderSide.strokeAlignInside,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
