let App = ../schemas/App.dhall

let EnvironmentConfig = ./EnvironmentConfig.dhall

in  { config : EnvironmentConfig, apps : List (EnvironmentConfig → App.Type) }
