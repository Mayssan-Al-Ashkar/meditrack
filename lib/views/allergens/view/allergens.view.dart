import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/base/view/base_widget.dart';
import 'package:medication_app_v0/core/components/widgets/custom_bottom_appbar.dart';
import 'package:medication_app_v0/core/components/widgets/drawer.dart';
import 'package:medication_app_v0/core/init/locale_keys.g.dart';
import 'package:medication_app_v0/core/init/theme/color_theme.dart';
import 'package:medication_app_v0/views/allergens/viewmodel/allergens_viewmodel.dart';
import 'package:medication_app_v0/core/extention/context_extention.dart';
import 'package:medication_app_v0/core/extention/string_extention.dart';

/// Allergens management view
///
/// Displays the user's list of allergens and provides UI to add/remove
/// allergens. Uses a `BaseView<AllergensViewModel>` to obtain the
/// view model and persist changes to shared preferences.
class AllergensView extends StatefulWidget {
  const AllergensView({Key? key}) : super(key: key);

  @override
  _AllergensViewState createState() => _AllergensViewState();
}

class _AllergensViewState extends State<AllergensView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<AllergensViewModel>(
      model: AllergensViewModel(),
      onModelReady: (AllergensViewModel model) {
        model.setContext(context);
        model.init();
      },
      builder: (BuildContext context, AllergensViewModel viewModel) =>
          _buildScaffold(context, viewModel),
    );
  }

  Scaffold _buildScaffold(BuildContext context, AllergensViewModel viewModel) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(LocaleKeys.allergens_ALLERGEN.locale),
      ),
      drawer:  CustomDrawer(),
      bottomNavigationBar:  CustomBottomAppBar(),
      body: _buildBody(context, viewModel),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddAllergenDialog(context, viewModel),
        tooltip: LocaleKeys.allergens_ADD.locale,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBody(BuildContext context, AllergensViewModel viewModel) {
    if (viewModel.allergens.isNotEmpty) {
      return _buildAllergensList(context, viewModel);
    }
    return _buildEmptyState(context);
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.primary;

    return Padding(
      padding: context.paddingMedium,
      child: Container(
        decoration: ShapeDecoration(
          shape: Border.all(color: color, width: 2.0),
        ),
        height: context.height * 0.12,
        width: double.infinity,
        child: Center(
          child: Text(
            LocaleKeys.allergens_EMPTY_SCREEN.locale,
            style: theme.textTheme.headline6?.copyWith(color: color),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildAllergensList(BuildContext context, AllergensViewModel viewModel) {
    return ListView.separated(
      padding: context.paddingLow,
      itemCount: viewModel.allergens.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final String allergen = viewModel.allergens[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: ListTile(
            title: Text(allergen),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: LocaleKeys.allergens_DELETE.locale,
              onPressed: () => _confirmRemoveAllergen(context, viewModel, index),
            ),
            onLongPress: () => _confirmRemoveAllergen(context, viewModel, index),
          ),
        );
      },
    );
  }

  Future<void> _showAddAllergenDialog(
      BuildContext context, AllergensViewModel viewModel) async {
    final controller = viewModel.allergenFieldController;
    controller.text = '';

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(LocaleKeys.allergens_INSERT_ALLERGEN.locale),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: LocaleKeys.allergens_INSERT_ALLERGEN_HINT.locale,
            ),
            autofocus: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => Navigator.of(context).pop(true),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(LocaleKeys.allergens_CANCEL.locale),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text(LocaleKeys.allergens_ADD.locale),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (result == true && controller.text.trim().isNotEmpty) {
      final newAllergen = controller.text.trim();
      setState(() {
        viewModel.allergens.insert(0, newAllergen);
      });
      await viewModel.setSharedPrefAllergen(viewModel.allergens);
    }
  }

  Future<void> _confirmRemoveAllergen(
      BuildContext context, AllergensViewModel viewModel, int index) async {
    final allergen = viewModel.allergens[index];
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(LocaleKeys.allergens_DELETE_ALLERGEN.locale),
          content: Text(allergen),
          actions: <Widget>[
            TextButton(
              child: Text(LocaleKeys.allergens_CANCEL.locale),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text(LocaleKeys.allergens_DELETE.locale),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      setState(() {
        viewModel.allergens.removeAt(index);
      });
      await viewModel.setSharedPrefAllergen(viewModel.allergens);
    }
  }
}
