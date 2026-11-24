import 'package:flutter/material.dart';
import '../models/diagnosis_model.dart';
import '../theme/app_theme.dart';
import 'diagnosis_result_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String _selectedCrop = 'طماطم';
  bool _isAnalyzing = false;

  final List<String> _crops = ['طماطم', 'قمح', 'بطاطس', 'ذرة', 'موالح', 'خيار'];

  void _startAnalysis() {
    setState(() {
      _isAnalyzing = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _isAnalyzing = false;
      });

      final sample = DiagnosisResult.getSampleData().first;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DiagnosisResultScreen(result: sample),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('فحص ورقة المحصول'),
      ),
      body: _isAnalyzing
          ? _buildAnalyzingView()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // اختيار نوع المحصول
                  const Text(
                    'اختر نوع المحصول المراد فحصه:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 44,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _crops.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final crop = _crops[index];
                        final isSelected = crop == _selectedCrop;
                        return ChoiceChip(
                          label: Text(crop),
                          selected: isSelected,
                          selectedColor: AppColors.primary,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                          onSelected: (selected) {
                            if (selected) {
                              setState(() => _selectedCrop = crop);
                            }
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // إطار معاينة الكاميرا
                  Container(
                    height: 320,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primary.withOpacity(0.4), width: 2),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              size: 72,
                              color: AppColors.primary.withOpacity(0.7),
                            ),
                            const SizedBox(height: 14),
                            const Text(
                              'ضع الورقة المصابة داخل الإطار بوضوح',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'تأكد من وجود إضاءة شمس كافية وعدم اهتزاز الكاميرا',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        // زوايا توجيه التصوير
                        Positioned(
                          top: 16,
                          left: 16,
                          child: _buildCorner(isTop: true, isLeft: true),
                        ),
                        Positioned(
                          top: 16,
                          right: 16,
                          child: _buildCorner(isTop: true, isLeft: false),
                        ),
                        Positioned(
                          bottom: 16,
                          left: 16,
                          child: _buildCorner(isTop: false, isLeft: true),
                        ),
                        Positioned(
                          bottom: 16,
                          right: 16,
                          child: _buildCorner(isTop: false, isLeft: false),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // أزرار التقاط الصورة
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ElevatedButton.icon(
                          onPressed: _startAnalysis,
                          icon: const Icon(Icons.camera),
                          label: const Text('التقاط وفحص الآن'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 1,
                        child: OutlinedButton.icon(
                          onPressed: _startAnalysis,
                          icon: const Icon(Icons.photo_library, color: AppColors.primary),
                          label: const Text('المعرض', style: TextStyle(color: AppColors.primary)),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: const BorderSide(color: AppColors.primary, width: 1.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // نصائح التصوير
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.lightbulb_outline, color: AppColors.primary, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'نصيحة: صوّر الورقة من مسافة 15 إلى 25 سم بحيث تغطي البقع المرضية معظم مساحة الصورة للوصول لدقة تشخيص تفوق 95%.',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textPrimary,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildAnalyzingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(
              strokeWidth: 6,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'جارٍ تحليل أعراض ورقة المحصول...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'يقوم الذكاء الاصطناعي بمقارنة البقع مع قاعدة بيانات أمراض $_selectedCrop',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorner({required bool isTop, required bool isLeft}) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        border: Border(
          top: isTop ? const BorderSide(color: AppColors.primary, width: 3) : BorderSide.none,
          bottom: !isTop ? const BorderSide(color: AppColors.primary, width: 3) : BorderSide.none,
          left: isLeft ? const BorderSide(color: AppColors.primary, width: 3) : BorderSide.none,
          right: !isLeft ? const BorderSide(color: AppColors.primary, width: 3) : BorderSide.none,
        ),
      ),
    );
  }
}
