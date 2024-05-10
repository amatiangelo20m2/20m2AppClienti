import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
    additionalProperties:
    AdditionalProperties(pubName: 'ventimetri_api', pubAuthor: 'Angelo Amati'),
    inputSpecFile: 'lib/json/ventimetri_service.yaml',
    generatorName: Generator.dart,
    outputDirectory: 'lib/api/client')
class OpenApi extends OpenapiGeneratorConfig {}