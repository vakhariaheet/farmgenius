export const TRANSLATE_REPORT = `
Here is a JSON structure for an organic soil report interpretation feature in an organic farming app and in response I only valid json nothing else.:
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
      // Add additional indicators as needed and for each organic_tips_for_improvement, provide on the best organic practices to improve the indicator instead of vague advice
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

export const CROP_DAILY_REPORT = `
Analyze the uploaded image(s) of [CROP_NAME] at coordinates [LATITUDE], [LONGITUDE] and provide the following information in JSON format:


{
  "crop_name": "[CROP_NAME]",
  "location": {
    "latitude": [LATITUDE],
    "longitude": [LONGITUDE]
  },
  "assessment_date": "YYYY-MM-DD",
  "crop_health": {
    "status": "Excellent|Good|Fair|Poor",
    "issues": [
      {
        "type": "pest_infestation|nutrient_deficiency|disease|other",
        "description": "",
        "severity": "Low|Moderate|High"
      }
    ]
  },
  "growth_stage": {
    "current_stage": "",
    "days_to_harvest": null
  },
  "ripeness": {
    "status": "Unripe|Nearly Ripe|Ripe|Overripe",
    "optimal_harvest_window": {
      "start_date": "YYYY-MM-DD",
      "end_date": "YYYY-MM-DD"
    }
  },
  "management_tips": {
    "watering": "",
    "fertilization": "",
    "pest_control": "",
    "other": ""
  },
  "market_info": {
    "current_price": {
      "value": 0.00,
      "currency": "USD"
    },
    "price_trend": "Increasing|Stable|Decreasing",
    "suggested_sell_date": "YYYY-MM-DD"
  },
  "local_conditions": {
    "current_weather": {
      "temperature": 0.0,
      "humidity": 0,
      "precipitation": 0.0
    },
    "weather_forecast": [
      {
        "date": "YYYY-MM-DD",
        "condition": "",
        "temperature_high": 0.0,
        "temperature_low": 0.0,
        "precipitation_chance": 0
      }
    ],
    "alerts": [
      {
        "type": "storm|frost|drought|other",
        "description": "",
        "severity": "Low|Moderate|High"
      }
    ]
  },
  "additional_observations": "",
  "comparison_to_previous": "",
  "confidence_level": "Low|Medium|High"
}


Provide this information in the exact JSON format shown above. Ensure all fields are populated with appropriate values based on the image analysis and location data. Use null for any fields where data is not applicable or available. For array fields, include an empty array [] if there are no items to report.`;

