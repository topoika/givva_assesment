import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingContainer extends StatelessWidget {
  final double height;
  final double? width;
  final double? radius;
  const LoadingContainer({
    super.key,
    required this.height,
    this.width,
    this.radius = 5,
  });
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 209, 208, 208),
      highlightColor: const Color.fromARGB(255, 150, 148, 148),
      period: const Duration(seconds: 2),
      child: Container(
        height: height,
        width: deviceWidth * (width ?? 1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius!),
          color: const Color.fromARGB(223, 209, 207, 207),
        ),
      ),
    );
  }
}

class CustomLoadingWidget extends StatelessWidget {
  final double height;
  final double? width;
  final double? radius;
  const CustomLoadingWidget({
    super.key,
    required this.height,
    this.width,
    this.radius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 209, 208, 208),
      highlightColor: const Color.fromARGB(255, 150, 148, 148),
      period: const Duration(seconds: 2),
      child: Container(
        height: height,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius!),
          color: const Color.fromARGB(223, 209, 207, 207),
        ),
      ),
    );
  }
}

class LoadingTilesWidget extends StatelessWidget {
  final int? count;
  final double? height;
  final double? width;
  final double? padding;
  final double? radius;
  const LoadingTilesWidget({
    super.key,
    this.count,
    this.height,
    this.width,
    this.padding,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: count ?? 4,
      padding: EdgeInsets.symmetric(horizontal: padding ?? 15, vertical: 12),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radius ?? 0),
          ),
          child: Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 209, 208, 208),
            highlightColor: const Color.fromARGB(255, 150, 148, 148),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width ?? double.infinity,
                  height: height ?? 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(223, 209, 207, 207),
                    borderRadius: BorderRadius.circular(radius ?? 0),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
