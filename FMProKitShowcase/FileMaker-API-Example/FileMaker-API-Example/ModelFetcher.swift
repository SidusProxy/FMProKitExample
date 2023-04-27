import Foundation

class ModelFetcher {
    //Support Struct to decode properly JSON Response
    struct FMClientValue: Codable{
        var value: [Client]
    }
    
    //Singleton Design Pattern
    static let shared = ModelFetcher()
    //Set API parameters
    var hostname: String = "napoli.fm-testing.com"
    var dbname: String = "Shop"
    var username: String = "Admin"
    var password: String = "admin"
    var baseuri: String
    var authdata: String
    
    private init() {
        //Create the base URI path
        baseuri = "https://\(hostname)/fmi/odata/v4/\(dbname)"
        //Set authorization credentials
        authdata = (username + ":" + password).data(using: .utf8)!.base64EncodedString()
    }
    
    public func getClients() async throws -> [Client]{
        //Build the request
        var urlRequest: URLRequest = URLRequest(url: URL(string: "\(baseuri)/Clients")!)
        //Set Headers and Method
        urlRequest.setValue("Basic \(authdata)", forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "GET"
        //Send the request
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        //Check HTTP response code in case of errors
        guard ((response as? HTTPURLResponse)?.statusCode ?? 500 < 300) else {
            throw HTTPError.httpError
        }
        //Process the results
        let fetchedData = try JSONDecoder().decode(FMClientValue.self, from: data)
        return fetchedData.value
    }
    
    
    public func addClient(client: Client) async throws{
        //Build the request
        var urlRequest: URLRequest = URLRequest(url: URL(string: "\(baseuri)/Clients")!)
        //Set Headers and Method
        urlRequest.setValue("Basic \(authdata)", forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //Send the request
        let encoded = try JSONEncoder().encode(client)
        let (_, response) = try await URLSession.shared.upload(for: urlRequest, from: encoded)
        //Check HTTP response code in case of errors
        guard ((response as? HTTPURLResponse)?.statusCode ?? 500 < 300) else {
            throw HTTPError.httpError
        }
    }
    
    
    public func editClient(client: Client,id:Int) async throws{
        //Build the request
        var urlRequest: URLRequest = URLRequest(url: URL(string: "\(baseuri)/Clients(\(id))")!)
        //Set Headers and Method
        urlRequest.setValue("Basic \(authdata)", forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "PATCH"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //Send the request
        let encoded = try JSONEncoder().encode(client)
        let (_, response) = try await URLSession.shared.upload(for: urlRequest, from: encoded)
        //Check HTTP response code in case of errors
        guard ((response as? HTTPURLResponse)?.statusCode ?? 500 < 300) else {
            throw HTTPError.httpError
        }
    }
}
