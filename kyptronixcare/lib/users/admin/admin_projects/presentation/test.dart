import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  bool _showAppBarTitle = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset > 140 && !_showAppBarTitle) {
      setState(() => _showAppBarTitle = true);
    } else if (_scrollController.offset <= 140 && _showAppBarTitle) {
      setState(() => _showAppBarTitle = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: AnimatedOpacity(
                opacity: _showAppBarTitle ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Text(
                  'Project Name',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Project Name',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today,
                                    color: Colors.white, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  'Jan 2024 - Dec 2024',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.link,
                                    color: Colors.white, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  'Visit Project',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: const [
                Tab(text: 'Overview'),
                Tab(text: 'Team'),
                Tab(text: 'Tasks'),
                Tab(text: 'Finances'),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildOverviewTab(),
            _buildTeamTab(),
            _buildTasksTab(),
            _buildFinancesTab(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Add Task'),
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionCard(
            title: 'Project Description',
            child: Text(
              'This is the project description. It provides a detailed overview of the project\'s purpose and goals.',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
          ),
          const SizedBox(height: 16),
          _buildProgressSection(),
          const SizedBox(height: 16),
          _buildProjectLinks(),
          const SizedBox(height: 16),
          _buildTagsSection(),
        ],
      ),
    );
  }

  Widget _buildTeamTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionCard(
          title: 'Project Manager',
          child: ListTile(
            leading: CircleAvatar(
              child: Text('JD'),
            ),
            title: Text('John Doe'),
            subtitle: Text('Project Manager'),
          ),
        ),
        const SizedBox(height: 16),
        _buildSectionCard(
          title: 'Team Members',
          child: Column(
            children: List.generate(
              4,
              (index) => ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Colors.primaries[index % Colors.primaries.length],
                  child: Text('D${index + 1}'),
                ),
                title: Text('Developer ${index + 1}'),
                subtitle: Text('Role Description'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.mail),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.chat),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTasksTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) => Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.task_alt, color: Colors.blue),
          ),
          title: Text(
            'Task ${index + 1}',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            'Due: ${DateTime.now().add(Duration(days: index + 1)).toString().substring(0, 10)}',
            style: GoogleFonts.poppins(),
          ),
          trailing: PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(child: Text('Edit')),
              const PopupMenuItem(child: Text('Delete')),
              const PopupMenuItem(child: Text('Mark Complete')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFinancesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionCard(
          title: 'Payment Overview',
          child: Column(
            children: [
              ListTile(
                title: const Text('Total Budget'),
                trailing: Text(
                  '\$50,000',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              const LinearProgressIndicator(value: 0.7),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Budget utilized: 70%',
                  style: GoogleFonts.poppins(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildSectionCard(
          title: 'Recent Payments',
          child: Column(
            children: List.generate(
              5,
              (index) => ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.payment, color: Colors.green),
                ),
                title: Text('Payment ${index + 1}'),
                subtitle: Text(
                  DateTime.now()
                      .subtract(Duration(days: index * 3))
                      .toString()
                      .substring(0, 10),
                ),
                trailing: Text(
                  '\$${(index + 1) * 1000}',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard({
    required String title,
    required Widget child,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection() {
    return _buildSectionCard(
      title: 'Progress',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '75% Complete',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '45 days remaining',
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const LinearProgressIndicator(
              value: 0.75,
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectLinks() {
    return _buildSectionCard(
      title: 'Project Links',
      child: Column(
        children: [
          _buildLinkTile(
            icon: Icons.language,
            title: 'Website',
            url: 'https://project-website.com',
          ),
          _buildLinkTile(
            icon: Icons.code,
            title: 'Repository',
            url: 'https://github.com/project',
          ),
          _buildLinkTile(
            icon: Icons.dashboard,
            title: 'Dashboard',
            url: 'https://dashboard.project.com',
          ),
        ],
      ),
    );
  }

  Widget _buildLinkTile({
    required IconData icon,
    required String title,
    required String url,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Theme.of(context).primaryColor),
      ),
      title: Text(title),
      subtitle: Text(url),
      trailing: IconButton(
        icon: const Icon(Icons.open_in_new),
        onPressed: () {
          // Open URL
        },
      ),
    );
  }

  Widget _buildTagsSection() {
    return _buildSectionCard(
      title: 'Tags',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          'Flutter',
          'Web Development',
          'Mobile App',
          'UI/UX',
          'Frontend',
        ]
            .map((tag) => Chip(
                  label: Text(tag),
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.1),
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                ))
            .toList(),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
