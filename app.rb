require("sinatra")
require("sinatra/reloader")
require("./lib/train")
require("./lib/city")
also_reload("lib/**/*.rb")
require("pg")

DB = PG.connect({:dbname => "train_sys"})
