//
//  APICaller.swift
//  CookBookUIKit
//
//  Created by Macbook on 17.12.2023.
//

import Foundation

struct Constants {
    static let key = "0c5a8841997342af86e59b720f6c2d80"
    static let baseURL = "https://api.spoonacular.com"
}

enum APIError: Error {
    case failedTogetData
    case invalidQuery
    case invalidUrl
    case invalidResponse
    case unknownError
    case emptyData
}

class APICaller {
    static let shared = APICaller()
    
    func getRandomRecipe(completion: @escaping (Result<[Model], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/recipes/random?apiKey=\(Constants.key)&number=1") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    print("Error in data task:", error.localizedDescription)
                    completion(.failure(error))
                } else {
                    print("Data is missing.")
                    completion(.failure(APIError.emptyData))
                }
                return
            }
            do {
                let response = try JSONDecoder().decode(RandomRecipeResponse.self, from: data)
                completion(.success(response.recipes))
            } catch {
                print("Error decoding data:", error.localizedDescription)
                print("Received JSON:", String(data: data, encoding: .utf8) ?? "Invalid JSON")
                completion(.failure(error))
            }
        }
        task.resume()
    }

    func getQuickRecipes(completion: @escaping (Result<[Model], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/recipes/complexSearch?apiKey=\(Constants.key)&maxReadyTime=30") else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    print("Error in data task:", error.localizedDescription)
                    completion(.failure(error))
                } else {
                    print("Data is missing.")
                    completion(.failure(APIError.emptyData))
                }
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                print("Error decoding data:", error.localizedDescription)
                print("Received JSON:", String(data: data, encoding: .utf8) ?? "Invalid JSON")
                
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getBreakfastRecipes(completion: @escaping (Result<[Model], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/recipes/complexSearch?type=breakfast&apiKey=\(Constants.key)") else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    print("Error in data task:", error.localizedDescription)
                    completion(.failure(error))
                } else {
                    print("Data is missing.")
                    completion(.failure(APIError.emptyData))
                }
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                print("Error decoding data:", error.localizedDescription)
                print("Received JSON:", String(data: data, encoding: .utf8) ?? "Invalid JSON")
                
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getSoupRecipes(completion: @escaping (Result<[Model], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/recipes/complexSearch?type=soup&apiKey=\(Constants.key)") else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    print("Error in data task:", error.localizedDescription)
                    completion(.failure(error))
                } else {
                    print("Data is missing.")
                    completion(.failure(APIError.emptyData))
                }
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                print("Error decoding data:", error.localizedDescription)
                print("Received JSON:", String(data: data, encoding: .utf8) ?? "Invalid JSON")
                
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getVegetarianRecipes(completion: @escaping (Result<[Model], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/recipes/complexSearch?diet=vegetarian&apiKey=\(Constants.key)") else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    print("Error in data task:", error.localizedDescription)
                    completion(.failure(error))
                } else {
                    print("Data is missing.")
                    completion(.failure(APIError.emptyData))
                }
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                print("Error decoding data:", error.localizedDescription)
                print("Received JSON:", String(data: data, encoding: .utf8) ?? "Invalid JSON")
                
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getVeganRecipes(completion: @escaping (Result<[Model], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/recipes/complexSearch?diet=vegan&apiKey=\(Constants.key)") else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    print("Error in data task:", error.localizedDescription)
                    completion(.failure(error))
                } else {
                    print("Data is missing.")
                    completion(.failure(APIError.emptyData))
                }
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                print("Error decoding data:", error.localizedDescription)
                print("Received JSON:", String(data: data, encoding: .utf8) ?? "Invalid JSON")
                
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getDessertsRecipes(completion: @escaping (Result<[Model], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/recipes/complexSearch?type=dessert&apiKey=\(Constants.key)") else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    print("Error in data task:", error.localizedDescription)
                    completion(.failure(error))
                } else {
                    print("Data is missing.")
                    completion(.failure(APIError.emptyData))
                }
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                print("Error decoding data:", error.localizedDescription)
                print("Received JSON:", String(data: data, encoding: .utf8) ?? "Invalid JSON")
                
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getGlutenFreeRecipes(completion: @escaping (Result<[Model], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/recipes/complexSearch?diet=glutenFree&apiKey=\(Constants.key)") else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    print("Error in data task:", error.localizedDescription)
                    completion(.failure(error))
                } else {
                    print("Data is missing.")
                    completion(.failure(APIError.emptyData))
                }
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                print("Error decoding data:", error.localizedDescription)
                print("Received JSON:", String(data: data, encoding: .utf8) ?? "Invalid JSON")
                
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getItalianCuisineRecipes(completion: @escaping (Result<[Model], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/recipes/complexSearch?cuisine=italian&apiKey=\(Constants.key)") else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    print("Error in data task:", error.localizedDescription)
                    completion(.failure(error))
                } else {
                    print("Data is missing.")
                    completion(.failure(APIError.emptyData))
                }
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                print("Error decoding data:", error.localizedDescription)
                print("Received JSON:", String(data: data, encoding: .utf8) ?? "Invalid JSON")
                
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getFrenchCuisineRecipes(completion: @escaping (Result<[Model], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/recipes/complexSearch?cuisine=french&apiKey=\(Constants.key)") else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    print("Error in data task:", error.localizedDescription)
                    completion(.failure(error))
                } else {
                    print("Data is missing.")
                    completion(.failure(APIError.emptyData))
                }
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                print("Error decoding data:", error.localizedDescription)
                print("Received JSON:", String(data: data, encoding: .utf8) ?? "Invalid JSON")
                
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getChineseCuisineRecipes(completion: @escaping (Result<[Model], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/recipes/complexSearch?cuisine=chinese&apiKey=\(Constants.key)") else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    print("Error in data task:", error.localizedDescription)
                    completion(.failure(error))
                } else {
                    print("Data is missing.")
                    completion(.failure(APIError.emptyData))
                }
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                print("Error decoding data:", error.localizedDescription)
                print("Received JSON:", String(data: data, encoding: .utf8) ?? "Invalid JSON")
                
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getJapaneseCuisineRecipes(completion: @escaping (Result<[Model], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/recipes/complexSearch?cuisine=japanese&apiKey=\(Constants.key)") else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    print("Error in data task:", error.localizedDescription)
                    completion(.failure(error))
                } else {
                    print("Data is missing.")
                    completion(.failure(APIError.emptyData))
                }
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                print("Error decoding data:", error.localizedDescription)
                print("Received JSON:", String(data: data, encoding: .utf8) ?? "Invalid JSON")
                
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getSaladRecipes(completion: @escaping (Result<[Model], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/recipes/complexSearch?type=salad&apiKey=\(Constants.key)") else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    print("Error in data task:", error.localizedDescription)
                    completion(.failure(error))
                } else {
                    print("Data is missing.")
                    completion(.failure(APIError.emptyData))
                }
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                print("Error decoding data:", error.localizedDescription)
                print("Received JSON:", String(data: data, encoding: .utf8) ?? "Invalid JSON")
                
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getDrinkRecipes(completion: @escaping (Result<[Model], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/recipes/complexSearch?type=drink&apiKey=\(Constants.key)") else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    print("Error in data task:", error.localizedDescription)
                    completion(.failure(error))
                } else {
                    print("Data is missing.")
                    completion(.failure(APIError.emptyData))
                }
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                print("Error decoding data:", error.localizedDescription)
                print("Received JSON:", String(data: data, encoding: .utf8) ?? "Invalid JSON")
                
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getRecipe(with id: Int, completion: @escaping (Result<Model, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/recipes/\(id)/information?apiKey=\(Constants.key)") else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? APIError.unknownError))
                return
            }
            do {
                let result = try JSONDecoder().decode(Model.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getNutritionFacts(with id: Int, completion: @escaping (Result<NutritionInfo, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/recipes/\(id)/nutritionWidget.json?apiKey=\(Constants.key)") else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.emptyData))
                return
            }
            
            do {
                let nutritionInfo = try JSONDecoder().decode(NutritionInfo.self, from: data)
                completion(.success(nutritionInfo))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
