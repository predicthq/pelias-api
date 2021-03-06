
module.exports = {
  'query': {
    'filtered': {
      'query': {
        'bool': {}
      },
      'filter': {
        'bool': {
          'must': [
            {
              'geo_distance': {
                'distance': '500km',
                'distance_type': 'plane',
                'optimize_bbox': 'indexed',
                '_cache': true,
                'center_point': {
                  'lat': 29.49136,
                  'lon': -82.50622
                }
              }
            }
          ]
        }
      }
    }
  },
  'sort': [
    '_score',
    {
      '_geo_distance': {
        'center_point': {
          'lat': 29.49136,
          'lon': -82.50622
        },
        'order': 'asc',
        'distance_type': 'plane'
      }
    }
  ],
  'size': 1,
  'track_scores': true
};