// class SoilReport {
//   final ReportSummary reportSummary;
//   final OrganicRecommendations organicRecommendations;
//   final OrganicActionPlan organicActionPlan;
//   final List<AdditionalResource> additionalOrganicResources;

//   SoilReport({
//     required this.reportSummary,
//     required this.organicRecommendations,
//     required this.organicActionPlan,
//     required this.additionalOrganicResources,
//   });

//   factory SoilReport.getDefaultReport() {
//     return SoilReport(
//       reportSummary: ReportSummary(
//         criticalIssues: [],
//         keyIndicators: {},
//       ),
//       organicRecommendations: OrganicRecommendations(
//         organicFertilizers: [],
//         organicPractices: [],
//       ),
//       organicActionPlan: OrganicActionPlan(
//         immediateOrganicActions: [],
//         shortTermOrganicActions: [],
//         longTermOrganicActions: [],
//       ),
//       additionalOrganicResources: [],
//     );
//   }

//   factory SoilReport.fromJson(Map<String, dynamic> json) {
//     return SoilReport(
//       reportSummary: ReportSummary.fromJson(json['report_summary']),
//       organicRecommendations: OrganicRecommendations.fromJson(json['organic_recommendations']),
//       organicActionPlan: OrganicActionPlan.fromJson(json['organic_action_plan']),
//       additionalOrganicResources: (json['additional_organic_resources'] as List)
//           .map((resource) => AdditionalResource.fromJson(resource))
//           .toList(),
//     );
//   }
// }

// class ReportSummary {
//   final List<String> criticalIssues;
//   final Map<String, KeyIndicator> keyIndicators;

//   ReportSummary({
//     required this.criticalIssues,
//     required this.keyIndicators,
//   });

//   factory ReportSummary.fromJson(Map<String, dynamic> json) {
//     var keyIndicatorsMap = json['key_indicators'] as Map<String, dynamic>;
//     return ReportSummary(
//       criticalIssues: List<String>.from(json['critical_issues']),
//       keyIndicators: keyIndicatorsMap.map((key, value) =>
//           MapEntry(key, KeyIndicator.fromJson(value))),
//     );
//   }
// }

// class KeyIndicator {
//   final double currentValue;
//   final IdealRange idealRange;
//   final String status;
//   final String? subclass;
//   final List<String> organicTipsForImprovement;

//   KeyIndicator({
//     required this.currentValue,
//     required this.idealRange,
//     required this.status,
//     this.subclass,
//     required this.organicTipsForImprovement,
//   });

//   factory KeyIndicator.fromJson(Map<String, dynamic> json) {
//     return KeyIndicator(
//       currentValue: json['current_value'].toDouble(),
//       idealRange: IdealRange.fromJson(json['ideal_range']),
//       status: json['status'],
//       subclass: json['subclass'],
//       organicTipsForImprovement: List<String>.from(json['organic_tips_for_improvement']),
//     );
//   }
// }

// class IdealRange {
//   final double min;
//   final double max;

//   IdealRange({
//     required this.min,
//     required this.max,
//   });

//   factory IdealRange.fromJson(Map<String, dynamic> json) {
//     return IdealRange(
//       min: json['min'].toDouble(),
//       max: json['max'].toDouble(),
//     );
//   }
// }

// class OrganicRecommendations {
//   final List<OrganicFertilizer> organicFertilizers;
//   final List<OrganicPractice> organicPractices;

//   OrganicRecommendations({
//     required this.organicFertilizers,
//     required this.organicPractices,
//   });

//   factory OrganicRecommendations.fromJson(Map<String, dynamic> json) {
//     return OrganicRecommendations(
//       organicFertilizers: (json['organic_fertilizers'] as List)
//           .map((fertilizer) => OrganicFertilizer.fromJson(fertilizer))
//           .toList(),
//       organicPractices: (json['organic_practices'] as List)
//           .map((practice) => OrganicPractice.fromJson(practice))
//           .toList(),
//     );
//   }
// }

// class OrganicFertilizer {
//   final String name;
//   final double amount;
//   final String unit;
//   final String frequency;

//   OrganicFertilizer({
//     required this.name,
//     required this.amount,
//     required this.unit,
//     required this.frequency,
//   });

//   factory OrganicFertilizer.fromJson(Map<String, dynamic> json) {
//     return OrganicFertilizer(
//       name: json['name'],
//       amount: json['amount'].toDouble(),
//       unit: json['unit'],
//       frequency: json['frequency'],
//     );
//   }
// }

// class OrganicPractice {
//   final String name;
//   final String implementation;
//   final String benefits;

//   OrganicPractice({
//     required this.name,
//     required this.implementation,
//     required this.benefits,
//   });

//   factory OrganicPractice.fromJson(Map<String, dynamic> json) {
//     return OrganicPractice(
//       name: json['name'],
//       implementation: json['implementation'],
//       benefits: json['benefits'],
//     );
//   }
// }

// class OrganicActionPlan {
//   final List<String> immediateOrganicActions;
//   final List<String> shortTermOrganicActions;
//   final List<String> longTermOrganicActions;

//   OrganicActionPlan({
//     required this.immediateOrganicActions,
//     required this.shortTermOrganicActions,
//     required this.longTermOrganicActions,
//   });

//   factory OrganicActionPlan.fromJson(Map<String, dynamic> json) {
//     return OrganicActionPlan(
//       immediateOrganicActions: List<String>.from(json['immediate_organic_actions']),
//       shortTermOrganicActions: List<String>.from(json['short_term_organic_actions']),
//       longTermOrganicActions: List<String>.from(json['long_term_organic_actions']),
//     );
//   }
// }

// class AdditionalResource {
//   final String name;
//   final String url;

//   AdditionalResource({
//     required this.name,
//     required this.url,
//   });

//   factory AdditionalResource.fromJson(Map<String, dynamic> json) {
//     return AdditionalResource(
//       name: json['name'],
//       url: json['url'],
//     );
//   }
// }

import 'dart:convert';
import 'dart:developer' as devtools;

class SoilReport {
  final Map<String, dynamic> _data;

  SoilReport(this._data);

factory SoilReport.fromJson(dynamic json) {
  if (json is Map<String, dynamic> && json.containsKey('resp')) {
    try {
      String jsonString = json['resp'] as String;
      // Remove any leading or trailing whitespace and newlines
      jsonString = jsonString.trim();
      // If the JSON string is incomplete, try to complete it
      if (!jsonString.endsWith('}')) {
        jsonString += '}}';
      }
      Map<String, dynamic> parsedJson = jsonDecode(jsonString);
      return SoilReport(parsedJson);
    } catch (e) {
      print('Error parsing JSON string: $e');
      return SoilReport({});
    }
  } else if (json is Map<String, dynamic>) {
    return SoilReport(json);
  } else {
    print('Invalid JSON type: ${json.runtimeType}');
    return SoilReport({});
  }
}

  dynamic get(String key) {
    List<String> keys = key.split('.');
    dynamic value = _data;
    print('----------------------->');
    print(_data.toString());
    print('<----------------------->');
    for (String k in keys) {
      if (value is Map<String, dynamic> && value.containsKey(k)) {
        value = value[k];
        print(value);
      } else {
        return null;
      }
    }
    return value;
  }

  List<T>? getList<T>(String key) {
    dynamic value = get(key);
    if (value is List) {
      return value.cast<T>();
    }
    return null;
  }

  @override
  String toString() {
    return json.encode(_data);
  }
}
