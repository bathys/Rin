{ config, pkgs, ... }:
{
  virtualisation = {
	  libvirtd.enable = true;
	  spiceUSBRedirection.enable = true;
  };
}
