Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE654785020
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 07:53:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYgmw-0001Fw-NY; Wed, 23 Aug 2023 01:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYgmn-0001Fe-W2
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:52:10 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYgmj-0007Fk-8Q
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:52:09 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 86A7C1C38A
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 08:52:18 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 34CB721232;
 Wed, 23 Aug 2023 08:52:00 +0300 (MSK)
Received: (nullmailer pid 1917443 invoked by uid 1000);
 Wed, 23 Aug 2023 05:52:00 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v2 00/24] tree-wide spelling fixes
Date: Wed, 23 Aug 2023 08:51:28 +0300
Message-Id: <20230823055155.1917375-1-mjt@tls.msk.ru>
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

This is a v2 of large tree-wide spelling patch set.
Mostly fixes spelling errors in comments, but also in
some messages too, in documentation, in trace event
formats and so on.

I tried to group the fixes into more-or-less reasonable
chunks, but due to large amount of changes it's a trade-
off, - either individual patches are large, or there are
just too many of them.

First version has been postd before, available here:
https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg03006.html

I renamed individual patches (to have grouping at the beginning
of the subject line), dropped patches which has been reviewed
and applied, and addressed some other review comments.

It is still a large series, 508 changes in 336 files.

Please review.  I plan to send a pull request via a trivial-patches
tree.

