
abstract class MobileLoginEvent {}

class GetOtpEvent extends MobileLoginEvent {
  final String mobile;

  GetOtpEvent(this.mobile);
}
