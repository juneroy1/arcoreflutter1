
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/models/ar_anchor.dart';
import 'package:ar_flutter_plugin_flutterflow/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin_flutterflow/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin_flutterflow/datatypes/node_types.dart';
import 'package:ar_flutter_plugin_flutterflow/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin_flutterflow/models/ar_node.dart';
import 'package:ar_flutter_plugin_flutterflow/models/ar_hittest_result.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart';
import 'dart:math';

class ObjectsOnPlanes extends StatefulWidget {
  const ObjectsOnPlanes({super.key, this.width, this.height});

  final double? width;
  final double? height;

  @override
  State<ObjectsOnPlanes> createState() => _ObjectsOnPlanesState();
}

class _ObjectsOnPlanesState extends State<ObjectsOnPlanes> {
  bool arSessionInitialized = false; // Track if AR session is ready
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;
  List<ARNode> nodes = [];
  List<ARAnchor> anchors = [];
    double selectedDistance = 10; // Default to 10 meters
  @override
  void dispose() {
    arSessionManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Anchors & Objects on Planes')),
      body: Stack(children: [
        // AR View
        ARView(
          onARViewCreated: onARViewCreated,
          planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
        ),
        // Distance Slider UI
        // Distance Slider UI
        Positioned(
          bottom: 100,
          left: 20,
          right: 20,
          child: Column(
            children: [
              Slider(
                value: selectedDistance,
                min: 1,
                max: 100,
                divisions: 99,
                label: "${selectedDistance.toStringAsFixed(0)} m",
                onChanged: (value) {
                  setState(() {
                    selectedDistance = value;
                  });
                },
              ),
              Text("Distance: ${selectedDistance.toStringAsFixed(0)} meters"),
              if (arSessionInitialized) // Show button only after AR session is ready
                ElevatedButton(
                  onPressed: placeObjectImmediately,
                  child: const Text("Place 3D Model"),
                ),
            ],
          ),
        ),
      ]),
    );;
  }

  void onARViewCreated(
    ARSessionManager arSessionManager,
    ARObjectManager arObjectManager,
    ARAnchorManager arAnchorManager,
    ARLocationManager arLocationManager) {
  this.arSessionManager = arSessionManager;
  this.arObjectManager = arObjectManager;
  this.arAnchorManager = arAnchorManager;

  // Enable AR session with automatic plane detection
 arSessionManager.onInitialize(
    showFeaturePoints: true,
    showPlanes: true,
    customPlaneTexturePath: "Images/triangle.png",
    showWorldOrigin: true,
    handlePans: false,
    showAnimatedGuide: false
  );
  arObjectManager.onInitialize();

  // Automatically place a 3D object 10 meters in front
  // placeObjectAutomatically();

   // Place 3D object immediately without an anchor
  // placeObjectImmediately();
  setState(() {
      arSessionInitialized = true; // Enable button when AR is ready
    });
  // arObjectManager.onInitialize();

  // // Ensure ARView updates the detected planes automatically
  // setState(() {});

  // arSessionManager.onPlaneOrPointTap = onPlaneOrPointTapped;
  // arObjectManager.onNodeTap = onNodeTapped;
}

