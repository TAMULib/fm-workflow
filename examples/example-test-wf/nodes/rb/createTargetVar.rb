
require 'json'

query_wrapper = {
  message: 'Hello, File From Script Task. You need me to create File Task!'
}

json_string  = query_wrapper.to_json
execution.setVariableLocal('exampleFileData', json_string)

execution.setVariable('exampleFileData', 'Hello, File From Script Task. You need me to create File Task!')

