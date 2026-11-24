class DiagnosisResult {
  final String id;
  final String cropName;
  final String diseaseName;
  final double confidence;
  final String severity; // عالي، متوسط، منخفض
  final String symptoms;
  final List<String> chemicalTreatment;
  final List<String> organicTreatment;
  final List<String> preventionTips;
  final DateTime date;
  final String? imagePlaceholder;

  DiagnosisResult({
    required this.id,
    required this.cropName,
    required this.diseaseName,
    required this.confidence,
    required this.severity,
    required this.symptoms,
    required this.chemicalTreatment,
    required this.organicTreatment,
    required this.preventionTips,
    required this.date,
    this.imagePlaceholder,
  });

  static List<DiagnosisResult> getSampleData() {
    return [
      DiagnosisResult(
        id: '1',
        cropName: 'الطماطم',
        diseaseName: 'اللفحة المتأخرة (Late Blight)',
        confidence: 0.94,
        severity: 'شديدة',
        symptoms: 'ظهور بقع بنية داكنة غير منتظمة على حواف الأوراق مع وجود زغب أبيض خفيف على السطح السفلي في الأجواء الرطبة.',
        chemicalTreatment: [
          'رش مبيد فطري نحاسي (أوكسي كلوريد النحاس) بتركيز 2.5 جم/لتر.',
          'استخدام ميتالاكسيل أو سيموكسانيل في الحالات المتقدمة.',
        ],
        organicTreatment: [
          'رش منقوع شاي الكومبوست المقاوم للفطريات.',
          'إزالة وحرق الأوراق المصابة فوراً لمنع انتشار العدوى.',
          'التهوية الجيدة بين الشتلات وتجنب الري بالرشاشات الرأسية.',
        ],
        preventionTips: [
          'زراعة أصناف مقاومة أو متحملة للفحة.',
          'تجنب الري في ساعات المساء لعدم مكوث الماء على الأوراق.',
          'تطبيق دورة زراعية ثلاثية.',
        ],
        date: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      DiagnosisResult(
        id: '2',
        cropName: 'القمح',
        diseaseName: 'صدأ الأوراق (Leaf Rust)',
        confidence: 0.88,
        severity: 'متوسطة',
        symptoms: 'بثرات برتقالية إلى بنية محمرة موزعة عشوائياً على السطح العلوي للأوراق.',
        chemicalTreatment: [
          'رش مركبات التريازول (مثل تيبوكونازول) بمعدل الموصى به.',
        ],
        organicTreatment: [
          'رش مستخلص زيت النيم 1% للمكافحة المبكرة.',
        ],
        preventionTips: [
          'الالتزام بمواعيد الزراعة الموصى بها في منطقتك.',
          'زراعة تقاوي معتمدة ومقاومة للأصداء.',
        ],
        date: DateTime.now().subtract(const Duration(days: 1)),
      ),
      DiagnosisResult(
        id: '3',
        cropName: 'البطاطس',
        diseaseName: 'نقص عنصر الماغنسيوم (Magnesium Deficiency)',
        confidence: 0.91,
        severity: 'منخفضة',
        symptoms: 'اصفرار بين عروق الأوراق المسنة مع بقاء العروق خضراء.',
        chemicalTreatment: [
          'تسميد ورقي بكبريتات الماغنسيوم (سلفات ماغنسيوم 2%).',
        ],
        organicTreatment: [
          'إضافة صخور الدولومايت المطحونة للتربة لتعديل الماغنسيوم والكالسيوم.',
        ],
        preventionTips: [
          'فحص التربة وتحليل نسبة العناصر بانتظام قبل بدء الموسم.',
        ],
        date: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];
  }
}
