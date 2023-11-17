void main(List<String> arguments) {
  print(miniMaxSum([1,3,5,7,9]));
}
String miniMaxSum(List<int> nums) {
  int sum = nums.reduce((value, element) => value + element);
  List<int> numEven = [];
  List<int> numOdd = [];
  int max = sum - nums.first;
  int min = sum - nums.first;


  for (int i = 0; i < nums.length; i++) {
    nums[i] % 2 == 0 ? numEven.add(nums[i]) : numOdd.add(nums[i]);

    final numSubtract = sum - nums[i];
    max = max > numSubtract ? max : numSubtract;
    min = min < numSubtract ? min : numSubtract;
  }
  return "min : $min\nmax : $max\nnums odd : ${numOdd.join(",")}\nnums even : ${numEven.join(",")}\ncount total array : $sum";
}