import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vote_planner/abstarction/abstraction.dart';
import 'package:vote_planner/controllers/controllers.dart';
import 'package:vote_planner/pages/pages.dart';
import 'package:vote_planner/providers/providers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome',
              style: TextStyle(
                fontWeight: Theme.of(context).textTheme.headline3?.fontWeight,
                fontSize: Theme.of(context).textTheme.headline3?.fontSize,
                color: Theme.of(context).primaryColorLight,
              ),
            ),
            SizedBox(height: 160),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter your name here',
                        hintStyle: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                        ),
                        errorStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                      maxLength: 24,
                      minLines: 1,
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Your name cannot be empty';
                        }

                        return null;
                      },
                      controller: _textEditingController,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColorDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            final User newUser =
                                await UserController.insertUser(
                                    name: _textEditingController.text);
                            userProvider.setUser(user: newUser);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => PlannersPage(),
                              ),
                            );
                          } catch (error) {}
                        }
                      },
                      child: Text('Continue'.toUpperCase()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
