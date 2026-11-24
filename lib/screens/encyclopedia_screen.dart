import 'package:flutter/material.dart';
import '../models/diagnosis_model.dart';
import '../theme/app_theme.dart';
import 'diagnosis_result_screen.dart';

class EncyclopediaScreen extends StatefulWidget {
  const EncyclopediaScreen({super.key});

  @override
  State<EncyclopediaScreen> createState() => _EncyclopediaScreenState();
}

class _EncyclopediaScreenState extends State<EncyclopediaScreen> {
  String _searchQuery = '';
  String _selectedCrop = 'الكل';
  final List<String> _filters = ['الكل', 'الطماطم', 'القمح', 'البطاطس'];

  @override
  Widget build(BuildContext context) {
    final allDiseases = DiagnosisResult.getSampleData();
    final filteredDiseases = allDiseases.where((d) {
      final matchesCrop = _selectedCrop == 'الكل' || d.cropName == _selectedCrop;
      final matchesSearch = _searchQuery.isEmpty ||
          d.diseaseName.contains(_searchQuery) ||
          d.cropName.contains(_searchQuery) ||
          d.symptoms.contains(_searchQuery);
      return matchesCrop && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('دليل الآفات والأمراض الزراعية'),
      ),
      body: Column(
        children: [
          // شريط البحث
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ابحث عن اسم المرض، المحصول، أو العَرَض...',
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              onChanged: (val) {
                setState(() => _searchQuery = val);
              },
            ),
          ),

          // فلاتر المحاصيل
          SizedBox(
            height: 40,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = filter == _selectedCrop;
                return FilterChip(
                  label: Text(filter),
                  selected: isSelected,
                  selectedColor: AppColors.primary.withOpacity(0.15),
                  checkmarkColor: AppColors.primary,
                  labelStyle: TextStyle(
                    color: isSelected ? AppColors.primary : AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  onSelected: (selected) {
                    setState(() => _selectedCrop = filter);
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 12),

          // قائمة الأمراض
          Expanded(
            child: filteredDiseases.isEmpty
                ? const Center(
                    child: Text('لم يتم العثور على نتائج مطابقة للبحث'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: filteredDiseases.length,
                    itemBuilder: (context, index) {
                      final item = filteredDiseases[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.eco, color: AppColors.primary, size: 28),
                          ),
                          title: Text(
                            item.diseaseName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text('محصول: ${item.cropName}',
                                  style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              Text(
                                item.symptoms,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DiagnosisResultScreen(result: item),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
