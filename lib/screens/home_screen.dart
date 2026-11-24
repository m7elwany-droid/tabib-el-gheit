import 'package:flutter/material.dart';
import '../models/diagnosis_model.dart';
import '../theme/app_theme.dart';
import 'diagnosis_result_screen.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onNavigateToScan;
  final VoidCallback onNavigateToEncyclopedia;

  const HomeScreen({
    super.key,
    required this.onNavigateToScan,
    required this.onNavigateToEncyclopedia,
  });

  @override
  Widget build(BuildContext context) {
    final recentScans = DiagnosisResult.getSampleData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('طبيب الغيط'),
        leading: const Icon(Icons.eco),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // بطاقة الطقس والإرشاد الزراعي
            _buildWeatherAdvisoryCard(),
            const SizedBox(height: 18),

            // لافتة الفحص السريع الرئيسية
            _buildMainScanBanner(context),
            const SizedBox(height: 22),

            // الخدمات والوصول السريع
            const Text(
              'الخدمات السريعة',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            _buildQuickServicesGrid(context),
            const SizedBox(height: 22),

            // آخر الفحوصات
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'آخر الفحوصات والتشخيصات',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                TextButton(
                  onPressed: onNavigateToEncyclopedia,
                  child: const Text('عرض الكل'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...recentScans.map((scan) => _buildRecentScanItem(context, scan)),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherAdvisoryCard() {
    return Card(
      color: const Color(0xFFE8F5E9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.wb_sunny, color: AppColors.warning, size: 32),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'طقس اليوم في مزرعتك: 28° مئوية (مشمس)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.primaryDark),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'نصيحة اليوم: سرعة الرياح هادئة (8 كم/س)، الوقت مثالي للرش الوقائي قبل اشتداد حرارة الظهيرة.',
                    style: TextStyle(fontSize: 12, color: AppColors.textPrimary, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainScanBanner(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryDark, AppColors.primary],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'هل لاحظت اصفراراً أو بقعاً؟',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'التقط صورة لورقة النبات وسيتولى الذكاء الاصطناعي تشخيص المرض فوراً مع العلاج المناسب.',
                  style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                ),
                const SizedBox(height: 14),
                ElevatedButton.icon(
                  onPressed: onNavigateToScan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primaryDark,
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.camera_alt, color: AppColors.primaryDark),
                  label: const Text('افحص محصولك الآن', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.document_scanner_outlined, size: 70, color: Colors.white30),
        ],
      ),
    );
  }

  Widget _buildQuickServicesGrid(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildServiceCard(
            icon: Icons.menu_book_outlined,
            title: 'موسوعة الآفات',
            subtitle: 'دليل أمراض النبات',
            color: Colors.blue,
            onTap: onNavigateToEncyclopedia,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildServiceCard(
            icon: Icons.support_agent_outlined,
            title: 'استشارة مهندس',
            subtitle: 'تواصل مع خبير',
            color: AppColors.primary,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('خدمة الاستشارة المباشرة متاحة من 8 صباحاً حتى 6 مساءً')),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentScanItem(BuildContext context, DiagnosisResult scan) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.eco, color: AppColors.primary),
        ),
        title: Text(
          'محصول ${scan.cropName} - ${scan.diseaseName}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(
          'دقة التشخيص ${(scan.confidence * 100).toInt()}% • الخطورة: ${scan.severity}',
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DiagnosisResultScreen(result: scan),
            ),
          );
        },
      ),
    );
  }
}
