import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:trace_app_3b/screens/login.dart';
import 'package:trace_app_3b/screens/register_client.dart';
import 'package:trace_app_3b/screens/register_establishment.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void openScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(CupertinoPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              alignment: Alignment.bottomCenter,
              opacity: 0.6,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TraceIT',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const Gap(12),
              Text(
                'A mobile application project for MAD 2',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const Gap(12),
              ElevatedButton(
                onPressed: () => openScreen(context, LoginScreen()),
                child: const Text('LOGIN'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: () => openScreen(context, RegisterClientScreen()),
                child: const Text('Register as Client'),
              ),
              ElevatedButton(
                onPressed: () =>
                    openScreen(context, RegisterEstablishmentScreen()),
                child: const Text('Register as Establishment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
