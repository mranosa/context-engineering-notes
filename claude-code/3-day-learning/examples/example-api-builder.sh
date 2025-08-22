#!/bin/bash
# example-api-builder.sh - Sub-agent for API creation
# This script demonstrates an API builder sub-agent that generates
# complete REST APIs with documentation

# Function to display usage
show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -n, --name NAME        API name/resource (e.g., users, products)"
    echo "  -m, --methods METHODS  HTTP methods (GET,POST,PUT,DELETE)"
    echo "  -d, --database DB      Database type (postgres, mongodb, mysql)"
    echo "  -a, --auth TYPE        Auth type (jwt, oauth, api-key, none)"
    echo "  -s, --spec             Generate OpenAPI specification"
    echo "  -h, --help             Show this help message"
}

# Default values
API_NAME=""
METHODS="GET,POST,PUT,DELETE"
DATABASE="postgres"
AUTH="jwt"
SPEC=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -n|--name)
            API_NAME="$2"
            shift 2
            ;;
        -m|--methods)
            METHODS="$2"
            shift 2
            ;;
        -d|--database)
            DATABASE="$2"
            shift 2
            ;;
        -a|--auth)
            AUTH="$2"
            shift 2
            ;;
        -s|--spec)
            SPEC=true
            shift
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
done

# Validate required arguments
if [ -z "$API_NAME" ]; then
    echo "Error: API name is required"
    show_usage
    exit 1
fi

# API Builder Sub-agent
run_api_builder() {
    claude-code "You are APIBuilder sub-agent. Generate a complete REST API:

API SPECIFICATION:
- Resource: $API_NAME
- Methods: $METHODS
- Database: $DATABASE
- Authentication: $AUTH
- Generate OpenAPI: $SPEC

PHASE 1: PROJECT SETUP

Create directory structure:
api-$API_NAME/
├── src/
│   ├── controllers/
│   │   └── ${API_NAME}.controller.js
│   ├── services/
│   │   └── ${API_NAME}.service.js
│   ├── models/
│   │   └── ${API_NAME}.model.js
│   ├── routes/
│   │   └── ${API_NAME}.routes.js
│   ├── middleware/
│   │   ├── auth.middleware.js
│   │   ├── validation.middleware.js
│   │   └── error.middleware.js
│   ├── config/
│   │   ├── database.js
│   │   └── config.js
│   ├── utils/
│   │   └── validators.js
│   └── app.js
├── tests/
│   ├── unit/
│   ├── integration/
│   └── fixtures/
├── docs/
│   └── api.md
├── .env.example
├── package.json
├── README.md
└── server.js

PHASE 2: DATABASE MODEL

$(case $DATABASE in
    postgres)
        echo "Generate Sequelize model:
// models/${API_NAME}.model.js
const { DataTypes } = require('sequelize');

module.exports = (sequelize) => {
  const ${API_NAME^} = sequelize.define('${API_NAME}', {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false,
      validate: {
        notEmpty: true
      }
    },
    description: DataTypes.TEXT,
    status: {
      type: DataTypes.ENUM('active', 'inactive'),
      defaultValue: 'active'
    },
    metadata: DataTypes.JSONB,
    createdBy: DataTypes.UUID,
    updatedBy: DataTypes.UUID
  }, {
    timestamps: true,
    paranoid: true,
    indexes: [
      { fields: ['name'] },
      { fields: ['status'] }
    ]
  });

  return ${API_NAME^};
};"
        ;;
    mongodb)
        echo "Generate Mongoose schema:
// models/${API_NAME}.model.js
const mongoose = require('mongoose');

const ${API_NAME}Schema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
    index: true
  },
  description: String,
  status: {
    type: String,
    enum: ['active', 'inactive'],
    default: 'active'
  },
  metadata: mongoose.Schema.Types.Mixed,
  createdBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User'
  },
  updatedBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User'
  }
}, {
  timestamps: true
});

module.exports = mongoose.model('${API_NAME^}', ${API_NAME}Schema);"
        ;;
