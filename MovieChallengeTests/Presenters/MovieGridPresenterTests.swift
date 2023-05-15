//
//  MovieGridPresenterTests.swift
//  MovieChallengeTests
//
//  Created by Tatiana Carvajal on 11/05/23.
//

import XCTest
@testable import MovieChallenge

final class MovieGridPresenterTests: XCTestCase {

    func testLoadMovies() {
        // Given
        let presenter = MovieGridPresenter(service: ServiceProtocolMock())
        
        // When
        presenter.loadMovies()
        
        // Then
        XCTAssertEqual(presenter.movies.first!.title, "Mock movie")
        XCTAssertEqual(presenter.movies.first!.adult, false)
        XCTAssertEqual(presenter.movies.first!.originalLanguage, "mock language")
        XCTAssertEqual(presenter.movies.first!.popularity, 0)
        XCTAssertEqual(presenter.movies.first!.poster, "Mock poster")
        XCTAssertEqual(presenter.movies.first!.id, 100)
        XCTAssertEqual(presenter.movies.first!.overview, "Mock overview")
    }
    
    func testLoadGenre() {
        // Given
        let presenter = MovieGridPresenter(service: ServiceProtocolMock())
        
        // When
        presenter.loadGenres()
        
        // Then
        XCTAssertEqual(presenter.genres.first!.name, "Mock genre")
        XCTAssertEqual(presenter.genres.first!.id, 0)
    }
    
    func testFetchMovieForGenre() {
        // Given
        let presenter = MovieGridPresenter(service: ServiceProtocolMock())
        
        // When
        presenter.fetchMoviesForGenre(id: 0)
        
        // Then
        XCTAssertEqual(presenter.movies.first!.title, "Mock movie genre")
        XCTAssertEqual(presenter.movies.first!.adult, false)
        XCTAssertEqual(presenter.movies.first!.originalLanguage, "mock language")
        XCTAssertEqual(presenter.movies.first!.popularity, 0)
        XCTAssertEqual(presenter.movies.first!.poster, "mock poster")
        XCTAssertEqual(presenter.movies.first!.id, 0)
        XCTAssertEqual(presenter.movies.first!.overview, "mock overview")
    }
    
    func testGetMoviePosterAndTitle() {
        // Given
        let presenter = MovieGridPresenter(service: ServiceProtocolMock())
        presenter.loadMovies()
        
        // When
        let (poster, title) = presenter.getMoviePosterAndTitle(pos: 0)
        
        // Then
        XCTAssertEqual(poster, "https://image.tmdb.org/t/p/w500\(presenter.movies.first!.poster)")
        
        XCTAssertEqual(title, presenter.movies.first!.title)
        
    }
    
    func testGetDetailViewController() {
        // Given
        let presenter = MovieGridPresenter(service: ServiceProtocolMock())
        
        presenter.loadMovies()
        
        // When
        let detailViewController = presenter.createDetailViewController(pos: 0)
        
        // Then
        XCTAssertEqual(detailViewController.presenter?.movieId, 100)
    }

}
