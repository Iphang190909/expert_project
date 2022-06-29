import 'package:equatable/equatable.dart';
import 'package:tv/data/models/tv_model.dart';

class TVResponse extends Equatable {
  final List<TVModel> tvlist;

  const TVResponse({required this.tvlist});
  factory TVResponse.fromJson(Map<String, dynamic> json) => TVResponse(
        tvlist: List<TVModel>.from((json["results"] as List)
            .map((x) => TVModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvlist.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [tvlist];
}
