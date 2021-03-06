# Copyright © Mapotempo, 2016
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
require './test/test_helper'

require './wrappers/osrm4'

class Wrappers::Osrm4Test < Minitest::Test

  def test_router
    osrm = RouterWrapper::OSRM4
    result = osrm.route([[49.610710, 18.237305], [47.010226, 2.900391]], :time, nil, nil, 'en', true)
    assert 0 < result[:features].size
  end

  def test_router_no_route
    osrm = RouterWrapper::OSRM4
    result = osrm.route([[-18.90928, 47.53381], [-16.92609, 145.75843]], :time, nil, nil, 'en', true)
    assert_equal 0, result[:features].size
  end

  def test_matrix_square
    osrm = RouterWrapper::OSRM4
    vector = [[49.610710, 18.237305], [47.010226, 2.900391]]
    result = osrm.matrix(vector, vector, :time, nil, nil, 'en')
    assert_equal vector.size, result[:matrix_time].size
    assert_equal vector.size, result[:matrix_time][0].size
  end

  def test_matrix_rectangular_time
    osrm = RouterWrapper::OSRM4
    src = [[49.610710, 18.237305], [47.010226, 2.900391]]
    dst = [[49.610710, 18.237305]]
    result = osrm.matrix(src, dst, :time, nil, nil, 'en')
    assert_equal src.size, result[:matrix_time].size
    assert_equal dst.size, result[:matrix_time][0].size
  end

  def test_matrix_1x1
    osrm = RouterWrapper::OSRM4
    src = [[49.610710, 18.237305]]
    dst = [[49.610710, 18.237305]]
    result = osrm.matrix(src, dst, :time_distance, nil, nil, 'en')
    assert_equal src.size, result[:matrix_time].size
    assert_equal dst.size, result[:matrix_time][0].size
    assert_equal src.size, result[:matrix_distance].size
    assert_equal dst.size, result[:matrix_distance][0].size
  end

  def test_matrix_rectangular_time_distance
    osrm = RouterWrapper::OSRM4
    src = [[49.610710, 18.237305], [47.010226, 2.900391]]
    dst = [[49.610710, 18.237305]]
    result = osrm.matrix(src, dst, :time_distance, nil, nil, 'en')
    assert_equal src.size, result[:matrix_time].size
    assert_equal src.size, result[:matrix_distance].size
    assert_equal dst.size, result[:matrix_time][0].size
    assert_equal dst.size, result[:matrix_distance][0].size
  end

  def test_isoline
    osrm = RouterWrapper::OSRM4
    result = osrm.isoline([49.610710, 18.237305], :time, 100, nil, 'en')
    assert 0 < result['features'].size
  end
end
