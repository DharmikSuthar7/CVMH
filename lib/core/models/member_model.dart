class MemberModel {
  final String id;
  final String name;
  final String avatarInitials;
  final double amountOwed;
  final bool isPaid;
  final String? phoneNumber; // Added for offline WhatsApp members

  const MemberModel({
    required this.id,
    required this.name,
    required this.avatarInitials,
    required this.amountOwed,
    required this.isPaid,
    this.phoneNumber,
  });
}
