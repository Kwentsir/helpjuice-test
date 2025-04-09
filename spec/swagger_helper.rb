# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.openapi_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under openapi_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a openapi_spec tag to the
  # the root example_group in your specs, e.g. describe '...', openapi_spec: 'v2/swagger.json'
  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {
                '/api/search_queries' => {
          post: {
            summary: 'Create a new search query',
            description: 'Create a new search query record with the provided query. The IP address is automatically captured, and the Session ID is passed in the X-Session-ID header.',
            tags: ['Search Queries'],
            requestBody: {
              description: 'Search Query Information',
              required: true,
              content: {
                'application/json': {
                  schema: {
                    type: 'object',
                    properties: {
                      query: { type: 'string' }
                    },
                    required: ['query']
                  }
                }
              }
            },
            responses: {
              '200': {
                description: 'Search Query created successfully'
              },
              '400': {
                description: 'Invalid input data (missing query or X-Session-ID)'
              },
              '422': {
                description: 'Unprocessable Content'
              }
            }
          }
        },
        '/api/user_analytics' => {
          get: {
            summary: 'Retrieve analytics for the current user',
            description: 'Fetch the search query counts for the current user based on their session (identified by cookies).',
            tags: ['Analytics'],
            responses: {
              '200': {
                description: 'User-specific search query analytics',
                content: {
                  'application/json': {
                    schema: {
                      type: 'object',
                      additionalProperties: {
                        type: 'integer',
                        description: 'Count of each search query by the user'
                      },
                      example: {
                        "What is": 3,
                        "good car": 1
                      }
                    }
                  }
                }
              }
            }
          }
        },
        '/api/popular' => {
          get: {
            summary: 'Retrieve popular search queries',
            description: 'Fetch the most popular search queries based on their frequency, in descending order of count.',
            tags: ['Analytics'],
            responses: {
              '200': {
                description: 'List of top search queries',
                content: {
                  'application/json': {
                    schema: {
                      type: 'object',
                      additionalProperties: { 
                        type: 'integer'
                      },
                      example: {
                      "What is your name?": 1,
                      "another query": 5
                    }
                    }
                  }
                }
              }
            }
          }
        }
      },
      servers: [
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: {
              default: '172.25.244.4:3000'
            }
          }
        }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The openapi_specs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.openapi_format = :yaml
end
