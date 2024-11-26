import 'package:flutter/material.dart';

class ClientServicesPage extends StatelessWidget {
  const ClientServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Services'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Graphics Design', context),
            const SizedBox(height: 10),
            _buildServiceGrid([
              ServiceItem(
                title: 'Logo Design',
                description: 'Creative logo design to represent your brand.',
                imageUrl: 'https://via.placeholder.com/150',
              ),
              ServiceItem(
                title: 'Brochure Design',
                description: 'Attractive brochures to showcase your business.',
                imageUrl: 'https://via.placeholder.com/150',
              ),
            ], context),
            const SizedBox(height: 20),
            _buildSectionTitle('Digital Marketing', context),
            const SizedBox(height: 10),
            _buildServiceGrid([
              ServiceItem(
                title: 'Email Marketing',
                description:
                    'Reach your audience with effective email campaigns.',
                imageUrl: 'https://via.placeholder.com/150',
              ),
              ServiceItem(
                title: 'Social Media Advertising',
                description:
                    'Engage with your audience on social media platforms.',
                imageUrl: 'https://via.placeholder.com/150',
              ),
            ], context),
            const SizedBox(height: 20),
            _buildSectionTitle('Website Design & Development', context),
            const SizedBox(height: 10),
            _buildServiceGrid([
              ServiceItem(
                title: 'E-Commerce Development',
                description: 'Build a robust online store for your business.',
                imageUrl: 'https://via.placeholder.com/150',
              ),
              ServiceItem(
                title: 'Web Programming',
                description: 'Custom web solutions tailored to your needs.',
                imageUrl: 'https://via.placeholder.com/150',
              ),
            ], context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
    );
  }

  Widget _buildServiceGrid(List<ServiceItem> services, BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: services.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return _buildServiceCard(services[index], context);
      },
    );
  }

  Widget _buildServiceCard(ServiceItem service, BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showServiceDetails(context, service);
      },
      child: Hero(
        tag: service.title,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 8,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Colors.purple, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(service.imageUrl, height: 80),
                const SizedBox(height: 10),
                Text(
                  service.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showServiceDetails(BuildContext context, ServiceItem service) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: service.title,
                  child: Image.network(service.imageUrl, height: 100),
                ),
                const SizedBox(height: 20),
                Text(
                  service.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  service.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.purple,
                  ),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ServiceItem {
  final String title;
  final String description;
  final String imageUrl;

  ServiceItem({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}
