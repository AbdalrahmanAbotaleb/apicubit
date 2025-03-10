import 'package:apicubit/controller/cubit/product_cubit.dart';
import 'package:apicubit/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..getProductData(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
          ),
          body: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              switch (state) {
                case ProductLoading():
                  return Center(child: CircularProgressIndicator());
                // TODO: Handle this case.
                case ProductLoaded():
                  return GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // عدد الأعمدة
                      crossAxisSpacing: 10.0, // المسافة بين الأعمدة
                      mainAxisSpacing: 10.0, // المسافة بين الصفوف
                      childAspectRatio: 0.8, // نسبة العرض إلى الارتفاع للعناصر
                    ),
                    itemCount: state.productList.length,
                    itemBuilder: (context, index) {
                      final product = state.productList[index];
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        product.image), // ضع رابط الصورة هنا
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    product.category,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "\$${product.price}",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );

                case ProductError():
                  print(state.errorMessage);
                  return Center(child: Text(state.errorMessage));
              }
            },
          )),
    );
  }
}
