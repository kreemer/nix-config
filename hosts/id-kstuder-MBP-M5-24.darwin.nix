{ config, lib, ... }:
{
  # Nur host-spezifische Überschreibungen hier
  networking.hostName = "id-kstuder-MBP-M5-24";
  
  # Falls du später noch andere Maschinen konfigurierst:
  # if config.networking.hostName == "id-kstuder-MBP-M5-24" then ...
  
  # Oder host-spezifische Pakete:
  # environment.systemPackages = lib.optionals (config.networking.hostName == "id-kstuder-MBP-M5-24")
  #   [ pkgs.specificMacOnlyTool ];
}
