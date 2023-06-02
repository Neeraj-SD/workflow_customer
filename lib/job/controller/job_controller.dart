import 'package:get/get.dart';
import 'package:workflow_customer/core/api_provider.dart';
import 'package:workflow_customer/job/model/job.dart';
import 'package:workflow_customer/screens/cancel_booking_screen.dart';
import 'package:workflow_customer/screens/last_booking_screen.dart';

class JobController extends GetxController {
  final ApiProvider api = Get.find();

  final activeJobs = <JobModel>[].obs;
  var activeLoading = false.obs;
  var selectedJobIndex;
  var selectedBidIndex = (-1).obs;
  late JobModel selectedJob;

  @override
  void onInit() {
    super.onInit();
    fetchActiveJobs();
  }

  void fetchActiveJobs() async {
    activeLoading(true);
    final result = await api.getApi('/api/job/jobs/?is_active=true');
    activeJobs.value = jobModelFromJson(result.body);
    activeLoading(false);
  }

  void goToJobDetailPage(int index) {
    selectedJobIndex = index;
    selectedJob = activeJobs[index];
    selectedBidIndex.value = -1;
    Get.to(CancelBookingScreen());
  }

  Future pullToRefresh() async {
    fetchActiveJobs();
    return Future.delayed(Duration(seconds: 1));
  }

  void setSelectedBid(int index) {
    selectedBidIndex.value = index;
  }

  void acceptBid() {
    if (selectedBidIndex == -1) {
      Get.snackbar(
        'No bid selected',
        'Please select a bid.',
      );
      return;
    }
    Get.off(() => LastBookingScreen(cancel: false));
  }
}
