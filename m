Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A3B79987F
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:17:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexmD-0008O9-DY; Sat, 09 Sep 2023 09:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexlr-0008BD-RM; Sat, 09 Sep 2023 09:13:09 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexln-0005H0-3D; Sat, 09 Sep 2023 09:13:05 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 33F6E20629;
 Sat,  9 Sep 2023 16:13:51 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0F58B26E49;
 Sat,  9 Sep 2023 16:13:00 +0300 (MSK)
Received: (nullmailer pid 354704 invoked by uid 1000);
 Sat, 09 Sep 2023 13:12:59 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v2 0/7] remaining tree-wide spelling fixes
Date: Sat,  9 Sep 2023 16:12:51 +0300
Message-Id: <20230909131258.354675-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

After quite some patches from the original series has been
reviewed and applied, there are 7 more left.  Re-sending
the remaining patches after rebasing to current qemu/master,
resolving some conflicts in the process.

While there are still quite a lot of changes (but much less
than initially), I think the remaining changes can be applied
as is via the trivial-patches tree.

Michael Tokarev (7):
  bsd-user: spelling fixes
  i386: spelling fixes
  ppc: spelling fixes
  hw/net: spelling fixes
  hw/pci: spelling fixes
  hw/tpm: spelling fixes
  hw/other: spelling fixes

 bsd-user/errno_defs.h                |  2 +-
 bsd-user/freebsd/target_os_siginfo.h |  2 +-
 bsd-user/freebsd/target_os_stack.h   |  4 ++--
 bsd-user/freebsd/target_os_user.h    |  2 +-
 bsd-user/qemu.h                      |  2 +-
 bsd-user/signal-common.h             |  4 ++--
 bsd-user/signal.c                    |  6 +++---
 host/include/i386/host/cpuinfo.h     |  2 +-
 host/include/ppc/host/cpuinfo.h      |  2 +-
 hw/acpi/aml-build.c                  |  6 +++---
 hw/acpi/hmat.c                       |  2 +-
 hw/acpi/nvdimm.c                     |  2 +-
 hw/block/hd-geometry.c               |  4 ++--
 hw/block/pflash_cfi01.c              |  2 +-
 hw/char/cadence_uart.c               |  2 +-
 hw/char/imx_serial.c                 |  2 +-
 hw/char/serial.c                     |  2 +-
 hw/core/generic-loader.c             |  4 ++--
 hw/core/machine.c                    |  2 +-
 hw/core/qdev-properties-system.c     |  2 +-
 hw/cpu/a15mpcore.c                   |  2 +-
 hw/cxl/cxl-events.c                  |  2 +-
 hw/cxl/cxl-mailbox-utils.c           |  4 ++--
 hw/dma/omap_dma.c                    |  4 ++--
 hw/i386/acpi-build.c                 |  4 ++--
 hw/i386/amd_iommu.c                  |  4 ++--
 hw/i386/intel_iommu.c                |  4 ++--
 hw/i386/kvm/xen_xenstore.c           |  2 +-
 hw/i386/kvm/xenstore_impl.c          |  2 +-
 hw/i386/pc.c                         |  4 ++--
 hw/input/hid.c                       |  2 +-
 hw/input/tsc2005.c                   | 16 ++++++++--------
 hw/intc/loongarch_extioi.c           |  2 +-
 hw/intc/loongson_liointc.c           |  2 +-
 hw/intc/omap_intc.c                  |  2 +-
 hw/intc/pnv_xive.c                   |  2 +-
 hw/intc/spapr_xive.c                 |  2 +-
 hw/intc/spapr_xive_kvm.c             |  6 +++---
 hw/intc/xive.c                       |  2 +-
 hw/intc/xive2.c                      |  6 +++---
 hw/ipmi/ipmi_bmc_extern.c            |  2 +-
 hw/mem/cxl_type3.c                   |  6 +++---
 hw/misc/imx7_ccm.c                   |  2 +-
 hw/misc/mac_via.c                    |  2 +-
 hw/misc/stm32f2xx_syscfg.c           |  4 ++--
 hw/misc/trace-events                 |  2 +-
 hw/misc/zynq_slcr.c                  |  2 +-
 hw/net/cadence_gem.c                 | 10 +++++-----
 hw/net/dp8393x.c                     |  2 +-
 hw/net/e1000_regs.h                  |  2 +-
 hw/net/e1000x_regs.h                 |  2 +-
 hw/net/fsl_etsec/rings.c             |  2 +-
 hw/net/igb_regs.h                    |  4 ++--
 hw/net/mcf_fec.c                     |  2 +-
 hw/net/rocker/rocker_fp.c            |  2 +-
 hw/net/rtl8139.c                     |  2 +-
 hw/net/smc91c111.c                   |  2 +-
 hw/net/sungem.c                      |  2 +-
 hw/net/sunhme.c                      |  2 +-
 hw/net/virtio-net.c                  |  6 +++---
 hw/net/vmxnet3.c                     |  2 +-
 hw/net/vmxnet3.h                     |  2 +-
 hw/nvme/ctrl.c                       |  6 +++---
 hw/nvram/eeprom_at24c.c              |  2 +-
 hw/nvram/fw_cfg.c                    |  2 +-
 hw/pci-bridge/cxl_downstream.c       |  2 +-
 hw/pci-bridge/pci_expander_bridge.c  |  2 +-
 hw/pci-host/bonito.c                 |  2 +-
 hw/pci-host/designware.c             |  4 ++--
 hw/pci-host/dino.c                   |  2 +-
 hw/pci-host/gpex-acpi.c              |  2 +-
 hw/pci-host/gt64120.c                |  4 ++--
 hw/pci-host/pnv_phb.c                |  2 +-
 hw/pci-host/pnv_phb3.c               |  2 +-
 hw/pci-host/pnv_phb3_msi.c           |  2 +-
 hw/pci-host/pnv_phb4.c               |  6 +++---
 hw/pci/pcie_aer.c                    |  2 +-
 hw/pci/shpc.c                        |  2 +-
 hw/ppc/ppc.c                         |  2 +-
 hw/ppc/prep_systemio.c               |  2 +-
 hw/ppc/spapr.c                       |  8 ++++----
 hw/ppc/spapr_hcall.c                 |  2 +-
 hw/ppc/spapr_nvdimm.c                |  4 ++--
 hw/ppc/spapr_pci_vfio.c              |  2 +-
 hw/rtc/exynos4210_rtc.c              |  2 +-
 hw/rx/rx62n.c                        |  2 +-
 hw/scsi/lsi53c895a.c                 |  2 +-
 hw/scsi/mfi.h                        |  2 +-
 hw/sh4/sh7750_regs.h                 | 26 +++++++++++++-------------
 hw/smbios/smbios.c                   |  2 +-
 hw/ssi/xilinx_spips.c                |  6 +++---
 hw/ssi/xlnx-versal-ospi.c            |  2 +-
 hw/timer/etraxfs_timer.c             |  2 +-
 hw/timer/renesas_tmr.c               |  2 +-
 hw/tpm/tpm_tis.h                     |  2 +-
 hw/tpm/tpm_tis_common.c              |  2 +-
 hw/tpm/tpm_tis_i2c.c                 |  4 ++--
 hw/tpm/tpm_tis_isa.c                 |  2 +-
 hw/tpm/tpm_tis_sysbus.c              |  2 +-
 hw/virtio/virtio-crypto.c            |  4 ++--
 hw/virtio/virtio-mem.c               |  2 +-
 hw/virtio/virtio.c                   |  2 +-
 include/hw/i386/topology.h           |  2 +-
 include/hw/ppc/openpic.h             |  2 +-
 include/hw/ppc/spapr.h               |  2 +-
 target/i386/cpu.c                    |  4 ++--
 target/i386/cpu.h                    |  4 ++--
 target/i386/kvm/kvm.c                |  4 ++--
 target/i386/kvm/xen-emu.c            |  2 +-
 target/i386/machine.c                |  4 ++--
 target/i386/tcg/translate.c          |  8 ++++----
 target/ppc/cpu-models.h              |  4 ++--
 target/ppc/cpu.h                     |  2 +-
 target/ppc/cpu_init.c                |  4 ++--
 target/ppc/excp_helper.c             | 14 +++++++-------
 target/ppc/power8-pmu-regs.c.inc     |  4 ++--
 target/ppc/translate/vmx-impl.c.inc  |  6 +++---
 tests/tcg/i386/system/boot.S         |  2 +-
 tests/tcg/i386/x86.csv               |  2 +-
 119 files changed, 198 insertions(+), 198 deletions(-)

-- 
2.39.2