esac)

PHASE 3: CONTROLLER GENERATION

Generate controller with methods: $METHODS

// controllers/${API_NAME}.controller.js
const ${API_NAME}Service = require('../services/${API_NAME}.service');

class ${API_NAME^}Controller {
$(echo "$METHODS" | tr ',' '\n' | while read method; do
    case $method in
        GET)
            echo "
  async getAll(req, res, next) {
    try {
      const { page = 1, limit = 10, sort, filter } = req.query;
      const options = {
        page: parseInt(page),
        limit: parseInt(limit),
        sort: sort || 'createdAt:desc',
        filter: filter ? JSON.parse(filter) : {}
      };
      
      const result = await ${API_NAME}Service.findAll(options);
      
      res.json({
        success: true,
        data: result.data,
        pagination: result.pagination
      });
    } catch (error) {
      next(error);
    }
  }

  async getById(req, res, next) {
    try {
      const { id } = req.params;
      const item = await ${API_NAME}Service.findById(id);
      
      if (!item) {
        return res.status(404).json({
          success: false,
          message: '${API_NAME^} not found'
        });
      }
      
      res.json({
        success: true,
        data: item
      });
    } catch (error) {
      next(error);
    }
  }"
            ;;
        POST)
            echo "
  async create(req, res, next) {
    try {
      const data = req.body;
      data.createdBy = req.user?.id;
      
      const item = await ${API_NAME}Service.create(data);
      
      res.status(201).json({
        success: true,
        data: item,
        message: '${API_NAME^} created successfully'
      });
    } catch (error) {
      next(error);
    }
  }"
            ;;
        PUT)
            echo "
  async update(req, res, next) {
    try {
      const { id } = req.params;
      const data = req.body;
      data.updatedBy = req.user?.id;
      
      const item = await ${API_NAME}Service.update(id, data);
      
      if (!item) {
        return res.status(404).json({
          success: false,
          message: '${API_NAME^} not found'
        });
      }
      
      res.json({
        success: true,
        data: item,
        message: '${API_NAME^} updated successfully'
      });
    } catch (error) {
      next(error);
    }
  }"
            ;;
        DELETE)
            echo "
  async delete(req, res, next) {
    try {
      const { id } = req.params;
      
      const result = await ${API_NAME}Service.delete(id);
      
      if (!result) {
        return res.status(404).json({
          success: false,
          message: '${API_NAME^} not found'
        });
      }
      
      res.status(204).send();
    } catch (error) {
      next(error);
    }
  }"
            ;;
    esac
done)
}

module.exports = new ${API_NAME^}Controller();

PHASE 4: SERVICE LAYER

// services/${API_NAME}.service.js
const ${API_NAME^}Model = require('../models/${API_NAME}.model');

class ${API_NAME^}Service {
  async findAll(options) {
    const { page, limit, sort, filter } = options;
    const offset = (page - 1) * limit;
    
    const { count, rows } = await ${API_NAME^}Model.findAndCountAll({
      where: filter,
      limit,
      offset,
      order: this.parseSort(sort)
    });
    
    return {
      data: rows,
      pagination: {
        total: count,
        page,
        limit,
        pages: Math.ceil(count / limit)
      }
    };
  }
  
  async findById(id) {
    return await ${API_NAME^}Model.findByPk(id);
  }
  
  async create(data) {
    return await ${API_NAME^}Model.create(data);
  }
  
  async update(id, data) {
    const item = await this.findById(id);
    if (!item) return null;
    
    return await item.update(data);
  }
  
  async delete(id) {
    const item = await this.findById(id);
    if (!item) return null;
    
    await item.destroy();
    return true;
  }
  
  parseSort(sortString) {
    if (!sortString) return [['createdAt', 'DESC']];
    
    return sortString.split(',').map(sort => {
      const [field, order] = sort.split(':');
      return [field, order?.toUpperCase() || 'ASC'];
    });
  }
}

module.exports = new ${API_NAME^}Service();

