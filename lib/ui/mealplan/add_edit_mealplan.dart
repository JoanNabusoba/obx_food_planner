import 'package:flutter/material.dart';
import 'package:foodplanner_app/ui/recipes/list_data.dart';

class AddEditMealplan extends StatefulWidget {
  const AddEditMealplan({super.key});

  @override
  State<AddEditMealplan> createState() => _AddEditMealplanState();
}

class _AddEditMealplanState extends State<AddEditMealplan> {
  int? value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Select New Meal",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.close_rounded,
                color: Colors.black87,
              ))
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
            itemBuilder: (context, index) {
              var item = foodList[index];
              return RadioListTile(
                contentPadding: const EdgeInsets.only(left: 0, right: 0),
                value: index,
                groupValue: value,
                onChanged: (ind) => setState(() => value = ind!),
                title: Row(
                  children: [
                    //img
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage(
                              "${item['image']}".toString(),
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item['title']}".toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            "${item['desc']}".toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(
                  color: Colors.black38,
                ),
            itemCount: foodList.length),
      ),
    );
  }
}
