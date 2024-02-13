//
//  CatService.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//

import Foundation
import Alamofire

struct CatService : CatServiceProtocol {
    private let networkManager = NetworkManager<CatApi>()
    
    //The function to retrieve the cats from the bundle
    //We mark it as an async function in case in the future we want to change this behaviour and fetch from the endpoint
    func getCats() async -> RequestResponse<[Cat]> {
        //Could not read the bundle
        guard let bundle = BIMMBundles.support.bundle, let path = bundle.path(forResource: "cats", ofType: "json") else { return .init(data: nil, error: BundleError.resourceNotFound) }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let cats = try JSONDecoder().decode([CatResponse].self, from: data)
            return .init(data: cats.map { $0.toDomain() })
        } catch let error {
            return .init(data: nil, error: error)
        }
        
    }
    
    func getTags() async -> RequestResponse<[String]> {
        let response: DataResponse<[String], AFError> = await networkManager.call(.tags)
        return .init(data: response.value, error: response.error)
    }
    
    func getCat(for cat: Cat) async -> RequestResponse<CatDetail> {
        let response: DataResponse<CatDetailResponse, AFError> = await networkManager.call(.cat(id: cat.id))
        let value = response.value
        var catDetail: CatDetail? = nil
        if let value {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFractionalSeconds, .withTimeZone, .withInternetDateTime]
            catDetail = .init(
                id: cat.id,
                tags: value.tags,
                owner: cat.owner,
                mimetype: value.mimetype,
                createdAt: formatter.date(from: value.createdAt) ?? Date(),
                updatedAt: formatter.date(from: value.updatedAt) ?? Date()
            )
        }
        return .init(data: catDetail, error: response.error)
    }
}
