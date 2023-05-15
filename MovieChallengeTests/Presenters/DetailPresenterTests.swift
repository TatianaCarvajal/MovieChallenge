//
//  DetailPresenterTests.swift
//  MovieChallengeTests
//
//  Created by Tatiana Carvajal on 11/05/23.
//

import XCTest
@testable import MovieChallenge

final class DetailPresenterTests: XCTestCase {

    func testFetchDetailMovie() {
        // Given
        let presenter = DetailPresenter(service: ServiceProtocolMock(), movieId: 0)
        
        // When
        presenter.fetchDetailMovie()
        
        // Then
        XCTAssertEqual(presenter.movie?.title, "Mock Movie")
        XCTAssertEqual(presenter.movie?.adult, false)
        XCTAssertEqual(presenter.movie?.originalLanguage, "Es")
        XCTAssertEqual(presenter.movie?.popularity, 10.0)
        XCTAssertEqual(presenter.movie?.poster, "poster")
        XCTAssertEqual(presenter.movie?.id, 999)
        XCTAssertEqual(presenter.movie?.overview, "Overview mock")
    }

    func testGetMoviePoster_givenNoMovie_shouldReturnNil() {
        // Given
        let presenter = DetailPresenter(service: ServiceProtocolMock(), movieId: 0)
        
        // When
        let url = presenter.getMoviePoster()
        
        // Then
        XCTAssertNil(url)
    }
    
    func testGetMoviePoster_givenMovie_shouldReturnUrl() {
        // Given
        let presenter = DetailPresenter(service: ServiceProtocolMock(), movieId: 0)
        presenter.fetchDetailMovie()
        
        // When
        let url = presenter.getMoviePoster()
        
        // Then
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.absoluteString, "https://image.tmdb.org/t/p/w500\(presenter.movie!.poster)")
    }
    
    func testGetMoviePopularity_givenNoMovie_shouldReturnNil() {
        // Given
        let presenter = DetailPresenter(service: ServiceProtocolMock(), movieId: 0)
        
        // When
        let popularity = presenter.getMoviePopularity()
        
        // Then
        XCTAssertNil(popularity)
        
    }
    
    func testGetMoviePopularity_givenMovie_shouldReturnString() {
        // Given
        let presenter = DetailPresenter(service: ServiceProtocolMock(), movieId: 0)
        presenter.fetchDetailMovie()
        
        // When
        let popularity = presenter.getMoviePopularity()
        
        // Then
        XCTAssertNotNil(popularity)
        XCTAssertEqual(popularity, "Popularity \(presenter.movie!.popularity)")
    }
}
