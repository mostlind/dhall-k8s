let Resources = ./Resources.dhall

let kubernetes = ../imports/kubernetes.dhall

in  { name : Text
    , image : Text
    , host : Text
    , requests : Resources
    , limits : Optional Resources
    , envVars : List kubernetes.EnvVar.Type
    , port : Natural
    }
