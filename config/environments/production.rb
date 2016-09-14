# Copyright © Mapotempo, 2015-2016
#
# This file is part of Mapotempo.
#
# Mapotempo is free software. You can redistribute it and/or
# modify since you respect the terms of the GNU Affero General
# Public License as published by the Free Software Foundation,
# either version 3 of the License, or (at your option) any later version.
#
# Mapotempo is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE.  See the Licenses for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with Mapotempo. If not, see:
# <http://www.gnu.org/licenses/agpl.html>
#
require 'active_support'
require 'tmpdir'

require './wrappers/crow'
require './wrappers/osrm5'
require './wrappers/otp'
require './wrappers/here'

require './lib/cache_manager'

module RouterWrapper
  ActiveSupport::Cache.lookup_store :redis_store
  CACHE = CacheManager.new(ActiveSupport::Cache::RedisStore.new(host: ENV['REDIS_HOST'] || 'localhost', namespace: 'router', expires_in: 60*60*24*1, raise_errors: true))

  CROW = Wrappers::Crow.new(CACHE)
  OSRM_CAR_EUROPE = Wrappers::Osrm4.new(CACHE, url_time: 'http://localhost:5000', url_distance: 'http://localhost:5004', url_isochrone: 'http://localhost:6000', url_isodistance: 'http://localhost:6004', licence: 'ODbL', attribution: '© OpenStreetMap contributors', area: 'Europe')
  OSRM_CAR_LANDES = Wrappers::Osrm4.new(CACHE, url_time: 'http://ns4004989.ip-198-27-65.net:5000', url_distance: 'http://ns4004989.ip-198-27-65.net:5004', url_isochrone: 'http://ns4004989.ip-198-27-65.net:6000', url_isodistance: 'http://ns4004989.ip-198-27-65.net:6004', licence: 'ODbL', attribution: '© OpenStreetMap contributors', area: 'Landes, France')
  OSRM_CAR_URBAN_FRANCE = Wrappers::Osrm4.new(CACHE, url_time: 'http://localhost:5003', url_distance: 'http://localhost:5004',url_isochrone: 'http://localhost:6003', url_isodistance: 'http://localhost:6004', licence: 'ODbL', attribution: '© OpenStreetMap contributors', area: 'France')
  OSRM_PEDESTRIAN_FRANCE = Wrappers::Osrm4.new(CACHE, url_time: 'http://localhost:5002', url_isochrone: 'http://localhost:6002', licence: 'ODbL', attribution: '© OpenStreetMap contributors', area: 'France')
  OSRM_CYCLE_FRANCE = Wrappers::Osrm4.new(CACHE, url_time: 'http://localhost:5001', url_isochrone: 'http://localhost:6001', licence: 'ODbL', attribution: '© OpenStreetMap contributors', area: 'France')

  OTP = {
    bordeaux: {licence: 'ODbL', attribution: 'Bordeaux Métropole', area: 'Bordeaux, France', boundary: 'poly/france-bordeaux.kml', crs: 'EPSG:2154'},
    nantes: {licence: 'ODbL', attribution: 'Nantes Métropole', area: 'Nantes, France', boundary: 'poly/france-nantes.kml', crs: 'EPSG:2154'},
    toulouse: {licence: 'ODbL', attribution: 'Tisséo', area: 'Toulouse, France', boundary: 'poly/france-toulouse.kml', crs: 'EPSG:2154'},
    metz: {licence: 'LO', attribution: 'Metz Métropole', area: 'Metz, France', boundary: 'poly/france-metz.kml', crs: 'EPSG:2154'},
    nancy: {licence: 'ODbL', attribution: 'Communauté Urbaine du Grand Nancy', area: 'Nancy, France', boundary: 'poly/france-nancy.kml', crs: 'EPSG:2154'},
    rennes: {licence: 'ODbL', attribution: 'STAR', area: 'Rennes, France', boundary: 'poly/france-rennes.kml', crs: 'EPSG:2154'},
    strasbourg: {licence: '', attribution: 'Compagnie des Transports Strasbourgeois', area: 'Strasbourg, France', boundary: 'poly/france-strasbourg.kml', crs: 'EPSG:2154'},
    idf: {licence: 'ODbL', attribution: 'STIF', area: 'Île-de-France, France', boundary: 'poly/france-idf.kml', crs: 'EPSG:2154'},
    grenoble: {licence: 'ODbL', attribution: 'Grenoble Alpes Métropole', area: 'Grenoble, France', boundary: 'poly/france-grenoble.kml', crs: 'EPSG:2154'},
    marseille: {licence: 'ODbL', attribution: 'Syndicat Mixte des Transports des Bouches-du-Rhône', area: 'Marseille, France', boundary: 'poly/france-marseille.kml', crs: 'EPSG:2154'},
    nice: {licence: 'LO', attribution: 'Régie Ligne d''Azur', area: 'Nice, France', boundary: 'poly/france-nice.kml', crs: 'EPSG:2154'},
    brest: {licence: 'LO', attribution: 'Bibus Brest Métropole', area: 'Brest, France', boundary: 'poly/france-brest.kml', crs: 'EPSG:2154'},
  }.collect{ |k, v|
    Wrappers::Otp.new(CACHE, v.merge(url: 'http://localhost:7000', router_id: k.to_s))
  }

  HERE_APP_ID = 'yihiGwg1ibLi0q6BfBOa'
  HERE_APP_CODE = '5GEGWZnjPAA-ZIwc7DF3Mw'
  HERE_TRUCK = Wrappers::Here.new(CACHE, app_id: HERE_APP_ID, app_code: HERE_APP_CODE, mode: 'truck')

  @@c = {
    product_title: 'Router Wrapper API',
    product_contact_email: 'tech@mapotempo.com',
    product_contact_url: 'https://github.com/Mapotempo/router-wrapper',
    profiles: [{
      api_keys: [
        'demo',
        'apologic-1-9f9f5d62b4c32ce08f7f1bd144133e088f59c445',
        'apologic-beta-79728b4dbd59e080d36ba862d592d694',
        'alyacom-test-e2f5c1a84d810f6a9a7cb6ba969300dab6324c16a1f496e389953f67',
      ],
      services: {
        route_default: :car,
        route: {
          car: [OSRM_CAR_EUROPE],
          car_urban: [OSRM_CAR_URBAN_FRANCE],
          pedestrian: [OSRM_PEDESTRIAN_FRANCE],
          cycle: [OSRM_CYCLE_FRANCE],
          public_transport: OTP,
          crow: [CROW],
        },
        matrix: {
          car: [OSRM_CAR_EUROPE],
          car_urban: [OSRM_CAR_URBAN_FRANCE],
          pedestrian: [OSRM_PEDESTRIAN_FRANCE],
          cycle: [OSRM_CYCLE_FRANCE],
          public_transport: OTP,
          crow: [CROW],
        },
        isoline: {
          car: [OSRM_CAR_EUROPE],
          car_urban: [OSRM_CAR_URBAN_FRANCE],
          pedestrian: [OSRM_PEDESTRIAN_FRANCE],
          cycle: [OSRM_CYCLE_FRANCE],
          public_transport: OTP,
          crow: [CROW],
        }
      }
    }, {
      api_keys: [
        'mapotempo-web-1-d701e4a905fbd3c8d0600a2af433db8b',
        'urios-test-1-97a6df314147dadea67b64c80f8d5494',
      ],
      services: {
        route_default: :car,
        route: {
          car: [OSRM_CAR_EUROPE],
          car_urban: [OSRM_CAR_URBAN_FRANCE],
          pedestrian: [OSRM_PEDESTRIAN_FRANCE],
          cycle: [OSRM_CYCLE_FRANCE],
          public_transport: OTP,
          crow: [CROW],
          truck: [HERE_TRUCK],
        },
        matrix: {
          car: [OSRM_CAR_EUROPE],
          car_urban: [OSRM_CAR_URBAN_FRANCE],
          pedestrian: [OSRM_PEDESTRIAN_FRANCE],
          cycle: [OSRM_CYCLE_FRANCE],
          public_transport: OTP,
          crow: [CROW],
          truck: [HERE_TRUCK],
        },
        isoline: {
          car: [OSRM_CAR_EUROPE],
          car_urban: [OSRM_CAR_URBAN_FRANCE],
          pedestrian: [OSRM_PEDESTRIAN_FRANCE],
          cycle: [OSRM_CYCLE_FRANCE],
          public_transport: OTP,
          crow: [CROW],
          truck: [HERE_TRUCK],
        }
      }
    }, {
      api_keys: [
        'mapotempo-web-beta-d701e4a905fbd3c8d0600a2af433db8b',
      ],
      services: {
        route_default: :car,
        route: {
          car: [OSRM_CAR_EUROPE],
          car_landes: [OSRM_CAR_LANDES],
          car_urban: [OSRM_CAR_URBAN_FRANCE],
          pedestrian: [OSRM_PEDESTRIAN_FRANCE],
          cycle: [OSRM_CYCLE_FRANCE],
          public_transport: OTP,
          truck: [HERE_TRUCK],
        },
        matrix: {
          car: [OSRM_CAR_EUROPE],
          car_landes: [OSRM_CAR_LANDES],
          car_urban: [OSRM_CAR_URBAN_FRANCE],
          pedestrian: [OSRM_PEDESTRIAN_FRANCE],
          cycle: [OSRM_CYCLE_FRANCE],
          public_transport: OTP,
          truck: [HERE_TRUCK],
        },
        isoline: {
          car: [OSRM_CAR_EUROPE],
          car_landes: [OSRM_CAR_LANDES],
          car_urban: [OSRM_CAR_URBAN_FRANCE],
          pedestrian: [OSRM_PEDESTRIAN_FRANCE],
          cycle: [OSRM_CYCLE_FRANCE],
          public_transport: OTP,
          truck: [HERE_TRUCK],
        }
      }
    }]
  }

  @@c[:api_keys] = Hash[@@c[:profiles].collect{ |profile|
    profile[:api_keys].collect{ |api_key|
      [api_key, profile[:services]]
    }
  }.flatten(1)]
end
