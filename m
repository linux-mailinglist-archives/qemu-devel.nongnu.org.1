Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 378057A929F
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:36:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjF9t-0005wD-I3; Thu, 21 Sep 2023 04:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjF9a-0005rq-Sl; Thu, 21 Sep 2023 04:35:20 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjF9X-0001B2-Q5; Thu, 21 Sep 2023 04:35:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0C28B23DA3;
 Thu, 21 Sep 2023 11:35:33 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C4F3C299FD;
 Thu, 21 Sep 2023 11:35:11 +0300 (MSK)
Received: (nullmailer pid 509081 invoked by uid 1000);
 Thu, 21 Sep 2023 08:35:11 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PULL 00/17] Trivial patches for 2023-09-21
Date: Thu, 21 Sep 2023 11:34:49 +0300
Message-Id: <20230921083506.509032-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The following changes since commit 4907644841e3200aea6475c0f72d3d987e9f3d93:

  Merge tag 'mem-2023-09-19' of https://github.com/davidhildenbrand/qemu into staging (2023-09-19 13:22:19 -0400)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to fa365d05b7050163a53d16aa2d8efb96834e8725:

  docs/devel/reset.rst: Correct function names (2023-09-21 11:31:18 +0300)

----------------------------------------------------------------
trivial patches for 2023-09-21

The remainder of spelling fixes, cxl trivial fixes, and a few other
docs and comments fixes.

----------------------------------------------------------------
Akihiko Odaki (1):
      docs/devel/reset.rst: Correct function names

Dave Jiang (1):
      hw/pci-bridge/cxl_upstream: Fix bandwidth entry base unit for SSLBIS

Dmitry Frolov (1):
      hw/cxl: Fix out of bound array access

Fan Ni (1):
      hw/cxl/cxl_device: Replace magic number in CXLError definition

Jonathan Cameron (2):
      hw/mem/cxl_type3: Add missing copyright and license notice
      docs/cxl: Cleanout some more aarch64 examples.

Laszlo Ersek (1):
      hw/i386/pc: fix code comment on cumulative flash size

Li Zhijian (2):
      hw/cxl: Fix CFMW config memory leak
      docs/cxl: Change to lowercase as others

Michael Tokarev (7):
      ppc: spelling fixes
      bsd-user: spelling fixes
      i386: spelling fixes
      hw/net: spelling fixes
      hw/pci: spelling fixes
      hw/tpm: spelling fixes
      hw/other: spelling fixes

