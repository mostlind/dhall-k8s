let App = ../schemas/App.dhall

let kubernetes = ../imports/kubernetes.dhall

let container = ./container.dhall

let deployment =
      λ(app : App.Type) →
        kubernetes.Deployment::{
        , metadata = kubernetes.ObjectMeta::{ name = Some app.name }
        , spec = Some kubernetes.DeploymentSpec::{
          , selector = kubernetes.LabelSelector::{
            , matchLabels = Some (toMap { app = app.name })
            }
          , template = kubernetes.PodTemplateSpec::{
            , metadata = Some kubernetes.ObjectMeta::{
              , labels = Some (toMap { app = app.name })
              }
            , spec = Some kubernetes.PodSpec::{ containers = [ container app ] }
            }
          }
        }

in  deployment
