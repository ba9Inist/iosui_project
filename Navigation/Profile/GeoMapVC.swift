//
//  GeoMapVC.swift
//  Navigation
//
//  Created by Егор Голубев on 30.06.2025.
//

import UIKit
import MapKit
import SnapKit

class GeoMapVC: UIViewController {
    
    
    private lazy var novgorodCoordinate = CLLocationCoordinate2D(latitude: 56.3275, longitude: 44.0055)
    
    private lazy var map: MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = self
        let customCoordinate = CLLocationCoordinate2DMake(55.7558, 37.6173)
        let span = MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
        let region = MKCoordinateRegion(center: customCoordinate, span: span)
        map.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = self.novgorodCoordinate
        annotation.title = "Нижний Новгород"
        map.addAnnotation(annotation)
        return map
    }()
    
    private let locationManager = CLLocationManager()
    
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
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
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
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userCoordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: novgorodCoordinate))
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
}
