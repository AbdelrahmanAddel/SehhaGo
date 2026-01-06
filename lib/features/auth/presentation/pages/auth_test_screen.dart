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
  // Controllers for common fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();

  // Controllers for doctor‑specific fields
  final specializationController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  // Selected role (patient by default)
  UserRole selectedRole = UserRole.patient;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    specializationController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
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
            authenticated: (a) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Welcome ${a.user.firstName}!')),
            ),
          );
        },
        builder: (context, state) {
          // Show loading indicator when in loading state
          if (state.maybeMap(loading: (_) => true, orElse: () => false)) {
            return const Center(child: CircularProgressIndicator());
          }
          // Show the auth form for all other states
          return _buildAuthForm(context);
        },
      ),
    );
  }

  Widget _buildAuthForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Email & password (common for login & sign‑up)
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          // Sign‑up only fields
          TextField(
            controller: firstNameController,
            decoration: const InputDecoration(labelText: 'First Name'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: lastNameController,
            decoration: const InputDecoration(labelText: 'Last Name'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: phoneController,
            decoration: const InputDecoration(labelText: 'Phone'),
          ),
          const SizedBox(height: 12),
          // Role selector
          DropdownButton<UserRole>(
            value: selectedRole,
            isExpanded: true,
            items: UserRole.values.map((role) {
              return DropdownMenuItem(value: role, child: Text(role.name));
            }).toList(),
            onChanged: (val) {
              if (val != null) setState(() => selectedRole = val);
            },
          ),
          // Doctor‑specific extra fields – shown only when role is doctor
          if (selectedRole == UserRole.doctor) ...[
            const SizedBox(height: 12),
            TextField(
              controller: specializationController,
              decoration: const InputDecoration(labelText: 'Specialization'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: startTimeController,
              decoration: const InputDecoration(
                labelText: 'Start Time (HH:mm)',
                hintText: '09:00',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: endTimeController,
              decoration: const InputDecoration(
                labelText: 'End Time (HH:mm)',
                hintText: '17:00',
              ),
            ),
          ],
          const SizedBox(height: 24),
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
                        specialization: selectedRole == UserRole.doctor
                            ? specializationController.text
                            : null,
                        startTime: selectedRole == UserRole.doctor
                            ? startTimeController.text
                            : null,
                        endTime: selectedRole == UserRole.doctor
                            ? endTimeController.text
                            : null,
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