Future<void> placeObjectImmediately() async {
  var  newNode = ARNode(
    type: NodeType.webGLB,  // Load from assets
    uri: "https://raw.githubusercontent.com/juneroy1/arcoreflutter1/main/assets/models/Arrow.glb", // Local file path
     scale: Vector3(0.05, 0.05, 0.05), // Reduces size by half
    position: Vector3(-0.5, 0.0, -2.0), // 10 meters in front of user
     rotation: Vector4(1.0, 0.2, 0.0, -1.57)
  );

  bool? didAddNode = await arObjectManager?.addNode(newNode);

  if (didAddNode == true) {
    setState(() {
      nodes.add(newNode);
    });
  } else {
    showErrorDialog("Failed to add object.");
  }


  newNode = ARNode(
    type: NodeType.webGLB,  // Load from assets
    uri: "https://raw.githubusercontent.com/juneroy1/arcoreflutter1/main/assets/models/Arrow.glb", // Local file path
     scale: Vector3(0.08, 0.08, 0.08), // Reduces size by half
    position: Vector3(-0.5, 0.0, -5.0), // 10 meters in front of user
     rotation:  Vector4(1.0, 0.2, 0.0, -1.57)
  );

   didAddNode = await arObjectManager?.addNode(newNode);

  if (didAddNode == true) {
    setState(() {
      nodes.add(newNode);
    });
  } else {
    showErrorDialog("Failed to add object.");
  }

   newNode = ARNode(
    type: NodeType.webGLB,  // Load from assets
    uri: "https://raw.githubusercontent.com/juneroy1/arcoreflutter1/main/assets/models/Arrow.glb", // Local file path
    scale: Vector3(0.08, 0.08, 0.08),  // Reduces size by half
    position: Vector3(-0.5, 0.0, -8.0), // 10 meters in front of user
     rotation:  Vector4(1.0, 0.2, 0.0, -1.57)
  );

   didAddNode = await arObjectManager?.addNode(newNode);

  if (didAddNode == true) {
    setState(() {
      nodes.add(newNode);
    });
  } else {
    showErrorDialog("Failed to add object.");
  }


   newNode = ARNode(
    type: NodeType.webGLB,  // Load from assets
    uri: "https://raw.githubusercontent.com/juneroy1/arcoreflutter1/main/assets/models/Arrow.glb", // Local file path
    scale: Vector3(0.08, 0.08, 0.08),  // Reduces size by half
    position: Vector3(-0.5, 0.0, -11.0), // 10 meters in front of user
     rotation:  Vector4(1.0, 0.2, 0.0, -1.57)
  );

   didAddNode = await arObjectManager?.addNode(newNode);

  if (didAddNode == true) {
    setState(() {
      nodes.add(newNode);
    });
  } else {
    showErrorDialog("Failed to add object.");
  }
   // type: NodeType.webGLB,
    // uri: "https://github.com/KhronosGroup/glTF-Sample-Models/raw/refs/heads/main/2.0/Duck/glTF-Binary/Duck.glb",
  newNode = ARNode(
   
    type: NodeType.webGLB,  // Load from assets
    uri: "https://raw.githubusercontent.com/juneroy1/arcoreflutter1/main/assets/models/Arrow.glb", // Local file path
    scale: Vector3(0.08, 0.08, 0.08),  // Reduces size by half
    position: Vector3(-0.5, 0.0, -14.0), // 10 meters in front of user
    rotation:  Vector4(1.0, 0.2, 0.0, -1.57)
  );

   didAddNode = await arObjectManager?.addNode(newNode);

  if (didAddNode == true) {
    setState(() {
      nodes.add(newNode);
    });
  } else {
    showErrorDialog("Failed to add object.");
  }
}

