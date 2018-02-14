# Copyright © Mapotempo, 2015
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
module Api
  module V01
    class Status401 < Grape::Entity
      def self.entity_name
        'Status401'
      end

      expose(:status, documentation: { type: String, desc: 'Server response status', values: [401] })
      expose(:detail, documentation: { type: String, desc: 'Server rendered details', values: ['401 Unauthorized'] })
    end
  end
end
