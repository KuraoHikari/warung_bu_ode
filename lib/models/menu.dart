class MenuItem {
  int id;
  String title;
  double price;
  String desc;
  String image;
  int quantity; // Add this line

  MenuItem({
    required this.id,
    required this.title,
    required this.price,
    required this.desc,
    required this.image,
    this.quantity = 1, // And this line
  });

  // Update your toJson and fromJson methods to include the quantity field
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'desc': desc,
        'image': image,
        'quantity': quantity, // And this line
      };

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        desc: json['desc'],
        image: json['image'],
        quantity: json['quantity'] ?? 1, // And this line
      );
}

class MenuWarung {
  // Daftar makanan
  static List<MenuItem> makanan = [
    MenuItem(
        id: 1,
        title: "Nasi Goreng",
        price: 15000,
        desc:
            "Hidangan klasik Indonesia ini terdiri dari nasi goreng dengan telur, ayam, dan berbagai macam sayuran seperti kol, wortel, dan daun bawang. Rasanya gurih dan sedikit pedas, dilengkapi dengan bawang goreng dan kerupuk untuk menambah tekstur. Cocok dinikmati sebagai sarapan, makan siang, atau makan malam.",
        image: "assets/images/nasi_goreng.jpeg"),
    MenuItem(
        id: 2,
        title: "Mie Goreng",
        price: 12000,
        desc:
            "Mi kuning yang digoreng dengan telur, ayam, dan sayuran seperti kol, wortel, dan daun bawang. Rasanya pedas dan gurih, dengan aroma khas dari bumbu rempah-rempah. Biasanya disajikan dengan acar timun dan kerupuk sebagai pelengkap.",
        image: "assets/images/mie_goreng.jpg"),
    MenuItem(
        id: 3,
        title: "Soto Ayam",
        price: 20000,
        desc:
            "Sup ayam kuning yang kaya rasa dengan kuah kaldu gurih dan rempah-rempah. Di dalamnya terdapat potongan ayam suwir, telur rebus, kol, tomat, dan bawang goreng. Biasanya disajikan dengan nasi putih, sambal, dan jeruk nipis untuk menambah rasa.",
        image: "assets/images/soto_ayam.jpg"),
    MenuItem(
        id: 4,
        title: "Ayam Bakar",
        price: 18000,
        desc:
            "Potongan ayam yang dibakar dengan bumbu kecap manis dan rempah-rempah, menghasilkan rasa manis, gurih, dan sedikit pedas. Biasanya disajikan dengan nasi putih, sambal, lalapan (sayuran segar), dan sambal kecap.",
        image: "assets/images/ayam_bakar.jpg"),
    MenuItem(
        id: 5,
        title: "Gado-Gado",
        price: 15000,
        desc:
            "Salad khas Indonesia dengan berbagai macam sayuran rebus seperti kacang panjang, bayam, kangkung, dan kentang. Disiram dengan saus kacang yang gurih dan manis, dan dilengkapi dengan lontong, emping, dan kerupuk.",
        image: "assets/images/gado_gado.jpg"),
  ];

  // Daftar minuman
  static List<MenuItem> minuman = [
    MenuItem(
        id: 6,
        title: "Es Teh Manis",
        price: 5000,
        desc:
            "Minuman menyegarkan yang terbuat dari teh hijau yang diseduh dengan air panas dan dicampur dengan gula. Rasanya manis dan sedikit pahit, cocok untuk dinikmati saat cuaca panas.",
        image: "assets/images/es_teh_manis.jpg"),
    MenuItem(
        id: 7,
        title: "Es Jeruk",
        price: 7000,
        desc:
            "Minuman segar yang terbuat dari air jeruk nipis yang dicampur dengan gula dan es batu. Rasanya asam manis dan menyegarkan, kaya akan vitamin C.",
        image: "assets/images/es_jeruk.jpg"),
    MenuItem(
        id: 8,
        title: "Kopi Susu",
        price: 10000,
        desc:
            "Perpaduan kopi dan susu yang menghasilkan rasa creamy dan sedikit pahit. Cocok dinikmati sebagai sarapan atau di pagi hari.",
        image: "assets/images/kopi_susu.jpg"),
    MenuItem(
        id: 9,
        title: "Teh Tarik",
        price: 8000,
        desc:
            "Teh tarik adalah teh khas Malaysia yang dibuat dengan cara menuangkan teh dari satu gelas ke gelas lain berulang kali, menghasilkan busa yang creamy. Biasanya dicampur dengan susu kental manis untuk menambah rasa manis dan creamy.",
        image: "assets/images/teh_tarik.jpg"),
    MenuItem(
        id: 10,
        title: "Es Cendol",
        price: 12000,
        desc:
            "Minuman dingin khas Indonesia yang terbuat dari tepung beras yang dibentuk seperti cendol, disiram dengan santan, gula merah cair, dan es serut. Rasanya manis, gurih, dan menyegarkan, cocok dinikmati saat cuaca panas.",
        image: "assets/images/es_cendol.jpg"),
  ];
}