Michael Tokarev (24):
  block: spelling fixes
  bsd-user: spelling fixes
  ui: spelling fixes
  util: spelling fixes
  tcg: spelling fixes
  docs: spelling fixes
  i386: spelling fixes
  mips: spelling fixes
  ppc: spelling fixes
  riscv: spelling fixes
  hexagon: spelling fixes
  hw/net: spelling fixes
  hw/pci: spelling fixes
  hw/tpm: spelling fixes
  hw/usb hw/ide hw/i2c: spelling fixes
  hw/display: spelling fixes
  xen: spelling fixes
  audio: spelling fixes
  hw/other: spelling fixes
  include/: spelling fixes
  scripts/: spelling fixes
  tests/: spelling fixes
  qga/: spelling fixes
  misc/other: spelling fixes

 accel/tcg/tb-maint.c                          |  2 +-
 audio/mixeng.h                                |  2 +-
 backends/tpm/tpm_ioctl.h                      |  2 +-
 block.c                                       |  2 +-
 block/block-copy.c                            |  4 +--
 block/export/vduse-blk.c                      |  2 +-
 block/export/vhost-user-blk-server.c          |  2 +-
 block/export/vhost-user-blk-server.h          |  2 +-
 block/file-posix.c                            |  8 +++---
 block/graph-lock.c                            |  2 +-
 block/io.c                                    |  2 +-
 block/linux-aio.c                             |  2 +-
 block/mirror.c                                |  2 +-
 block/qcow2-refcount.c                        |  2 +-
 block/vhdx.c                                  |  2 +-
 block/vhdx.h                                  |  4 +--
 bsd-user/errno_defs.h                         |  2 +-
 bsd-user/freebsd/target_os_siginfo.h          |  2 +-
 bsd-user/freebsd/target_os_stack.h            |  4 +--
 bsd-user/freebsd/target_os_user.h             |  2 +-
 bsd-user/qemu.h                               |  2 +-
 bsd-user/signal-common.h                      |  4 +--
 bsd-user/signal.c                             |  6 ++---
 chardev/char-socket.c                         |  6 ++---
 chardev/char.c                                |  2 +-
 contrib/plugins/cache.c                       |  2 +-
 contrib/plugins/lockstep.c                    |  2 +-
 crypto/afalg.c                                |  2 +-
 crypto/block-luks.c                           |  6 ++---
 crypto/der.c                                  |  2 +-
 crypto/der.h                                  |  6 ++---
 docs/devel/qapi-code-gen.rst                  |  2 +-
 host/include/i386/host/cpuinfo.h              |  2 +-
 host/include/ppc/host/cpuinfo.h               |  2 +-
 hw/acpi/aml-build.c                           |  6 ++---
 hw/acpi/hmat.c                                |  2 +-
 hw/acpi/nvdimm.c                              |  2 +-
 hw/audio/fmopl.c                              |  8 +++---
 hw/audio/fmopl.h                              |  2 +-
 hw/audio/gusemu_hal.c                         |  4 +--
 hw/audio/intel-hda-defs.h                     |  4 +--
 hw/block/hd-geometry.c                        |  4 +--
 hw/block/pflash_cfi01.c                       |  2 +-
 hw/char/cadence_uart.c                        |  2 +-
 hw/char/imx_serial.c                          |  2 +-
 hw/char/serial.c                              |  2 +-
 hw/core/generic-loader.c                      |  4 +--
 hw/core/machine.c                             |  2 +-
 hw/core/qdev-properties-system.c              |  2 +-
 hw/cpu/a15mpcore.c                            |  2 +-
 hw/cxl/cxl-events.c                           |  2 +-
 hw/cxl/cxl-mailbox-utils.c                    |  4 +--
 hw/display/bochs-display.c                    |  2 +-
 hw/display/qxl.c                              |  2 +-
 hw/display/ssd0303.c                          |  2 +-
 hw/display/ssd0323.c                          |  2 +-
 hw/display/xlnx_dp.c                          |  2 +-
 hw/dma/omap_dma.c                             |  4 +--
 hw/i2c/pm_smbus.c                             |  2 +-
 hw/i2c/pmbus_device.c                         |  2 +-
 hw/i2c/smbus_slave.c                          |  2 +-
 hw/i386/acpi-build.c                          |  4 +--
 hw/i386/amd_iommu.c                           |  4 +--
 hw/i386/intel_iommu.c                         |  4 +--
 hw/i386/kvm/xen_xenstore.c                    |  2 +-
 hw/i386/kvm/xenstore_impl.c                   |  2 +-
 hw/i386/pc.c                                  |  4 +--
 hw/ide/ahci_internal.h                        |  4 +--
 hw/ide/cmd646.c                               |  2 +-
 hw/ide/core.c                                 |  2 +-
 hw/input/hid.c                                |  2 +-
 hw/input/tsc2005.c                            | 16 ++++++------
 hw/intc/loongarch_extioi.c                    |  2 +-
 hw/intc/loongson_liointc.c                    |  2 +-
 hw/intc/omap_intc.c                           |  2 +-
 hw/intc/pnv_xive.c                            |  2 +-
 hw/intc/spapr_xive.c                          |  2 +-
 hw/intc/spapr_xive_kvm.c                      |  6 ++---
 hw/intc/xive.c                                |  2 +-
 hw/intc/xive2.c                               |  6 ++---
 hw/ipmi/ipmi_bmc_extern.c                     |  2 +-
 hw/mem/cxl_type3.c                            |  6 ++---
 hw/mips/malta.c                               |  2 +-
 hw/misc/imx7_ccm.c                            |  2 +-
 hw/misc/mac_via.c                             |  2 +-
 hw/misc/stm32f2xx_syscfg.c                    |  4 +--
 hw/misc/trace-events                          |  2 +-
 hw/misc/zynq_slcr.c                           |  2 +-
 hw/net/cadence_gem.c                          | 10 +++----
 hw/net/dp8393x.c                              |  2 +-
 hw/net/e1000_regs.h                           |  2 +-
 hw/net/e1000x_regs.h                          |  2 +-
 hw/net/fsl_etsec/rings.c                      |  2 +-
 hw/net/igb_regs.h                             |  4 +--
 hw/net/mcf_fec.c                              |  2 +-
 hw/net/rocker/rocker_fp.c                     |  2 +-
 hw/net/rtl8139.c                              |  2 +-
 hw/net/smc91c111.c                            |  2 +-
 hw/net/sungem.c                               |  2 +-
 hw/net/sunhme.c                               |  2 +-
 hw/net/virtio-net.c                           |  6 ++---
 hw/net/vmxnet3.c                              |  2 +-
 hw/net/vmxnet3.h                              |  2 +-
 hw/nvme/ctrl.c                                |  6 ++---
 hw/nvram/eeprom_at24c.c                       |  2 +-
 hw/nvram/fw_cfg.c                             |  2 +-
 hw/pci-bridge/cxl_downstream.c                |  2 +-
 hw/pci-bridge/pci_expander_bridge.c           |  2 +-
 hw/pci-host/bonito.c                          |  2 +-
 hw/pci-host/designware.c                      |  4 +--
 hw/pci-host/dino.c                            |  2 +-
 hw/pci-host/gpex-acpi.c                       |  2 +-
 hw/pci-host/gt64120.c                         |  4 +--
 hw/pci-host/pnv_phb.c                         |  2 +-
 hw/pci-host/pnv_phb3.c                        |  2 +-
 hw/pci-host/pnv_phb3_msi.c                    |  2 +-
 hw/pci-host/pnv_phb4.c                        |  6 ++---
 hw/pci/pcie_aer.c                             |  2 +-
 hw/pci/shpc.c                                 |  2 +-
 hw/ppc/ppc.c                                  |  2 +-
 hw/ppc/prep_systemio.c                        |  2 +-
 hw/ppc/spapr.c                                |  8 +++---
 hw/ppc/spapr_hcall.c                          |  2 +-
 hw/ppc/spapr_nvdimm.c                         |  4 +--
 hw/ppc/spapr_pci_vfio.c                       |  2 +-
 hw/riscv/microchip_pfsoc.c                    |  2 +-
 hw/riscv/virt.c                               |  4 +--
 hw/rtc/exynos4210_rtc.c                       |  2 +-
 hw/rx/rx62n.c                                 |  2 +-
 hw/scsi/lsi53c895a.c                          |  2 +-
 hw/scsi/mfi.h                                 |  2 +-
 hw/sd/sd.c                                    |  2 +-
 hw/sd/sdhci.c                                 |  2 +-
 hw/sensor/isl_pmbus_vr.c                      |  2 +-
 hw/sensor/max34451.c                          |  2 +-
 hw/sh4/sh7750_regs.h                          | 26 +++++++++----------
 hw/smbios/smbios.c                            |  2 +-
 hw/ssi/xilinx_spips.c                         |  6 ++---
 hw/ssi/xlnx-versal-ospi.c                     |  2 +-
 hw/timer/etraxfs_timer.c                      |  2 +-
 hw/timer/renesas_tmr.c                        |  2 +-
 hw/tpm/tpm_tis.h                              |  2 +-
 hw/tpm/tpm_tis_common.c                       |  2 +-
 hw/tpm/tpm_tis_i2c.c                          |  4 +--
 hw/tpm/tpm_tis_isa.c                          |  2 +-
 hw/tpm/tpm_tis_sysbus.c                       |  2 +-
 hw/usb/ccid-card-emulated.c                   |  2 +-
 hw/usb/hcd-ehci.c                             |  6 ++---
 hw/usb/hcd-ohci.c                             |  2 +-
 hw/usb/quirks.h                               |  2 +-
 hw/usb/redirect.c                             |  2 +-
 hw/usb/trace-events                           |  2 +-
 hw/usb/xen-usb.c                              |  2 +-
 hw/virtio/virtio-crypto.c                     |  4 +--
 hw/virtio/virtio-mem.c                        |  2 +-
 hw/virtio/virtio.c                            |  2 +-
 hw/xen/xen_pvdev.c                            |  2 +-
 include/block/block_int-common.h              |  2 +-
 include/chardev/char-fe.h                     |  4 +--
 include/crypto/akcipher.h                     |  2 +-
 include/crypto/ivgen.h                        |  4 +--
 include/elf.h                                 |  4 +--
 include/hw/acpi/aml-build.h                   |  2 +-
 include/hw/acpi/pc-hotplug.h                  |  2 +-
 include/hw/acpi/vmgenid.h                     |  2 +-
 include/hw/boards.h                           |  6 ++---
 include/hw/char/avr_usart.h                   |  2 +-
 include/hw/clock.h                            |  2 +-
 include/hw/core/tcg-cpu-ops.h                 |  2 +-
 include/hw/cxl/cxl_device.h                   |  2 +-
 include/hw/hyperv/vmbus.h                     |  2 +-
 include/hw/i2c/npcm7xx_smbus.h                |  2 +-
 include/hw/i386/topology.h                    |  2 +-
 include/hw/misc/auxbus.h                      |  2 +-
 include/hw/misc/macio/pmu.h                   |  2 +-
 include/hw/net/mii.h                          |  2 +-
 include/hw/pci-host/dino.h                    |  2 +-
 include/hw/pci/pcie_aer.h                     |  2 +-
 include/hw/ppc/openpic.h                      |  2 +-
 include/hw/ppc/spapr.h                        |  2 +-
 include/hw/riscv/riscv_hart.h                 |  2 +-
 include/hw/ssi/xilinx_spips.h                 |  2 +-
 include/hw/virtio/virtio-net.h                |  2 +-
 .../hw/xen/interface/arch-x86/xen-x86_64.h    |  2 +-
 include/hw/xen/interface/arch-x86/xen.h       |  2 +-
 include/hw/xen/interface/event_channel.h      |  2 +-
 include/hw/xen/interface/grant_table.h        |  2 +-
 include/hw/xen/interface/hvm/hvm_op.h         |  2 +-
 include/hw/xen/interface/io/blkif.h           |  6 ++---
 include/hw/xen/interface/io/fbif.h            |  2 +-
 include/hw/xen/interface/io/kbdif.h           |  2 +-
 include/hw/xen/interface/memory.h             |  2 +-
 include/hw/xen/interface/physdev.h            |  4 +--
 include/hw/xen/interface/xen.h                |  4 +--
 include/io/channel-socket.h                   |  4 +--
 include/io/task.h                             |  2 +-
 include/qemu/iova-tree.h                      |  4 +--
 include/qemu/yank.h                           |  2 +-
 include/sysemu/cryptodev-vhost.h              |  2 +-
 include/sysemu/cryptodev.h                    |  6 ++---
 include/sysemu/iothread.h                     |  2 +-
 include/sysemu/stats.h                        |  2 +-
 include/sysemu/tpm_backend.h                  |  2 +-
 include/tcg/helper-info.h                     |  2 +-
 include/tcg/tcg.h                             |  4 +--
 include/ui/kbd-state.h                        |  2 +-
 include/ui/spice-display.h                    |  2 +-
 include/user/safe-syscall.h                   |  2 +-
 linux-user/flatload.c                         |  2 +-
 linux-user/syscall.c                          |  4 +--
 nbd/client-connection.c                       |  2 +-
 net/checksum.c                                |  4 +--
 net/filter.c                                  |  4 +--
 net/vhost-vdpa.c                              |  8 +++---
 qga/channel-posix.c                           |  2 +-
 qga/commands-posix-ssh.c                      |  2 +-
 qga/commands-posix.c                          |  2 +-
 qga/commands-win32.c                          |  4 +--
 qga/main.c                                    |  2 +-
 qga/vss-win32/install.cpp                     |  4 +--
 scripts/checkpatch.pl                         |  2 +-
 scripts/ci/gitlab-pipeline-status             |  2 +-
 .../codeconverter/codeconverter/qom_macros.py |  2 +-
 scripts/oss-fuzz/minimize_qtest_trace.py      |  8 +++---
 scripts/performance/topN_callgrind.py         |  2 +-
 scripts/performance/topN_perf.py              |  2 +-
 scripts/qapi/gen.py                           |  2 +-
 scripts/replay-dump.py                        |  2 +-
 scripts/simplebench/bench_block_job.py        |  2 +-
 semihosting/config.c                          |  2 +-
 semihosting/syscalls.c                        |  4 +--
 softmmu/icount.c                              |  2 +-
 softmmu/ioport.c                              |  2 +-
 target/hexagon/README                         |  2 +-
 target/hexagon/fma_emu.c                      |  2 +-
 target/hexagon/idef-parser/README.rst         |  2 +-
 target/hexagon/idef-parser/idef-parser.h      |  2 +-
 target/hexagon/idef-parser/parser-helpers.c   |  6 ++---
 target/hexagon/imported/alu.idef              |  8 +++---
 target/hexagon/imported/macros.def            |  2 +-
 target/hexagon/imported/mmvec/ext.idef        | 10 +++----
 target/i386/cpu.c                             |  4 +--
 target/i386/cpu.h                             |  4 +--
 target/i386/hax/hax-interface.h               |  4 +--
 target/i386/hax/hax-windows.c                 |  2 +-
 target/i386/kvm/kvm.c                         |  4 +--
 target/i386/kvm/xen-emu.c                     |  2 +-
 target/i386/machine.c                         |  4 +--
 target/i386/tcg/translate.c                   |  8 +++---
 target/mips/cpu-defs.c.inc                    |  2 +-
 target/mips/tcg/msa_helper.c                  | 12 ++++-----
 target/mips/tcg/mxu_translate.c               |  6 ++---
 target/ppc/cpu-models.h                       |  4 +--
 target/ppc/cpu.h                              |  2 +-
 target/ppc/cpu_init.c                         |  4 +--
 target/ppc/excp_helper.c                      | 14 +++++-----
 target/ppc/power8-pmu-regs.c.inc              |  4 +--
 target/ppc/translate/vmx-impl.c.inc           |  6 ++---
 target/riscv/cpu.h                            |  2 +-
 target/riscv/cpu_bits.h                       |  4 +--
 target/riscv/csr.c                            |  4 +--
 target/riscv/debug.c                          | 10 +++----
 target/riscv/insn_trans/trans_rvf.c.inc       |  4 +--
 target/riscv/insn_trans/trans_rvv.c.inc       |  4 +--
 target/riscv/insn_trans/trans_rvzfh.c.inc     |  4 +--
 target/riscv/monitor.c                        |  2 +-
 tcg/aarch64/tcg-target.c.inc                  |  2 +-
 tcg/arm/tcg-target.c.inc                      |  4 +--
 tcg/riscv/tcg-target.c.inc                    |  4 +--
 tests/avocado/acpi-bits.py                    |  4 +--
 .../avocado/acpi-bits/bits-tests/testacpi.py2 |  4 +--
 tests/decode/err_pattern_group_ident2.decode  |  2 +-
 tests/docker/common.rc                        |  2 +-
 tests/migration/guestperf-batch.py            |  2 +-
 tests/migration/guestperf.py                  |  2 +-
 tests/plugin/mem.c                            |  2 +-
 tests/qapi-schema/bad-if-not.json             |  2 +-
 tests/qemu-iotests/029                        |  2 +-
 tests/qemu-iotests/040                        |  8 +++---
 tests/qemu-iotests/046                        |  2 +-
 tests/qemu-iotests/059                        |  2 +-
 tests/qemu-iotests/061                        |  2 +-
 tests/qemu-iotests/071                        |  2 +-
 tests/qemu-iotests/197                        |  2 +-
 tests/qemu-iotests/215                        |  2 +-
 tests/qemu-iotests/298                        |  2 +-
 tests/qemu-iotests/pylintrc                   |  2 +-
 tests/qtest/ahci-test.c                       |  2 +-
 tests/qtest/bcm2835-dma-test.c                |  2 +-
 tests/qtest/bios-tables-test.c                |  2 +-
 tests/qtest/ds1338-test.c                     |  2 +-
 tests/qtest/fuzz/generic_fuzz.c               |  4 +--
 tests/qtest/libqos/qgraph.c                   |  4 +--
 tests/qtest/libqos/qgraph_internal.h          |  2 +-
 tests/qtest/libqos/virtio-gpio.c              |  2 +-
 tests/qtest/libqtest.c                        |  4 +--
 tests/qtest/migration-test.c                  |  6 ++---
 tests/qtest/npcm7xx_timer-test.c              |  2 +-
 tests/qtest/tpm-emu.c                         |  2 +-
 tests/qtest/tpm-tests.c                       |  2 +-
 tests/qtest/tpm-tests.h                       |  2 +-
 tests/qtest/tpm-tis-i2c-test.c                |  2 +-
 tests/qtest/tpm-tis-util.c                    |  2 +-
 tests/qtest/vhost-user-blk-test.c             |  2 +-
 tests/qtest/virtio-net-test.c                 |  2 +-
 tests/qtest/vmgenid-test.c                    |  2 +-
 tests/tcg/hexagon/fpstuff.c                   |  2 +-
 tests/tcg/hexagon/test_clobber.S              |  2 +-
 tests/tcg/i386/system/boot.S                  |  2 +-
 tests/tcg/i386/x86.csv                        |  2 +-
 tests/tsan/suppressions.tsan                  |  2 +-
 tests/uefi-test-tools/Makefile                |  2 +-
 tests/unit/check-qjson.c                      |  2 +-
 tests/unit/test-aio.c                         |  2 +-
 tests/unit/test-bdrv-graph-mod.c              | 12 ++++-----
 tests/unit/test-crypto-secret.c               |  2 +-
 tests/unit/test-qobject-input-visitor.c       |  2 +-
 tests/unit/test-throttle.c                    |  4 +--
 tests/unit/test-util-filemonitor.c            |  2 +-
 tests/unit/test-xs-node.c                     |  2 +-
 tests/vm/Makefile.include                     |  2 +-
 tests/vm/ubuntuvm.py                          |  2 +-
 ui/cocoa.m                                    |  2 +-
 ui/keymaps.h                                  |  2 +-
 ui/sdl2-2d.c                                  |  2 +-
 ui/sdl2.c                                     |  2 +-
 ui/vnc-enc-zrle.c.inc                         |  2 +-
 ui/vnc-enc-zywrle.h                           |  4 +--
 util/cpuinfo-aarch64.c                        |  4 +--
 util/cpuinfo-i386.c                           |  4 +--
 util/cpuinfo-ppc.c                            |  2 +-
 util/main-loop.c                              |  2 +-
 util/oslib-posix.c                            |  2 +-
 util/qdist.c                                  |  2 +-
 util/qemu-sockets.c                           |  2 +-
 util/rcu.c                                    |  2 +-
 336 files changed, 508 insertions(+), 508 deletions(-)

-- 
2.39.2


