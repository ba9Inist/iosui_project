//
//  GeoMapVC.swift
//  Navigation
//
//  Created by Егор Голубев on 30.06.2025.
//

import UIKit
import MapKit
import SnapKit
import CoreLocation

class GeoMapVC: UIViewController {
    
    private lazy var selectedPoint: CLLocationCoordinate2D = {
        let point = CLLocationCoordinate2D()
        return point
    }()
    
    private lazy var map: MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = self
        let customCoordinate = CLLocationCoordinate2DMake(55.7558, 37.6173)
        let span = MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
        let region = MKCoordinateRegion(center: customCoordinate, span: span)
        map.setRegion(region, animated: true)
        return map
    }()
    
    private let locationManager = CLLocationManager()
    private lazy var geoCoder = CLGeocoder()
    
    private lazy var buttonRoute: UIButton = {
        let button = UIButton()
        button.setTitle("Проложить маршрут", for: .normal)
        button.addTarget(self , action: #selector(toucheButtonRoute), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .systemPink
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setubViews()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        map.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setubViews() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(map)
        view.addSubview(buttonRoute)
        
        map.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        buttonRoute.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).offset(-20)
            $0.left.equalTo(view.snp.left).inset(30)
            $0.right.equalTo(view.snp.right).inset(30)
            $0.height.equalTo(50)
        }
    }
    
    @objc private func toucheButtonRoute() {
        let userCoordinate = map.userLocation.coordinate
        
        guard isValidCoordinate(selectedPoint) else {
            print("Не задана точка")
            return }
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userCoordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: selectedPoint))
        request.transportType = .any
        request.requestsAlternateRoutes = true

        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let routeResponse = response else {
                if let err = error {
                    print(err.localizedDescription)
                }
                return
            }

            guard let firstRoute = routeResponse.routes.first else { return }
            
            DispatchQueue.main.async {
                self.map.addOverlay(firstRoute.polyline)
                
                let rect = firstRoute.polyline.boundingMapRect
                self.map.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
            }
        }
    }
    
    @objc func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
        
        map.removeAnnotations(map.annotations)
        map.removeOverlays(map.overlays)
        let touchPoint = gestureRecognizer.location(in: map)
        let coordinate = map.convert(touchPoint, toCoordinateFrom: map)
        selectedPoint = coordinate
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first else {
                if let err = error {
                    print("Ошибка обратного геокодинга:", err.localizedDescription)
                }
                return
            }
            annotation.title = placemark.name
        }
        map.addAnnotation(annotation)
        
    }
    
   private func isValidCoordinate(_ coordinate: CLLocationCoordinate2D) -> Bool {
        return coordinate.latitude != 0 || coordinate.longitude != 0
    }


    
    
}

extension GeoMapVC: CLLocationManagerDelegate {

}

extension GeoMapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .blue
            renderer.lineWidth = 5
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !annotation.isKind(of: MKUserLocation.self) else { return nil }
        
        let identifier = "CustomAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
}
