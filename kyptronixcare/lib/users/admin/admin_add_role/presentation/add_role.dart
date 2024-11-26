import 'package:flutter/material.dart';

class AddRole extends StatefulWidget {
  const AddRole({super.key});

  @override
  State<AddRole> createState() => _AddRoleState();
}

class _AddRoleState extends State<AddRole> with SingleTickerProviderStateMixin {
  final List<Category> categories = [];
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  final _formKey = GlobalKey<FormState>();

  // Custom Colors
  final primaryColor = const Color(0xFF2A4365); // Deep Blue
  final secondaryColor = const Color(0xFF48BB78); // Green
  final backgroundColor = const Color(0xFFF7FAFC); // Light Gray
  final errorColor = const Color(0xFFE53E3E); // Red
  final accentColor = const Color(0xFF667EEA); // Purple Blue

  @override
  void initState() {
    super.initState();
    // Initialize animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Add initial sample data
    // setState(() {
    //   categories.add(Category(
    //       name: 'Developer', types: ['Mobile Developer', 'Web Developer']));
    //   categories.add(Category(
    //       name: 'Digital Marketing', types: ['SEO', 'SMO', 'PPC Specialist']));
    // });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _addCategory() {
    if (categories.any((category) => category.name.isEmpty)) {
      _showErrorSnackBar(
          'Please fill in existing category names before adding new ones.');
      return;
    }

    setState(() {
      categories.add(Category(name: '', types: []));
    });

    // Animate new category addition
    _animationController.reset();
    _animationController.forward();

    // Scroll to bottom
    Future.delayed(const Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  void _addType(int index) {
    if (categories[index].types.any((type) => type.isEmpty)) {
      _showErrorSnackBar(
          'Please fill in existing roles before adding new ones.');
      return;
    }

    setState(() {
      categories[index].types.add('');
    });
  }

  void _removeType(int categoryIndex, int typeIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to remove this role?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Delete', style: TextStyle(color: errorColor)),
              onPressed: () {
                setState(() {
                  categories[categoryIndex].types.removeAt(typeIndex);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _removeCategory(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text(
              'Are you sure you want to remove this category and all its roles?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Delete', style: TextStyle(color: errorColor)),
              onPressed: () {
                setState(() {
                  categories.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: errorColor,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  bool _validateData() {
    if (categories.isEmpty) {
      _showErrorSnackBar('Please add at least one category.');
      return false;
    }

    for (var category in categories) {
      if (category.name.isEmpty) {
        _showErrorSnackBar('Please fill in all category names.');
        return false;
      }

      if (category.types.isEmpty) {
        _showErrorSnackBar('Each category must have at least one role.');
        return false;
      }

      if (category.types.any((type) => type.isEmpty)) {
        _showErrorSnackBar('Please fill in all role names.');
        return false;
      }
    }

    // Check for duplicate categories
    Set<String> categoryNames = {};
    for (var category in categories) {
      if (!categoryNames.add(category.name.toLowerCase())) {
        _showErrorSnackBar('Duplicate category name: ${category.name}');
        return false;
      }

      // Check for duplicate roles within category
      Set<String> roleNames = {};
      for (var role in category.types) {
        if (!roleNames.add(role.toLowerCase())) {
          _showErrorSnackBar('Duplicate role name in ${category.name}: $role');
          return false;
        }
      }
    }

    return true;
  }

  void _saveData() {
    if (!_validateData()) return;

    Map<String, List<String>> data = {};
    for (var category in categories) {
      data[category.name] = category.types;
    }
    print(data);

    // Show success animation and message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('Roles saved successfully!'),
          ],
        ),
        backgroundColor: secondaryColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Roles',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: primaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backgroundColor,
              Colors.white,
            ],
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            children: [
              // Header Section with animation
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.easeOut,
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Employee Roles',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      'Manage different types of roles and their categories',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Categories List
              ...categories.asMap().entries.map((entry) {
                int categoryIndex = entry.key;
                Category category = entry.value;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: accentColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category Header
                          Row(
                            children: [
                              Icon(Icons.category, color: accentColor),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Category Name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    errorStyle: TextStyle(color: errorColor),
                                  ),
                                  initialValue: category.name,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Category name is required';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      category.name = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Types List with animations
                          ...category.types.asMap().entries.map((typeEntry) {
                            int typeIndex = typeEntry.key;
                            String type = typeEntry.value;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Icon(Icons.work,
                                      color: accentColor.withOpacity(0.7),
                                      size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Role Type',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        errorStyle:
                                            TextStyle(color: errorColor),
                                        suffixIcon: IconButton(
                                          icon: Icon(Icons.remove_circle,
                                              color: errorColor),
                                          onPressed: () => _removeType(
                                              categoryIndex, typeIndex),
                                        ),
                                      ),
                                      initialValue: type,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Role type is required';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          category.types[typeIndex] = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),

                          // Add Type Button
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.add),
                              label: const Text('Add Role'),
                              onPressed: () => _addType(categoryIndex),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accentColor.withOpacity(0.1),
                                foregroundColor: accentColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),

                          // Remove Category Button
                          if (categories.length > 1)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: TextButton.icon(
                                icon: Icon(Icons.delete_outline,
                                    color: errorColor),
                                label: Text('Remove Category',
                                    style: TextStyle(color: errorColor)),
                                onPressed: () => _removeCategory(categoryIndex),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),

              // Add Category Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('Add New Category'),
                  onPressed: _addCategory,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: accentColor,
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              // Save Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Save Changes'),
                  onPressed: _saveData,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: secondaryColor,
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Category {
  String name;
  List<String> types;

  Category({required this.name, required this.types});
}
