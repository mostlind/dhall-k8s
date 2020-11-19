let service = ../resources/service.dhall

let deployment = ../resources/deployment.dhall

let kubernetes = ../imports/kubernetes.dhall

let App = ../schemas/App.dhall

let concatMap = ../imports/concatMap.dhall

let map = ../imports/map.dhall

let Environment = ../types/Environment.dhall

let EnvironmentConfig = ../types/EnvironmentConfig.dhall

let apply = ../utils/apply.dhall

let items =
      λ(environment : Environment) →
        let appConfigs =
              map
                (EnvironmentConfig → App.Type)
                App.Type
                (apply EnvironmentConfig App.Type environment.config)
                environment.apps

        let services = map App.Type kubernetes.Service.Type service appConfigs

        let deployments =
              map App.Type kubernetes.Deployment.Type deployment appConfigs

        let ingress =
              ../resources/ingress.dhall
                (environment.config.prefix ++ "ingress")
                appConfigs

        let servicesUnion =
              map
                kubernetes.Service.Type
                kubernetes.Resource
                kubernetes.Resource.Service
                services

        let deploymentsUnion =
              map
                kubernetes.Deployment.Type
                kubernetes.Resource
                kubernetes.Resource.Deployment
                deployments

        let ingressUnion = [ kubernetes.Resource.Ingress ingress ]

        in  servicesUnion # deploymentsUnion # ingressUnion

in  items
