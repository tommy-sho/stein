rule "namespace_is_specified" {
  description = "Check namespace name is not empty"

  ignore_cases = []

  expressions = [
    "${jsonpath("metadata.namespace") != ""}",
  ]

  report {
    level   = "ERROR"
    message = "Namespace is not specified"
  }
}

rule "namespace_name_is_valid" {
  description = "Check namespace name is valid"

  ignore_cases = []

  expressions = [
    # "${jsonpath(".metadata.namespace") == get_service_id_with_env(filename)}",
    # "${contains(lookup2(var.hoge, "gateway"), get_service_id_with_env(filename))}",
    # "${jsonpath(".metadata.namespace") == get_service_id_with_env(filename) || contains(maplist(var.hoge, jsonpath(".metadata.namespace")), get_service_id_with_env(filename))}",
    "${jsonpath("metadata.namespace") == get_service_id_with_env(filename) || contains(lookuplist(var.namespace_name_map, jsonpath("metadata.namespace")), get_service_id_with_env(filename))}",
  ]

  report {
    level   = "ERROR"
    message = "${format("Namespace name %q is invalid", jsonpath("metadata.namespace"))}"
  }
}

rule "extension" {
  description = "Acceptable yaml file extensions are limtited"

  ignore_cases = []

  expressions = [
    "${ext(filename) == ".yaml" || ext(filename) == ".yaml.enc"}",
  ]

  report {
    level   = "ERROR"
    message = "File extension should be yaml or yaml.enc"
  }
}
