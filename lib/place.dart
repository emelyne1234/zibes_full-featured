class Place {
  final List<String> images;
  final String name;
  final String description;
  final double price;

  Place({
    required this.images,
    required this.name,
    required this.description,
    required this.price,
  });
}

List<Place> placesList = [
  Place(
    images: [
      "https://images.unsplash.com/photo-1665069671597-1143b859fecb?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8QWthZ2VyYXxlbnwwfHwwfHx8MA%3D%3D",
      "https://images.unsplash.com/photo-1665069671745-3b67372facbf?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8QWthZ2VyYXxlbnwwfHwwfHx8MA%3D%3D",
    ],
    name: 'Akagera Game Park',
    description:
        'Akagera is Central Africa\'s largest protected wetland and the last remaining refuge for savannah-adapted species in Rwanda.',
    price: 100.0,
  ),
  Place(
    images: [
      "https://images.unsplash.com/photo-1489640818597-89b1edc97db5?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Tnl1bmd3ZXxlbnwwfHwwfHx8MA%3D%3D",
    ],
    name: 'Nyungwe Forest',
    description: 'Nyungwe Forest is a preserved part of rainforest in Rwanda.',
    price: 120.0,
  ),
  Place(
    images: [
      "https://lh5.googleusercontent.com/tTujAra6jJHvoGZPb7DOOZl0r5QcflIKGgSi1Ev5euN3pKp4CKrkfZv1VI9vkM6h9c-pyDrZePWgbomt6yFF7oqaHr2cgKPAGDj09IayvQjBVpZh-7CdIpanyRKtY0B1EYhzLux-Nb-LcOzolE71jnI",
      "https://c8.alamy.com/comp/BDM42R/national-museum-butare-rwanda-BDM42R.jpg"
    ],
    name: 'National Museum Of Rwanda',
    description:
        'The national museum is chamber of most of the past Rwanda and the previous houses',
    price: 150.0,
  ),
  Place(
    images: [
      "https://images.unsplash.com/photo-1676102818778-7dedb5cdad46?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "https://images.unsplash.com/photo-1667504320745-eade6c25e053?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    ],
    name: 'Virunga National Park',
    description: 'A park of Gorillas and volcanoes',
    price: 90.0,
  ),
  Place(
    images: [
      "https://live.staticflickr.com/65535/52390677349_84cb726e11_b.jpg"
    ],
    name: 'Nyandungu Eco-Park',
    description:
        'Wetland  convervation park based in Kigali the capital of rwanda',
    price: 50.0,
  ),
];