PHASE 5: ROUTES CONFIGURATION

// routes/${API_NAME}.routes.js
const router = require('express').Router();
const ${API_NAME}Controller = require('../controllers/${API_NAME}.controller');
const { authenticate } = require('../middleware/auth.middleware');
const { validate } = require('../middleware/validation.middleware');
const { ${API_NAME}Schema } = require('../utils/validators');

$(echo "$METHODS" | tr ',' '\n' | while read method; do
    case $method in
        GET)
            echo "router.get('/', authenticate, ${API_NAME}Controller.getAll);
router.get('/:id', authenticate, ${API_NAME}Controller.getById);"
            ;;
        POST)
            echo "router.post('/', authenticate, validate(${API_NAME}Schema), ${API_NAME}Controller.create);"
            ;;
        PUT)
            echo "router.put('/:id', authenticate, validate(${API_NAME}Schema), ${API_NAME}Controller.update);"
            ;;
        DELETE)
            echo "router.delete('/:id', authenticate, ${API_NAME}Controller.delete);"
            ;;
    esac
done)

module.exports = router;

$(if [ "$AUTH" != "none" ]; then
    echo "
PHASE 6: AUTHENTICATION MIDDLEWARE

$(case $AUTH in
    jwt)
        echo "// middleware/auth.middleware.js
const jwt = require('jsonwebtoken');

exports.authenticate = async (req, res, next) => {
  try {
    const token = req.headers.authorization?.split(' ')[1];
    
    if (!token) {
      return res.status(401).json({
        success: false,
        message: 'Authentication required'
      });
    }
    
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded;
    
    next();
  } catch (error) {
    res.status(401).json({
      success: false,
      message: 'Invalid token'
    });
  }
};"
        ;;
    oauth)
        echo "// middleware/auth.middleware.js
const passport = require('passport');

exports.authenticate = passport.authenticate('oauth2', { session: false });"
        ;;
    api-key)
        echo "// middleware/auth.middleware.js
exports.authenticate = async (req, res, next) => {
  const apiKey = req.headers['x-api-key'];
  
  if (!apiKey || apiKey !== process.env.API_KEY) {
    return res.status(401).json({
      success: false,
      message: 'Invalid API key'
    });
  }
  
  next();
};"
        ;;
esac)"
fi)

PHASE 7: VALIDATION SCHEMAS

// utils/validators.js
const Joi = require('joi');

exports.${API_NAME}Schema = Joi.object({
  name: Joi.string().required().min(3).max(100),
  description: Joi.string().optional().max(500),
  status: Joi.string().valid('active', 'inactive').optional(),
  metadata: Joi.object().optional()
});

$(if [ "$SPEC" = true ]; then
    echo "
PHASE 8: OPENAPI SPECIFICATION

Generate docs/openapi.yaml:
openapi: 3.0.0
info:
  title: ${API_NAME^} API
  version: 1.0.0
  description: REST API for managing ${API_NAME}

servers:
  - url: http://localhost:3000/api
    description: Development server

security:
  - bearerAuth: []

paths:
  /${API_NAME}:
    get:
      summary: List all ${API_NAME}
      parameters:
        - name: page
          in: query
          schema:
            type: integer
            default: 1
        - name: limit
          in: query
          schema:
            type: integer
            default: 10
      responses:
        200:
          description: Success
          content:
            application/json:
              schema:
                \$ref: '#/components/schemas/ListResponse'
    
    post:
      summary: Create new ${API_NAME}
      requestBody:
        required: true
        content:
          application/json:
            schema:
              \$ref: '#/components/schemas/${API_NAME^}'
      responses:
        201:
          description: Created

  /${API_NAME}/{id}:
    get:
      summary: Get ${API_NAME} by ID
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: string
      responses:
        200:
          description: Success
        404:
          description: Not found
    
    put:
      summary: Update ${API_NAME}
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: string
      requestBody:
        required: true
        content:
          application/json:
            schema:
              \$ref: '#/components/schemas/${API_NAME^}'
      responses:
        200:
          description: Updated
    
    delete:
      summary: Delete ${API_NAME}
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: string
      responses:
        204:
          description: Deleted

components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT
  
  schemas:
    ${API_NAME^}:
      type: object
      properties:
        id:
          type: string
        name:
          type: string
        description:
          type: string
        status:
          type: string
          enum: [active, inactive]
        metadata:
          type: object"
fi)

