class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String hospitalName;
  final String imageUrl;
  final double rating;
  final int reviewsCount;
  final int experienceYears;
  final int patientsCount;
  final String about;
  final int consultationFee;
  final bool availableToday;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.hospitalName,
    required this.imageUrl,
    required this.rating,
    required this.reviewsCount,
    required this.experienceYears,
    required this.patientsCount,
    required this.about,
    required this.consultationFee,
    required this.availableToday,
  });

  String get formattedPatients {
    if (patientsCount >= 1000) {
      return '${(patientsCount / 1000).toStringAsFixed(1)}K+';
    }
    return patientsCount.toString();
  }
}

final List<Doctor> dummyDoctors = [
  const Doctor(
    id: 'doc_1',
    name: 'Dr. Sarah Ahmed',
    specialty: 'Cardiologist',
    hospitalName: 'City Medical Center',
    imageUrl:
        'https://images.unsplash.com/photo-1594824476967-48c8b964273f?w=400&q=80',
    rating: 4.9,
    reviewsCount: 248,
    experienceYears: 12,
    patientsCount: 1800,
    about:
        'Dr. Sarah Ahmed is an experienced cardiologist specializing in heart health, high blood pressure management, preventive cardiac care, and long-term cardiovascular treatment.',
    consultationFee: 2500,
    availableToday: true,
  ),
  const Doctor(
    id: 'doc_2',
    name: 'Dr. Hamza Khan',
    specialty: 'Neurologist',
    hospitalName: 'Prime Health Hospital',
    imageUrl:
        'https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=400&q=80',
    rating: 4.8,
    reviewsCount: 184,
    experienceYears: 9,
    patientsCount: 1200,
    about:
        'Dr. Hamza Khan is a skilled neurologist focused on diagnosing and treating disorders of the brain, spine, and nervous system with a patient-first approach.',
    consultationFee: 3000,
    availableToday: true,
  ),
  const Doctor(
    id: 'doc_3',
    name: 'Dr. Ayesha Noor',
    specialty: 'Dermatologist',
    hospitalName: 'Skin Care Institute',
    imageUrl:
        'https://images.unsplash.com/photo-1651008376811-b90baee60c1f?w=400&q=80',
    rating: 4.7,
    reviewsCount: 159,
    experienceYears: 7,
    patientsCount: 950,
    about:
        'Dr. Ayesha Noor is a dermatologist dedicated to skin health, cosmetic dermatology, and the treatment of chronic skin conditions.',
    consultationFee: 2200,
    availableToday: false,
  ),
];