Future<void> placeObjectAutomatically() async {
  // Define a position 10 meters in front of the user
  var transformedPosition = Vector3(0.0, 0.0, -10.0); // Z = -10 moves forward

  // Create an anchor at this position
  var newAnchor = ARPlaneAnchor(transformation: Matrix4.translation(transformedPosition));
  bool? didAddAnchor = await arAnchorManager?.addAnchor(newAnchor);

  if (didAddAnchor == true) {
    setState(() {
      anchors.add(newAnchor);
    });

    // Add a 3D object to the anchor
    var newNode = ARNode(
      type: NodeType.webGLB,
      uri: "https://github.com/KhronosGroup/glTF-Sample-Models/raw/refs/heads/main/2.0/Duck/glTF-Binary/Duck.glb",
      scale: Vector3(0.2, 0.2, 0.2),
      position: Vector3(0.0, 0.0, 0.0), // Keep it centered on the anchor
      rotation: Vector4(1.0, 0.0, 0.0, 0.0),
    );

    bool? didAddNodeToAnchor = await arObjectManager?.addNode(newNode, planeAnchor: newAnchor);

    if (didAddNodeToAnchor == true) {
      setState(() {
        nodes.add(newNode);
      });
    } else {
      showErrorDialog("Adding Node to Anchor failed");
    }
  } else {
    showErrorDialog("Adding Anchor failed");
  }
}



  Future<void> onRemoveEverything() async {
    for (var anchor in anchors) {
      await arAnchorManager?.removeAnchor(anchor);
    }
    setState(() {
      anchors.clear();
      nodes.clear();
    });
  }

  Future<void> onNodeTapped(List<String> nodes) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Information"),
          content: Text("Tapped ${nodes.length} node(s)"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> onPlaneOrPointTapped(List<ARHitTestResult> hitTestResults) async {
    // var singleHitTestResult = hitTestResults.firstWhere(
    //   (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane,
      
    // );

    // if (singleHitTestResult == null) return;

    // var newAnchor = ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
    // bool? didAddAnchor = await arAnchorManager?.addAnchor(newAnchor);
    
    // if (didAddAnchor == true) {
    //   setState(() {
    //     anchors.add(newAnchor);
    //   });
    //   var newNode = ARNode(
    //     type: NodeType.webGLB,
    //     uri: "https://github.com/KhronosGroup/glTF-Sample-Models/raw/refs/heads/main/2.0/Duck/glTF-Binary/Duck.glb",
    //     scale: Vector3(0.2, 0.2, 0.2),
    //     position: Vector3(0.0, 0.0, 0.0),
    //     rotation: Vector4(1.0, 0.0, 0.0, 0.0),
    //   );
    //   bool? didAddNodeToAnchor = await arObjectManager?.addNode(newNode, planeAnchor: newAnchor);
      
    //   if (didAddNodeToAnchor == true) {
    //     setState(() {
    //       nodes.add(newNode);
    //     });
    //   } else {
    //     showErrorDialog("Adding Node to Anchor failed");
    //   }
    // } else {
    //   showErrorDialog("Adding Anchor failed");
    // }



    var singleHitTestResult = hitTestResults.firstWhere(
    (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane, 
    
  );

  if (singleHitTestResult == null) return;

  // Get current world transform
  var originalTransform = singleHitTestResult.worldTransform;

  // Modify transform to place the plane 100 meters ahead in the Z direction
  var transformedPosition = Vector3(
    originalTransform.row0.w,  // X position stays the same
    originalTransform.row1.w,  // Y position stays the same
    originalTransform.row2.w - 100,  // Move 100 meters forward in Z direction
  );

  // Create a new anchor with the updated position
  var newAnchor = ARPlaneAnchor(transformation: Matrix4.translation(transformedPosition));
  bool? didAddAnchor = await arAnchorManager?.addAnchor(newAnchor);

  if (didAddAnchor == true) {
    setState(() {
      anchors.add(newAnchor);
    });

    // Add an AR node to the new anchor
    var newNode = ARNode(
      type: NodeType.webGLB,
      uri: "https://github.com/KhronosGroup/glTF-Sample-Models/raw/refs/heads/main/2.0/Duck/glTF-Binary/Duck.glb",
      scale: Vector3(0.2, 0.2, 0.2),
      position: Vector3(0.0, 0.0, 0.0),
      rotation: Vector4(1.0, 0.0, 0.0, 0.0),
    );
    
    bool? didAddNodeToAnchor = await arObjectManager?.addNode(newNode, planeAnchor: newAnchor);
    
    if (didAddNodeToAnchor == true) {
      setState(() {
        nodes.add(newNode);
      });
    } else {
      showErrorDialog("Adding Node to Anchor failed");
    }
  } else {
    showErrorDialog("Adding Anchor failed");
  }

  // var singleHitTestResult = hitTestResults.firstWhere(
  //     (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane, 
     
  //   );

  //   if (singleHitTestResult == null) return;

  //   var originalTransform = singleHitTestResult.worldTransform;
  //   var transformedPosition = Vector3(
  //     originalTransform.row0.w,
  //     originalTransform.row1.w,
  //     originalTransform.row2.w - selectedDistance, // Use user-selected distance
  //   );

  //   var newAnchor = ARPlaneAnchor(transformation: Matrix4.translation(transformedPosition));
  //   bool? didAddAnchor = await arAnchorManager?.addAnchor(newAnchor);

  //   if (didAddAnchor == true) {
  //     setState(() {
  //       anchors.add(newAnchor);
  //     });
  //   }
  
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
