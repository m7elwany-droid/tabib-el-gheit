import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي والمزرعة'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // بطاقة المزارع
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: AppColors.primary.withOpacity(0.15),
                      child: const Icon(Icons.person, size: 40, color: AppColors.primary),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'الحاج أحمد عبد الله',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'مزرعة الخير - محافظة الدقهلية',
                            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'المساحة: 5 أفدنة (طماطم وقمح)',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // قائمة الخيارات والإعدادات
            Card(
              child: Column(
                children: [
                  _buildOptionTile(
                    icon: Icons.agriculture_outlined,
                    title: 'سجل المحاصيل والمواسم الزراعية',
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  _buildOptionTile(
                    icon: Icons.history,
                    title: 'أرشيف جميع الفحوصات السابقة',
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  _buildOptionTile(
                    icon: Icons.notifications_active_outlined,
                    title: 'تنبيهات الآفات والطقس للمنطقة',
                    trailing: const Text('مفعلة', style: TextStyle(color: AppColors.primary)),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  _buildOptionTile(
                    icon: Icons.phone_in_talk_outlined,
                    title: 'الخط الساخن للإرشاد الزراعي (19500)',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('جارٍ الاتصال بالإرشاد الزراعي...')),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  _buildOptionTile(
                    icon: Icons.info_outline,
                    title: 'عن تطبيق طبيب الغيط (الإصدار 1.0)',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // زر تسجيل الخروج
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout, color: AppColors.danger),
              label: const Text(
                'تسجيل الخروج',
                style: TextStyle(color: AppColors.danger, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: const TextStyle(fontSize: 15)),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