Thomas Huth (1):
      subprojects: Use the correct .git suffix in the repository URLs

 bsd-user/errno_defs.h                 |  2 +-
 bsd-user/freebsd/target_os_siginfo.h  |  2 +-
 bsd-user/freebsd/target_os_stack.h    |  4 ++--
 bsd-user/freebsd/target_os_user.h     |  2 +-
 bsd-user/qemu.h                       |  2 +-
 bsd-user/signal-common.h              |  4 ++--
 bsd-user/signal.c                     |  6 +++---
 docs/devel/reset.rst                  | 17 ++++++++---------
 docs/system/devices/cxl.rst           | 12 ++++++------
 host/include/i386/host/cpuinfo.h      |  2 +-
 host/include/ppc/host/cpuinfo.h       |  2 +-
 hw/acpi/aml-build.c                   |  6 +++---
 hw/acpi/hmat.c                        |  2 +-
 hw/acpi/nvdimm.c                      |  2 +-
 hw/block/hd-geometry.c                |  4 ++--
 hw/block/pflash_cfi01.c               |  2 +-
 hw/char/cadence_uart.c                |  2 +-
 hw/char/imx_serial.c                  |  2 +-
 hw/char/serial.c                      |  2 +-
 hw/core/generic-loader.c              |  4 ++--
 hw/core/machine.c                     |  2 +-
 hw/core/qdev-properties-system.c      |  2 +-
 hw/cpu/a15mpcore.c                    |  2 +-
 hw/cxl/cxl-events.c                   |  2 +-
 hw/cxl/cxl-host.c                     | 12 ++++++------
 hw/cxl/cxl-mailbox-utils.c            |  4 ++--
 hw/dma/omap_dma.c                     |  4 ++--
 hw/i386/acpi-build.c                  |  4 ++--
 hw/i386/amd_iommu.c                   |  4 ++--
 hw/i386/intel_iommu.c                 |  4 ++--
 hw/i386/kvm/xen_xenstore.c            |  2 +-
 hw/i386/kvm/xenstore_impl.c           |  2 +-
 hw/i386/pc.c                          | 16 ++++++++--------
 hw/input/hid.c                        |  2 +-
 hw/input/tsc2005.c                    | 16 ++++++++--------
 hw/intc/loongarch_extioi.c            |  2 +-
 hw/intc/loongson_liointc.c            |  2 +-
 hw/intc/omap_intc.c                   |  2 +-
 hw/intc/pnv_xive.c                    |  2 +-
 hw/intc/spapr_xive.c                  |  2 +-
 hw/intc/spapr_xive_kvm.c              |  6 +++---
 hw/intc/xive.c                        |  2 +-
 hw/intc/xive2.c                       |  6 +++---
 hw/ipmi/ipmi_bmc_extern.c             |  2 +-
 hw/mem/cxl_type3.c                    | 17 ++++++++++++++---
 hw/mem/cxl_type3_stubs.c              | 10 ++++++++++
 hw/misc/imx7_ccm.c                    |  2 +-
 hw/misc/mac_via.c                     |  2 +-
 hw/misc/stm32f2xx_syscfg.c            |  4 ++--
 hw/misc/trace-events                  |  2 +-
 hw/misc/zynq_slcr.c                   |  2 +-
 hw/net/cadence_gem.c                  | 10 +++++-----
 hw/net/dp8393x.c                      |  2 +-
 hw/net/e1000_regs.h                   |  2 +-
 hw/net/e1000x_regs.h                  |  2 +-
 hw/net/fsl_etsec/rings.c              |  2 +-
 hw/net/igb_regs.h                     |  4 ++--
 hw/net/mcf_fec.c                      |  2 +-
 hw/net/rocker/rocker_fp.c             |  2 +-
 hw/net/rtl8139.c                      |  2 +-
 hw/net/smc91c111.c                    |  2 +-
 hw/net/sungem.c                       |  2 +-
 hw/net/sunhme.c                       |  2 +-
 hw/net/virtio-net.c                   |  6 +++---
 hw/net/vmxnet3.c                      |  2 +-
 hw/net/vmxnet3.h                      |  2 +-
 hw/nvme/ctrl.c                        |  6 +++---
 hw/nvram/eeprom_at24c.c               |  2 +-
 hw/nvram/fw_cfg.c                     |  2 +-
 hw/pci-bridge/cxl_downstream.c        |  2 +-
 hw/pci-bridge/cxl_upstream.c          |  2 +-
 hw/pci-bridge/pci_expander_bridge.c   |  2 +-
 hw/pci-host/bonito.c                  |  2 +-
 hw/pci-host/designware.c              |  4 ++--
 hw/pci-host/dino.c                    |  2 +-
 hw/pci-host/gpex-acpi.c               |  2 +-
 hw/pci-host/gt64120.c                 |  4 ++--
 hw/pci-host/pnv_phb.c                 |  2 +-
 hw/pci-host/pnv_phb3.c                |  2 +-
 hw/pci-host/pnv_phb3_msi.c            |  2 +-
 hw/pci-host/pnv_phb4.c                |  6 +++---
 hw/pci/pcie_aer.c                     |  2 +-
 hw/pci/shpc.c                         |  2 +-
 hw/ppc/ppc.c                          |  2 +-
 hw/ppc/prep_systemio.c                |  2 +-
 hw/ppc/spapr.c                        |  8 ++++----
 hw/ppc/spapr_hcall.c                  |  2 +-
 hw/ppc/spapr_nvdimm.c                 |  4 ++--
 hw/ppc/spapr_pci_vfio.c               |  2 +-
 hw/rtc/exynos4210_rtc.c               |  2 +-
 hw/rx/rx62n.c                         |  2 +-
 hw/scsi/lsi53c895a.c                  |  2 +-
 hw/scsi/mfi.h                         |  2 +-
 hw/sh4/sh7750_regs.h                  | 26 +++++++++++++-------------
 hw/smbios/smbios.c                    |  2 +-
 hw/ssi/xilinx_spips.c                 |  6 +++---
 hw/ssi/xlnx-versal-ospi.c             |  2 +-
 hw/timer/etraxfs_timer.c              |  2 +-
 hw/timer/renesas_tmr.c                |  2 +-
 hw/tpm/tpm_tis.h                      |  2 +-
 hw/tpm/tpm_tis_common.c               |  2 +-
 hw/tpm/tpm_tis_i2c.c                  |  4 ++--
 hw/tpm/tpm_tis_isa.c                  |  2 +-
 hw/tpm/tpm_tis_sysbus.c               |  2 +-
 hw/virtio/virtio-crypto.c             |  4 ++--
 hw/virtio/virtio-mem.c                |  2 +-
 hw/virtio/virtio.c                    |  2 +-
 include/hw/cxl/cxl.h                  |  2 +-
 include/hw/cxl/cxl_device.h           |  2 +-
 include/hw/i386/topology.h            |  2 +-
 include/hw/ppc/openpic.h              |  2 +-
 include/hw/ppc/spapr.h                |  2 +-
 subprojects/berkeley-softfloat-3.wrap |  2 +-
 subprojects/berkeley-testfloat-3.wrap |  2 +-
 subprojects/slirp.wrap                |  2 +-
 target/i386/cpu.c                     |  4 ++--
 target/i386/cpu.h                     |  4 ++--
 target/i386/kvm/kvm.c                 |  4 ++--
 target/i386/kvm/xen-emu.c             |  2 +-
 target/i386/machine.c                 |  4 ++--
 target/i386/tcg/translate.c           |  8 ++++----
 target/ppc/cpu-models.h               |  4 ++--
 target/ppc/cpu.h                      |  2 +-
 target/ppc/cpu_init.c                 |  4 ++--
 target/ppc/excp_helper.c              | 14 +++++++-------
 target/ppc/power8-pmu-regs.c.inc      |  4 ++--
 target/ppc/translate/vmx-impl.c.inc   |  6 +++---
 tests/tcg/i386/system/boot.S          |  2 +-
 tests/tcg/i386/x86.csv                |  2 +-
 129 files changed, 251 insertions(+), 231 deletions(-)

