class OnBoardingContent {
  String image;
  String title;
  String description;
  OnBoardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<OnBoardingContent> contents = [
  OnBoardingContent(
    image: "images/screen1.png",
    title: "Select from our\n  Best Menu",
    description:
        "Pick Your Food From Our Menu\n             More Than 35 Times",
  ),
  OnBoardingContent(
    image: "images/screen2.png",
    title: "Easy and Online Payment",
    description:
        "You can pay cash on delivery and\n       card payment is available",
  ),
  OnBoardingContent(
    image: "images/screen3.png",
    title: "Quick Delivery at your Doorstep",
    description: "Deliver your food at \n   Yours Doorstept",
  ),
];
