let App = ../schemas/App.dhall

let kubernetes = ../imports/kubernetes.dhall

let Optional/map = ../imports/mapOption.dhall

let Map = ../imports/mapType.dhall

let Resources = ../types/Resources.dhall

let containerPort =
      λ(port : Integer) → kubernetes.ContainerPort::{ containerPort = port }

let resourcesToMap = λ(resources : Resources) → toMap resources

let container =
      λ(app : App.Type) →
        kubernetes.Container::{
        , name = app.name
        , image = Some app.image
        , resources = Some kubernetes.ResourceRequirements::{
          , requests = Some (toMap app.requests)
          , limits =
              Optional/map Resources (Map Text Text) resourcesToMap app.limits
          }
        , ports = Some [ containerPort app.port ]
        , env = Some app.envVars
        }

in  container
