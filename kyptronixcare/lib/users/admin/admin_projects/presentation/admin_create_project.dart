import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// import 'package:project_management_app/core/widgets/custom_appbar.dart';

class AdminCreateProject extends StatefulWidget {
  const AdminCreateProject({super.key});

  @override
  State<AdminCreateProject> createState() => _AdminCreateProjectState();
}

class _AdminCreateProjectState extends State<AdminCreateProject> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();
  // final TextEditingController _grossAmountController = TextEditingController();
  final TextEditingController _amountPaidController = TextEditingController();
  final TextEditingController _recurringAmountController =
      TextEditingController();

  final List<TextEditingController> _subProjectControllers = [];
  final List<Map<String, List<TextEditingController>>>
      _subProjectDevelopersControllers = [];
  final List<Map<String, TextEditingController>>
      _subProjectManagersControllers = [];

  String? _paymentModel;
  bool _isSubProject = false;

  final List<String> _managers = [
    'Manager 1',
    'Manager 2',
    'Manager 3'
  ]; // Replace with your data

  int _currentStep = 0; // Track the current step

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Stepper(
              physics: const NeverScrollableScrollPhysics(),

              type: StepperType.vertical,
              controlsBuilder: (context, details) {
                return Row(
                  children: [
                    ElevatedButton(
                      onPressed: details.onStepContinue,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.primary,
                        textStyle:
                            textTheme.bodyLarge!.copyWith(color: Colors.white),
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(18.0)),
                      ),
                      child: Text(_currentStep ==
                              _buildSteps(false, textTheme).length - 1
                          ? 'Submit'
                          : 'Continue'),
                    ),
                    if (_currentStep > 0) ...[
                      TextButton(
                        onPressed: details.onStepCancel,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                          textStyle: textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                      const Gap(8),
                    ],
                  ],
                );
              },
              steps: _buildSteps(isDarkMode, textTheme),
              currentStep: _currentStep, // Use the tracked step
              onStepContinue: () {
                if (_currentStep <
                    _buildSteps(false, Theme.of(context).textTheme).length -
                        1) {
                  setState(() {
                    _currentStep += 1;
                  });
                } else {
                  // Handle form submission or final action
                }
                // if (_formKey.currentState!.validate()) {
                //   if (_currentStep <
                //       _buildSteps(false, Theme.of(context).textTheme).length -
                //           1) {
                //     setState(() {
                //       _currentStep += 1;
                //     });
                //   } else {
                //     // Handle form submission or final action
                //   }
                // }
                // setState(() {
                //   _currentStep += 1;
                // });
              },
              onStepCancel: _handleStepCancel,
            ),
          ),
        ),
      ),
    );
  }

  List<Step> _buildSteps(bool isDarkMode, TextTheme textTheme) {
    return [
      Step(
        title: const Text('Project Details'),
        content: Column(
          children: [
            _buildTextField(
              controller: _projectNameController,
              label: 'Project Name',
              icon: Icons.title,
              textInputType: TextInputType.name,
            ),
            _buildTextField(
              controller: _descriptionController,
              label: 'Description',
              icon: Icons.description,
              maxLines: 4,
              textInputType: TextInputType.text,
            ),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: const Text('Sub-Project Details'),
        content: Column(
          children: [
            _buildProjectTypeSwitch(),
            if (_isSubProject)
              _buildDynamicFieldList(
                title: 'Sub-Projects',
                controllers: _subProjectControllers,
                onAdd: _addSubProjectField,
                onRemove: _removeSubProjectField,
                isDarkMode: isDarkMode,
                additionalWidgetBuilder: (index) {
                  return Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Divider(),
                      ),
                      _buildDynamicFieldList(
                        isDarkMode: isDarkMode,
                        title: 'Sub-Project ${index + 1} Developers',
                        controllers: _subProjectDevelopersControllers[index]
                                ['developers'] ??
                            [],
                        onAdd: () => _addSubProjectDeveloperField(index),
                        onRemove: (int developerIndex) =>
                            _removeSubProjectDeveloperField(
                                index, developerIndex),
                      ),
                      _buildDropdown(
                        label: 'Sub-Project ${index + 1} Manager',
                        items: _managers,
                        value: _managers.contains(
                                _subProjectManagersControllers[index]
                                        ['manager']!
                                    .text)
                            ? _subProjectManagersControllers[index]['manager']!
                                .text
                            : null,
                        isDarkMode: isDarkMode,
                        textTheme: textTheme,
                        onChanged: (String? newValue) {
                          setState(() {
                            _subProjectManagersControllers[index]['manager']!
                                .text = newValue!;
                          });
                        },
                      ),
                      const Gap(24.0),
                      Divider(
                        thickness: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const Gap(24.0),
                    ],
                  );
                },
              )
          ],
        ),
        isActive: true,
      ),
      Step(
        title: const Text('Dates'),
        content: Column(
          children: [
            _buildTextField(
              controller: _startDateController,
              label: 'Start Date',
              icon: Icons.calendar_today,
              textInputType: TextInputType.datetime,
              readOnly: true,
              onTap: () => _selectDate(_startDateController),
            ),
            _buildTextField(
              controller: _endDateController,
              label: 'End Date',
              icon: Icons.calendar_today,
              textInputType: TextInputType.datetime,
              readOnly: true,
              onTap: () => _selectDate(_endDateController),
            ),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: const Text('Payment Details'),
        content: Column(
          children: [
            _buildDropdown(
              label: 'Payment Model',
              items: ['one-time', 'recurring'],
              value: _paymentModel,
              isDarkMode: isDarkMode,
              textTheme: textTheme,
              onChanged: (String? newValue) {
                setState(() {
                  _paymentModel = newValue;
                });
              },
            ),
            if (_paymentModel == 'one-time')
              Column(
                children: [
                  _buildTextField(
                    controller: _totalAmountController,
                    label: 'Total Amount',
                    icon: Icons.attach_money,
                    textInputType: TextInputType.number,
                  ),
                  _buildTextField(
                    controller: _amountPaidController,
                    label: 'Amount Paid',
                    icon: Icons.attach_money,
                    textInputType: TextInputType.number,
                  ),
                ],
              )
            else if (_paymentModel == 'recurring')
              _buildTextField(
                controller: _recurringAmountController,
                label: 'Recurring Amount',
                icon: Icons.attach_money,
                textInputType: TextInputType.number,
              ),
          ],
        ),
        isActive: true,
      ),
    ];
  }

  void _handleStepContinue() {
    if (_formKey.currentState!.validate()) {
      if (_currentStep <
          _buildSteps(false, Theme.of(context).textTheme).length - 1) {
        setState(() {
          _currentStep += 1;
        });
      } else {
        // Handle form submission or final action
      }
    }
  }

  void _handleStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType textInputType = TextInputType.text,
    int maxLines = 1,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        maxLines: maxLines,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required List<String> items,
    required String? value,
    required bool isDarkMode,
    required TextTheme textTheme,
    required void Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        value: value,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select $label';
          }
          return null;
        },
      ),
    );
  }

