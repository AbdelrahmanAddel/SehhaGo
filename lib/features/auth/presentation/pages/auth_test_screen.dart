import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/enums/user_role.dart';
import '../../domain/usecases/sign_up_params.dart';
import '../bloc/auth_bloc.dart';

class AuthTestScreen extends StatefulWidget {
  const AuthTestScreen({super.key});

  @override
  State<AuthTestScreen> createState() => _AuthTestScreenState();
}

class _AuthTestScreenState extends State<AuthTestScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  UserRole selectedRole = UserRole.patient;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auth Test')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.mapOrNull(
            failure: (f) => ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(f.message))),
            authenticated: (u) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Welcome ${u.user.firstName}!')),
            ),
          );
        },
        builder: (context, state) {
          if (state.maybeMap(loading: (_) => true, orElse: () => false)) {
            return const Center(child: CircularProgressIndicator());
          }

          return state.maybeMap(
            authenticated: (state) =>
                _buildAuthenticatedView(context, state.user.firstName),
            orElse: () => _buildAuthForm(context),
          );
        },
      ),
    );
  }

  Widget _buildAuthenticatedView(BuildContext context, String name) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Logged in as $name'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEvent.logout());
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          // Sign Up Only Fields
          TextField(
            controller: firstNameController,
            decoration: const InputDecoration(
              labelText: 'First Name (Sign Up only)',
            ),
          ),
          TextField(
            controller: lastNameController,
            decoration: const InputDecoration(
              labelText: 'Last Name (Sign Up only)',
            ),
          ),
          TextField(
            controller: phoneController,
            decoration: const InputDecoration(
              labelText: 'Phone (Sign Up only)',
            ),
          ),
          DropdownButton<UserRole>(
            value: selectedRole,
            items: UserRole.values.map((role) {
              return DropdownMenuItem(value: role, child: Text(role.name));
            }).toList(),
            onChanged: (val) {
              if (val != null) setState(() => selectedRole = val);
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                    AuthEvent.login(
                      email: emailController.text,
                      password: passwordController.text,
                    ),
                  );
                },
                child: const Text('Login'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                    AuthEvent.signUp(
                      params: SignUpParams(
                        email: emailController.text,
                        password: passwordController.text,
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        phoneNumber: phoneController.text,
                        role: selectedRole,
                      ),
                    ),
                  );
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
