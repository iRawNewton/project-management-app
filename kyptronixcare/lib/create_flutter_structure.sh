#!/bin/bash

# Create core directory and its subdirectories
mkdir -p core/{constants,error,network,themes,utils,widgets}

# Create files in core subdirectories
touch core/constants/{api_constants.dart,app_constants.dart}
touch core/error/{exceptions.dart,failures.dart}
touch core/network/{network_info.dart,api_client.dart}
touch core/themes/{app_colors.dart,app_text_styles.dart,app_theme.dart}
touch core/utils/{input_converter.dart,date_time_utils.dart}
touch core/widgets/{custom_button.dart,loading_widget.dart}

# Create features directory and its subdirectories
mkdir -p features/{feature_1,feature_2}/{data/{datasources,models,repositories},domain/{entities,repositories,usecases},presentation/{bloc,pages,widgets}}

# Create files in feature_1 subdirectories
touch features/feature_1/data/datasources/{feature_1_local_data_source.dart,feature_1_remote_data_source.dart}
touch features/feature_1/data/models/feature_1_model.dart
touch features/feature_1/data/repositories/feature_1_repository_impl.dart
touch features/feature_1/domain/entities/feature_1.dart
touch features/feature_1/domain/repositories/feature_1_repository.dart
touch features/feature_1/domain/usecases/get_feature_1.dart
touch features/feature_1/presentation/bloc/{feature_1_bloc.dart,feature_1_event.dart,feature_1_state.dart}
touch features/feature_1/presentation/pages/feature_1_page.dart
touch features/feature_1/presentation/widgets/feature_1_widget.dart

# Create similar structure for feature_2 (you can add specific files if needed)

# Create config directory and its subdirectories
mkdir -p config/{routes,injection}

# Create files in config subdirectories
touch config/routes/app_router.dart
touch config/injection/injection_container.dart

# Create main.dart file
touch main.dart

echo "Folder structure and files created successfully!"