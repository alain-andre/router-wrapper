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
  OSRM_CAR_EUROPE = Wrappers::Osrm5.new(CACHE, url_time: 'http://164.132.202.168:5005', url_distance: nil, url_isochrone: 'http://164.132.202.168:6005', url_isodistance: nil, licence: 'ODbL', attribution: '© OpenStreetMap contributors', area: 'Europe')
  OSRM_CAR_INTERURBAN_EUROPE = Wrappers::Osrm4.new(CACHE, url_time: 'http://localhost:5000', url_distance: 'http://localhost:5004', url_isochrone: 'http://localhost:6000', url_isodistance: 'http://localhost:6004', licence: 'ODbL', attribution: '© OpenStreetMap contributors', area: 'Europe', boundary: 'poly/europe-extended.kml')
  OSRM_CAR_URBAN_FRANCE = Wrappers::Osrm4.new(CACHE, url_time: 'http://localhost:5003', url_distance: 'http://localhost:5004', url_isochrone: 'http://localhost:6003', url_isodistance: 'http://localhost:6004', licence: 'ODbL', attribution: '© OpenStreetMap contributors', area: 'France', boundary: 'poly/france-extended.kml')
  OSRM_PEDESTRIAN_FRANCE = Wrappers::Osrm4.new(CACHE, url_time: 'http://localhost:5002', url_isochrone: 'http://localhost:6002', licence: 'ODbL', attribution: '© OpenStreetMap contributors', area: 'France')
  OSRM_CYCLE_FRANCE = Wrappers::Osrm4.new(CACHE, url_time: 'http://localhost:5001', url_isochrone: 'http://localhost:6001', licence: 'ODbL', attribution: '© OpenStreetMap contributors', area: 'France')
  # tmp
  OSRM_CAR_INTERURBAN_USA_NE = Wrappers::Osrm5.new(CACHE, url_time: 'http://delta.mapotempo.com:5001', url_distance: nil, url_isochrone: nil, url_isodistance: nil, licence: 'ODbL', attribution: '© OpenStreetMap contributors', area: 'US Northeast', boundary: 'poly/us-east-coast.kml')
  OSRM_CAR_INTERURBAN_QUEBEC = Wrappers::Osrm5.new(CACHE, url_time: 'http://delta.mapotempo.com:5002', url_distance: nil, url_isochrone: nil, url_isodistance: nil, licence: 'ODbL', attribution: '© OpenStreetMap contributors', area: 'Quebec', boundary: 'poly/quebec.kml')
  OSRM_CAR_INTERURBAN_TEXAS = Wrappers::Osrm5.new(CACHE, url_time: 'http://delta.mapotempo.com:5003', url_distance: nil, url_isochrone: nil, url_isodistance: nil, licence: 'ODbL', attribution: '© OpenStreetMap contributors', area: 'US Texas', boundary: 'poly/texas.kml')
  OSRM_CAR_INTERURBAN_COLORADO = Wrappers::Osrm5.new(CACHE, url_time: 'http://delta.mapotempo.com:5006', url_distance: nil, url_isochrone: nil, url_isodistance: nil, licence: 'ODbL', attribution: '© OpenStreetMap contributors', area: 'US Texas', boundary: 'poly/colorado.kml')
  OSRM_CAR_INTERURBAN_ILLINOIS = Wrappers::Osrm5.new(CACHE, url_time: 'http://delta.mapotempo.com:5007', url_distance: nil, url_isochrone: nil, url_isodistance: nil, licence: 'ODbL', attribution: '© OpenStreetMap contributors', area: 'US Texas', boundary: 'poly/illinois.kml')
  OSRM_CAR_INTERURBAN_MAGHREB = Wrappers::Osrm5.new(CACHE, url_time: 'http://delta.mapotempo.com:5004', url_distance: nil, url_isochrone: nil, url_isodistance: nil, licence: 'ODbL', attribution: '© OpenStreetMap contributors', area: 'Morooco, Algeria, Tunisia', boundary: 'poly/maghreb.kml')
  OSRM_CAR_INTERURBAN_SOUTH_AFRICA = Wrappers::Osrm5.new(CACHE, url_time: 'http://delta.mapotempo.com:5005', url_distance: nil, url_isochrone: nil, url_isodistance: nil, licence: 'ODbL', attribution: '© OpenStreetMap contributors', area: 'South-Africa', boundary: 'poly/south-africa-and-lesotho.kml')
  OSRM_CAR_URBAN_USA_NE = Wrappers::Osrm5.new(CACHE, url_time: 'http://delta.mapotempo.com:5101', url_distance: nil, url_isochrone: nil, url_isodistance: nil, licence: 'ODbL', attribution: '© OpenStreetMap contributors', area: 'US Northeast', boundary: 'poly/us-east-coast.kml')
  OSRM_CAR_URBAN_QUEBEC = Wrappers::Osrm5.new(CACHE, url_time: 'http://delta.mapotempo.com:5102', url_distance: nil, url_isochrone: nil, url_isodistance: nil, licence: 'ODbL', attribution: '© OpenStreetMap contributors', area: 'Quebec', boundary: 'poly/quebec.kml')
  OSRM_CAR_URBAN_TEXAS = Wrappers::Osrm5.new(CACHE, url_time: 'http://delta.mapotempo.com:5103', url_distance: nil, url_isochrone: nil, url_isodistance: nil, licence: 'ODbL', attribution: '© OpenStreetMap contributors', area: 'US Texas', boundary: 'poly/texas.kml')
  OSRM_CAR_URBAN_COLORADO = Wrappers::Osrm5.new(CACHE, url_time: 'http://delta.mapotempo.com:5106', url_distance: nil, url_isochrone: nil, url_isodistance: nil, licence: 'ODbL', attribution: '© OpenStreetMap contributors', area: 'US Texas', boundary: 'poly/colorado.kml')
  OSRM_CAR_URBAN_ILLINOIS = Wrappers::Osrm5.new(CACHE, url_time: 'http://delta.mapotempo.com:5107', url_distance: nil, url_isochrone: nil, url_isodistance: nil, licence: 'ODbL', attribution: '© OpenStreetMap contributors', area: 'US Texas', boundary: 'poly/illinois.kml')

  OSRM_CAR_INTERURBAN = [
    OSRM_CAR_INTERURBAN_EUROPE,
    OSRM_CAR_INTERURBAN_USA_NE,
    OSRM_CAR_INTERURBAN_QUEBEC,
    OSRM_CAR_INTERURBAN_TEXAS,
    OSRM_CAR_INTERURBAN_COLORADO,
    OSRM_CAR_INTERURBAN_ILLINOIS,
    OSRM_CAR_INTERURBAN_MAGHREB,
    OSRM_CAR_INTERURBAN_SOUTH_AFRICA,
  ]

  OSRM_CAR_URBAN = [
    OSRM_CAR_URBAN_FRANCE,
    OSRM_CAR_URBAN_USA_NE,
    OSRM_CAR_URBAN_QUEBEC,
    OSRM_CAR_URBAN_TEXAS,
    OSRM_CAR_URBAN_COLORADO,
    OSRM_CAR_URBAN_ILLINOIS,
  ]

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
        'alyacom-test-e2f5c1a84d810f6a9a7cb6ba969300dab6324c16a1f496e389953f67',
        'apologic-1-9f9f5d62b4c32ce08f7f1bd144133e088f59c445',
        'apologic-beta-79728b4dbd59e080d36ba862d592d694',
        'admr-test-1-3ba76b0f79c1a8517a9d3d101dcbd837',
      ],
      services: {
        route_default: :car,
        route: {
          car2: [OSRM_CAR_EUROPE],
          car: OSRM_CAR_INTERURBAN,
          car_interurban: OSRM_CAR_INTERURBAN,
          car_urban: OSRM_CAR_URBAN,
          pedestrian: [OSRM_PEDESTRIAN_FRANCE],
          cycle: [OSRM_CYCLE_FRANCE],
          public_transport: OTP,
          crow: [CROW],
        },
        matrix: {
          car2: [OSRM_CAR_EUROPE],
          car: OSRM_CAR_INTERURBAN,
          car_interurban: OSRM_CAR_INTERURBAN,
          car_urban: OSRM_CAR_URBAN,
          pedestrian: [OSRM_PEDESTRIAN_FRANCE],
          cycle: [OSRM_CYCLE_FRANCE],
          public_transport: OTP,
          crow: [CROW],
        },
        isoline: {
          car2: [OSRM_CAR_EUROPE],
          car: [OSRM_CAR_INTERURBAN_EUROPE],
          car_interurban: [OSRM_CAR_INTERURBAN_EUROPE],
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
          car2: [OSRM_CAR_EUROPE],
          car: OSRM_CAR_INTERURBAN,
          car_interurban: OSRM_CAR_INTERURBAN,
          car_urban: OSRM_CAR_URBAN,
          pedestrian: [OSRM_PEDESTRIAN_FRANCE],
          cycle: [OSRM_CYCLE_FRANCE],
          public_transport: OTP,
          crow: [CROW],
          truck: [HERE_TRUCK],
        },
        matrix: {
          car2: [OSRM_CAR_EUROPE],
          car: OSRM_CAR_INTERURBAN,
          car_interurban: OSRM_CAR_INTERURBAN,
          car_urban: OSRM_CAR_URBAN,
          pedestrian: [OSRM_PEDESTRIAN_FRANCE],
          cycle: [OSRM_CYCLE_FRANCE],
          public_transport: OTP,
          crow: [CROW],
          truck: [HERE_TRUCK],
        },
        isoline: {
          car2: [OSRM_CAR_EUROPE],
          car: [OSRM_CAR_INTERURBAN_EUROPE],
          car_interurban: [OSRM_CAR_INTERURBAN_EUROPE],
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
          car2: [OSRM_CAR_EUROPE],
          car: OSRM_CAR_INTERURBAN,
          car_interurban: OSRM_CAR_INTERURBAN,
          car_urban: OSRM_CAR_URBAN,
          pedestrian: [OSRM_PEDESTRIAN_FRANCE],
          cycle: [OSRM_CYCLE_FRANCE],
          public_transport: OTP,
          crow: [CROW],
          truck: [HERE_TRUCK],
        },
        matrix: {
          car2: [OSRM_CAR_EUROPE],
          car: OSRM_CAR_INTERURBAN,
          car_interurban: OSRM_CAR_INTERURBAN,
          car_urban: OSRM_CAR_URBAN,
          pedestrian: [OSRM_PEDESTRIAN_FRANCE],
          cycle: [OSRM_CYCLE_FRANCE],
          public_transport: OTP,
          crow: [CROW],
          truck: [HERE_TRUCK],
        },
        isoline: {
          car2: [OSRM_CAR_EUROPE],
          car: [OSRM_CAR_INTERURBAN_EUROPE],
          car_interurban: [OSRM_CAR_INTERURBAN_EUROPE],
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
        'althea-test-e056ea36866a81665c51070b9bbc323164',
      ],
      services: {
        route_default: :truck,
        route: {
          truck: [HERE_TRUCK],
        },
        matrix: {
          truck: [HERE_TRUCK],
        },
        isoline: {
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
