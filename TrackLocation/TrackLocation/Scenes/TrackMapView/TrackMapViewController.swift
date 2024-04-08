//
//  TrackMapViewController.swift
//  TrackLocation
//
//  Created by Oğuzhan Kabul on 7.04.2024.
//

import UIKit
import MapKit

final class TrackMapViewController: BaseViewController<TrackMapViewModel> {
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.isZoomEnabled = true
        mapView.isRotateEnabled = true
        return mapView
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.addTarget(self, action: #selector(startTracking), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    private lazy var stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Stop", for: .normal)
        button.addTarget(self, action: #selector(stopTracking), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Reset", for: .normal)
        button.addTarget(self, action: #selector(resetTracking), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        configureLocationManager()
        addExistingPins()
        updateUIForTrackingState(isTracking: viewModel.isTracking)
    }
    
    override func setupViews() {
        super.setupViews()
        view.addSubviews(mapView, startButton, stopButton, resetButton)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            startButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            startButton.widthAnchor.constraint(equalToConstant: 100),
            
            stopButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 20),
            stopButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stopButton.widthAnchor.constraint(equalToConstant: 100),
            
            resetButton.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: 20),
            resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resetButton.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func configureLocationManager() {
        LocationManager.shared.delegate = self
        if viewModel.isTracking {
            resumeTracking()
        } else {
            updateUIForTrackingState(isTracking: false)
        }
    }
    
    private func addExistingPins() {
        for location in viewModel.locationList {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.clLocation.coordinate
            mapView.addAnnotation(annotation)
        }
    }
    
    @objc private func startTracking() {
        viewModel.startTracking()
        updateUIForTrackingState(isTracking: true)
    }
    
    private func resumeTracking() {
        viewModel.resumeTracking()
        updateUIForTrackingState(isTracking: true)
    }
    
    @objc private func stopTracking() {
        viewModel.stopTracking()
        updateUIForTrackingState(isTracking: false)
    }
    
    @objc private func resetTracking() {
        mapView.removeAnnotations(mapView.annotations)
        viewModel.resetTracking()
        updateUIForTrackingState(isTracking: viewModel.isTracking)
    }
    
    private func updateUIForTrackingState(isTracking: Bool) {
        setButton(startButton, enabled: !isTracking)
        setButton(stopButton, enabled: isTracking)
        setButton(resetButton, enabled: !mapView.annotations.isEmpty)
    }
    
    private func addPinForLocation(_ location: CLLocation) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        mapView.addAnnotation(annotation)
    }
    
    private func setButton(_ button: UIButton, enabled: Bool) {
        button.isEnabled = enabled
        button.backgroundColor = enabled ? .systemBlue : .systemGray
        button.setTitleColor(enabled ? .white : .darkGray, for: .normal)
    }
}

extension TrackMapViewController: LocationManagerDelegate {
    func didUpdateLocations(_ locations: [CLLocation]) {
        guard let location = locations.last else { return }
        addPinForLocation(location)
    }
    
    func didChangeAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            LocationManager.shared.requestLocationAuthorization()
        case .restricted:
            viewModel.pushWarningView()
        case .denied:
            viewModel.pushWarningView()
        default:
            break
        }
    }
}

extension TrackMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        if pinView == nil {
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pinView?.canShowCallout = true
            pinView?.animatesWhenAdded = false
        } else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? MKPointAnnotation else { return }
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let _ = self, let placemark = placemarks?.first, error == nil else { return }
            let addressArray = [placemark.subThoroughfare, placemark.thoroughfare, placemark.locality, placemark.administrativeArea, placemark.country].compactMap { $0 }
            let address = addressArray.joined(separator: ", ")
            DispatchQueue.main.async {
                annotation.subtitle = address
                mapView.selectAnnotation(annotation, animated: true)
            }
        }
    }
}
