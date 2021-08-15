package flags

import "github.com/alecthomas/kong"

// API api related flags passing in env variables
type API struct {
	Version kong.VersionFlag
	Debug   bool   `help:"Enable debug output."`
	Stage   string `help:"Stage the software is deployed." env:"STAGE"`
	Branch  string `help:"Branch used to build software." env:"BRANCH"`
}
