import 'package:flutter/material.dart';
import '../models/diagnosis_model.dart';
import '../theme/app_theme.dart';

class DiagnosisResultScreen extends StatelessWidget {
  final DiagnosisResult result;

  const DiagnosisResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    Color severityColor;
    switch (result.severity) {
      case 'شديدة':
        severityColor = AppColors.danger;
        break;
      case 'متوسطة':
        severityColor = AppColors.warning;
        break;
      default:
        severityColor = AppColors.success;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('تقرير تشخيص المحصول'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم نسخ رابط التقرير لمشاركته مع المرشد الزراعي')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // بطاقة النتيجة الأساسية
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.12),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.eco, color: AppColors.primary, size: 36),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'محصول ${result.cropName}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                result.diseaseName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(
                          icon: Icons.verified,
                          color: AppColors.primary,
                          label: 'دقة التشخيص',
                          value: '${(result.confidence * 100).toInt()}%',
                        ),
                        Container(height: 36, width: 1, color: Colors.grey.shade300),
                        _buildStatItem(
                          icon: Icons.warning_amber_rounded,
                          color: severityColor,
                          label: 'درجة الخطورة',
                          value: result.severity,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // قسم الأعراض
            _buildSectionCard(
              title: 'الأعراض الملاحظة',
              icon: Icons.remove_red_eye_outlined,
              iconColor: Colors.blue,
              content: Text(
                result.symptoms,
                style: const TextStyle(fontSize: 15, height: 1.6),
              ),
            ),
            const SizedBox(height: 16),

            // قسم المكافحة الحيوية والطبيعية
            _buildSectionCard(
              title: 'العلاج الحيوي والوقائي (آمن للتربة)',
              icon: Icons.nature_outlined,
              iconColor: AppColors.success,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: result.organicTreatment
                    .map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.check_circle, size: 18, color: AppColors.success),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(item, style: const TextStyle(fontSize: 14, height: 1.5)),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),

            // قسم العلاج الكيميائي والمبيدات الموصى بها
            _buildSectionCard(
              title: 'العلاج الكيميائي والمبيدات المعتمدة',
              icon: Icons.science_outlined,
              iconColor: AppColors.warning,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: result.chemicalTreatment
                    .map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.medication_liquid_outlined, size: 18, color: AppColors.warning),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(item, style: const TextStyle(fontSize: 14, height: 1.5)),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),

            // الإجراءات الوقائية
            _buildSectionCard(
              title: 'إرشادات وقائية لتفادي تكرار الإصابة',
              icon: Icons.shield_outlined,
              iconColor: AppColors.primary,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: result.preventionTips
                    .map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.arrow_circle_left_outlined, size: 18, color: AppColors.primary),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(item, style: const TextStyle(fontSize: 14, height: 1.5)),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 24),

            // زر استشارة خبير
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('جارٍ تحويلك للتواصل المباشر مع المرشد الزراعي المعتمد...')),
                  );
                },
                icon: const Icon(Icons.support_agent),
                label: const Text('استشارة مهندس زراعي متخصص'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required Color color,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Widget content,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 22),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            content,
          ],
        ),
      ),
    );
  }
}