PHASE 9: TESTING

Generate test files:
// tests/integration/${API_NAME}.test.js
const request = require('supertest');
const app = require('../../src/app');

describe('${API_NAME^} API', () => {
  let token;
  let itemId;
  
  beforeAll(async () => {
    // Setup authentication
    const auth = await request(app)
      .post('/api/auth/login')
      .send({ email: 'test@example.com', password: 'password' });
    token = auth.body.token;
  });
  
  describe('POST /api/${API_NAME}', () => {
    it('should create new ${API_NAME}', async () => {
      const res = await request(app)
        .post('/api/${API_NAME}')
        .set('Authorization', \`Bearer \${token}\`)
        .send({
          name: 'Test ${API_NAME^}',
          description: 'Test description'
        });
      
      expect(res.status).toBe(201);
      expect(res.body.success).toBe(true);
      expect(res.body.data.name).toBe('Test ${API_NAME^}');
      
      itemId = res.body.data.id;
    });
  });
  
  describe('GET /api/${API_NAME}', () => {
    it('should list all ${API_NAME}', async () => {
      const res = await request(app)
        .get('/api/${API_NAME}')
        .set('Authorization', \`Bearer \${token}\`);
      
      expect(res.status).toBe(200);
      expect(res.body.success).toBe(true);
      expect(Array.isArray(res.body.data)).toBe(true);
    });
  });
});

PHASE 10: DOCUMENTATION

Generate README.md:
# ${API_NAME^} API

## Overview
REST API for managing ${API_NAME} resources.

## Features
- CRUD operations for ${API_NAME}
- ${AUTH} authentication
- Pagination and filtering
- Input validation
- Error handling

## Installation
\`\`\`bash
npm install
cp .env.example .env
npm run migrate
npm run seed
\`\`\`

## Usage
\`\`\`bash
npm run dev     # Development
npm test        # Run tests
npm start       # Production
\`\`\`

## API Endpoints
| Method | Endpoint | Description |
|--------|----------|-------------|
$(echo "$METHODS" | tr ',' '\n' | while read method; do
    case $method in
        GET)
            echo "| GET | /api/${API_NAME} | List all ${API_NAME} |
| GET | /api/${API_NAME}/:id | Get single ${API_NAME} |"
            ;;
        POST)
            echo "| POST | /api/${API_NAME} | Create new ${API_NAME} |"
            ;;
        PUT)
            echo "| PUT | /api/${API_NAME}/:id | Update ${API_NAME} |"
            ;;
        DELETE)
            echo "| DELETE | /api/${API_NAME}/:id | Delete ${API_NAME} |"
            ;;
    esac
done)

## Environment Variables
\`\`\`
NODE_ENV=development
PORT=3000
DATABASE_URL=${DATABASE}://localhost/${API_NAME}_db
JWT_SECRET=your-secret-key
\`\`\`

SUCCESS OUTPUT:
- Complete API structure created
- All CRUD operations implemented
- Authentication configured
- Validation in place
- Tests generated
- Documentation complete
- Ready to run with 'npm start'"
}

# Main execution
echo "Starting API Builder Sub-agent..."
echo "Building API for: $API_NAME"
echo "Methods: $METHODS"
echo "Database: $DATABASE"
echo "Authentication: $AUTH"
[ "$SPEC" = true ] && echo "OpenAPI Spec: Enabled"
echo "----------------------------------------"

# Run the sub-agent
run_api_builder

echo "----------------------------------------"
echo "API generation complete!"
echo "Navigate to api-$API_NAME/ and run:"
echo "  npm install"
echo "  npm run dev"