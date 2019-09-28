import Foundation

struct Defaults {

    static let Latitude: Double = 51.400592
    static let Longitude: Double = 4.760970

}

struct API {

    static let APIKey = "ec4a24cc5850c748449ae2fdacf8fa4e"
    static let BaseURL = URL(string: "https://api.darksky.net/forecast/")!

    static var AuthenticatedBaseURL: URL {
        return BaseURL.appendingPathComponent(APIKey)
    }
    
}
