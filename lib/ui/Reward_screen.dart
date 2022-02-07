import 'package:flutter_kundol/index/index.dart';

class RewardScreen extends StatefulWidget {
  @override
  _RewardScreenState createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RewardBloc>(context).add(GetRewardPoints());
  }

  @override
  Widget build(BuildContext context) {
    Widget mainWidget;
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title:
            Text("Reward Points", style: Theme.of(context).textTheme.headline6),
        elevation: 0.0,
      ),
      body: BlocConsumer<RewardBloc, RewardState>(
        builder: (context, state) {
          if (state is RewardLoaded) {
            double points = 0.0;

            for (int i = 0; i < state.rewardPointsResponse.data.length; i++) {
              points += double.parse(
                  state.rewardPointsResponse.data[i].points.toString());
            }
            mainWidget = Column(
              children: [
                Container(
                  height: 120,
                  width: double.maxFinite,
                  child: Center(
                    child: Text(
                      points.toStringAsFixed(2),
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.rewardPointsResponse.data.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(
                          state.rewardPointsResponse.data[index].description),
                      trailing: Text(double.parse(state
                              .rewardPointsResponse.data[index].points
                              .toString())
                          .toStringAsFixed(2)),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.maxFinite,
                  height: 45.0,
                  child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<RewardBloc>(context)
                            .add(RedeemPoints());
                      },
                      child: Text("Redeem")),
                ),
              ],
            );
            return mainWidget;
          } else if (state is RedeemLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.redeemResponse.message)));
            return mainWidget;
          } else if (state is CartLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return Container();
        },
        listener: (context, state) {
          if (state is RewardError) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is RedeemLoaded) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.redeemResponse.message)));
          }
        },
      ),
    );
  }
}
