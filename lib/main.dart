import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, GoogleAuthProvider;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> _initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Load .env file
    await dotenv.load(fileName: ".env");

    // Initialize Firebase
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: dotenv.env['FIREBASE_API_KEY']!,
        authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN']!,
        projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
        storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET']!,
        messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
        appId: dotenv.env['FIREBASE_APP_ID']!,
      ),
    );

    print('✅ Firebase initialized successfully!');
    print('📦 Project ID: ${dotenv.env['FIREBASE_PROJECT_ID']}');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeApp(),
      builder: (context, snapshot) {
        // Show error if initialization fails
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Initialization Error: ${snapshot.error}'),
              ),
            ),
          );
        }

        // Show app once initialization is complete
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Gauntlet App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            home: const MyHomePage(title: 'Gauntlet App'),
          );
        }

        // Show loading indicator while initializing
        return const MaterialApp(
          home: Scaffold(body: Center(child: CircularProgressIndicator())),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User? _currentUser;
  String _dbStatus = 'Not tested';

  @override
  void initState() {
    super.initState();
    // Listen to auth state changes - keeps user signed in
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _currentUser = user;
      });
      if (user != null) {
        print('✅ User signed in: ${user.displayName}');
        print('📸 Photo URL: ${user.photoURL}');
      } else {
        print('👤 No user signed in');
      }
    });
  }

  void _signInWithGoogle() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => SignInScreen(
              providers: [GoogleProvider(clientId: ''), EmailAuthProvider()],
              actions: [
                AuthStateChangeAction<SignedIn>((context, state) {
                  // Automatically close sign-in screen after successful login
                  Navigator.of(context).pop();
                }),
              ],
              headerBuilder: (context, constraints, shrinkOffset) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Welcome to Gauntlet App',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Sign in to continue'),
                    ],
                  ),
                );
              },
            ),
      ),
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    print('👋 Signed out');
  }

  Future<void> _testDatabase() async {
    try {
      var snapshot =
          await FirebaseFirestore.instance.collection('users').limit(1).get();

      setState(() {
        _dbStatus = '✅ Read Success (${snapshot.docs.length} docs found)';
      });
      print('✅ Database read successful!');
    } catch (e) {
      setState(() {
        _dbStatus = '❌ ${e.toString()}';
      });
      print('❌ Database error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Firebase.apps.isNotEmpty ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  Firebase.apps.isNotEmpty
                      ? 'Firebase Connected'
                      : 'Firebase Disconnected',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _testDatabase,
              child: const Text('Test Database Read'),
            ),
            const SizedBox(height: 10),
            Text(
              _dbStatus,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color:
                    _dbStatus.contains('✅')
                        ? Colors.green
                        : _dbStatus.contains('❌')
                        ? Colors.red
                        : Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            if (_currentUser == null)
              ElevatedButton.icon(
                onPressed: _signInWithGoogle,
                icon: const Icon(Icons.login),
                label: const Text('Sign In'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              )
            else
              Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300],
                    backgroundImage:
                        _currentUser!.photoURL != null &&
                                _currentUser!.photoURL!.isNotEmpty
                            ? NetworkImage(_currentUser!.photoURL!)
                            : null,
                    child:
                        _currentUser!.photoURL == null ||
                                _currentUser!.photoURL!.isEmpty
                            ? const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.grey,
                            )
                            : null,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _currentUser!.displayName ?? 'User',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _currentUser!.email ?? '',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: _signOut,
                    icon: const Icon(Icons.logout),
                    label: const Text('Sign Out'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
