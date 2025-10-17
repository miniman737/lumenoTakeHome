//
//  Profile.swift
//  lumenoTakeHome
//
//  Created by Marcus Ganz on 2025-10-16.
//

// api example to hit
//$.ajax({
//  url: 'https://randomuser.me/api/',
//  dataType: 'json',
//  success: function(data) {
//    console.log(data);
//  }
//});
//{
//  "results": [
//    {
//      "gender": "female",
//      "name": {
//        "title": "Miss",
//        "first": "Jennie",
//        "last": "Nichols"
//      },
//      "location": {
//        "street": {
//          "number": 8929,
//          "name": "Valwood Pkwy",
//        },
//        "city": "Billings",
//        "state": "Michigan",
//        "country": "United States",
//        "postcode": "63104",
//        "coordinates": {
//          "latitude": "-69.8246",
//          "longitude": "134.8719"
//        },
//        "timezone": {
//          "offset": "+9:30",
//          "description": "Adelaide, Darwin"
//        }
//      },
//      "email": "jennie.nichols@example.com",
//      "login": {
//        "uuid": "7a0eed16-9430-4d68-901f-c0d4c1c3bf00",
//        "username": "yellowpeacock117",
//        "password": "addison",
//        "salt": "sld1yGtd",
//        "md5": "ab54ac4c0be9480ae8fa5e9e2a5196a3",
//        "sha1": "edcf2ce613cbdea349133c52dc2f3b83168dc51b",
//        "sha256": "48df5229235ada28389b91e60a935e4f9b73eb4bdb855ef9258a1751f10bdc5d"
//      },
//      "dob": {
//        "date": "1992-03-08T15:13:16.688Z",
//        "age": 30
//      },
//      "registered": {
//        "date": "2007-07-09T05:51:59.390Z",
//        "age": 14
//      },
//      "phone": "(272) 790-0888",
//      "cell": "(489) 330-2385",
//      "id": {
//        "name": "SSN",
//        "value": "405-88-3636"
//      },
//      "picture": {
//        "large": "https://randomuser.me/api/portraits/men/75.jpg",
//        "medium": "https://randomuser.me/api/portraits/med/men/75.jpg",
//        "thumbnail": "https://randomuser.me/api/portraits/thumb/men/75.jpg"
//      },
//      "nat": "US"
//    }
//  ],
//  "info": {
//    "seed": "56d27f4a53bd5441",
//    "results": 1,
//    "page": 1,
//    "version": "1.4"
//  }
//}
import Foundation

struct ProfileResponse: Codable {
    let results: [Profile]
}
//Name
//profile picture
// email
// location
struct Profile: Codable, Identifiable, Hashable {
    let id: UUID
    let name: Name
    let location: Location
    let email: String
    let phone: String
    let cell: String
    let picture: Picture
    let login: Login

    enum CodingKeys: String, CodingKey {
        case name, location, email, phone, cell, picture, login
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(Name.self, forKey: .name)
        self.location = try container.decode(Location.self, forKey: .location)
        self.email = try container.decode(String.self, forKey: .email)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.cell = try container.decode(String.self, forKey: .cell)
        self.picture = try container.decode(Picture.self, forKey: .picture)
        self.login = try container.decode(Login.self, forKey: .login)
        
        guard let uuid = UUID(uuidString: self.login.uuid) else {
            throw DecodingError.dataCorruptedError(forKey: .login, in: container, debugDescription: "Invalid UUID")
        }
        self.id = uuid
    }
}

struct Name: Codable, Hashable {
    let title: String
    let first: String
    let last: String
}

struct Location: Codable, Hashable {
    let street: Street
    let city: String
    let state: String
    let country: String
}

struct Street: Codable, Hashable {
    let number: Int
    let name: String
}

struct Login: Codable, Hashable {
    let uuid: String
}

struct Picture: Codable, Hashable {
    let large: String
    let medium: String
    let thumbnail: String
}