// TODO:
  Widget _buildDynamicFieldList({
    required String title,
    required List<TextEditingController> controllers,
    required VoidCallback onAdd,
    required void Function(int) onRemove,
    Widget Function(int index)? additionalWidgetBuilder,
    required bool isDarkMode,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Gap(8),
          ...List.generate(controllers.length, (index) {
            return Column(
              key: ValueKey(index),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: controllers[index],
                        label: '$title ${index + 1}',
                        icon: Icons.subdirectory_arrow_right,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () => onRemove(index),
                    ),
                  ],
                ),
                if (additionalWidgetBuilder != null)
                  additionalWidgetBuilder(index),
              ],
            );
          }),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.6)
                    : Theme.of(context).colorScheme.primary,
                iconColor: Colors.white,
              ),
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: Text(
                'Add $title',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addSubProjectField() {
    setState(() {
      final subProjectController = TextEditingController();
      _subProjectControllers.add(subProjectController);
      _subProjectDevelopersControllers.add({
        'developers': [],
      });
      _subProjectManagersControllers.add({
        'manager': TextEditingController(),
      });
    });
  }

  void _removeSubProjectField(int index) {
    setState(() {
      _subProjectControllers.removeAt(index);
      _subProjectDevelopersControllers.removeAt(index);
      _subProjectManagersControllers.removeAt(index);
    });
  }

  void _addSubProjectDeveloperField(int index) {
    setState(() {
      _subProjectDevelopersControllers[index]['developers']!
          .add(TextEditingController());
    });
  }

  void _removeSubProjectDeveloperField(int projectIndex, int developerIndex) {
    setState(() {
      _subProjectDevelopersControllers[projectIndex]['developers']!
          .removeAt(developerIndex);
    });
  }

  void _selectDate(TextEditingController controller) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      controller.text = selectedDate.toIso8601String().substring(0, 10);
    }
  }

  Widget _buildProjectTypeSwitch() {
    return SwitchListTile(
      inactiveThumbColor: Colors.grey.shade800,
      inactiveTrackColor: Colors.black38,
      title: const Text('Is this a Sub-Project?'),
      value: _isSubProject,
      onChanged: (bool value) {
        setState(() {
          _isSubProject = value;
        });
      },
    );
  }
}
