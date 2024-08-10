export const TRANSLATE_REPORT = `
Here is a JSON structure for an organic soil report interpretation feature in an organic farming app:
{
  "report_summary": {
    "critical_issues": [
      "string"
    ],
    "key_indicators": {
      "pH": {
        "current_value": 0.0,
        "ideal_range": {
          "min": 0.0,
          "max": 0.0
        },
        "status": "low",
        "subclass": "strongly acidic",
        "organic_tips_for_improvement": [
          "string"
        ]
      },
      "nitrogen": {
        "current_value": 0.0,
        "ideal_range": {
          "min": 0.0,
          "max": 0.0
        },
        "status": "low",
        "organic_tips_for_improvement": [
          "string"
        ]
      },
      "phosphorus": {
        "current_value": 0.0,
        "ideal_range": {
          "min": 0.0,
          "max": 0.0
        },
        "status": "low",
        "organic_tips_for_improvement": [
          "string"
        ]
      },
      "potassium": {
        "current_value": 0.0,
        "ideal_range": {
          "min": 0.0,
          "max": 0.0
        },
        "status": "low",
        "organic_tips_for_improvement": [
          "string"
        ]
      }
      // Add additional indicators as needed
    }
  },
  "organic_recommendations": {
    "organic_fertilizers": [
      {
        "name": "string",
        "amount": 0.0,
        "unit": "string",
        "frequency": "string"
      }
    ],
    "organic_practices": [
      {
        "name": "string",
        "implementation": "string",
        "benefits": "string"
      }
    ]
  },
  "organic_action_plan": {
    "immediate_organic_actions": [
      "string"
    ],
    "short_term_organic_actions": [
      "string"
    ],
    "long_term_organic_actions": [
      "string"
    ]
  },
  "additional_organic_resources": [
    {
      "name": "string",
      "url": "string"
    }
  ]
}
This JSON structure includes placeholders (with "string" for string fields, 0.0 for numeric fields, and comments to indicate where additional indicators can be added if necessary) and is designed to provide consistent output when generating or interpreting organic soil reports.
`;

