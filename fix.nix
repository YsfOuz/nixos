{ pkgs, ... }:
{
  # ==========================================================================
  # THINKPAD E16 GEN 2 - POWER FIX
  # ==========================================================================
  # Intel Core Ultra 7 155H + 65W charger
  #
  # Lenovo default: PL1 40W / PL2 55W
  # After fix:      PL1 45W / PL2 115W  (clamped to 28W by firmware max_power_uw)
  #
  # Note: constraint_0_max_power_uw is firmware-locked at 28W.
  #       Limits are set to spec anyway — if a BIOS update ever raises
  #       the ceiling, this config will automatically take full effect.
  #
  # Note: Upgrade to 96W/100W charger → raise PL1 to 65000000
  # ==========================================================================

  # Boot
  systemd.services.cpu-power-fix = {
    description = "Fix ThinkPad E16 Gen 2 RAPL power limits";
    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "cpu-power-fix" ''
        # MSR interface
        echo 45000000  > /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_power_limit_uw
        echo 115000000 > /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_1_power_limit_uw
        # MMIO interface (the one hardware actually enforces on this platform)
        echo 45000000  > /sys/class/powercap/intel-rapl-mmio/intel-rapl-mmio:0/constraint_0_power_limit_uw
        echo 115000000 > /sys/class/powercap/intel-rapl-mmio/intel-rapl-mmio:0/constraint_1_power_limit_uw
      '';
    };
  };

  # Suspend/hibernate resume
  powerManagement.resumeCommands = ''
    echo 45000000  > /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_power_limit_uw
    echo 115000000 > /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_1_power_limit_uw
    echo 45000000  > /sys/class/powercap/intel-rapl-mmio/intel-rapl-mmio:0/constraint_0_power_limit_uw
    echo 115000000 > /sys/class/powercap/intel-rapl-mmio/intel-rapl-mmio:0/constraint_1_power_limit_uw
  '';
}
