import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const WeddingInvitationApp());
}

class WeddingInvitationApp extends StatelessWidget {
  const WeddingInvitationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InvitationScreen(),
    );
  }
}

class InvitationScreen extends StatelessWidget {
  const InvitationScreen({super.key});

  void _onDragCompleted(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const InvitationDetailsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final imageSize = screenSize.width * 0.25;

    return Scaffold(
      body: Stack(
        children: [
          // Blurred background to fill gaps
          Image.asset(
            'assets/images/landingBG_blurred.png',
            width: screenSize.width,
            height: screenSize.height,
            fit: BoxFit.cover,
          ),
          // Main background image
          Center(
            child: Image.asset(
              'assets/images/landingBG.jpeg',
              width: screenSize.width,
              height: screenSize.height,
              fit: BoxFit.contain,
            ),
          ),
          // Centered content within background boundaries
          Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final bgImageRatio = screenSize.width / screenSize.height;
                final contentWidth = bgImageRatio > 1
                    ? constraints.maxHeight * bgImageRatio
                    : constraints.maxWidth;
                final contentHeight = bgImageRatio > 1
                    ? constraints.maxHeight
                    : constraints.maxWidth / bgImageRatio;

                return SizedBox(
                  width: contentWidth,
                  height: contentHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PersonImageWidget(
                            imagePath: 'assets/images/man.png',
                            imageSize: imageSize,
                            name: 'Mohamed',
                            // Groom's name
                            isDraggable: true,
                            onDragCompleted: () => _onDragCompleted(context),
                          ),
                          SizedBox(width: imageSize * 0.2),
                          PersonImageWidget(
                            imagePath: 'assets/images/woman.png',
                            imageSize: imageSize,
                            name: 'Toqa',
                            // Bride's name
                            isDraggable: false,
                            onDragCompleted: () => _onDragCompleted(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PersonImageWidget extends StatelessWidget {
  final String imagePath;
  final double imageSize;
  final String name;
  final bool isDraggable;
  final VoidCallback onDragCompleted;

  const PersonImageWidget({
    super.key,
    required this.imagePath,
    required this.imageSize,
    required this.name,
    required this.isDraggable,
    required this.onDragCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      imagePath,
      width: imageSize,
      height: imageSize,
      fit: BoxFit.contain,
    );

    final decoratedImage = Column(
      children: [
        image,
        const SizedBox(height: 8),
        Text(
          name,
          style: GoogleFonts.greatVibes(
            fontSize: 24,
            color: const Color(0xFF8B5E3C),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );

    return isDraggable
        ? Draggable<int>(
            data: 1,
            feedback: Transform.scale(
              scale: 1.1,
              child: decoratedImage,
            ),
            childWhenDragging: Opacity(
              opacity: 0.5,
              child: decoratedImage,
            ),
            onDragCompleted: onDragCompleted,
            child: decoratedImage,
          )
        : DragTarget<int>(
            onWillAcceptWithDetails: (_) => true,
            onAcceptWithDetails: (_) => onDragCompleted(),
            builder: (context, candidateData, rejectedData) {
              return Stack(
                children: [
                  decoratedImage,
                  if (candidateData.isNotEmpty)
                    Container(
                      width: imageSize,
                      height: imageSize,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                ],
              );
            },
          );
  }
}

class InvitationDetailsPage extends StatelessWidget {
  const InvitationDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Blurred background image
          Image.asset(
            'assets/images/invitation_blurred.png',
            width: screenSize.width,
            height: screenSize.height,
            fit: BoxFit.cover,
          ),
          // Main invitation image
          Center(
            child: Image.asset(
              'assets/images/invitation.jpeg',
              width: screenSize.width,
              height: screenSize.height,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
