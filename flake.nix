{
	description = "Flake for pokescript";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	};

	outputs = { self, nixpkgs, ... }@inputs: 
	let
		make-pokescript = nixpkgs.legacyPackages.x86_64-linux.rustPlatform.buildRustPackage rec {
			pname = "pokescript";
			version = "0.1.0";

			src = ./.;

			cargoLock = {
				lockFile = ./Cargo.lock;
			};
			meta = with nixpkgs.lib; {
				description = "A CLI utility to print out images of pokemon to the terminal";
				homepage = "https://github.com/mimiqdev/pokescript";
				license = licenses.mit;
				maintainers = [];
			};
		};
		in
		{
			packages.x86_64-linux = {
				default = self.packages.x86_64-linux.pokescript;
				pokescript = make-pokescript;
			};
		};
}
