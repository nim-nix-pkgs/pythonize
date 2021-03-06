{
  description = ''A higher-level wrapper for the Python Programing Language'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."pythonize-master".dir   = "master";
  inputs."pythonize-master".owner = "nim-nix-pkgs";
  inputs."pythonize-master".ref   = "master";
  inputs."pythonize-master".repo  = "pythonize";
  inputs."pythonize-master".type  = "github";
  inputs."pythonize-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."pythonize-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}