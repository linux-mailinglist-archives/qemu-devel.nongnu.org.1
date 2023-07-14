Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D71D57539DB
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:44:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKH8T-0000FB-Rv; Fri, 14 Jul 2023 07:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH8R-0000Ej-7m; Fri, 14 Jul 2023 07:38:55 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH8K-00046E-E9; Fri, 14 Jul 2023 07:38:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C45FF13D8D;
 Fri, 14 Jul 2023 14:38:54 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A8FFF14B9C;
 Fri, 14 Jul 2023 14:38:38 +0300 (MSK)
Received: (nullmailer pid 1186198 invoked by uid 1000);
 Fri, 14 Jul 2023 11:38:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] treewide: spelling fixes in comments and some strings
Date: Fri, 14 Jul 2023 14:38:06 +0300
Message-Id: <20230714113834.1186117-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714113834.1186117-1-mjt@tls.msk.ru>
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

---
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
 docs/about/deprecated.rst                     |  2 +-
 docs/devel/qapi-code-gen.rst                  |  2 +-
 docs/devel/qom.rst                            |  2 +-
 docs/system/arm/palm.rst                      |  2 +-
 docs/system/arm/xscale.rst                    |  2 +-
 docs/system/devices/can.rst                   |  6 ++---
 docs/system/devices/nvme.rst                  |  2 +-
 host/include/aarch64/host/cpuinfo.h           |  2 +-
 host/include/generic/host/cpuinfo.h           |  2 +-
 host/include/i386/host/cpuinfo.h              |  2 +-
 host/include/ppc/host/cpuinfo.h               |  2 +-
 hw/9pfs/9p-local.c                            |  8 +++---
 hw/9pfs/9p-proxy.c                            |  2 +-
 hw/9pfs/9p-synth.c                            |  2 +-
 hw/9pfs/9p-util.h                             |  2 +-
 hw/9pfs/9p.c                                  |  4 +--
 hw/9pfs/9p.h                                  |  2 +-
 hw/acpi/aml-build.c                           |  6 ++---
 hw/acpi/hmat.c                                |  2 +-
 hw/acpi/nvdimm.c                              |  2 +-
 hw/arm/aspeed.c                               |  2 +-
 hw/arm/mps2-tz.c                              |  2 +-
 hw/arm/versatilepb.c                          |  2 +-
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
 hw/core/loader.c                              |  4 +--
 hw/core/machine.c                             |  2 +-
 hw/core/qdev-properties-system.c              |  2 +-
 hw/cpu/a15mpcore.c                            |  2 +-
 hw/cxl/cxl-events.c                           |  2 +-
 hw/cxl/cxl-host.c                             |  2 +-
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
 hw/intc/arm_gic.c                             |  4 +--
 hw/intc/arm_gicv3_redist.c                    |  2 +-
 hw/intc/armv7m_nvic.c                         |  2 +-
 hw/intc/loongarch_extioi.c                    |  2 +-
 hw/intc/loongson_liointc.c                    |  2 +-
 hw/intc/omap_intc.c                           |  2 +-
 hw/intc/pnv_xive.c                            |  2 +-
 hw/intc/s390_flic_kvm.c                       |  2 +-
 hw/intc/spapr_xive.c                          |  2 +-
 hw/intc/spapr_xive_kvm.c                      |  6 ++---
 hw/intc/xive.c                                |  2 +-
 hw/intc/xive2.c                               |  6 ++---
 hw/ipmi/ipmi_bmc_extern.c                     |  2 +-
 hw/m68k/next-cube.c                           |  2 +-
 hw/m68k/next-kbd.c                            |  2 +-
 hw/m68k/virt.c                                |  2 +-
 hw/mem/cxl_type3.c                            |  6 ++---
 hw/microblaze/petalogix_ml605_mmu.c           |  2 +-
 hw/mips/malta.c                               |  2 +-
 hw/misc/allwinner-r40-dramc.c                 |  2 +-
 hw/misc/exynos4210_rng.c                      |  2 +-
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
 hw/pci-host/gpex-acpi.c                       |  4 +--
 hw/pci-host/gt64120.c                         |  4 +--
 hw/pci-host/pnv_phb.c                         |  2 +-
 hw/pci-host/pnv_phb3.c                        |  2 +-
 hw/pci-host/pnv_phb3_msi.c                    |  2 +-
 hw/pci-host/pnv_phb4.c                        |  6 ++---
 hw/pci-host/sabre.c                           |  2 +-
 hw/pci/pcie_aer.c                             |  2 +-
 hw/pci/shpc.c                                 |  2 +-
 hw/ppc/ppc.c                                  |  2 +-
 hw/ppc/prep_systemio.c                        |  2 +-
 hw/ppc/spapr.c                                |  8 +++---
 hw/ppc/spapr_hcall.c                          |  2 +-
 hw/ppc/spapr_nvdimm.c                         |  4 +--
 hw/ppc/spapr_pci_vfio.c                       |  6 ++---
 hw/remote/machine.c                           |  2 +-
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
 hw/sparc/sun4m_iommu.c                        |  8 +++---
 hw/ssi/xilinx_spips.c                         |  6 ++---
 hw/ssi/xlnx-versal-ospi.c                     |  2 +-
 hw/timer/etraxfs_timer.c                      |  2 +-
 hw/timer/i8254.c                              |  2 +-
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
 include/exec/memory.h                         |  2 +-
 include/hw/acpi/aml-build.h                   |  2 +-
 include/hw/acpi/pc-hotplug.h                  |  2 +-
 include/hw/acpi/vmgenid.h                     |  2 +-
 include/hw/arm/fsl-imx7.h                     |  2 +-
 include/hw/boards.h                           |  6 ++---
 include/hw/char/avr_usart.h                   |  2 +-
 include/hw/clock.h                            |  2 +-
 include/hw/core/tcg-cpu-ops.h                 |  2 +-
 include/hw/cxl/cxl_device.h                   |  2 +-
 include/hw/hyperv/vmbus.h                     |  2 +-
 include/hw/i2c/npcm7xx_smbus.h                |  2 +-
 include/hw/i386/topology.h                    |  2 +-
 include/hw/intc/armv7m_nvic.h                 |  2 +-
 include/hw/misc/auxbus.h                      |  2 +-
 include/hw/misc/macio/pmu.h                   |  2 +-
 include/hw/net/mii.h                          |  2 +-
 include/hw/pci-host/dino.h                    |  2 +-
 include/hw/pci/pcie_aer.h                     |  2 +-
 include/hw/ppc/openpic.h                      |  2 +-
 include/hw/ppc/spapr.h                        |  2 +-
 include/hw/qdev-core.h                        |  2 +-
 include/hw/riscv/riscv_hart.h                 |  2 +-
 include/hw/s390x/s390-pci-bus.h               |  2 +-
 include/hw/s390x/sclp.h                       |  2 +-
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
 include/hw/xen/interface/sched.h              |  2 +-
 include/hw/xen/interface/xen.h                |  4 +--
 include/io/channel-socket.h                   |  4 +--
 include/io/task.h                             |  2 +-
 include/qemu/iova-tree.h                      |  4 +--
 include/qemu/timer.h                          |  2 +-
 include/qemu/yank.h                           |  2 +-
 include/standard-headers/drm/drm_fourcc.h     |  8 +++---
 include/standard-headers/linux/ethtool.h      |  2 +-
 .../standard-headers/linux/virtio_console.h   |  2 +-
 include/standard-headers/linux/virtio_i2c.h   |  2 +-
 include/standard-headers/linux/virtio_net.h   |  4 +--
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
 linux-user/elfload.c                          |  2 +-
 linux-user/flatload.c                         |  2 +-
 linux-user/syscall.c                          |  6 ++---
 migration/migration-stats.c                   |  2 +-
 migration/migration.h                         |  4 +--
 migration/multifd-zlib.c                      |  2 +-
 migration/multifd-zstd.c                      |  2 +-
 migration/multifd.c                           |  2 +-
 migration/savevm.c                            |  2 +-
 migration/trace-events                        |  2 +-
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
 scripts/checkpatch.pl                         |  4 +--
 scripts/ci/gitlab-pipeline-status             |  2 +-
 .../codeconverter/codeconverter/qom_macros.py |  2 +-
 scripts/oss-fuzz/minimize_qtest_trace.py      |  8 +++---
 scripts/performance/topN_callgrind.py         |  2 +-
 scripts/performance/topN_perf.py              |  2 +-
 scripts/qapi/gen.py                           |  2 +-
 scripts/qapi/pylintrc                         |  2 +-
 scripts/replay-dump.py                        |  2 +-
 scripts/simplebench/bench_block_job.py        |  2 +-
 semihosting/config.c                          |  2 +-
 semihosting/syscalls.c                        |  4 +--
 softmmu/icount.c                              |  2 +-
 softmmu/ioport.c                              |  2 +-
 stubs/colo.c                                  |  2 +-
 target/alpha/cpu.h                            |  4 +--
 target/alpha/translate.c                      |  2 +-
 target/arm/cpu.c                              |  2 +-
 target/arm/cpu.h                              |  2 +-
 target/arm/cpu64.c                            |  2 +-
 target/arm/helper.c                           |  4 +--
 target/arm/tcg/m_helper.c                     |  2 +-
 target/arm/tcg/translate-a64.c                |  4 +--
 target/arm/tcg/translate-mve.c                |  4 +--
 target/arm/tcg/translate-sve.c                |  2 +-
 target/arm/tcg/translate-vfp.c                |  2 +-
 target/arm/tcg/vec_helper.c                   |  2 +-
 target/cris/helper.c                          |  8 +++---
 target/cris/op_helper.c                       |  2 +-
 target/cris/translate.c                       | 16 ++++++------
 target/hexagon/README                         |  2 +-
 target/hexagon/fma_emu.c                      |  2 +-
 target/hexagon/idef-parser/README.rst         |  2 +-
 target/hexagon/idef-parser/idef-parser.h      |  2 +-
 target/hexagon/idef-parser/parser-helpers.c   |  6 ++---
 target/hexagon/imported/alu.idef              |  8 +++---
 target/hexagon/imported/macros.def            |  2 +-
 target/hexagon/imported/mmvec/ext.idef        | 10 +++----
 target/hppa/cpu.h                             |  4 +--
 target/hppa/int_helper.c                      |  2 +-
 target/hppa/translate.c                       |  2 +-
 target/i386/cpu.c                             |  4 +--
 target/i386/cpu.h                             |  4 +--
 target/i386/hax/hax-interface.h               |  4 +--
 target/i386/hax/hax-windows.c                 |  2 +-
 target/i386/kvm/kvm.c                         |  4 +--
 target/i386/kvm/xen-emu.c                     |  2 +-
 target/i386/machine.c                         |  4 +--
 target/i386/tcg/translate.c                   |  8 +++---
 target/loongarch/cpu-csr.h                    |  2 +-
 target/m68k/helper.c                          |  4 +--
 target/microblaze/cpu.h                       |  2 +-
 target/mips/cpu-defs.c.inc                    |  2 +-
 target/mips/tcg/msa_helper.c                  | 12 ++++-----
 target/mips/tcg/mxu_translate.c               |  6 ++---
 target/openrisc/cpu.h                         |  2 +-
 target/openrisc/translate.c                   |  4 +--
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
 target/rx/translate.c                         |  4 +--
 target/s390x/cpu_features.c                   |  2 +-
 target/s390x/cpu_models.c                     |  2 +-
 target/s390x/tcg/fpu_helper.c                 |  2 +-
 target/s390x/tcg/insn-data.h.inc              |  2 +-
 target/s390x/tcg/translate.c                  |  2 +-
 target/sparc/asi.h                            | 14 +++++-----
 target/tricore/csfr.h.inc                     |  2 +-
 target/tricore/helper.c                       |  2 +-
 target/tricore/translate.c                    |  8 +++---
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
 tests/qemu-iotests/pylintrc                   |  4 +--
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
 tests/tcg/Makefile.target                     |  4 +--
 tests/tcg/aarch64/gdbstub/test-sve.py         |  2 +-
 tests/tcg/aarch64/sme-outprod1.c              |  2 +-
 tests/tcg/aarch64/system/boot.S               |  6 ++---
 tests/tcg/aarch64/system/semiheap.c           |  2 +-
 tests/tcg/hexagon/fpstuff.c                   |  2 +-
 tests/tcg/hexagon/test_clobber.S              |  2 +-
 tests/tcg/i386/system/boot.S                  |  2 +-
 tests/tcg/i386/x86.csv                        |  2 +-
 tests/tcg/multiarch/sha512.c                  |  2 +-
 .../multiarch/system/Makefile.softmmu-target  |  2 +-
 tests/tcg/s390x/mvc.c                         |  2 +-
 tests/tcg/tricore/c/crt0-tc2x.S               |  4 +--
 tests/tcg/x86_64/system/boot.S                |  4 +--
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
 ui/vnc-enc-tight.c                            |  2 +-
 ui/vnc-enc-zrle.c.inc                         |  2 +-
 ui/vnc-enc-zywrle.h                           |  4 +--
 util/cpuinfo-aarch64.c                        |  4 +--
 util/cpuinfo-i386.c                           |  4 +--
 util/cpuinfo-ppc.c                            |  2 +-
 util/main-loop.c                              |  2 +-
 util/oslib-posix.c                            |  2 +-
 util/qdist.c                                  |  2 +-
 util/qemu-progress.c                          |  2 +-
 util/qemu-sockets.c                           |  2 +-
 util/rcu.c                                    |  2 +-
 437 files changed, 663 insertions(+), 663 deletions(-)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 9566224d18..9ed86a6b0a 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1,5 +1,5 @@
 /*
- * Translation Block Maintaince
+ * Translation Block Maintenance
  *
  *  Copyright (c) 2003 Fabrice Bellard
  *
diff --git a/audio/mixeng.h b/audio/mixeng.h
index f9de7cffeb..a5f56d2c26 100644
--- a/audio/mixeng.h
+++ b/audio/mixeng.h
@@ -38,7 +38,7 @@ typedef struct st_sample st_sample;
 typedef void (t_sample) (struct st_sample *dst, const void *src, int samples);
 typedef void (f_sample) (void *dst, const struct st_sample *src, int samples);
 
-/* indices: [stereo][signed][swap endiannes][8, 16 or 32-bits] */
+/* indices: [stereo][signed][swap endianness][8, 16 or 32-bits] */
 extern t_sample *mixeng_conv[2][2][2][3];
 extern f_sample *mixeng_clip[2][2][2][3];
 
diff --git a/backends/tpm/tpm_ioctl.h b/backends/tpm/tpm_ioctl.h
index b1d31768a6..1933ab6855 100644
--- a/backends/tpm/tpm_ioctl.h
+++ b/backends/tpm/tpm_ioctl.h
@@ -238,7 +238,7 @@ struct ptm_lockstorage {
         } req; /* request */
         struct {
             ptm_res tpm_result;
-        } resp; /* reponse */
+        } resp; /* response */
     } u;
 };
 
diff --git a/block.c b/block.c
index a307c151a8..90d2dde828 100644
--- a/block.c
+++ b/block.c
@@ -7582,7 +7582,7 @@ int bdrv_try_change_aio_context(BlockDriverState *bs, AioContext *ctx,
     /*
      * Recursion phase: go through all nodes of the graph.
      * Take care of checking that all nodes support changing AioContext
-     * and drain them, builing a linear list of callbacks to run if everything
+     * and drain them, building a linear list of callbacks to run if everything
      * is successful (the transaction itself).
      */
     tran = tran_new();
diff --git a/block/block-copy.c b/block/block-copy.c
index e13d7bc6b6..db1efc3eb9 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -67,7 +67,7 @@ typedef struct BlockCopyCallState {
     QLIST_ENTRY(BlockCopyCallState) list;
 
     /*
-     * Fields that report information about return values and erros.
+     * Fields that report information about return values and errors.
      * Protected by lock in BlockCopyState.
      */
     bool error_is_read;
@@ -462,7 +462,7 @@ static coroutine_fn int block_copy_task_run(AioTaskPool *pool,
  * Do copy of cluster-aligned chunk. Requested region is allowed to exceed
  * s->len only to cover last cluster when s->len is not aligned to clusters.
  *
- * No sync here: nor bitmap neighter intersecting requests handling, only copy.
+ * No sync here: nor bitmap neither intersecting requests handling, only copy.
  *
  * @method is an in-out argument, so that copy_range can be either extended to
  * a full-size buffer or disabled if the copy_range attempt fails.  The output
diff --git a/block/export/vduse-blk.c b/block/export/vduse-blk.c
index 83b05548e7..172f73cef4 100644
--- a/block/export/vduse-blk.c
+++ b/block/export/vduse-blk.c
@@ -138,7 +138,7 @@ static void vduse_blk_enable_queue(VduseDev *dev, VduseVirtq *vq)
 
     aio_set_fd_handler(vblk_exp->export.ctx, vduse_queue_get_fd(vq),
                        on_vduse_vq_kick, NULL, NULL, NULL, vq);
-    /* Make sure we don't miss any kick afer reconnecting */
+    /* Make sure we don't miss any kick after reconnecting */
     eventfd_write(vduse_queue_get_fd(vq), 1);
 }
 
diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
index f7b5073605..fe2cee3a78 100644
--- a/block/export/vhost-user-blk-server.c
+++ b/block/export/vhost-user-blk-server.c
@@ -1,5 +1,5 @@
 /*
- * Sharing QEMU block devices via vhost-user protocal
+ * Sharing QEMU block devices via vhost-user protocol
  *
  * Parts of the code based on nbd/server.c.
  *
diff --git a/block/export/vhost-user-blk-server.h b/block/export/vhost-user-blk-server.h
index fcf46fc8a5..77fb5c0131 100644
--- a/block/export/vhost-user-blk-server.h
+++ b/block/export/vhost-user-blk-server.h
@@ -1,5 +1,5 @@
 /*
- * Sharing QEMU block devices via vhost-user protocal
+ * Sharing QEMU block devices via vhost-user protocol
  *
  * Copyright (c) Coiby Xu <coiby.xu@gmail.com>.
  * Copyright (c) 2020 Red Hat, Inc.
diff --git a/block/file-posix.c b/block/file-posix.c
index 9e8e3d8ca5..f84c35d831 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1159,9 +1159,9 @@ static int raw_reopen_prepare(BDRVReopenState *state,
      * As part of reopen prepare we also want to create new fd by
      * raw_reconfigure_getfd(). But it wants updated "perm", when in
      * bdrv_reopen_multiple() .bdrv_reopen_prepare() callback called prior to
-     * permission update. Happily, permission update is always a part (a seprate
-     * stage) of bdrv_reopen_multiple() so we can rely on this fact and
-     * reconfigure fd in raw_check_perm().
+     * permission update. Happily, permission update is always a part
+     * (a separate stage) of bdrv_reopen_multiple() so we can rely on this
+     * fact and reconfigure fd in raw_check_perm().
      */
 
     s->reopen_state = state;
@@ -3376,7 +3376,7 @@ static void raw_account_discard(BDRVRawState *s, uint64_t nbytes, int ret)
  * of an array of zone descriptors.
  * zones is an array of zone descriptors to hold zone information on reply;
  * offset can be any byte within the entire size of the device;
- * nr_zones is the maxium number of sectors the command should operate on.
+ * nr_zones is the maximum number of sectors the command should operate on.
  */
 #if defined(CONFIG_BLKZONED)
 static int coroutine_fn raw_co_zone_report(BlockDriverState *bs, int64_t offset,
diff --git a/block/graph-lock.c b/block/graph-lock.c
index 5e66f01ae8..f357a2c0b1 100644
--- a/block/graph-lock.c
+++ b/block/graph-lock.c
@@ -95,7 +95,7 @@ static uint32_t reader_count(void)
 
     QEMU_LOCK_GUARD(&aio_context_list_lock);
 
-    /* rd can temporarly be negative, but the total will *always* be >= 0 */
+    /* rd can temporarily be negative, but the total will *always* be >= 0 */
     rd = orphaned_reader_count;
     QTAILQ_FOREACH(brdv_graph, &aio_context_list, next_aio) {
         rd += qatomic_read(&brdv_graph->reader_count);
diff --git a/block/io.c b/block/io.c
index e8293d6b26..2b872f32f1 100644
--- a/block/io.c
+++ b/block/io.c
@@ -342,7 +342,7 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
      * timer callback), it is a bug in the caller that should be fixed. */
     assert(data.done);
 
-    /* Reaquire the AioContext of bs if we dropped it */
+    /* Reacquire the AioContext of bs if we dropped it */
     if (ctx != co_ctx) {
         aio_context_acquire(ctx);
     }
diff --git a/block/linux-aio.c b/block/linux-aio.c
index 561c71a9ae..1a51503271 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -227,7 +227,7 @@ static void qemu_laio_process_completions(LinuxAioState *s)
 
     /* If we are nested we have to notify the level above that we are done
      * by setting event_max to zero, upper level will then jump out of it's
-     * own `for` loop.  If we are the last all counters droped to zero. */
+     * own `for` loop.  If we are the last all counters dropped to zero. */
     s->event_max = 0;
     s->event_idx = 0;
 }
diff --git a/block/mirror.c b/block/mirror.c
index d3cacd1708..02a092c61c 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -502,7 +502,7 @@ static void coroutine_fn mirror_iteration(MirrorBlockJob *s)
 
     job_pause_point(&s->common.job);
 
-    /* Find the number of consective dirty chunks following the first dirty
+    /* Find the number of consecutive dirty chunks following the first dirty
      * one, and wait for in flight requests in them. */
     bdrv_dirty_bitmap_lock(s->dirty_bitmap);
     while (nb_chunks * s->granularity < s->buf_size) {
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 5095e99a37..996d1217d0 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -2645,7 +2645,7 @@ rebuild_refcount_structure(BlockDriverState *bs, BdrvCheckResult *res,
      * repeat all this until the reftable stops growing.
      *
      * (This loop will terminate, because with every cluster the
-     * reftable grows, it can accomodate a multitude of more refcounts,
+     * reftable grows, it can accommodate a multitude of more refcounts,
      * so that at some point this must be able to cover the reftable
      * and all refblocks describing it.)
      *
diff --git a/block/vhdx.c b/block/vhdx.c
index f2c3a80190..a67edcc03e 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1077,7 +1077,7 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
-    /* endian convert populated BAT field entires */
+    /* endian convert populated BAT field entries */
     for (i = 0; i < s->bat_entries; i++) {
         s->bat[i] = le64_to_cpu(s->bat[i]);
     }
diff --git a/block/vhdx.h b/block/vhdx.h
index 7db746cd18..455a627a46 100644
--- a/block/vhdx.h
+++ b/block/vhdx.h
@@ -212,7 +212,7 @@ typedef struct QEMU_PACKED VHDXLogDataSector {
     uint32_t    sequence_high;          /* 4 MSB of 8 byte sequence_number */
     uint8_t     data[4084];             /* raw data, bytes 8-4091 (inclusive).
                                            see the data descriptor field for the
-                                           other mising bytes */
+                                           other missing bytes */
     uint32_t    sequence_low;           /* 4 LSB of 8 byte sequence_number */
 } VHDXLogDataSector;
 
@@ -257,7 +257,7 @@ typedef struct QEMU_PACKED VHDXMetadataTableHeader {
 
 #define VHDX_META_FLAGS_IS_USER         0x01    /* max 1024 entries */
 #define VHDX_META_FLAGS_IS_VIRTUAL_DISK 0x02    /* virtual disk metadata if set,
-                                                   otherwise file metdata */
+                                                   otherwise file metadata */
 #define VHDX_META_FLAGS_IS_REQUIRED     0x04    /* parse must understand this
                                                    entry to open the file */
 typedef struct QEMU_PACKED VHDXMetadataTableEntry {
diff --git a/bsd-user/errno_defs.h b/bsd-user/errno_defs.h
index f3e8ac3488..abe70119d9 100644
--- a/bsd-user/errno_defs.h
+++ b/bsd-user/errno_defs.h
@@ -149,7 +149,7 @@
 #define TARGET_ELAST            90              /* Must be equal largest errno */
 
 /* Internal errors: */
-#define TARGET_EJUSTRETURN      254             /* Just return without modifing regs */
+#define TARGET_EJUSTRETURN      254             /* Just return without modifying regs */
 #define TARGET_ERESTART         255             /* Restart syscall */
 
 #include "special-errno.h"
diff --git a/bsd-user/freebsd/target_os_siginfo.h b/bsd-user/freebsd/target_os_siginfo.h
index 4573738752..6c282d8502 100644
--- a/bsd-user/freebsd/target_os_siginfo.h
+++ b/bsd-user/freebsd/target_os_siginfo.h
@@ -72,7 +72,7 @@ typedef struct target_siginfo {
             int32_t _mqd;
         } _mesgp;
 
-        /* SIGPOLL -- Not really genreated in FreeBSD ??? */
+        /* SIGPOLL -- Not really generated in FreeBSD ??? */
         struct {
             int _band;  /* POLL_IN, POLL_OUT, POLL_MSG */
         } _poll;
diff --git a/bsd-user/freebsd/target_os_stack.h b/bsd-user/freebsd/target_os_stack.h
index 0590133291..d15fc3263f 100644
--- a/bsd-user/freebsd/target_os_stack.h
+++ b/bsd-user/freebsd/target_os_stack.h
@@ -25,7 +25,7 @@
 #include "qemu/guest-random.h"
 
 /*
- * The inital FreeBSD stack is as follows:
+ * The initial FreeBSD stack is as follows:
  * (see kern/kern_exec.c exec_copyout_strings() )
  *
  *  Hi Address -> char **ps_argvstr  (struct ps_strings for ps, w, etc.)
@@ -59,7 +59,7 @@ static inline int setup_initial_stack(struct bsd_binprm *bprm,
     /* Save some space for ps_strings. */
     p -= sizeof(struct target_ps_strings);
 
-    /* Add machine depedent sigcode. */
+    /* Add machine dependent sigcode. */
     p -= TARGET_SZSIGCODE;
     if (setup_sigtramp(p, (unsigned)offsetof(struct target_sigframe, sf_uc),
             TARGET_FREEBSD_NR_sigreturn)) {
diff --git a/bsd-user/freebsd/target_os_user.h b/bsd-user/freebsd/target_os_user.h
index f036a32343..1ca7b5ab17 100644
--- a/bsd-user/freebsd/target_os_user.h
+++ b/bsd-user/freebsd/target_os_user.h
@@ -26,7 +26,7 @@
 struct target_priority {
     uint8_t     pri_class;      /* Scheduling class. */
     uint8_t     pri_level;      /* Normal priority level. */
-    uint8_t     pri_native;     /* Priority before propogation. */
+    uint8_t     pri_native;     /* Priority before propagation. */
     uint8_t     pri_user;       /* User priority based on p_cpu and p_nice. */
 };
 
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 41d84e0b81..79c9b62609 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -118,7 +118,7 @@ extern const char *qemu_uname_release;
 /*
  * TARGET_ARG_MAX defines the number of bytes allocated for arguments
  * and envelope for the new program. 256k should suffice for a reasonable
- * maxiumum env+arg in 32-bit environments, bump it up to 512k for !ILP32
+ * maximum env+arg in 32-bit environments, bump it up to 512k for !ILP32
  * platforms.
  */
 #if TARGET_ABI_BITS > 32
diff --git a/bsd-user/signal-common.h b/bsd-user/signal-common.h
index 6f90345bb2..c044e81165 100644
--- a/bsd-user/signal-common.h
+++ b/bsd-user/signal-common.h
@@ -49,11 +49,11 @@ void target_to_host_sigset(sigset_t *d, const target_sigset_t *s);
  * union in target_siginfo is valid. This only applies between
  * host_to_target_siginfo_noswap() and tswap_siginfo(); it does not appear
  * either within host siginfo_t or in target_siginfo structures which we get
- * from the guest userspace program. Linux kenrels use this internally, but BSD
+ * from the guest userspace program. Linux kernels use this internally, but BSD
  * kernels don't do this, but its a useful abstraction.
  *
  * The linux-user version of this uses the top 16 bits, but FreeBSD's SI_USER
- * and other signal indepenent SI_ codes have bit 16 set, so we only use the top
+ * and other signal independent SI_ codes have bit 16 set, so we only use the top
  * byte instead.
  *
  * For FreeBSD, we have si_pid, si_uid, si_status, and si_addr always. Linux and
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index f4e078ee1d..6e77dd0b4d 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -44,7 +44,7 @@ static inline int sas_ss_flags(TaskState *ts, unsigned long sp)
 }
 
 /*
- * The BSD ABIs use the same singal numbers across all the CPU architectures, so
+ * The BSD ABIs use the same signal numbers across all the CPU architectures, so
  * (unlike Linux) these functions are just the identity mapping. This might not
  * be true for XyzBSD running on AbcBSD, which doesn't currently work.
  */
@@ -241,7 +241,7 @@ static inline void host_to_target_siginfo_noswap(target_siginfo_t *tinfo,
 #endif
         /*
          * Unsure that this can actually be generated, and our support for
-         * capsicum is somewhere between weak and non-existant, but if we get
+         * capsicum is somewhere between weak and non-existent, but if we get
          * one, then we know what to save.
          */
 #ifdef QEMU_SI_CAPSICUM
@@ -319,7 +319,7 @@ int block_signals(void)
     /*
      * It's OK to block everything including SIGSEGV, because we won't run any
      * further guest code before unblocking signals in
-     * process_pending_signals(). We depend on the FreeBSD behaivor here where
+     * process_pending_signals(). We depend on the FreeBSD behavior here where
      * this will only affect this thread's signal mask. We don't use
      * pthread_sigmask which might seem more correct because that routine also
      * does odd things with SIGCANCEL to implement pthread_cancel().
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 8c58532171..fbe5716e57 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -710,7 +710,7 @@ static void tcp_chr_telnet_init(Chardev *chr)
 
     if (!s->is_tn3270) {
         init->buflen = 12;
-        /* Prep the telnet negotion to put telnet in binary,
+        /* Prep the telnet negotiation to put telnet in binary,
          * no echo, single char mode */
         IACSET(init->buf, 0xff, 0xfb, 0x01);  /* IAC WILL ECHO */
         IACSET(init->buf, 0xff, 0xfb, 0x03);  /* IAC WILL Suppress go ahead */
@@ -718,7 +718,7 @@ static void tcp_chr_telnet_init(Chardev *chr)
         IACSET(init->buf, 0xff, 0xfd, 0x00);  /* IAC DO Binary */
     } else {
         init->buflen = 21;
-        /* Prep the TN3270 negotion based on RFC1576 */
+        /* Prep the TN3270 negotiation based on RFC1576 */
         IACSET(init->buf, 0xff, 0xfd, 0x19);  /* IAC DO EOR */
         IACSET(init->buf, 0xff, 0xfb, 0x19);  /* IAC WILL EOR */
         IACSET(init->buf, 0xff, 0xfd, 0x00);  /* IAC DO BINARY */
@@ -1290,7 +1290,7 @@ static bool qmp_chardev_validate_socket(ChardevSocket *sock,
         return false;
     }
 
-    /* Validate any options which have a dependancy on client vs server */
+    /* Validate any options which have a dependency on client vs server */
     if (!sock->has_server || sock->server) {
         if (sock->has_reconnect) {
             error_setg(errp,
diff --git a/chardev/char.c b/chardev/char.c
index 661ad8176a..996a024c7a 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -1115,7 +1115,7 @@ ChardevReturn *qmp_chardev_change(const char *id, ChardevBackend *backend,
         return NULL;
     }
 
-    /* change successfull, clean up */
+    /* change successful, clean up */
     chr_new->handover_yank_instance = false;
 
     /*
diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index 5036213f1b..dea4a56c8d 100644
--- a/contrib/plugins/cache.c
+++ b/contrib/plugins/cache.c
@@ -350,7 +350,7 @@ static int in_cache(Cache *cache, uint64_t addr)
  * @cache: The cache under simulation
  * @addr: The address of the requested memory location
  *
- * Returns true if the requsted data is hit in the cache and false when missed.
+ * Returns true if the requested data is hit in the cache and false when missed.
  * The cache is updated on miss for the next access.
  */
 static bool access_cache(Cache *cache, uint64_t addr)
diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index 3614c3564c..850f7b2941 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -108,7 +108,7 @@ static void report_divergance(ExecState *us, ExecState *them)
 
     /*
      * If we have diverged before did we get back on track or are we
-     * totally loosing it?
+     * totally losing it?
      */
     if (divergence_log) {
         DivergeState *last = (DivergeState *) divergence_log->data;
diff --git a/crypto/afalg.c b/crypto/afalg.c
index 348301e703..52a491dbb5 100644
--- a/crypto/afalg.c
+++ b/crypto/afalg.c
@@ -73,7 +73,7 @@ qcrypto_afalg_comm_alloc(const char *type, const char *name,
     QCryptoAFAlg *afalg;
 
     afalg = g_new0(QCryptoAFAlg, 1);
-    /* initilize crypto API socket */
+    /* initialize crypto API socket */
     afalg->opfd = -1;
     afalg->tfmfd = qcrypto_afalg_socket_bind(type, name, errp);
     if (afalg->tfmfd == -1) {
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 5688783ab1..d5dadb7892 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -244,7 +244,7 @@ qcrypto_block_luks_has_format(const uint8_t *buf,
  *
  * When calculating ESSIV IVs, the cipher length used by ESSIV
  * may be different from the cipher length used for the block
- * encryption, becauses dm-crypt uses the hash digest length
+ * encryption, because dm-crypt uses the hash digest length
  * as the key size. ie, if you have AES 128 as the block cipher
  * and SHA 256 as ESSIV hash, then ESSIV will use AES 256 as
  * the cipher since that gets a key length matching the digest
@@ -393,7 +393,7 @@ qcrypto_block_luks_from_disk_endian(QCryptoBlockLUKSHeader *hdr)
 }
 
 /*
- * Stores the main LUKS header, taking care of endianess
+ * Stores the main LUKS header, taking care of endianness
  */
 static int
 qcrypto_block_luks_store_header(QCryptoBlock *block,
@@ -423,7 +423,7 @@ qcrypto_block_luks_store_header(QCryptoBlock *block,
 }
 
 /*
- * Loads the main LUKS header,and byteswaps it to native endianess
+ * Loads the main LUKS header,and byteswaps it to native endianness
  * And run basic sanity checks on it
  */
 static int
diff --git a/crypto/der.c b/crypto/der.c
index dab3fe4f24..ebbecfc3fe 100644
--- a/crypto/der.c
+++ b/crypto/der.c
@@ -76,7 +76,7 @@ enum QCryptoDERTagEnc {
 /**
  * qcrypto_der_encode_length:
  * @src_len: the length of source data
- * @dst: distination to save the encoded 'length', if dst is NULL, only compute
+ * @dst: destination to save the encoded 'length', if dst is NULL, only compute
  * the expected buffer size in bytes.
  * @dst_len: output parameter, indicates how many bytes wrote.
  *
diff --git a/crypto/der.h b/crypto/der.h
index 0e895bbeec..f4ba6da28a 100644
--- a/crypto/der.h
+++ b/crypto/der.h
@@ -249,7 +249,7 @@ void qcrypto_der_encode_octet_str(QCryptoEncodeContext *ctx,
  * Start encoding a octet string, All fields between
  * qcrypto_der_encode_octet_str_begin and qcrypto_der_encode_octet_str_end
  * are encoded as an octet string. This is useful when we need to encode a
- * encoded SEQUNCE as OCTET STRING.
+ * encoded SEQUENCE as OCTET STRING.
  */
 void qcrypto_der_encode_octet_str_begin(QCryptoEncodeContext *ctx);
 
@@ -260,7 +260,7 @@ void qcrypto_der_encode_octet_str_begin(QCryptoEncodeContext *ctx);
  * Finish encoding a octet string, All fields between
  * qcrypto_der_encode_octet_str_begin and qcrypto_der_encode_octet_str_end
  * are encoded as an octet string. This is useful when we need to encode a
- * encoded SEQUNCE as OCTET STRING.
+ * encoded SEQUENCE as OCTET STRING.
  */
 void qcrypto_der_encode_octet_str_end(QCryptoEncodeContext *ctx);
 
@@ -275,7 +275,7 @@ size_t qcrypto_der_encode_ctx_buffer_len(QCryptoEncodeContext *ctx);
 /**
  * qcrypto_der_encode_ctx_flush_and_free:
  * @ctx: the encode context.
- * @dst: the distination to save the encoded data, the length of dst should
+ * @dst: the destination to save the encoded data, the length of dst should
  * not less than qcrypto_der_encode_cxt_buffer_len
  *
  * Flush all encoded data into dst, then free ctx.
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 02ea5a839f..7dc95dab7a 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -369,7 +369,7 @@ mapping permissions et al by using its 'mapped' security model option.
 Nowadays it would make sense to reimplement the ``proxy`` backend by using
 QEMU's ``vhost`` feature, which would eliminate the high latency costs under
 which the 9p ``proxy`` backend currently suffers. However as of to date nobody
-has indicated plans for such kind of reimplemention unfortunately.
+has indicated plans for such kind of reimplementation unfortunately.
 
 
 Block device options
diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 7f78183cd4..b0852da97b 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -1367,7 +1367,7 @@ Removing "unreachable" stuff like events that can't be triggered
 anymore, optional return or event data members that can't be sent
 anymore, and return or event data member (enumeration) values that
 can't be sent anymore makes no difference to clients, except for
-introspection.  The latter can conceivably confuse clients, so tread
+introspection.  The latter can conceivably confuse clients, so treat
 carefully.
 
 Incompatible changes include removing return and event data members.
diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index 0b506426d7..9918fac7f2 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -30,7 +30,7 @@ user configuration.
 Creating a QOM class
 ====================
 
-A simple minimal device implementation may look something like bellow:
+A simple minimal device implementation may look something like below:
 
 .. code-block:: c
    :caption: Creating a minimal type
diff --git a/docs/system/arm/palm.rst b/docs/system/arm/palm.rst
index 47ff9b36d4..61bc8d34f4 100644
--- a/docs/system/arm/palm.rst
+++ b/docs/system/arm/palm.rst
@@ -14,7 +14,7 @@ following elements:
 -  On-chip Real Time Clock
 
 -  TI TSC2102i touchscreen controller / analog-digital converter /
-   Audio CODEC, connected through MicroWire and |I2S| busses
+   Audio CODEC, connected through MicroWire and |I2S| buses
 
 -  GPIO-connected matrix keypad
 
diff --git a/docs/system/arm/xscale.rst b/docs/system/arm/xscale.rst
index d2d5949e10..e239136c3c 100644
--- a/docs/system/arm/xscale.rst
+++ b/docs/system/arm/xscale.rst
@@ -32,4 +32,4 @@ The clamshell PDA models emulation includes the following peripherals:
 
 -  Three on-chip UARTs
 
--  WM8750 audio CODEC on |I2C| and |I2S| busses
+-  WM8750 audio CODEC on |I2C| and |I2S| buses
diff --git a/docs/system/devices/can.rst b/docs/system/devices/can.rst
index 0af3d9912a..09121836fd 100644
--- a/docs/system/devices/can.rst
+++ b/docs/system/devices/can.rst
@@ -1,12 +1,12 @@
 CAN Bus Emulation Support
 =========================
 The CAN bus emulation provides mechanism to connect multiple
-emulated CAN controller chips together by one or multiple CAN busses
-(the controller device "canbus"  parameter). The individual busses
+emulated CAN controller chips together by one or multiple CAN buses
+(the controller device "canbus"  parameter). The individual buses
 can be connected to host system CAN API (at this time only Linux
 SocketCAN is supported).
 
-The concept of busses is generic and different CAN controllers
+The concept of buses is generic and different CAN controllers
 can be implemented.
 
 The initial submission implemented SJA1000 controller which
diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
index a8bb8d729c..2a3af268f7 100644
--- a/docs/system/devices/nvme.rst
+++ b/docs/system/devices/nvme.rst
@@ -232,7 +232,7 @@ parameters:
   Set the number of Reclaim Groups.
 
 ``fdp.nruh`` (default: ``0``)
-  Set the number of Reclaim Unit Handles. This is a mandatory paramater and
+  Set the number of Reclaim Unit Handles. This is a mandatory parameter and
   must be non-zero.
 
 ``fdp.runs`` (default: ``96M``)
diff --git a/host/include/aarch64/host/cpuinfo.h b/host/include/aarch64/host/cpuinfo.h
index 05feeb4f43..769626b098 100644
--- a/host/include/aarch64/host/cpuinfo.h
+++ b/host/include/aarch64/host/cpuinfo.h
@@ -1,6 +1,6 @@
 /*
  * SPDX-License-Identifier: GPL-2.0-or-later
- * Host specific cpu indentification for AArch64.
+ * Host specific cpu identification for AArch64.
  */
 
 #ifndef HOST_CPUINFO_H
diff --git a/host/include/generic/host/cpuinfo.h b/host/include/generic/host/cpuinfo.h
index eca672064a..67ad410871 100644
--- a/host/include/generic/host/cpuinfo.h
+++ b/host/include/generic/host/cpuinfo.h
@@ -1,4 +1,4 @@
 /*
- * No host specific cpu indentification.
+ * No host specific cpu identification.
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index 073d0a426f..6e46939132 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -1,6 +1,6 @@
 /*
  * SPDX-License-Identifier: GPL-2.0-or-later
- * Host specific cpu indentification for x86.
+ * Host specific cpu identification for x86.
  */
 
 #ifndef HOST_CPUINFO_H
diff --git a/host/include/ppc/host/cpuinfo.h b/host/include/ppc/host/cpuinfo.h
index 29ee7f9ef8..38b8eabe2a 100644
--- a/host/include/ppc/host/cpuinfo.h
+++ b/host/include/ppc/host/cpuinfo.h
@@ -1,6 +1,6 @@
 /*
  * SPDX-License-Identifier: GPL-2.0-or-later
- * Host specific cpu indentification for ppc.
+ * Host specific cpu identification for ppc.
  */
 
 #ifndef HOST_CPUINFO_H
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 9d07620235..1b1f3b9ec8 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -624,7 +624,7 @@ static ssize_t local_pwritev(FsContext *ctx, V9fsFidOpenState *fs,
         /*
          * Initiate a writeback. This is not a data integrity sync.
          * We want to ensure that we don't leave dirty pages in the cache
-         * after write when writeout=immediate is sepcified.
+         * after write when writeout=immediate is specified.
          */
         sync_file_range(fs->fd, offset, ret,
                         SYNC_FILE_RANGE_WAIT_BEFORE | SYNC_FILE_RANGE_WRITE);
@@ -843,7 +843,7 @@ static int local_open2(FsContext *fs_ctx, V9fsPath *dir_path, const char *name,
         }
         credp->fc_mode = credp->fc_mode | S_IFREG;
         if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
-            /* Set cleint credentials in xattr */
+            /* Set client credentials in xattr */
             err = local_set_xattrat(dirfd, name, credp);
         } else {
             err = local_set_mapped_file_attrat(dirfd, name, credp);
@@ -912,7 +912,7 @@ static int local_symlink(FsContext *fs_ctx, const char *oldpath,
         if (write_size != oldpath_size) {
             goto err_end;
         }
-        /* Set cleint credentials in symlink's xattr */
+        /* Set client credentials in symlink's xattr */
         credp->fc_mode = credp->fc_mode | S_IFLNK;
 
         if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
@@ -1418,7 +1418,7 @@ static int local_ioc_getversion_init(FsContext *ctx, LocalData *data, Error **er
     struct statfs stbuf;
 
     /*
-     * use ioc_getversion only if the ioctl is definied
+     * use ioc_getversion only if the ioctl is defined
      */
     if (fstatfs(data->mountfd, &stbuf) < 0) {
         error_setg_errno(errp, errno,
diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
index 905cae6992..7aac49ad4a 100644
--- a/hw/9pfs/9p-proxy.c
+++ b/hw/9pfs/9p-proxy.c
@@ -767,7 +767,7 @@ static ssize_t proxy_pwritev(FsContext *ctx, V9fsFidOpenState *fs,
         /*
          * Initiate a writeback. This is not a data integrity sync.
          * We want to ensure that we don't leave dirty pages in the cache
-         * after write when writeout=immediate is sepcified.
+         * after write when writeout=immediate is specified.
          */
         sync_file_range(fs->fd, offset, ret,
                         SYNC_FILE_RANGE_WAIT_BEFORE | SYNC_FILE_RANGE_WRITE);
diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index f62c40b639..0ac79a500b 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -493,7 +493,7 @@ static int synth_name_to_path(FsContext *ctx, V9fsPath *dir_path,
         node = dir_node;
         goto out;
     }
-    /* search for the name in the childern */
+    /* search for the name in the children */
     rcu_read_lock();
     QLIST_FOREACH(node, &dir_node->child, sibling) {
         if (!strcmp(node->name, name)) {
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index df1b583a5e..51c94b0116 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -48,7 +48,7 @@ static inline uint64_t makedev_dotl(uint32_t dev_major, uint32_t dev_minor)
 /*
  * Converts given device number from host's device number format to Linux
  * device number format. As both the size of type dev_t and encoding of
- * dev_t is system dependant, we have to convert them for Linux guests if
+ * dev_t is system dependent, we have to convert them for Linux guests if
  * host is not running Linux.
  */
 static inline uint64_t host_dev_to_dotl_dev(dev_t dev)
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 991645adca..323f042e65 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -644,7 +644,7 @@ static inline uint64_t mirror64bit(uint64_t value)
 }
 
 /*
- * Parameter k for the Exponential Golomb algorihm to be used.
+ * Parameter k for the Exponential Golomb algorithm to be used.
  *
  * The smaller this value, the smaller the minimum bit count for the Exp.
  * Golomb generated affixes will be (at lowest index) however for the
@@ -1039,7 +1039,7 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
      * Sending a reply would confuse clients because they would
      * assume that any EINTR is the actual result of the operation,
      * rather than a consequence of the cancellation. However, if
-     * the operation completed (succesfully or with an error other
+     * the operation completed (successfully or with an error other
      * than caused be cancellation), we do send out that reply, both
      * for efficiency and to avoid confusing the rest of the state machine
      * that assumes passing a non-error here will mean a successful
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 1b0d805b9c..a6f59abccb 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -304,7 +304,7 @@ typedef struct VariLenAffix {
     AffixType_t type; /* Whether this affix is a suffix or a prefix. */
     uint64_t value; /* Actual numerical value of this affix. */
     /*
-     * Lenght of the affix, that is how many (of the lowest) bits of ``value``
+     * Length of the affix, that is how many (of the lowest) bits of ``value``
      * must be used for appending/prepending this affix to its final resulting,
      * unique number.
      */
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index ea331a20d1..af66bde0f5 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -312,7 +312,7 @@ build_prepend_package_length(GArray *package, unsigned length, bool incl_self)
         /*
          * PkgLength is the length of the inclusive length of the data
          * and PkgLength's length itself when used for terms with
-         * explitit length.
+         * explicit length.
          */
         length += length_bytes;
     }
@@ -680,7 +680,7 @@ Aml *aml_store(Aml *val, Aml *target)
  *   "Op Operand Operand Target"
  * pattern.
  *
- * Returns: The newly allocated and composed according to patter Aml object.
+ * Returns: The newly allocated and composed according to pattern Aml object.
  */
 static Aml *
 build_opcode_2arg_dst(uint8_t op, Aml *arg1, Aml *arg2, Aml *dst)
@@ -2159,7 +2159,7 @@ void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
         /* FADT Minor Version */
         build_append_int_noprefix(tbl, f->minor_ver, 1);
     } else {
-        build_append_int_noprefix(tbl, 0, 3); /* Reserved upto ACPI 5.0 */
+        build_append_int_noprefix(tbl, 0, 3); /* Reserved up to ACPI 5.0 */
     }
     build_append_int_noprefix(tbl, 0, 8); /* X_FIRMWARE_CTRL */
 
diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index 3a6d51282a..2d5e199ba9 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -82,7 +82,7 @@ static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
     uint32_t base;
     /* Length in bytes for entire structure */
     uint32_t lb_length
-        = 32 /* Table length upto and including Entry Base Unit */
+        = 32 /* Table length up to and including Entry Base Unit */
         + 4 * num_initiator /* Initiator Proximity Domain List */
         + 4 * num_target /* Target Proximity Domain List */
         + 2 * num_initiator * num_target; /* Latency or Bandwidth Entries */
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index a3b25a92f3..fe03ce87e0 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -1097,7 +1097,7 @@ static void nvdimm_build_common_dsm(Aml *dev,
      * be treated as an integer. Moreover, the integer size depends on
      * DSDT tables revision number. If revision number is < 2, integer
      * size is 32 bits, otherwise it is 64 bits.
-     * Because of this CreateField() canot be used if RLEN < Integer Size.
+     * Because of this CreateField() cannot be used if RLEN < Integer Size.
      *
      * Also please note that APCI ASL operator SizeOf() doesn't support
      * Integer and there isn't any other way to figure out the Integer
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 6880998484..263626abea 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1565,7 +1565,7 @@ static void ast1030_evb_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = &bmc->soc;
 
-    /* U10 24C08 connects to SDA/SCL Groupt 1 by default */
+    /* U10 24C08 connects to SDA/SCL Group 1 by default */
     uint8_t *eeprom_buf = g_malloc0(32 * 1024);
     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50, eeprom_buf);
 
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 07aecd9497..5873107302 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1205,7 +1205,7 @@ static void mps2_tz_idau_check(IDAUInterface *ii, uint32_t address,
 {
     /*
      * The MPS2 TZ FPGA images have IDAUs in them which are connected to
-     * the Master Security Controllers. Thes have the same logic as
+     * the Master Security Controllers. These have the same logic as
      * is used by the IoTKit for the IDAU connected to the CPU, except
      * that MSCs don't care about the NSC attribute.
      */
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 05b9462a5b..b8b4e02594 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -175,7 +175,7 @@ static void vpb_sic_init(Object *obj)
 /* Board init.  */
 
 /* The AB and PB boards both use the same core, just with different
-   peripherals and expansion busses.  For now we emulate a subset of the
+   peripherals and expansion buses.  For now we emulate a subset of the
    PB peripherals and just change the board ID.  */
 
 static struct arm_boot_info versatile_binfo;
diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 8a71a569fa..a63ad0f04d 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -355,7 +355,7 @@ static void set_algorithm( OPL_CH *CH)
 	CH->connect2 = carrier;
 }
 
-/* ---------- frequency counter for operater update ---------- */
+/* ---------- frequency counter for operator update ---------- */
 static inline void CALC_FCSLOT(OPL_CH *CH,OPL_SLOT *SLOT)
 {
 	int ksr;
@@ -640,7 +640,7 @@ static int OPLOpenTable( void )
 		TL_TABLE[t] = TL_TABLE[TL_MAX+t] = 0;
 	}
 
-	/* make sinwave table (total level offet) */
+	/* make sinwave table (total level offset) */
 	/* degree 0 = degree 180                   = off */
 	SIN_TABLE[0] = SIN_TABLE[SIN_ENT/2]         = &TL_TABLE[EG_ENT-1];
 	for (s = 1;s <= SIN_ENT/4;s++){
@@ -1075,7 +1075,7 @@ FM_OPL *OPLCreate(int clock, int rate)
 	char *ptr;
 	FM_OPL *OPL;
 	int state_size;
-	int max_ch = 9; /* normaly 9 channels */
+	int max_ch = 9; /* normally 9 channels */
 
 	if( OPL_LockTable() ==-1) return NULL;
 	/* allocate OPL state space */
@@ -1092,7 +1092,7 @@ FM_OPL *OPLCreate(int clock, int rate)
 	OPL->clock = clock;
 	OPL->rate  = rate;
 	OPL->max_ch = max_ch;
-	/* init grobal tables */
+	/* init global tables */
 	OPL_initialize(OPL);
 	/* reset chip */
 	OPLResetChip(OPL);
diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index e008e72d7a..89086b93f4 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -69,7 +69,7 @@ typedef struct fm_opl_f {
 	/* FM channel slots */
 	OPL_CH *P_CH;		/* pointer of CH                     */
 	int	max_ch;			/* maximum channel                   */
-	/* Rhythm sention */
+	/* Rhythm section */
 	uint8_t rhythm;		/* Rhythm mode , key flag */
 	/* time tables */
 	int32_t AR_TABLE[76];	/* attack rate tables  */
diff --git a/hw/audio/gusemu_hal.c b/hw/audio/gusemu_hal.c
index 5b9a14ee21..f159978b49 100644
--- a/hw/audio/gusemu_hal.c
+++ b/hw/audio/gusemu_hal.c
@@ -154,7 +154,7 @@ unsigned int gus_read(GUSEmuState * state, int port, int size)
         case 0x8d:
             {
                 int             offset = 2 * (GUSregb(FunkSelReg3x3) & 0x0f);
-                offset += ((int) GUSregb(VoiceSelReg3x2) & 0x1f) << 5; /* = Voice*32 + Funktion*2 */
+                offset += ((int) GUSregb(VoiceSelReg3x2) & 0x1f) << 5; /* = Voice*32 + Function*2 */
                 value_read = GUSregw(offset);
             }
             break;
@@ -353,7 +353,7 @@ void gus_write(GUSEmuState * state, int port, int size, unsigned int data)
                     if (!(GUSregb(GUS4cReset) & 0x01))
                         break;  /* reset flag active? */
                     offset = 2 * (GUSregb(FunkSelReg3x3) & 0x0f);
-                    offset += (GUSregb(VoiceSelReg3x2) & 0x1f) << 5; /*  = Voice*32 + Funktion*2 */
+                    offset += (GUSregb(VoiceSelReg3x2) & 0x1f) << 5; /*  = Voice*32 + Function*2 */
                     GUSregw(offset) = (uint16_t) ((GUSregw(offset) & readmask) | writedata);
                 }
                 break;
diff --git a/hw/audio/intel-hda-defs.h b/hw/audio/intel-hda-defs.h
index 2e37e5b874..261bdb48ff 100644
--- a/hw/audio/intel-hda-defs.h
+++ b/hw/audio/intel-hda-defs.h
@@ -418,7 +418,7 @@ enum {
 #define AC_UNSOL_RES_CP_STATE		(1<<1)	/* content protection */
 #define AC_UNSOL_RES_CP_READY		(1<<0)	/* content protection */
 
-/* Pin widget capabilies */
+/* Pin widget capabilities */
 #define AC_PINCAP_IMP_SENSE		(1<<0)	/* impedance sense capable */
 #define AC_PINCAP_TRIG_REQ		(1<<1)	/* trigger required */
 #define AC_PINCAP_PRES_DETECT		(1<<2)	/* presence detect capable */
@@ -483,7 +483,7 @@ enum {
 #define AC_PWRST_D2			0x02
 #define AC_PWRST_D3			0x03
 
-/* Processing capabilies */
+/* Processing capabilities */
 #define AC_PCAP_BENIGN			(1<<0)
 #define AC_PCAP_NUM_COEF		(0xff<<8)
 #define AC_PCAP_NUM_COEF_SHIFT		8
diff --git a/hw/block/hd-geometry.c b/hw/block/hd-geometry.c
index dae13ab14d..2b0af4430f 100644
--- a/hw/block/hd-geometry.c
+++ b/hw/block/hd-geometry.c
@@ -50,7 +50,7 @@ struct partition {
         uint32_t nr_sects;          /* nr of sectors in partition */
 } QEMU_PACKED;
 
-/* try to guess the disk logical geometry from the MSDOS partition table.
+/* try to guess the disk logical geometry from the MS-DOS partition table.
    Return 0 if OK, -1 if could not guess */
 static int guess_disk_lchs(BlockBackend *blk,
                            int *pcylinders, int *pheads, int *psectors)
@@ -66,7 +66,7 @@ static int guess_disk_lchs(BlockBackend *blk,
     if (blk_pread(blk, 0, BDRV_SECTOR_SIZE, buf, 0) < 0) {
         return -1;
     }
-    /* test msdos magic */
+    /* test MS-DOS magic */
     if (buf[510] != 0x55 || buf[511] != 0xaa) {
         return -1;
     }
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 3c066e3405..62056b1d74 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -891,7 +891,7 @@ static Property pflash_cfi01_properties[] = {
     /* num-blocks is the number of blocks actually visible to the guest,
      * ie the total size of the device divided by the sector length.
      * If we're emulating flash devices wired in parallel the actual
-     * number of blocks per indvidual device will differ.
+     * number of blocks per individual device will differ.
      */
     DEFINE_PROP_UINT32("num-blocks", PFlashCFI01, nb_blocs, 0),
     DEFINE_PROP_UINT64("sector-length", PFlashCFI01, sector_len, 0),
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 807e398541..5dffd61b98 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -575,7 +575,7 @@ static int cadence_uart_pre_load(void *opaque)
 {
     CadenceUARTState *s = opaque;
 
-    /* the frequency will be overriden if the refclk field is present */
+    /* the frequency will be overridden if the refclk field is present */
     clock_set_hz(s->refclk, UART_DEFAULT_REF_CLK);
     return 0;
 }
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 1b75a89588..377d1d9773 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -112,7 +112,7 @@ static void imx_serial_reset_at_boot(DeviceState *dev)
     imx_serial_reset(s);
 
     /*
-     * enable the uart on boot, so messages from the linux decompresser
+     * enable the uart on boot, so messages from the linux decompressor
      * are visible.  On real hardware this is done by the boot rom
      * before anything else is loaded.
      */
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 270e1b1094..880b632177 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -54,7 +54,7 @@
 #define UART_IIR_RLSI   0x06    /* Receiver line status interrupt */
 #define UART_IIR_CTI    0x0C    /* Character Timeout Indication */
 
-#define UART_IIR_FENF   0x80    /* Fifo enabled, but not functionning */
+#define UART_IIR_FENF   0x80    /* Fifo enabled, but not functioning */
 #define UART_IIR_FE     0xC0    /* Fifo enabled */
 
 /*
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index 4f4d77908d..d4b5c501d8 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -24,7 +24,7 @@
  * callback that does the memory operations.
 
  * This device allows the user to monkey patch memory. To be able to do
- * this it needs a backend to manage the datas, the same as other
+ * this it needs a backend to manage the data, the same as other
  * memory-related devices. In this case as the backend is so trivial we
  * have merged it with the frontend instead of creating and maintaining a
  * separate backend.
@@ -166,7 +166,7 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    /* Convert the data endiannes */
+    /* Convert the data endianness */
     if (s->data_be) {
         s->data = cpu_to_be64(s->data);
     } else {
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 8b7fd9e9e5..4dd5a71fb7 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -863,7 +863,7 @@ ssize_t load_image_gzipped(const char *filename, hwaddr addr, uint64_t max_sz)
 
 /*
  * The Linux header magic number for a EFI PE/COFF
- * image targetting an unspecified architecture.
+ * image targeting an unspecified architecture.
  */
 #define EFI_PE_LINUX_MAGIC        "\xcd\x23\x82\x81"
 
@@ -1492,7 +1492,7 @@ RomGap rom_find_largest_gap_between(hwaddr base, size_t size)
         if (rom->mr || rom->fw_file) {
             continue;
         }
-        /* ignore anything finishing bellow base */
+        /* ignore anything finishing below base */
         if (rom->addr + rom->romsize <= base) {
             continue;
         }
diff --git a/hw/core/machine.c b/hw/core/machine.c
index f0d35c6401..ac33799c1b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1414,7 +1414,7 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
         for (i = 0; machine_class->valid_cpu_types[i]; i++) {
             if (object_class_dynamic_cast(oc,
                                           machine_class->valid_cpu_types[i])) {
-                /* The user specificed CPU is in the valid field, we are
+                /* The user specified CPU is in the valid field, we are
                  * good to go.
                  */
                 break;
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 6d5d43eda2..41b7e682c7 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -107,7 +107,7 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
     }
 
     if (*ptr) {
-        /* BlockBackend alread exists. So, we want to change attached node */
+        /* BlockBackend already exists. So, we want to change attached node */
         blk = *ptr;
         ctx = blk_get_aio_context(blk);
         bs = bdrv_lookup_bs(NULL, str, errp);
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 774ca9987a..bfd8aa5644 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -161,7 +161,7 @@ static void a15mp_priv_class_init(ObjectClass *klass, void *data)
 
     dc->realize = a15mp_priv_realize;
     device_class_set_props(dc, a15mp_priv_properties);
-    /* We currently have no savable state */
+    /* We currently have no saveable state */
 }
 
 static const TypeInfo a15mp_priv_info = {
diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index d161d57456..3ddd6369ad 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -197,7 +197,7 @@ CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds, CXLClearEventPayload *
 
     QEMU_LOCK_GUARD(&log->lock);
     /*
-     * Must itterate the queue twice.
+     * Must iterate the queue twice.
      * "The device shall verify the event record handles specified in the input
      * payload are in temporal order. If the device detects an older event
      * record that will not be cleared when Clear Event Records is executed,
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 034c7805b3..d7c5aa07bd 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -329,7 +329,7 @@ void cxl_machine_init(Object *obj, CXLState *state)
 
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp)
 {
-    /* Walk the pci busses looking for pxb busses to hook up */
+    /* Walk the pci buses looking for pxb buses to hook up */
     if (bus) {
         QLIST_FOREACH(bus, &bus->child, sibling) {
             if (!pci_bus_is_root(bus)) {
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 02f9b5a870..434ccc5f6e 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -39,7 +39,7 @@
  *    fill the output data into cmd->payload (overwriting what was there),
  *    setting the length, and returning a valid return code.
  *
- *  XXX: The handler need not worry about endianess. The payload is read out of
+ *  XXX: The handler need not worry about endianness. The payload is read out of
  *  a register interface that already deals with it.
  */
 
@@ -501,7 +501,7 @@ static CXLRetCode cmd_media_get_poison_list(struct cxl_cmd *cmd,
     uint16_t out_pl_len;
 
     query_start = ldq_le_p(&in->pa);
-    /* 64 byte alignemnt required */
+    /* 64 byte alignment required */
     if (query_start & 0x3f) {
         return CXL_MBOX_INVALID_INPUT;
     }
diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index e7ec268184..9138e98c3b 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -164,7 +164,7 @@ static int bochs_display_get_mode(BochsDisplayState *s,
     memset(mode, 0, sizeof(*mode));
     switch (vbe[VBE_DISPI_INDEX_BPP]) {
     case 16:
-        /* best effort: support native endianess only */
+        /* best effort: support native endianness only */
         mode->format = PIXMAN_r5g6b5;
         mode->bytepp = 2;
         break;
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index f1c0eb7dfc..af941fb0c2 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1544,7 +1544,7 @@ static void qxl_create_guest_primary(PCIQXLDevice *qxl, int loadvm,
     }
 }
 
-/* return 1 if surface destoy was initiated (in QXL_ASYNC case) or
+/* return 1 if surface destroy was initiated (in QXL_ASYNC case) or
  * done (in QXL_SYNC case), 0 otherwise. */
 static int qxl_destroy_primary(PCIQXLDevice *d, qxl_async_io async)
 {
diff --git a/hw/display/ssd0303.c b/hw/display/ssd0303.c
index d67b0ad7b5..32b32a3044 100644
--- a/hw/display/ssd0303.c
+++ b/hw/display/ssd0303.c
@@ -8,7 +8,7 @@
  */
 
 /* The controller can support a variety of different displays, but we only
-   implement one.  Most of the commends relating to brightness and geometry
+   implement one.  Most of the commands relating to brightness and geometry
    setup are ignored. */
 
 #include "qemu/osdep.h"
diff --git a/hw/display/ssd0323.c b/hw/display/ssd0323.c
index ab229d32b7..09b1bbed0a 100644
--- a/hw/display/ssd0323.c
+++ b/hw/display/ssd0323.c
@@ -8,7 +8,7 @@
  */
 
 /* The controller can support a variety of different displays, but we only
-   implement one.  Most of the commends relating to brightness and geometry
+   implement one.  Most of the commands relating to brightness and geometry
    setup are ignored. */
 
 #include "qemu/osdep.h"
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index b0828d65aa..822355ecc6 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -380,7 +380,7 @@ static inline void xlnx_dp_audio_mix_buffer(XlnxDPState *s)
 static void xlnx_dp_audio_callback(void *opaque, int avail)
 {
     /*
-     * Get some data from the DPDMA and compute these datas.
+     * Get some data from the DPDMA and compute these data.
      * Then wait for QEMU's audio subsystem to call this callback.
      */
     XlnxDPState *s = XLNX_DP(opaque);
diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index c6e35ba4b8..77797a67b5 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -247,7 +247,7 @@ static void omap_dma_deactivate_channel(struct omap_dma_s *s,
         return;
     }
 
-    /* Don't deactive the channel if it is synchronized and the DMA request is
+    /* Don't deactivate the channel if it is synchronized and the DMA request is
        active */
     if (ch->sync && ch->enable && (s->dma->drqbmp & (1ULL << ch->sync)))
         return;
@@ -422,7 +422,7 @@ static void omap_dma_transfer_generic(struct soc_dma_ch_s *dma)
 
         if (ch->fs && ch->bs) {
             a->pck_element ++;
-            /* Check if a full packet has beed transferred.  */
+            /* Check if a full packet has been transferred.  */
             if (a->pck_element == a->pck_elements) {
                 a->pck_element = 0;
 
diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index d7eae548cb..9ad6a47739 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -1,6 +1,6 @@
 /*
  * PC SMBus implementation
- * splitted from acpi.c
+ * split from acpi.c
  *
  * Copyright (c) 2006 Fabrice Bellard
  *
diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
index 44fe4eddbb..426f72ac60 100644
--- a/hw/i2c/pmbus_device.c
+++ b/hw/i2c/pmbus_device.c
@@ -1623,7 +1623,7 @@ static int pmbus_write_data(SMBusDevice *smd, uint8_t *buf, uint8_t len)
         break;
 
 passthrough:
-    /* Unimplimented registers get passed to the device */
+    /* Unimplemented registers get passed to the device */
     default:
         if (pmdc->write_data) {
             ret = pmdc->write_data(pmdev, buf, len);
diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index feb3ec6333..2ef2c7c5f6 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -2,7 +2,7 @@
  * QEMU SMBus device emulation.
  *
  * This code is a helper for SMBus device emulation.  It implements an
- * I2C device inteface and runs the SMBus protocol from the device
+ * I2C device interface and runs the SMBus protocol from the device
  * point of view and maps those to simple calls to emulate.
  *
  * Copyright (c) 2007 CodeSourcery.
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 512162003b..beda9198b4 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -775,7 +775,7 @@ static Aml *initialize_route(Aml *route, const char *link_name,
  *
  * Returns an array of 128 routes, one for each device,
  * based on device location.
- * The main goal is to equaly distribute the interrupts
+ * The main goal is to equally distribute the interrupts
  * over the 4 existing ACPI links (works only for i440fx).
  * The hash function is  (slot + pin) & 3 -> "LNK[D|A|B|C]".
  *
@@ -2081,7 +2081,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 }
 
 /*
- * Insert DMAR scope for PCI bridges and endpoint devcie
+ * Insert DMAR scope for PCI bridges and endpoint device
  */
 static void
 insert_scope(PCIBus *bus, PCIDevice *dev, void *opaque)
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 9c77304438..c98a3c6e11 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -259,7 +259,7 @@ static void amdvi_log_command_error(AMDVIState *s, hwaddr addr)
     pci_word_test_and_set_mask(s->pci.dev.config + PCI_STATUS,
             PCI_STATUS_SIG_TARGET_ABORT);
 }
-/* log an illegal comand event
+/* log an illegal command event
  *   @addr : address of illegal command
  */
 static void amdvi_log_illegalcom_error(AMDVIState *s, uint16_t info,
@@ -767,7 +767,7 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
         break;
     case AMDVI_MMIO_COMMAND_BASE:
         amdvi_mmio_reg_write(s, size, val, addr);
-        /* FIXME - make sure System Software has finished writing incase
+        /* FIXME - make sure System Software has finished writing in case
          * it writes in chucks less than 8 bytes in a robust way.As for
          * now, this hacks works for the linux driver
          */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index dcc334060c..09b19a43ee 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -52,7 +52,7 @@
 
 /*
  * PCI bus number (or SID) is not reliable since the device is usaully
- * initalized before guest can configure the PCI bridge
+ * initialized before guest can configure the PCI bridge
  * (SECONDARY_BUS_NUMBER).
  */
 struct vtd_as_key {
@@ -1689,7 +1689,7 @@ static bool vtd_switch_address_space(VTDAddressSpace *as)
      * """
      *
      * We enable per as memory region (iommu_ir_fault) for catching
-     * the tranlsation for interrupt range through PASID + PT.
+     * the translation for interrupt range through PASID + PT.
      */
     if (pt && as->pasid != PCI_NO_PASID) {
         memory_region_set_enabled(&as->iommu_ir_fault, true);
diff --git a/hw/i386/kvm/xen_xenstore.c b/hw/i386/kvm/xen_xenstore.c
index 133d89e953..660d0b72f9 100644
--- a/hw/i386/kvm/xen_xenstore.c
+++ b/hw/i386/kvm/xen_xenstore.c
@@ -1156,7 +1156,7 @@ static unsigned int copy_to_ring(XenXenstoreState *s, uint8_t *ptr,
 
     /*
      * This matches the barrier in copy_to_ring() (or the guest's
-     * equivalent) betweem writing the data to the ring and updating
+     * equivalent) between writing the data to the ring and updating
      * rsp_prod. It protects against the pathological case (which
      * again I think never happened except on Alpha) where our
      * subsequent writes to the ring could *cross* the read of
diff --git a/hw/i386/kvm/xenstore_impl.c b/hw/i386/kvm/xenstore_impl.c
index 305fe75519..36595fdb45 100644
--- a/hw/i386/kvm/xenstore_impl.c
+++ b/hw/i386/kvm/xenstore_impl.c
@@ -1426,7 +1426,7 @@ static void save_node(gpointer key, gpointer value, gpointer opaque)
     /*
      * If we already wrote this node, refer to the previous copy.
      * There's no rename/move in XenStore, so all we need to find
-     * it is the tx_id of the transation in which it exists. Which
+     * it is the tx_id of the transaction in which it exists. Which
      * may be the root tx.
      */
     if (n->serialized_tx != XBT_NULL) {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f01d7de5ad..a76483c9fb 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -435,7 +435,7 @@ static uint64_t ioport80_read(void *opaque, hwaddr addr, unsigned size)
     return 0xffffffffffffffffULL;
 }
 
-/* MSDOS compatibility mode FPU exception support */
+/* MS-DOS compatibility mode FPU exception support */
 static void ioportF0_write(void *opaque, hwaddr addr, uint64_t data,
                            unsigned size)
 {
@@ -1842,7 +1842,7 @@ static void pc_machine_set_max_fw_size(Object *obj, Visitor *v,
     if (value > 16 * MiB) {
         error_setg(errp,
                    "User specified max allowed firmware size %" PRIu64 " is "
-                   "greater than 16MiB. If combined firwmare size exceeds "
+                   "greater than 16MiB. If combined firmware size exceeds "
                    "16MiB the system may not boot, or experience intermittent"
                    "stability issues.",
                    value);
diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index 2480455372..c244bbd8be 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -61,13 +61,13 @@ enum AHCIHostReg {
     AHCI_HOST_REG_CTL        = 1,  /* GHC: global host control */
     AHCI_HOST_REG_IRQ_STAT   = 2,  /* IS: interrupt status */
     AHCI_HOST_REG_PORTS_IMPL = 3,  /* PI: bitmap of implemented ports */
-    AHCI_HOST_REG_VERSION    = 4,  /* VS: AHCI spec. version compliancy */
+    AHCI_HOST_REG_VERSION    = 4,  /* VS: AHCI spec. version compliance */
     AHCI_HOST_REG_CCC_CTL    = 5,  /* CCC_CTL: CCC Control */
     AHCI_HOST_REG_CCC_PORTS  = 6,  /* CCC_PORTS: CCC Ports */
     AHCI_HOST_REG_EM_LOC     = 7,  /* EM_LOC: Enclosure Mgmt Location */
     AHCI_HOST_REG_EM_CTL     = 8,  /* EM_CTL: Enclosure Mgmt Control */
     AHCI_HOST_REG_CAP2       = 9,  /* CAP2: host capabilities, extended */
-    AHCI_HOST_REG_BOHC       = 10, /* BOHC: firmare/os handoff ctrl & status */
+    AHCI_HOST_REG_BOHC       = 10, /* BOHC: firmware/os handoff ctrl & status */
     AHCI_HOST_REG__COUNT     = 11
 };
 
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index cabe9048b1..c0bcfa4414 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -257,7 +257,7 @@ static void pci_cmd646_ide_realize(PCIDevice *dev, Error **errp)
 
     pci_conf[CNTRL] = CNTRL_EN_CH0; // enable IDE0
     if (d->secondary) {
-        /* XXX: if not enabled, really disable the seconday IDE controller */
+        /* XXX: if not enabled, really disable the secondary IDE controller */
         pci_conf[CNTRL] |= CNTRL_EN_CH1; /* enable IDE1 */
     }
 
diff --git a/hw/ide/core.c b/hw/ide/core.c
index de48ff9f86..ee116891ed 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1698,7 +1698,7 @@ static bool cmd_set_features(IDEState *s, uint8_t cmd)
                 put_le16(identify_data + 63, 0x07);
                 put_le16(identify_data + 88, 0x3f);
                 break;
-            case 0x02: /* sigle word dma mode*/
+            case 0x02: /* single word dma mode */
                 put_le16(identify_data + 62, 0x07 | (1 << (val + 8)));
                 put_le16(identify_data + 63, 0x07);
                 put_le16(identify_data + 88, 0x3f);
diff --git a/hw/input/hid.c b/hw/input/hid.c
index e7ecebdf8f..a9c7dd1ce1 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -209,7 +209,7 @@ static void hid_pointer_sync(DeviceState *dev)
         prev->dz += curr->dz;
         curr->dz = 0;
     } else {
-        /* prepate next (clear rel, copy abs + btns) */
+        /* prepare next (clear rel, copy abs + btns) */
         if (hs->kind == HID_MOUSE) {
             next->xdx = 0;
             next->ydy = 0;
diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index 555b677173..a4f23705b5 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -157,14 +157,14 @@ static uint16_t tsc2005_read(TSC2005State *s, int reg)
         s->reset = true;
         return ret;
 
-    case 0x8:	/* AUX high treshold */
+    case 0x8:	/* AUX high threshold */
         return s->aux_thr[1];
-    case 0x9:	/* AUX low treshold */
+    case 0x9:	/* AUX low threshold */
         return s->aux_thr[0];
 
-    case 0xa:	/* TEMP high treshold */
+    case 0xa:	/* TEMP high threshold */
         return s->temp_thr[1];
-    case 0xb:	/* TEMP low treshold */
+    case 0xb:	/* TEMP low threshold */
         return s->temp_thr[0];
 
     case 0xc:	/* CFR0 */
@@ -186,17 +186,17 @@ static uint16_t tsc2005_read(TSC2005State *s, int reg)
 static void tsc2005_write(TSC2005State *s, int reg, uint16_t data)
 {
     switch (reg) {
-    case 0x8:	/* AUX high treshold */
+    case 0x8:	/* AUX high threshold */
         s->aux_thr[1] = data;
         break;
-    case 0x9:	/* AUX low treshold */
+    case 0x9:	/* AUX low threshold */
         s->aux_thr[0] = data;
         break;
 
-    case 0xa:	/* TEMP high treshold */
+    case 0xa:	/* TEMP high threshold */
         s->temp_thr[1] = data;
         break;
-    case 0xb:	/* TEMP low treshold */
+    case 0xb:	/* TEMP low threshold */
         s->temp_thr[0] = data;
         break;
 
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 7a34bc0998..074cf50af2 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -239,7 +239,7 @@ static inline bool gic_lr_entry_is_free(uint32_t entry)
 }
 
 /* Return true if this LR should trigger an EOI maintenance interrupt, i.e. the
- * corrsponding bit in EISR is set.
+ * corresponding bit in EISR is set.
  */
 static inline bool gic_lr_entry_is_eoi(uint32_t entry)
 {
@@ -1333,7 +1333,7 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
 
             /* ??? This currently clears the pending bit for all CPUs, even
                for per-CPU interrupts.  It's unclear whether this is the
-               corect behavior.  */
+               correct behavior.  */
             if (value & (1 << i)) {
                 GIC_DIST_CLEAR_PENDING(irq + i, ALL_CPU_MASK);
             }
diff --git a/hw/intc/arm_gicv3_redist.c b/hw/intc/arm_gicv3_redist.c
index 297f7f0263..8153525849 100644
--- a/hw/intc/arm_gicv3_redist.c
+++ b/hw/intc/arm_gicv3_redist.c
@@ -494,7 +494,7 @@ static MemTxResult gicr_writel(GICv3CPUState *cs, hwaddr offset,
         /* Only the ProcessorSleep bit is writable. When the guest sets
          * it, it requests that we transition the channel between the
          * redistributor and the cpu interface to quiescent, and that
-         * we set the ChildrenAsleep bit once the inteface has reached the
+         * we set the ChildrenAsleep bit once the interface has reached the
          * quiescent state.
          * Setting the ProcessorSleep to 0 reverses the quiescing, and
          * ChildrenAsleep is cleared once the transition is complete.
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 63afe1fdf5..03b6b8c986 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -894,7 +894,7 @@ int armv7m_nvic_complete_irq(NVICState *s, int irq, bool secure)
     vec->active = 0;
     if (vec->level) {
         /* Re-pend the exception if it's still held high; only
-         * happens for extenal IRQs
+         * happens for external IRQs
          */
         assert(irq >= NVIC_FIRST_IRQ);
         vec->pending = 1;
diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index af75460643..24fb3af8cc 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -191,7 +191,7 @@ static MemTxResult extioi_writew(void *opaque, hwaddr addr,
         cpu = attrs.requester_id;
         old_data = s->coreisr[cpu][index];
         s->coreisr[cpu][index] = old_data & ~val;
-        /* write 1 to clear interrrupt */
+        /* write 1 to clear interrupt */
         old_data &= val;
         irq = ctz32(old_data);
         while (irq != 32) {
diff --git a/hw/intc/loongson_liointc.c b/hw/intc/loongson_liointc.c
index cc11b544cb..c10fb97a06 100644
--- a/hw/intc/loongson_liointc.c
+++ b/hw/intc/loongson_liointc.c
@@ -1,5 +1,5 @@
 /*
- * QEMU Loongson Local I/O interrupt controler.
+ * QEMU Loongson Local I/O interrupt controller.
  *
  * Copyright (c) 2020 Huacai Chen <chenhc@lemote.com>
  * Copyright (c) 2020 Jiaxun Yang <jiaxun.yang@flygoat.com>
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index 647bf324a8..435c47600f 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -68,7 +68,7 @@ static void omap_inth_sir_update(OMAPIntcState *s, int is_fiq)
     p_intr = 255;
 
     /* Find the interrupt line with the highest dynamic priority.
-     * Note: 0 denotes the hightest priority.
+     * Note: 0 denotes the highest priority.
      * If all interrupts have the same priority, the default order is IRQ_N,
      * IRQ_N-1,...,IRQ_0. */
     for (j = 0; j < s->nbanks; ++j) {
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index e536b3ec26..6b6b42eb14 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -943,7 +943,7 @@ static void pnv_xive_ic_reg_write(void *opaque, hwaddr offset,
      */
     case VC_SBC_CONFIG: /* Store EOI configuration */
         /*
-         * Configure store EOI if required by firwmare (skiboot has removed
+         * Configure store EOI if required by firmware (skiboot has removed
          * support recently though)
          */
         if (val & (VC_SBC_CONF_CPLX_CIST | VC_SBC_CONF_CIST_BOTH)) {
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 4e86d2d436..28364b22d6 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -380,7 +380,7 @@ static void kvm_s390_release_adapter_routes(S390FLICState *fs,
  * @size: ignored
  *
  * Note: Pass buf and len to kernel. Start with one page and
- * increase until buffer is sufficient or maxium size is
+ * increase until buffer is sufficient or maximum size is
  * reached
  */
 static int kvm_flic_save(QEMUFile *f, void *opaque, size_t size,
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 8bcab2846c..7f701d414b 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -27,7 +27,7 @@
 #include "trace.h"
 
 /*
- * XIVE Virtualization Controller BAR and Thread Managment BAR that we
+ * XIVE Virtualization Controller BAR and Thread Management BAR that we
  * use for the ESB pages and the TIMA pages
  */
 #define SPAPR_XIVE_VC_BASE   0x0006010000000000ull
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 61fe7bd2d3..5789062379 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -485,7 +485,7 @@ static int kvmppc_xive_get_queues(SpaprXive *xive, Error **errp)
  *
  * Whenever the VM is stopped, the VM change handler sets the source
  * PQs to PENDING to stop the flow of events and to possibly catch a
- * triggered interrupt occuring while the VM is stopped. The previous
+ * triggered interrupt occurring while the VM is stopped. The previous
  * state is saved in anticipation of a migration. The XIVE controller
  * is then synced through KVM to flush any in-flight event
  * notification and stabilize the EQs.
@@ -551,7 +551,7 @@ static void kvmppc_xive_change_state_handler(void *opaque, bool running,
 
         /*
          * PQ is set to PENDING to possibly catch a triggered
-         * interrupt occuring while the VM is stopped (hotplug event
+         * interrupt occurring while the VM is stopped (hotplug event
          * for instance) .
          */
         if (pq != XIVE_ESB_OFF) {
@@ -633,7 +633,7 @@ int kvmppc_xive_post_load(SpaprXive *xive, int version_id)
     /* The KVM XIVE device should be in use */
     assert(xive->fd != -1);
 
-    /* Restore the ENDT first. The targetting depends on it. */
+    /* Restore the ENDT first. The targeting depends on it. */
     for (i = 0; i < xive->nr_ends; i++) {
         if (!xive_end_is_valid(&xive->endt[i])) {
             continue;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 56670b2cac..9cdf2b56b3 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1601,7 +1601,7 @@ int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
  *
  * It receives notification requests sent by the IVRE to find one
  * matching NVT (or more) dispatched on the processor threads. In case
- * of a single NVT notification, the process is abreviated and the
+ * of a single NVT notification, the process is abbreviated and the
  * thread is signaled if a match is found. In case of a logical server
  * notification (bits ignored at the end of the NVT identifier), the
  * IVPE and IVRE select a winning thread using different filters. This
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index c37ef25d44..98c0d8ba44 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -542,7 +542,7 @@ static void xive2_router_realize(DeviceState *dev, Error **errp)
 
 /*
  * Notification using the END ESe/ESn bit (Event State Buffer for
- * escalation and notification). Profide futher coalescing in the
+ * escalation and notification). Profide further coalescing in the
  * Router.
  */
 static bool xive2_router_end_es_notify(Xive2Router *xrtr, uint8_t end_blk,
@@ -621,7 +621,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
 
     /*
      * Check the END ESn (Event State Buffer for notification) for
-     * even futher coalescing in the Router
+     * even further coalescing in the Router
      */
     if (!xive2_end_is_notify(&end)) {
         /* ESn[Q]=1 : end of notification */
@@ -702,7 +702,7 @@ do_escalation:
 
     /*
      * Check the END ESe (Event State Buffer for escalation) for even
-     * futher coalescing in the Router
+     * further coalescing in the Router
      */
     if (!xive2_end_is_uncond_escalation(&end)) {
         /* ESe[Q]=1 : end of escalation notification */
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index acf2bab35f..e232d35ba2 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -301,7 +301,7 @@ static void handle_msg(IPMIBmcExtern *ibe)
         ipmi_debug("msg checksum failure\n");
         return;
     } else {
-        ibe->inpos--; /* Remove checkum */
+        ibe->inpos--; /* Remove checksum */
     }
 
     timer_del(ibe->extern_timer);
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index ce8ee50b9e..5d244b3b95 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -734,7 +734,7 @@ static void next_irq(void *opaque, int number, int level)
     M68kCPU *cpu = s->cpu;
     int shift = 0;
 
-    /* first switch sets interupt status */
+    /* first switch sets interrupt status */
     /* DPRINTF("IRQ %i\n",number); */
     switch (number) {
     /* level 3 - floppy, kbd/mouse, power, ether rx/tx, scsi, clock */
diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
index 0544160e91..0c348c18cf 100644
--- a/hw/m68k/next-kbd.c
+++ b/hw/m68k/next-kbd.c
@@ -37,7 +37,7 @@
 
 OBJECT_DECLARE_SIMPLE_TYPE(NextKBDState, NEXTKBD)
 
-/* following defintions from next68k netbsd */
+/* following definitions from next68k netbsd */
 #define CSR_INT 0x00800000
 #define CSR_DATA 0x00400000
 
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 731205b215..de91726cf9 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -1,7 +1,7 @@
 /*
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
- * QEMU Vitual M68K Machine
+ * QEMU Virtual M68K Machine
  *
  * (c) 2020 Laurent Vivier <laurent@vivier.eu>
  *
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4e314748d3..a98a157065 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -538,7 +538,7 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
                                      FIRST_ERROR_POINTER, cxl_err->type);
             } else {
                 /*
-                 * If no more errors, then follow recomendation of PCI spec
+                 * If no more errors, then follow recommendation of PCI spec
                  * r6.0 6.2.4.2 to set the first error pointer to a status
                  * bit that will never be used.
                  */
@@ -697,7 +697,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
                          PCI_BASE_ADDRESS_MEM_TYPE_64,
                      &ct3d->cxl_dstate.device_registers);
 
-    /* MSI(-X) Initailization */
+    /* MSI(-X) Initialization */
     rc = msix_init_exclusive_bar(pci_dev, msix_num, 4, NULL);
     if (rc) {
         goto err_address_space_free;
@@ -706,7 +706,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
         msix_vector_use(pci_dev, i);
     }
 
-    /* DOE Initailization */
+    /* DOE Initialization */
     pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true, 0);
 
     cxl_cstate->cdat.build_cdat_table = ct3_build_cdat_table;
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index a24fadddca..babb053035 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -104,7 +104,7 @@ petalogix_ml605_init(MachineState *machine)
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
     /* 5th parameter 2 means bank-width
-     * 10th paremeter 0 means little-endian */
+     * 10th parameter 0 means little-endian */
     pflash_cfi01_register(FLASH_BASEADDR, "petalogix_ml605.flash", FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           64 * KiB, 2, 0x89, 0x18, 0x0000, 0x0, 0);
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index f9618fa5f5..16e9c4773f 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -627,7 +627,7 @@ static void bl_setup_gt64120_jump_kernel(void **p, uint64_t run_addr,
         10, 10, 11, 11 /* PIIX IRQRC[A:D] */
     };
 
-    /* Bus endianess is always reversed */
+    /* Bus endianness is always reversed */
 #if TARGET_BIG_ENDIAN
 #define cpu_to_gt32(x) (x)
 #else
diff --git a/hw/misc/allwinner-r40-dramc.c b/hw/misc/allwinner-r40-dramc.c
index ea6124744f..6944f84455 100644
--- a/hw/misc/allwinner-r40-dramc.c
+++ b/hw/misc/allwinner-r40-dramc.c
@@ -368,7 +368,7 @@ static const MemoryRegionOps allwinner_r40_detect_ops = {
 
 /*
  * mctl_r40_detect_rank_count in u-boot will write the high 1G of DDR
- * to detect wether the board support dual_rank or not. Create a virtual memory
+ * to detect whether the board support dual_rank or not. Create a virtual memory
  * if the board's ram_size less or equal than 1G, and set read time out flag of
  * REG_DRAMCTL_PGSR when the user touch this high dram.
  */
diff --git a/hw/misc/exynos4210_rng.c b/hw/misc/exynos4210_rng.c
index 1b9e8347a1..9214ec14cc 100644
--- a/hw/misc/exynos4210_rng.c
+++ b/hw/misc/exynos4210_rng.c
@@ -1,5 +1,5 @@
 /*
- *  Exynos4210 Pseudo Random Nubmer Generator Emulation
+ *  Exynos4210 Pseudo Random Number Generator Emulation
  *
  *  Copyright (c) 2017 Krzysztof Kozlowski <krzk@kernel.org>
  *
diff --git a/hw/misc/imx7_ccm.c b/hw/misc/imx7_ccm.c
index f135ec7b7e..7539f7fb45 100644
--- a/hw/misc/imx7_ccm.c
+++ b/hw/misc/imx7_ccm.c
@@ -227,7 +227,7 @@ static uint32_t imx7_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
      * have fixed frequencies and we can provide requested frequency
      * easily. However for CCM provided clocks (like IPG) each GPT
      * timer can have its own clock root.
-     * This means we need additionnal information when calling this
+     * This means we need additional information when calling this
      * function to know the requester's identity.
      */
     uint32_t freq = 0;
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 0787a0268d..f84cc68849 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -246,7 +246,7 @@
 #define vT2CL    0x1000  /* [VIA only] Timer two counter low. */
 #define vT2CH    0x1200  /* [VIA only] Timer two counter high. */
 #define vSR      0x1400  /* [VIA only] Shift register. */
-#define vACR     0x1600  /* [VIA only] Auxilary control register. */
+#define vACR     0x1600  /* [VIA only] Auxiliary control register. */
 #define vPCR     0x1800  /* [VIA only] Peripheral control register. */
                          /*
                           *           CHRP sez never ever to *write* this.
diff --git a/hw/misc/stm32f2xx_syscfg.c b/hw/misc/stm32f2xx_syscfg.c
index 04c22c2850..19c1e86424 100644
--- a/hw/misc/stm32f2xx_syscfg.c
+++ b/hw/misc/stm32f2xx_syscfg.c
@@ -94,12 +94,12 @@ static void stm32f2xx_syscfg_write(void *opaque, hwaddr addr,
     switch (addr) {
     case SYSCFG_MEMRMP:
         qemu_log_mask(LOG_UNIMP,
-                      "%s: Changeing the memory mapping isn't supported " \
+                      "%s: Changing the memory mapping isn't supported " \
                       "in QEMU\n", __func__);
         return;
     case SYSCFG_PMC:
         qemu_log_mask(LOG_UNIMP,
-                      "%s: Changeing the memory mapping isn't supported " \
+                      "%s: Changing the memory mapping isn't supported " \
                       "in QEMU\n", __func__);
         return;
     case SYSCFG_EXTICR1:
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 4d1a0e17af..bfd56ce9e2 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -155,7 +155,7 @@ stm32f4xx_syscfg_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
 stm32f4xx_syscfg_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
 
 # stm32f4xx_exti.c
-stm32f4xx_exti_set_irq(int irq, int leve) "Set EXTI: %d to %d"
+stm32f4xx_exti_set_irq(int irq, int level) "Set EXTI: %d to %d"
 stm32f4xx_exti_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
 stm32f4xx_exti_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
 
diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index 8b70285961..41f38a98e9 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -285,7 +285,7 @@ static void zynq_slcr_compute_clocks_internal(ZynqSLCRState *s, uint64_t ps_clk)
 }
 
 /**
- * Compute and set the ouputs clocks periods.
+ * Compute and set the outputs clocks periods.
  * But do not propagate them further. Connected clocks
  * will not receive any updates (See zynq_slcr_compute_clocks())
  */
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 42ea2411a2..f445d8bb5e 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -81,8 +81,8 @@
 #define GEM_IPGSTRETCH    (0x000000BC / 4) /* IPG Stretch reg */
 #define GEM_SVLAN         (0x000000C0 / 4) /* Stacked VLAN reg */
 #define GEM_MODID         (0x000000FC / 4) /* Module ID reg */
-#define GEM_OCTTXLO       (0x00000100 / 4) /* Octects transmitted Low reg */
-#define GEM_OCTTXHI       (0x00000104 / 4) /* Octects transmitted High reg */
+#define GEM_OCTTXLO       (0x00000100 / 4) /* Octets transmitted Low reg */
+#define GEM_OCTTXHI       (0x00000104 / 4) /* Octets transmitted High reg */
 #define GEM_TXCNT         (0x00000108 / 4) /* Error-free Frames transmitted */
 #define GEM_TXBCNT        (0x0000010C / 4) /* Error-free Broadcast Frames */
 #define GEM_TXMCNT        (0x00000110 / 4) /* Error-free Multicast Frame */
@@ -101,8 +101,8 @@
 #define GEM_LATECOLLCNT   (0x00000144 / 4) /* Late Collision Frames */
 #define GEM_DEFERTXCNT    (0x00000148 / 4) /* Deferred Transmission Frames */
 #define GEM_CSENSECNT     (0x0000014C / 4) /* Carrier Sense Error Counter */
-#define GEM_OCTRXLO       (0x00000150 / 4) /* Octects Received register Low */
-#define GEM_OCTRXHI       (0x00000154 / 4) /* Octects Received register High */
+#define GEM_OCTRXLO       (0x00000150 / 4) /* Octets Received register Low */
+#define GEM_OCTRXHI       (0x00000154 / 4) /* Octets Received register High */
 #define GEM_RXCNT         (0x00000158 / 4) /* Error-free Frames Received */
 #define GEM_RXBROADCNT    (0x0000015C / 4) /* Error-free Broadcast Frames RX */
 #define GEM_RXMULTICNT    (0x00000160 / 4) /* Error-free Multicast Frames RX */
@@ -954,7 +954,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     /* Is this destination MAC address "for us" ? */
     maf = gem_mac_address_filter(s, buf);
     if (maf == GEM_RX_REJECT) {
-        return size;  /* no, drop siliently b/c it's not an error */
+        return size;  /* no, drop silently b/c it's not an error */
     }
 
     /* Discard packets with receive length error enabled ? */
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index a596f7fbc6..c6f5fb7dce 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -551,7 +551,7 @@ static uint64_t dp8393x_read(void *opaque, hwaddr addr, unsigned int size)
             val = s->cam[s->regs[SONIC_CEP] & 0xf][SONIC_CAP0 - reg];
         }
         break;
-    /* All other registers have no special contraints */
+    /* All other registers have no special constraints */
     default:
         val = s->regs[reg];
     }
diff --git a/hw/net/e1000_regs.h b/hw/net/e1000_regs.h
index 8a4ce82034..39f4882510 100644
--- a/hw/net/e1000_regs.h
+++ b/hw/net/e1000_regs.h
@@ -130,7 +130,7 @@
 
 #define E1000_GCR2      0x05B64 /* 3GIO Control Register 2 */
 #define E1000_FFLT_DBG  0x05F04 /* Debug Register */
-#define E1000_HICR      0x08F00 /* Host Inteface Control */
+#define E1000_HICR      0x08F00 /* Host Interface Control */
 
 #define E1000_RXMTRL     0x0B634 /* Time sync Rx EtherType and Msg Type - RW */
 #define E1000_RXUDP      0x0B638 /* Time Sync Rx UDP Port - RW */
diff --git a/hw/net/e1000x_regs.h b/hw/net/e1000x_regs.h
index 13760c66d3..cd896fc0ca 100644
--- a/hw/net/e1000x_regs.h
+++ b/hw/net/e1000x_regs.h
@@ -839,7 +839,7 @@ union e1000_rx_desc_packet_split {
 #define E1000_RXD_STAT_EOP      0x02    /* End of Packet */
 #define E1000_RXD_STAT_IXSM     0x04    /* Ignore checksum */
 #define E1000_RXD_STAT_VP       0x08    /* IEEE VLAN Packet */
-#define E1000_RXD_STAT_UDPCS    0x10    /* UDP xsum caculated */
+#define E1000_RXD_STAT_UDPCS    0x10    /* UDP xsum calculated */
 #define E1000_RXD_STAT_TCPCS    0x20    /* TCP xsum calculated */
 #define E1000_RXD_STAT_IPCS     0x40    /* IP xsum calculated */
 #define E1000_RXD_STAT_PIF      0x80    /* passed in-exact filter */
diff --git a/hw/net/fsl_etsec/rings.c b/hw/net/fsl_etsec/rings.c
index 788463f1b6..e6c3bf5361 100644
--- a/hw/net/fsl_etsec/rings.c
+++ b/hw/net/fsl_etsec/rings.c
@@ -365,7 +365,7 @@ void etsec_walk_tx_ring(eTSEC *etsec, int ring_nbr)
     } while (TRUE);
 
     /* Save the Buffer Descriptor Pointers to last bd that was not
-     * succesfully closed */
+     * successfully closed */
     etsec->regs[TBPTR0 + ring_nbr].value = bd_addr;
 
     /* Set transmit halt THLTx */
diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
index 82ff195dfc..d6e0405d0a 100644
--- a/hw/net/igb_regs.h
+++ b/hw/net/igb_regs.h
@@ -364,7 +364,7 @@ union e1000_adv_rx_desc {
 /* Indicates that VF is still clear to send requests */
 #define E1000_VT_MSGTYPE_CTS 0x20000000
 #define E1000_VT_MSGINFO_SHIFT 16
-/* bits 23:16 are used for exra info for certain messages */
+/* bits 23:16 are used for extra info for certain messages */
 #define E1000_VT_MSGINFO_MASK (0xFF << E1000_VT_MSGINFO_SHIFT)
 
 #define E1000_VF_RESET                 0x01 /* VF requests reset */
@@ -490,7 +490,7 @@ union e1000_adv_rx_desc {
 #define E1000_VF_MBX_INIT_DELAY   500  /* usec delay between retries */
 
 #define E1000_VT_MSGINFO_SHIFT    16
-/* bits 23:16 are used for exra info for certain messages */
+/* bits 23:16 are used for extra info for certain messages */
 #define E1000_VT_MSGINFO_MASK     (0xFF << E1000_VT_MSGINFO_SHIFT)
 
 #define E1000_VF_RESET            0x01 /* VF requests reset */
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index 8aa27bd322..ec3ddf520a 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -571,7 +571,7 @@ static ssize_t mcf_fec_receive(NetClientState *nc, const uint8_t *buf, size_t si
     size += 4;
     crc = cpu_to_be32(crc32(~0, buf, size));
     crc_ptr = (uint8_t *)&crc;
-    /* Huge frames are truncted.  */
+    /* Huge frames are truncated.  */
     if (size > FEC_MAX_FRAME_SIZE) {
         size = FEC_MAX_FRAME_SIZE;
         flags |= FEC_BD_TR | FEC_BD_LG;
diff --git a/hw/net/rocker/rocker_fp.c b/hw/net/rocker/rocker_fp.c
index cbeed65bd5..9afd0c5e3f 100644
--- a/hw/net/rocker/rocker_fp.c
+++ b/hw/net/rocker/rocker_fp.c
@@ -134,7 +134,7 @@ static ssize_t fp_port_receive_iov(NetClientState *nc, const struct iovec *iov,
     FpPort *port = qemu_get_nic_opaque(nc);
 
     /* If the port is disabled, we want to drop this pkt
-     * now rather than queing it for later.  We don't want
+     * now rather than queueing it for later.  We don't want
      * any stale pkts getting into the device when the port
      * transitions to enabled.
      */
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index b4df75b2c9..4525fda383 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -100,7 +100,7 @@ enum RTL8139_registers {
     MAC0 = 0,        /* Ethernet hardware address. */
     MAR0 = 8,        /* Multicast filter. */
     TxStatus0 = 0x10,/* Transmit status (Four 32bit registers). C mode only */
-                     /* Dump Tally Conter control register(64bit). C+ mode only */
+                     /* Dump Tally Counter control register(64bit). C+ mode only */
     TxAddr0 = 0x20,  /* Tx descriptors (also four 32bit). */
     RxBuf = 0x30,
     ChipCmd = 0x37,
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index ad778cd8fc..ddbceda967 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -361,7 +361,7 @@ static void smc91c111_writeb(void *opaque, hwaddr offset,
         case 4: case 5: case 6: case 7: case 8: case 9: /* IA */
             /* Not implemented.  */
             return;
-        case 10: /* Genral Purpose */
+        case 10: /* General Purpose */
             SET_LOW(gpr, value);
             return;
         case 11:
diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index 510b370e5f..c2e2c90668 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -1228,7 +1228,7 @@ static void sungem_mmio_mif_write(void *opaque, hwaddr addr, uint64_t val,
     case MIF_SMACHINE:
         return; /* No actual write */
     case MIF_CFG:
-        /* Maintain the RO MDI bits to advertize an MDIO PHY on MDI0 */
+        /* Maintain the RO MDI bits to advertise an MDIO PHY on MDI0 */
         val &= ~MIF_CFG_MDI1;
         val |= MIF_CFG_MDI0;
         break;
diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index 391d26fb82..64d4ea5850 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -901,7 +901,7 @@ static void sunhme_reset(DeviceState *ds)
     /* Configure internal transceiver */
     s->mifregs[HME_MIFI_CFG >> 2] |= HME_MIF_CFG_MDI0;
 
-    /* Advetise auto, 100Mbps FD */
+    /* Advertise auto, 100Mbps FD */
     s->miiregs[MII_ANAR] = MII_ANAR_TXFD;
     s->miiregs[MII_BMSR] = MII_BMSR_AUTONEG | MII_BMSR_100TX_FD |
                            MII_BMSR_AN_COMP;
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7102ec4817..57a359b7a5 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1307,7 +1307,7 @@ static void virtio_net_detach_epbf_rss(VirtIONet *n)
 static bool virtio_net_load_ebpf(VirtIONet *n)
 {
     if (!virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
-        /* backend does't support steering ebpf */
+        /* backend doesn't support steering ebpf */
         return false;
     }
 
@@ -2046,7 +2046,7 @@ static void virtio_net_rsc_extract_unit6(VirtioNetRscChain *chain,
                                         + sizeof(struct ip6_header));
     unit->tcp_hdrlen = (htons(unit->tcp->th_offset_flags) & 0xF000) >> 10;
 
-    /* There is a difference between payload lenght in ipv4 and v6,
+    /* There is a difference between payload length in ipv4 and v6,
        ip header is excluded in ipv6 */
     unit->payload = htons(*unit->ip_plen) - unit->tcp_hdrlen;
 }
@@ -3795,7 +3795,7 @@ static void virtio_net_instance_init(Object *obj)
 
     /*
      * The default config_size is sizeof(struct virtio_net_config).
-     * Can be overriden with virtio_net_set_config_size.
+     * Can be overridden with virtio_net_set_config_size.
      */
     n->config_size = sizeof(struct virtio_net_config);
     device_add_bootindex_property(obj, &n->nic_conf.bootindex,
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 5dfacb1098..ea9e86476e 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -1884,7 +1884,7 @@ vmxnet3_io_bar1_read(void *opaque, hwaddr addr, unsigned size)
             break;
 
         default:
-            VMW_CBPRN("Unknow read BAR1[%" PRIx64 "], %d bytes", addr, size);
+            VMW_CBPRN("Unknown read BAR1[%" PRIx64 "], %d bytes", addr, size);
             break;
         }
 
diff --git a/hw/net/vmxnet3.h b/hw/net/vmxnet3.h
index bf4f6de74a..f9283f9e7b 100644
--- a/hw/net/vmxnet3.h
+++ b/hw/net/vmxnet3.h
@@ -733,7 +733,7 @@ struct Vmxnet3_TxQueueDesc {
 struct Vmxnet3_RxQueueDesc {
     struct Vmxnet3_RxQueueCtrl        ctrl;
     struct Vmxnet3_RxQueueConf        conf;
-    /* Driver read after a GET commad */
+    /* Driver read after a GET command */
     struct Vmxnet3_QueueStatus        status;
     struct UPT1_RxStats            stats;
     u8                      __pad[88]; /* 128 aligned */
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 8e8e870b9a..c3e2f31c6c 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -17,7 +17,7 @@
  * Notes on coding style
  * ---------------------
  * While QEMU coding style prefers lowercase hexadecimals in constants, the
- * NVMe subsystem use thes format from the NVMe specifications in the comments
+ * NVMe subsystem use this format from the NVMe specifications in the comments
  * (i.e. 'h' suffix instead of '0x' prefix).
  *
  * Usage
@@ -730,7 +730,7 @@ static inline void nvme_sg_unmap(NvmeSg *sg)
 }
 
 /*
- * When metadata is transfered as extended LBAs, the DPTR mapped into `sg`
+ * When metadata is transferred as extended LBAs, the DPTR mapped into `sg`
  * holds both data and metadata. This function splits the data and metadata
  * into two separate QSG/IOVs.
  */
@@ -7613,7 +7613,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
             /*
              * NVM Express v1.3d, Section 4.1 state: "If host software writes
              * an invalid value to the Submission Queue Tail Doorbell or
-             * Completion Queue Head Doorbell regiter and an Asynchronous Event
+             * Completion Queue Head Doorbell register and an Asynchronous Event
              * Request command is outstanding, then an asynchronous event is
              * posted to the Admin Completion Queue with a status code of
              * Invalid Doorbell Write Value."
diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index 613c4929e3..3272068663 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -51,7 +51,7 @@ struct EEPROMState {
     bool writable;
     /* cells changed since last START? */
     bool changed;
-    /* during WRITE, # of address bytes transfered */
+    /* during WRITE, # of address bytes transferred */
     uint8_t haveaddr;
 
     uint8_t *mem;
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 29a5bef1d5..4e4524673a 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -877,7 +877,7 @@ static struct {
 /*
  * Any sub-page size update to these table MRs will be lost during migration,
  * as we use aligned size in ram_load_precopy() -> qemu_ram_resize() path.
- * In order to avoid the inconsistency in sizes save them seperately and
+ * In order to avoid the inconsistency in sizes save them separately and
  * migrate over in vmstate post_load().
  */
 static void fw_cfg_acpi_mr_save(FWCfgState *s, const char *filename, size_t len)
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 54f507318f..5a2b749c8e 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -42,7 +42,7 @@ static void latch_registers(CXLDownstreamPort *dsp)
                                        CXL2_DOWNSTREAM_PORT);
 }
 
-/* TODO: Look at sharing this code acorss all CXL port types */
+/* TODO: Look at sharing this code across all CXL port types */
 static void cxl_dsp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
                                       uint32_t val, int len)
 {
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 613857b601..535889f7c2 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -263,7 +263,7 @@ static int pxb_map_irq_fn(PCIDevice *pci_dev, int pin)
 
     /*
      * First carry out normal swizzle to handle
-     * multple root ports on a pxb instance.
+     * multiple root ports on a pxb instance.
      */
     pin = pci_swizzle_map_irq_fn(pci_dev, pin);
 
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 4701481b9b..ee6cb85e97 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -62,7 +62,7 @@
 #define DPRINTF(fmt, ...)
 #endif
 
-/* from linux soure code. include/asm-mips/mips-boards/bonito64.h*/
+/* from linux source code. include/asm-mips/mips-boards/bonito64.h*/
 #define BONITO_BOOT_BASE        0x1fc00000
 #define BONITO_BOOT_SIZE        0x00100000
 #define BONITO_BOOT_TOP         (BONITO_BOOT_BASE + BONITO_BOOT_SIZE - 1)
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 9e183caa48..77a1b66d50 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -488,7 +488,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
 
     /*
      * If no inbound iATU windows are configured, HW defaults to
-     * letting inbound TLPs to pass in. We emulate that by exlicitly
+     * letting inbound TLPs to pass in. We emulate that by explicitly
      * configuring first inbound window to cover all of target's
      * address space.
      *
@@ -503,7 +503,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
                           &designware_pci_host_msi_ops,
                           root, "pcie-msi", 0x4);
     /*
-     * We initially place MSI interrupt I/O region a adress 0 and
+     * We initially place MSI interrupt I/O region a address 0 and
      * disable it. It'll be later moved to correct offset and enabled
      * in designware_pcie_root_update_msi_mapping() as a part of
      * initialization done by guest OS
diff --git a/hw/pci-host/dino.c b/hw/pci-host/dino.c
index e8eaebca54..82503229fa 100644
--- a/hw/pci-host/dino.c
+++ b/hw/pci-host/dino.c
@@ -1,5 +1,5 @@
 /*
- * HP-PARISC Dino PCI chipset emulation, as in B160L and similiar machines
+ * HP-PARISC Dino PCI chipset emulation, as in B160L and similar machines
  *
  * (C) 2017-2019 by Helge Deller <deller@gmx.de>
  *
diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index 7c7316bc96..40524026fa 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -177,7 +177,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
             acpi_dsdt_add_pci_route_table(dev, cfg->irq);
 
             /*
-             * Resources defined for PXBs are composed by the folling parts:
+             * Resources defined for PXBs are composed by the following parts:
              * 1. The resources the pci-brige/pcie-root-port need.
              * 2. The resources the devices behind pxb need.
              */
@@ -213,7 +213,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
 
     /*
      * At this point crs_range_set has all the ranges used by pci
-     * busses *other* than PCI0.  These ranges will be excluded from
+     * buses *other* than PCI0.  These ranges will be excluded from
      * the PCI0._CRS.
      */
     rbuf = aml_resource_template();
diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index 82c15edb46..143bf053d7 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -331,9 +331,9 @@ static void gt64120_update_pci_cfgdata_mapping(GT64120State *s)
     /*
      * The setting of the MByteSwap bit and MWordSwap bit in the PCI Internal
      * Command Register determines how data transactions from the CPU to/from
-     * PCI are handled along with the setting of the Endianess bit in the CPU
+     * PCI are handled along with the setting of the Endianness bit in the CPU
      * Configuration Register. See:
-     * - Table 16: 32-bit PCI Transaction Endianess
+     * - Table 16: 32-bit PCI Transaction Endianness
      * - Table 158: PCI_0 Command, Offset: 0xc00
      */
 
diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
index 82332d7a05..157c00782c 100644
--- a/hw/pci-host/pnv_phb.c
+++ b/hw/pci-host/pnv_phb.c
@@ -25,7 +25,7 @@
  * state associated with the child has an id, use it as QOM id.
  * Otherwise use object_typename[index] as QOM id.
  *
- * This helper does both operations at the same time because seting
+ * This helper does both operations at the same time because setting
  * a new QOM child will erase the bus parent of the device. This happens
  * because object_unparent() will call object_property_del_child(),
  * which in turn calls the property release callback prop->release if
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 7a21497cf8..c5e58f4086 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -757,7 +757,7 @@ static void pnv_phb3_translate_tve(PnvPhb3DMASpace *ds, hwaddr addr,
          * We only support non-translate in top window.
          *
          * TODO: Venice/Murano support it on bottom window above 4G and
-         * Naples suports it on everything
+         * Naples supports it on everything
          */
         if (!(tve & PPC_BIT(51))) {
             phb3_error(phb, "xlate for invalid non-translate TVE");
diff --git a/hw/pci-host/pnv_phb3_msi.c b/hw/pci-host/pnv_phb3_msi.c
index 41e63b066f..dc8d8637f2 100644
--- a/hw/pci-host/pnv_phb3_msi.c
+++ b/hw/pci-host/pnv_phb3_msi.c
@@ -281,7 +281,7 @@ static void phb3_msi_instance_init(Object *obj)
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG);
 
-    /* Will be overriden later */
+    /* Will be overridden later */
     ics->offset = 0;
 }
 
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 6232cbeee1..29cb11a5d9 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -207,7 +207,7 @@ static void pnv_phb4_check_mbt(PnvPHB4 *phb, uint32_t index)
         start = base | (phb->regs[PHB_M64_UPPER_BITS >> 3]);
     }
 
-    /* TODO: Figure out how to implemet/decode AOMASK */
+    /* TODO: Figure out how to implement/decode AOMASK */
 
     /* Check if it matches an enabled MMIO region in the PEC stack */
     if (memory_region_is_mapped(&phb->mmbar0) &&
@@ -391,7 +391,7 @@ static void pnv_phb4_ioda_write(PnvPHB4 *phb, uint64_t val)
     case IODA3_TBL_MBT:
         *tptr = val;
 
-        /* Copy accross the valid bit to the other half */
+        /* Copy across the valid bit to the other half */
         phb->ioda_MBT[idx ^ 1] &= 0x7fffffffffffffffull;
         phb->ioda_MBT[idx ^ 1] |= 0x8000000000000000ull & val;
 
@@ -1408,7 +1408,7 @@ static void pnv_phb4_msi_write(void *opaque, hwaddr addr,
         return;
     }
 
-    /* TODO: check PE/MSI assignement */
+    /* TODO: check PE/MSI assignment */
 
     qemu_irq_pulse(phb->qirqs[src]);
 }
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index dcb2e230b6..7e51ba535b 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -386,7 +386,7 @@ static void sabre_realize(DeviceState *dev, Error **errp)
                     sysbus_mmio_get_region(SYS_BUS_DEVICE(s->iommu), 0), 1);
     pci_setup_iommu(phb->bus, sabre_pci_dma_iommu, s->iommu);
 
-    /* APB secondary busses */
+    /* APB secondary buses */
     pci_dev = pci_new_multifunction(PCI_DEVFN(1, 0), TYPE_SIMBA_PCI_BRIDGE);
     s->bridgeB = PCI_BRIDGE(pci_dev);
     pci_bridge_map_irq(s->bridgeB, "pciB", pci_simbaB_map_irq);
diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index 374d593ead..b68c7ecb49 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -324,7 +324,7 @@ static void pcie_aer_msg_root_port(PCIDevice *dev, const PCIEAERMsg *msg)
          * it isn't implemented in qemu right now.
          * So just discard the error for now.
          * OS which cares of aer would receive errors via
-         * native aer mechanims, so this wouldn't matter.
+         * native aer mechanisms, so this wouldn't matter.
          */
     }
 
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index e7bc7192f1..df7f370111 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -615,7 +615,7 @@ int shpc_init(PCIDevice *d, PCIBus *sec_bus, MemoryRegion *bar,
     }
     if (nslots > SHPC_MAX_SLOTS ||
         SHPC_IDX_TO_PCI(nslots) > PCI_SLOT_MAX) {
-        /* TODO: report an error mesage that makes sense. */
+        /* TODO: report an error message that makes sense. */
         return -EINVAL;
     }
     shpc->nslots = nslots;
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 0e0a3d93c3..6c46204428 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -713,7 +713,7 @@ target_ulong cpu_ppc_load_decr(CPUPPCState *env)
     decr = _cpu_ppc_load_decr(env, tb_env->decr_next);
 
     /*
-     * If large decrementer is enabled then the decrementer is signed extened
+     * If large decrementer is enabled then the decrementer is signed extended
      * to 64 bits, otherwise it is a 32 bit value.
      */
     if (env->spr[SPR_LPCR] & LPCR_LD) {
diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index 5a56f155f5..c96cefb13d 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -39,7 +39,7 @@
 #define TYPE_PREP_SYSTEMIO "prep-systemio"
 OBJECT_DECLARE_SIMPLE_TYPE(PrepSystemIoState, PREP_SYSTEMIO)
 
-/* Bit as defined in PowerPC Reference Plaform v1.1, sect. 6.1.5, p. 132 */
+/* Bit as defined in PowerPC Reference Platform v1.1, sect. 6.1.5, p. 132 */
 #define PREP_BIT(n) (1 << (7 - (n)))
 
 struct PrepSystemIoState {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 54dbfd7fe9..1448d5ff32 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2545,7 +2545,7 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
         return;
     }
 
-    /* Detemine the VSMT mode to use: */
+    /* Determine the VSMT mode to use: */
     if (vsmt_user) {
         if (spapr->vsmt < smp_threads) {
             error_setg(errp, "Cannot support VSMT mode %d"
@@ -3086,7 +3086,7 @@ static int spapr_kvm_type(MachineState *machine, const char *vm_type)
 {
     /*
      * The use of g_ascii_strcasecmp() for 'hv' and 'pr' is to
-     * accomodate the 'HV' and 'PV' formats that exists in the
+     * accommodate the 'HV' and 'PV' formats that exists in the
      * wild. The 'auto' mode is being introduced already as
      * lower-case, thus we don't need to bother checking for
      * "AUTO".
@@ -4320,7 +4320,7 @@ spapr_cpu_index_to_props(MachineState *machine, unsigned cpu_index)
     CPUArchId *core_slot;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
 
-    /* make sure possible_cpu are intialized */
+    /* make sure possible_cpu are initialized */
     mc->possible_cpu_arch_ids(machine);
     /* get CPU core slot containing thread that matches cpu_index */
     core_slot = spapr_find_cpu_slot(machine, cpu_index, NULL);
@@ -5011,7 +5011,7 @@ static void spapr_machine_2_12_class_options(MachineClass *mc)
 
     /* We depend on kvm_enabled() to choose a default value for the
      * hpt-max-page-size capability. Of course we can't do it here
-     * because this is too early and the HW accelerator isn't initialzed
+     * because this is too early and the HW accelerator isn't initialized
      * yet. Postpone this to machine init (see default_caps_with_cpu()).
      */
     smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = 0;
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 002ea0b7c1..aef198abf3 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1558,7 +1558,7 @@ static void hypercall_register_types(void)
     spapr_register_hypercall(H_GET_CPU_CHARACTERISTICS,
                              h_get_cpu_characteristics);
 
-    /* "debugger" hcalls (also used by SLOF). Note: We do -not- differenciate
+    /* "debugger" hcalls (also used by SLOF). Note: We do -not- differentiate
      * here between the "CI" and the "CACHE" variants, they will use whatever
      * mapping attributes qemu is using. When using KVM, the kernel will
      * enforce the attributes more strongly
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index a8688243a6..4e34545dcf 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -377,7 +377,7 @@ static target_ulong h_scm_bind_mem(PowerPCCPU *cpu, SpaprMachineState *spapr,
 
     /*
      * Currently continue token should be zero qemu has already bound
-     * everything and this hcall doesnt return H_BUSY.
+     * everything and this hcall doesn't return H_BUSY.
      */
     if (continue_token > 0) {
         return H_P5;
@@ -588,7 +588,7 @@ void spapr_nvdimm_finish_flushes(void)
      * Called on reset path, the main loop thread which calls
      * the pending BHs has gotten out running in the reset path,
      * finally reaching here. Other code path being guest
-     * h_client_architecture_support, thats early boot up.
+     * h_client_architecture_support, that's early boot up.
      */
     nvdimms = nvdimm_get_device_list();
     for (list = nvdimms; list; list = list->next) {
diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index d8aeee0b7e..12e7790cf6 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -39,7 +39,7 @@ static void spapr_phb_vfio_eeh_reenable(SpaprPhbState *sphb)
 void spapr_phb_vfio_reset(DeviceState *qdev)
 {
     /*
-     * The PE might be in frozen state. To reenable the EEH
+     * The PE might be in frozen state. To re-enable the EEH
      * functionality on it will clean the frozen state, which
      * ensures that the contained PCI devices will work properly
      * after reboot.
@@ -78,7 +78,7 @@ int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
          * call. Now we just need to check the validity of the PCI
          * pass-through devices (vfio-pci) under this sphb bus.
          * We have already validated that all the devices under this sphb
-         * are from same iommu group (within same PE) before comming here.
+         * are from same iommu group (within same PE) before coming here.
          *
          * Prior to linux commit 98ba956f6a389 ("powerpc/pseries/eeh:
          * Rework device EEH PE determination") kernel would call
@@ -144,7 +144,7 @@ static void spapr_phb_vfio_eeh_clear_dev_msix(PCIBus *bus,
 
     /*
      * The MSIx table will be cleaned out by reset. We need
-     * disable it so that it can be reenabled properly. Also,
+     * disable it so that it can be re-enabled properly. Also,
      * the cached MSIx table should be cleared as it's not
      * reflecting the contents in hardware.
      */
diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index fdc6c441bb..d2898f8d18 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -2,7 +2,7 @@
  * Machine for remote device
  *
  *  This machine type is used by the remote device process in multi-process
- *  QEMU. QEMU device models depend on parent busses, interrupt controllers,
+ *  QEMU. QEMU device models depend on parent buses, interrupt controllers,
  *  memory regions, etc. The remote machine type offers this environment so
  *  that QEMU device models can be used as remote devices.
  *
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index e81bbd12df..b775aa8946 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -659,7 +659,7 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_id = "microchip.icicle.kit.ram";
 
     /*
-     * Map 513 MiB high memory, the mimimum required high memory size, because
+     * Map 513 MiB high memory, the minimum required high memory size, because
      * HSS will do memory test against the high memory address range regardless
      * of physical memory installed.
      *
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d90286dc46..a0c2cbce89 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -66,13 +66,13 @@
 #define VIRT_IMSIC_GROUP_MAX_SIZE      (1U << IMSIC_MMIO_GROUP_MIN_SHIFT)
 #if VIRT_IMSIC_GROUP_MAX_SIZE < \
     IMSIC_GROUP_SIZE(VIRT_CPUS_MAX_BITS, VIRT_IRQCHIP_MAX_GUESTS_BITS)
-#error "Can't accomodate single IMSIC group in address space"
+#error "Can't accommodate single IMSIC group in address space"
 #endif
 
 #define VIRT_IMSIC_MAX_SIZE            (VIRT_SOCKETS_MAX * \
                                         VIRT_IMSIC_GROUP_MAX_SIZE)
 #if 0x4000000 < VIRT_IMSIC_MAX_SIZE
-#error "Can't accomodate all IMSIC groups in address space"
+#error "Can't accommodate all IMSIC groups in address space"
 #endif
 
 static const MemMapEntry virt_memmap[] = {
diff --git a/hw/rtc/exynos4210_rtc.c b/hw/rtc/exynos4210_rtc.c
index 2b8a38a296..cc7101c530 100644
--- a/hw/rtc/exynos4210_rtc.c
+++ b/hw/rtc/exynos4210_rtc.c
@@ -202,7 +202,7 @@ static void exynos4210_rtc_update_freq(Exynos4210RTCState *s,
     uint32_t freq;
 
     freq = s->freq;
-    /* set frequncy for time generator */
+    /* set frequency for time generator */
     s->freq = RTC_BASE_FREQ / (1 << TICCKSEL(reg_value));
 
     if (freq != s->freq) {
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index 3e887a0fc7..d00fcb0ef0 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -114,7 +114,7 @@ static const uint8_t ipr_table[NR_IRQS] = {
 };
 
 /*
- * Level triggerd IRQ list
+ * Level triggered IRQ list
  * Not listed IRQ is Edge trigger.
  * See "11.3.1 Interrupt Vector Table" in hardware manual.
  */
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index f7d45b0b20..634ed49c2e 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -1321,7 +1321,7 @@ again:
                 }
                 trace_lsi_execute_script_io_selected(id,
                                              insn & (1 << 3) ? " ATN" : "");
-                /* ??? Linux drivers compain when this is set.  Maybe
+                /* ??? Linux drivers complain when this is set.  Maybe
                    it only applies in low-level mode (unimplemented).
                 lsi_script_scsi_interrupt(s, LSI_SIST0_CMP, 0); */
                 s->select_tag = id << 8;
diff --git a/hw/scsi/mfi.h b/hw/scsi/mfi.h
index 0b4ee53dfc..cf7a2d775b 100644
--- a/hw/scsi/mfi.h
+++ b/hw/scsi/mfi.h
@@ -65,7 +65,7 @@
 #define MFI_IQPH        0xc4            /* Inbound queue port (high bytes)  */
 #define MFI_DIAG        0xf8            /* Host diag */
 #define MFI_SEQ         0xfc            /* Sequencer offset */
-#define MFI_1078_EIM    0x80000004      /* 1078 enable intrrupt mask  */
+#define MFI_1078_EIM    0x80000004      /* 1078 enable interrupt mask  */
 #define MFI_RMI         0x2             /* reply message interrupt  */
 #define MFI_1078_RM     0x80000000      /* reply 1078 message interrupt  */
 #define MFI_ODC         0x4             /* outbound doorbell change interrupt */
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 77a717d355..43c374e829 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1224,7 +1224,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         }
         break;
 
-    /* Block read commands (Classs 2) */
+    /* Block read commands (Class 2) */
     case 16:  /* CMD16:  SET_BLOCKLEN */
         switch (sd->state) {
         case sd_transfer_state:
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 6811f0f1a8..dda4c4c438 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1805,7 +1805,7 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
          * on i.MX, but since it is not used by QEMU we do not care.
          *
          * We don't want to call sdhci_write(.., SDHC_TRNMOD, ...)
-         * here becuase it will result in a call to
+         * here because it will result in a call to
          * sdhci_send_command(s) which we don't want.
          *
          */
diff --git a/hw/sensor/isl_pmbus_vr.c b/hw/sensor/isl_pmbus_vr.c
index eb344dd5a9..e51269f6b8 100644
--- a/hw/sensor/isl_pmbus_vr.c
+++ b/hw/sensor/isl_pmbus_vr.c
@@ -101,7 +101,7 @@ static void isl_pmbus_vr_exit_reset(Object *obj)
     }
 }
 
-/* The raa228000 uses different direct mode coefficents from most isl devices */
+/* The raa228000 uses different direct mode coefficients from most isl devices */
 static void raa228000_exit_reset(Object *obj)
 {
     PMBusDevice *pmdev = PMBUS_DEVICE(obj);
diff --git a/hw/sensor/max34451.c b/hw/sensor/max34451.c
index a91d8bd487..9db52ef677 100644
--- a/hw/sensor/max34451.c
+++ b/hw/sensor/max34451.c
@@ -734,7 +734,7 @@ static void max34451_init(Object *obj)
 
     /*
      * get and set the temperature of the internal temperature sensor in
-     * centidegrees Celcius i.e.: 2500 -> 25.00 C, max is 327.67 C
+     * centidegrees Celsius i.e.: 2500 -> 25.00 C, max is 327.67 C
      */
     for (int i = 0; i < MAX34451_NUM_TEMP_DEVICES; i++) {
         object_property_add(obj, "temperature[*]", "uint16",
diff --git a/hw/sh4/sh7750_regs.h b/hw/sh4/sh7750_regs.h
index 94043431e6..edb5d18f00 100644
--- a/hw/sh4/sh7750_regs.h
+++ b/hw/sh4/sh7750_regs.h
@@ -113,7 +113,7 @@
 #define SH7750_TTB            SH7750_P4_REG32(SH7750_TTB_REGOFS)
 #define SH7750_TTB_A7         SH7750_A7_REG32(SH7750_TTB_REGOFS)
 
-/* TLB exeption address register - TEA */
+/* TLB exception address register - TEA */
 #define SH7750_TEA_REGOFS     0x00000c /* offset */
 #define SH7750_TEA            SH7750_P4_REG32(SH7750_TEA_REGOFS)
 #define SH7750_TEA_A7         SH7750_A7_REG32(SH7750_TEA_REGOFS)
@@ -183,19 +183,19 @@
 #define SH7750_TRA_IMM      0x000003fd /* Immediate data operand */
 #define SH7750_TRA_IMM_S    2
 
-/* Exeption event register - EXPEVT */
+/* Exception event register - EXPEVT */
 #define SH7750_EXPEVT_REGOFS  0x000024
 #define SH7750_EXPEVT         SH7750_P4_REG32(SH7750_EXPEVT_REGOFS)
 #define SH7750_EXPEVT_A7      SH7750_A7_REG32(SH7750_EXPEVT_REGOFS)
 
-#define SH7750_EXPEVT_EX      0x00000fff /* Exeption code */
+#define SH7750_EXPEVT_EX      0x00000fff /* Exception code */
 #define SH7750_EXPEVT_EX_S    0
 
 /* Interrupt event register */
 #define SH7750_INTEVT_REGOFS  0x000028
 #define SH7750_INTEVT         SH7750_P4_REG32(SH7750_INTEVT_REGOFS)
 #define SH7750_INTEVT_A7      SH7750_A7_REG32(SH7750_INTEVT_REGOFS)
-#define SH7750_INTEVT_EX    0x00000fff /* Exeption code */
+#define SH7750_INTEVT_EX    0x00000fff /* Exception code */
 #define SH7750_INTEVT_EX_S  0
 
 /*
@@ -1274,15 +1274,15 @@
 /*
  * User Break Controller registers
  */
-#define SH7750_BARA           0x200000 /* Break address regiser A */
-#define SH7750_BAMRA          0x200004 /* Break address mask regiser A */
-#define SH7750_BBRA           0x200008 /* Break bus cycle regiser A */
-#define SH7750_BARB           0x20000c /* Break address regiser B */
-#define SH7750_BAMRB          0x200010 /* Break address mask regiser B */
-#define SH7750_BBRB           0x200014 /* Break bus cycle regiser B */
-#define SH7750_BASRB          0x000018 /* Break ASID regiser B */
-#define SH7750_BDRB           0x200018 /* Break data regiser B */
-#define SH7750_BDMRB          0x20001c /* Break data mask regiser B */
+#define SH7750_BARA           0x200000 /* Break address register A */
+#define SH7750_BAMRA          0x200004 /* Break address mask register A */
+#define SH7750_BBRA           0x200008 /* Break bus cycle register A */
+#define SH7750_BARB           0x20000c /* Break address register B */
+#define SH7750_BAMRB          0x200010 /* Break address mask register B */
+#define SH7750_BBRB           0x200014 /* Break bus cycle register B */
+#define SH7750_BASRB          0x000018 /* Break ASID register B */
+#define SH7750_BDRB           0x200018 /* Break data register B */
+#define SH7750_BDMRB          0x20001c /* Break data mask register B */
 #define SH7750_BRCR           0x200020 /* Break control register */
 
 #define SH7750_BRCR_UDBE        0x0001 /* User break debug enable bit */
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 10cd22f610..b753705856 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -1110,7 +1110,7 @@ void smbios_get_tables(MachineState *ms,
         dimm_cnt = QEMU_ALIGN_UP(current_machine->ram_size, MAX_DIMM_SZ) / MAX_DIMM_SZ;
 
         /*
-         * The offset determines if we need to keep additional space betweeen
+         * The offset determines if we need to keep additional space between
          * table 17 and table 19 header handle numbers so that they do
          * not overlap. For example, for a VM with larger than 8 TB guest
          * memory and DIMM like chunks of 16 GiB, the default space between
diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index 71f5465249..eb40f9377c 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -96,10 +96,10 @@
 #define IOMMU_AER_SBW       0x80000000    /* S-to-M asynchronous writes */
 #define IOMMU_AER_MASK      0x801f000f
 
-#define IOMMU_SBCFG0        (0x1010 >> 2) /* SBUS configration per-slot */
-#define IOMMU_SBCFG1        (0x1014 >> 2) /* SBUS configration per-slot */
-#define IOMMU_SBCFG2        (0x1018 >> 2) /* SBUS configration per-slot */
-#define IOMMU_SBCFG3        (0x101c >> 2) /* SBUS configration per-slot */
+#define IOMMU_SBCFG0        (0x1010 >> 2) /* SBUS configuration per-slot */
+#define IOMMU_SBCFG1        (0x1014 >> 2) /* SBUS configuration per-slot */
+#define IOMMU_SBCFG2        (0x1018 >> 2) /* SBUS configuration per-slot */
+#define IOMMU_SBCFG3        (0x101c >> 2) /* SBUS configuration per-slot */
 #define IOMMU_SBCFG_SAB30   0x00010000 /* Phys-address bit 30 when
                                           bypass enabled */
 #define IOMMU_SBCFG_BA16    0x00000004 /* Slave supports 16 byte bursts */
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 97009d3a5d..a3955c6c50 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -163,7 +163,7 @@
     FIELD(GQSPI_CNFG, ENDIAN, 26, 1)
     /* Poll timeout not implemented */
     FIELD(GQSPI_CNFG, EN_POLL_TIMEOUT, 20, 1)
-    /* QEMU doesnt care about any of these last three */
+    /* QEMU doesn't care about any of these last three */
     FIELD(GQSPI_CNFG, BR, 3, 3)
     FIELD(GQSPI_CNFG, CPH, 2, 1)
     FIELD(GQSPI_CNFG, CPL, 1, 1)
@@ -469,7 +469,7 @@ static void xlnx_zynqmp_qspips_flush_fifo_g(XlnxZynqMPQSPIPS *s)
 
             imm = ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, IMMEDIATE_DATA);
             if (!ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, DATA_XFER)) {
-                /* immedate transfer */
+                /* immediate transfer */
                 if (ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, TRANSMIT) ||
                     ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, RECIEVE)) {
                     s->regs[R_GQSPI_DATA_STS] = 1;
@@ -768,7 +768,7 @@ static void xilinx_spips_check_zero_pump(XilinxSPIPS *s)
      */
     while (s->regs[R_TRANSFER_SIZE] &&
            s->rx_fifo.num + s->tx_fifo.num < RXFF_A_Q - 3) {
-        /* endianess just doesn't matter when zero pumping */
+        /* endianness just doesn't matter when zero pumping */
         tx_data_bytes(&s->tx_fifo, 0, 4, false);
         s->regs[R_TRANSFER_SIZE] &= ~0x03ull;
         s->regs[R_TRANSFER_SIZE] -= 4;
diff --git a/hw/ssi/xlnx-versal-ospi.c b/hw/ssi/xlnx-versal-ospi.c
index c762e0b367..1a61679c2f 100644
--- a/hw/ssi/xlnx-versal-ospi.c
+++ b/hw/ssi/xlnx-versal-ospi.c
@@ -837,7 +837,7 @@ static void ospi_do_ind_read(XlnxVersalOspi *s)
     /* Continue to read flash until we run out of space in sram */
     while (!ospi_ind_op_completed(op) &&
            !fifo8_is_full(&s->rx_sram)) {
-        /* Read reqested number of bytes, max bytes limited to size of sram */
+        /* Read requested number of bytes, max bytes limited to size of sram */
         next_b = ind_op_next_byte(op);
         end_b = next_b + fifo8_num_free(&s->rx_sram);
         end_b = MIN(end_b, ind_op_end_byte(op));
diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
index 2d6d92ef93..f035b74560 100644
--- a/hw/timer/etraxfs_timer.c
+++ b/hw/timer/etraxfs_timer.c
@@ -236,7 +236,7 @@ static void watchdog_hit(void *opaque)
 {
     ETRAXTimerState *t = opaque;
     if (t->wd_hits == 0) {
-        /* real hw gives a single tick before reseting but we are
+        /* real hw gives a single tick before resetting but we are
            a bit friendlier to compensate for our slower execution.  */
         ptimer_set_count(t->ptimer_wd, 10);
         ptimer_run(t->ptimer_wd, 1);
diff --git a/hw/timer/i8254.c b/hw/timer/i8254.c
index c235496fc9..dd13bdfa42 100644
--- a/hw/timer/i8254.c
+++ b/hw/timer/i8254.c
@@ -295,7 +295,7 @@ static void pit_reset(DeviceState *dev)
 }
 
 /* When HPET is operating in legacy mode, suppress the ignored timer IRQ,
- * reenable it when legacy mode is left again. */
+ * re-enable it when legacy mode is left again. */
 static void pit_irq_control(void *opaque, int n, int enable)
 {
     PITCommonState *pit = opaque;
diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
index c15f654738..43b31213bc 100644
--- a/hw/timer/renesas_tmr.c
+++ b/hw/timer/renesas_tmr.c
@@ -115,7 +115,7 @@ static int elapsed_time(RTMRState *tmr, int ch, int64_t delta)
         et = tmr->div_round[ch] / divrate;
         tmr->div_round[ch] %= divrate;
     } else {
-        /* disble clock. so no update */
+        /* disable clock. so no update */
         et = 0;
     }
     return et;
diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
index 6f29a508dd..6f14896b97 100644
--- a/hw/tpm/tpm_tis.h
+++ b/hw/tpm/tpm_tis.h
@@ -19,7 +19,7 @@
  * specification.
  *
  * TPM TIS for TPM 2 implementation following TCG PC Client Platform
- * TPM Profile (PTP) Specification, Familiy 2.0, Revision 00.43
+ * TPM Profile (PTP) Specification, Family 2.0, Revision 00.43
  */
 #ifndef TPM_TPM_TIS_H
 #define TPM_TPM_TIS_H
diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
index c07c179dbc..279ce436b5 100644
--- a/hw/tpm/tpm_tis_common.c
+++ b/hw/tpm/tpm_tis_common.c
@@ -20,7 +20,7 @@
  * specification.
  *
  * TPM TIS for TPM 2 implementation following TCG PC Client Platform
- * TPM Profile (PTP) Specification, Familiy 2.0, Revision 00.43
+ * TPM Profile (PTP) Specification, Family 2.0, Revision 00.43
  */
 #include "qemu/osdep.h"
 #include "hw/irq.h"
diff --git a/hw/tpm/tpm_tis_i2c.c b/hw/tpm/tpm_tis_i2c.c
index b695fd3a46..4ecea7fa3e 100644
--- a/hw/tpm/tpm_tis_i2c.c
+++ b/hw/tpm/tpm_tis_i2c.c
@@ -13,7 +13,7 @@
  * Family 2.0, Level 00, Revision 1.00
  *
  * TPM TIS for TPM 2 implementation following TCG PC Client Platform
- * TPM Profile (PTP) Specification, Familiy 2.0, Revision 00.43
+ * TPM Profile (PTP) Specification, Family 2.0, Revision 00.43
  *
  */
 
@@ -507,7 +507,7 @@ static void tpm_tis_i2c_realizefn(DeviceState *dev, Error **errp)
     }
 
     /*
-     * Get the backend pointer. It is not initialized propery during
+     * Get the backend pointer. It is not initialized properly during
      * device_class_set_props
      */
     s->be_driver = qemu_find_tpm_be("tpm0");
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 91e3792248..0367401586 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -19,7 +19,7 @@
  * specification.
  *
  * TPM TIS for TPM 2 implementation following TCG PC Client Platform
- * TPM Profile (PTP) Specification, Familiy 2.0, Revision 00.43
+ * TPM Profile (PTP) Specification, Family 2.0, Revision 00.43
  */
 
 #include "qemu/osdep.h"
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index 45e63efd63..6754ade8bd 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -19,7 +19,7 @@
  * specification.
  *
  * TPM TIS for TPM 2 implementation following TCG PC Client Platform
- * TPM Profile (PTP) Specification, Familiy 2.0, Revision 00.43
+ * TPM Profile (PTP) Specification, Family 2.0, Revision 00.43
  */
 
 #include "qemu/osdep.h"
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index c328660075..3ee9c73b87 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -518,7 +518,7 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
         goto out2;
     }
 
-    /* TODO: a passthru backened that works on local machine. third card type?*/
+    /* TODO: a passthru backend that works on local machine. third card type?*/
     if (card->backend == BACKEND_CERTIFICATES) {
         if (card->cert1 != NULL && card->cert2 != NULL && card->cert3 != NULL) {
             ret = emulated_initialize_vcard_from_certificates(card);
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index c930c60921..19b4534c20 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -1464,7 +1464,7 @@ static int ehci_process_itd(EHCIState *ehci,
                     usb_handle_packet(dev, &ehci->ipacket);
                     usb_packet_unmap(&ehci->ipacket, &ehci->isgl);
                 } else {
-                    DPRINTF("ISOCH: attempt to addess non-iso endpoint\n");
+                    DPRINTF("ISOCH: attempt to address non-iso endpoint\n");
                     ehci->ipacket.status = USB_RET_NAK;
                     ehci->ipacket.actual_length = 0;
                 }
@@ -1513,7 +1513,7 @@ static int ehci_process_itd(EHCIState *ehci,
 
 
 /*  This state is the entry point for asynchronous schedule
- *  processing.  Entry here consitutes a EHCI start event state (4.8.5)
+ *  processing.  Entry here constitutes a EHCI start event state (4.8.5)
  */
 static int ehci_state_waitlisthead(EHCIState *ehci,  int async)
 {
@@ -2458,7 +2458,7 @@ static void usb_ehci_vm_state_change(void *opaque, bool running, RunState state)
     /*
      * The schedule rebuilt from guest memory could cause the migration dest
      * to miss a QH unlink, and fail to cancel packets, since the unlinked QH
-     * will never have existed on the destination. Therefor we must flush the
+     * will never have existed on the destination. Therefore we must flush the
      * async schedule on savevm to catch any not yet noticed unlinks.
      */
     if (state == RUN_STATE_SAVE_VM) {
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index cc5cde6983..7ff1b65ced 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -1355,7 +1355,7 @@ static uint32_t ohci_get_frame_remaining(OHCIState *ohci)
     if ((ohci->ctl & OHCI_CTL_HCFS) != OHCI_USB_OPERATIONAL) {
         return ohci->frt << 31;
     }
-    /* Being in USB operational state guarnatees sof_time was set already. */
+    /* Being in USB operational state guarantees sof_time was set already. */
     tks = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - ohci->sof_time;
     if (tks < 0) {
         tks = 0;
diff --git a/hw/usb/quirks.h b/hw/usb/quirks.h
index c3e595f40b..94b2c95341 100644
--- a/hw/usb/quirks.h
+++ b/hw/usb/quirks.h
@@ -67,7 +67,7 @@ static const struct usb_device_id usbredir_raw_serial_ids[] = {
     { USB_DEVICE(0x10C4, 0x800A) }, /* SPORTident BSM7-D-USB main station */
     { USB_DEVICE(0x10C4, 0x803B) }, /* Pololu USB-serial converter */
     { USB_DEVICE(0x10C4, 0x8044) }, /* Cygnal Debug Adapter */
-    { USB_DEVICE(0x10C4, 0x804E) }, /* Software Bisque Paramount ME build-in converter */
+    { USB_DEVICE(0x10C4, 0x804E) }, /* Software Bisque Paramount ME built-in converter */
     { USB_DEVICE(0x10C4, 0x8053) }, /* Enfora EDG1228 */
     { USB_DEVICE(0x10C4, 0x8054) }, /* Enfora GSM2228 */
     { USB_DEVICE(0x10C4, 0x8066) }, /* Argussoft In-System Programmer */
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 39fbaaab16..0e256c1eca 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -471,7 +471,7 @@ static int bufp_alloc(USBRedirDevice *dev, uint8_t *data, uint16_t len,
         DPRINTF("bufpq overflow, dropping packets ep %02X\n", ep);
         dev->endpoint[EP2I(ep)].bufpq_dropping_packets = 1;
     }
-    /* Since we're interupting the stream anyways, drop enough packets to get
+    /* Since we're interrupting the stream anyways, drop enough packets to get
        back to our target buffer size */
     if (dev->endpoint[EP2I(ep)].bufpq_dropping_packets) {
         if (dev->endpoint[EP2I(ep)].bufpq_size >
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index 6bb9655c8d..ed7dc210d3 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -248,7 +248,7 @@ usb_set_device_feature(int addr, int feature, int ret) "dev %d, feature %d, ret
 
 # dev-hub.c
 usb_hub_reset(int addr) "dev %d"
-usb_hub_control(int addr, int request, int value, int index, int length) "dev %d, req 0x%x, value %d, index %d, langth %d"
+usb_hub_control(int addr, int request, int value, int index, int length) "dev %d, req 0x%x, value %d, index %d, length %d"
 usb_hub_get_port_status(int addr, int nr, int status, int changed) "dev %d, port %d, status 0x%x, changed 0x%x"
 usb_hub_set_port_feature(int addr, int nr, const char *f) "dev %d, port %d, feature %s"
 usb_hub_clear_port_feature(int addr, int nr, const char *f) "dev %d, port %d, feature %s"
diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index 38ee660a30..09ec326aea 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -451,7 +451,7 @@ static int usbback_check_and_submit(struct usbback_req *usbback_req)
     wValue = le16_to_cpu(ctrl->wValue);
 
     /*
-     * When the device is first connected or resetted, USB device has no
+     * When the device is first connected or reset, USB device has no
      * address. In this initial state, following requests are sent to device
      * address (#0),
      *
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 44faf5a522..e9bc5695cf 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -650,7 +650,7 @@ virtio_crypto_sym_op_helper(VirtIODevice *vdev,
     op_info->len_to_hash = len_to_hash;
     op_info->cipher_start_src_offset = cipher_start_src_offset;
     op_info->len_to_cipher = len_to_cipher;
-    /* Handle the initilization vector */
+    /* Handle the initialization vector */
     if (op_info->iv_len > 0) {
         DPRINTF("iv_len=%" PRIu32 "\n", op_info->iv_len);
         op_info->iv = op_info->data + curr_size;
@@ -1273,7 +1273,7 @@ static void virtio_crypto_instance_init(Object *obj)
 
     /*
      * The default config_size is sizeof(struct virtio_crypto_config).
-     * Can be overriden with virtio_crypto_set_config_size.
+     * Can be overridden with virtio_crypto_set_config_size.
      */
     vcrypto->config_size = sizeof(struct virtio_crypto_config);
 }
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index ec0ae32589..3992217d82 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1090,7 +1090,7 @@ static int virtio_mem_mig_sanity_checks_post_load(void *opaque, int version_id)
         return -EINVAL;
     }
     /*
-     * Note: Preparation for resizeable memory regions. The maximum size
+     * Note: Preparation for resizable memory regions. The maximum size
      * of the memory region must not change during migration.
      */
     if (tmp->region_size != new_region_size) {
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 295a603e58..c85ce8ac47 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2096,7 +2096,7 @@ void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index)
      * being converted to LOG_GUEST_ERROR.
      *
     if (!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-        error_report("queue_enable is only suppported in devices of virtio "
+        error_report("queue_enable is only supported in devices of virtio "
                      "1.0 or later.");
     }
     */
diff --git a/hw/xen/xen_pvdev.c b/hw/xen/xen_pvdev.c
index be1504b82c..c5ad71e8dc 100644
--- a/hw/xen/xen_pvdev.c
+++ b/hw/xen/xen_pvdev.c
@@ -89,7 +89,7 @@ char *xenstore_read_str(const char *base, const char *node)
     str = qemu_xen_xs_read(xenstore, 0, abspath, &len);
     if (str != NULL) {
         /* move to qemu-allocated memory to make sure
-         * callers can savely g_free() stuff. */
+         * callers can safely g_free() stuff. */
         ret = g_strdup(str);
         free(str);
     }
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 74195c3004..e09d277328 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -418,7 +418,7 @@ struct BlockDriver {
 
     /**
      * Called to inform the driver that the set of cumulative set of used
-     * permissions for @bs has changed to @perm, and the set of sharable
+     * permissions for @bs has changed to @perm, and the set of shareable
      * permission to @shared. The driver can use this to propagate changes to
      * its children (i.e. request permissions only if a parent actually needs
      * them).
diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 8c420fa36e..82a2a92602 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -78,7 +78,7 @@ bool qemu_chr_fe_backend_open(CharBackend *be);
  *             is not supported and will not be attempted
  * @opaque: an opaque pointer for the callbacks
  * @context: a main loop context or NULL for the default
- * @set_open: whether to call qemu_chr_fe_set_open() implicitely when
+ * @set_open: whether to call qemu_chr_fe_set_open() implicitly when
  * any of the handler is non-NULL
  * @sync_state: whether to issue event callback with updated state
  *
@@ -138,7 +138,7 @@ void qemu_chr_fe_disconnect(CharBackend *be);
 /**
  * qemu_chr_fe_wait_connected:
  *
- * Wait for characted backend to be connected, return < 0 on error or
+ * Wait for character backend to be connected, return < 0 on error or
  * if no associated Chardev.
  */
 int qemu_chr_fe_wait_connected(CharBackend *be, Error **errp);
diff --git a/include/crypto/akcipher.h b/include/crypto/akcipher.h
index 214e58ca47..8756105f22 100644
--- a/include/crypto/akcipher.h
+++ b/include/crypto/akcipher.h
@@ -30,7 +30,7 @@ typedef struct QCryptoAkCipher QCryptoAkCipher;
  * qcrypto_akcipher_supports:
  * @opts: the asymmetric key algorithm and related options
  *
- * Determine if asymmetric key cipher decribed with @opts is
+ * Determine if asymmetric key cipher described with @opts is
  * supported by the current configured build
  *
  * Returns: true if it is supported, false otherwise.
diff --git a/include/crypto/ivgen.h b/include/crypto/ivgen.h
index e41521519c..a09d5732da 100644
--- a/include/crypto/ivgen.h
+++ b/include/crypto/ivgen.h
@@ -32,7 +32,7 @@
  * sector.
  *
  * <example>
- *   <title>Encrypting block data with initialiation vectors</title>
+ *   <title>Encrypting block data with initialization vectors</title>
  *   <programlisting>
  * uint8_t *data = ....data to encrypt...
  * size_t ndata = XXX;
@@ -147,7 +147,7 @@ QCryptoIVGen *qcrypto_ivgen_new(QCryptoIVGenAlgorithm alg,
  * @niv: the number of bytes in @iv
  * @errp: pointer to a NULL-initialized error object
  *
- * Calculate a new initialiation vector for the data
+ * Calculate a new initialization vector for the data
  * to be stored in sector @sector. The IV will be
  * written into the buffer @iv of size @niv.
  *
diff --git a/include/elf.h b/include/elf.h
index 2f4d0e56d1..7bbd419205 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -1097,9 +1097,9 @@ typedef struct {
 #define EFA_PARISC_1_1      0x0210 /* PA-RISC 1.1 big-endian.  */
 #define EFA_PARISC_2_0      0x0214 /* PA-RISC 2.0 big-endian.  */
 
-/* Additional section indeces.  */
+/* Additional section indices.  */
 
-#define SHN_PARISC_ANSI_COMMON  0xff00   /* Section for tenatively declared
+#define SHN_PARISC_ANSI_COMMON  0xff00   /* Section for tentatively declared
                                               symbols in ANSI C.  */
 #define SHN_PARISC_HUGE_COMMON  0xff01   /* Common blocks in huge model.  */
 
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 7f5c11a0cc..68284428f8 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -942,7 +942,7 @@ struct MemoryListener {
      *
      * @listener: The #MemoryListener.
      * @last_stage: The last stage to synchronize the log during migration.
-     * The caller should gurantee that the synchronization with true for
+     * The caller should guarantee that the synchronization with true for
      * @last_stage is triggered for once after all VCPUs have been stopped.
      */
     void (*log_sync_global)(MemoryListener *listener, bool last_stage);
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index d1fb08514b..ff2a310270 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -277,7 +277,7 @@ void free_aml_allocator(void);
  * @child: element that is copied into @parent_ctx context
  *
  * Joins Aml elements together and helps to construct AML tables
- * Examle of usage:
+ * Example of usage:
  *   Aml *table = aml_def_block("SSDT", ...);
  *   Aml *sb = aml_scope("\\_SB");
  *   Aml *dev = aml_device("PCI0");
diff --git a/include/hw/acpi/pc-hotplug.h b/include/hw/acpi/pc-hotplug.h
index 31bc9191c3..8a654248e9 100644
--- a/include/hw/acpi/pc-hotplug.h
+++ b/include/hw/acpi/pc-hotplug.h
@@ -13,7 +13,7 @@
 #define PC_HOTPLUG_H
 
 /*
- * ONLY DEFINEs are permited in this file since it's shared
+ * ONLY DEFINEs are permitted in this file since it's shared
  * between C and ASL code.
  */
 
diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
index dc8bb3433e..fb135d5bcb 100644
--- a/include/hw/acpi/vmgenid.h
+++ b/include/hw/acpi/vmgenid.h
@@ -13,7 +13,7 @@
 
 #define VMGENID_FW_CFG_SIZE      4096 /* Occupy a page of memory */
 #define VMGENID_GUID_OFFSET      40   /* allow space for
-                                       * OVMF SDT Header Probe Supressor
+                                       * OVMF SDT Header Probe Suppressor
                                        */
 
 OBJECT_DECLARE_SIMPLE_TYPE(VmGenIdState, VMGENID)
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 54ea2f0890..fcce6421c8 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -165,7 +165,7 @@ enum FslIMX7MemoryMap {
      * Some versions of the reference manual claim that UART2 is @
      * 0x30870000, but experiments with HW + DT files in upstream
      * Linux kernel show that not to be true and that block is
-     * acutally located @ 0x30890000
+     * actually located @ 0x30890000
      */
     FSL_IMX7_UART2_ADDR           = 0x30890000,
     FSL_IMX7_UART3_ADDR           = 0x30880000,
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 12d9e9d17c..1700dbd621 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -157,7 +157,7 @@ typedef struct {
  *    any actions to be performed by hotplug handler.
  * @cpu_index_to_instance_props:
  *    used to provide @cpu_index to socket/core/thread number mapping, allowing
- *    legacy code to perform maping from cpu_index to topology properties
+ *    legacy code to perform mapping from cpu_index to topology properties
  *    Returns: tuple of socket/core/thread ids given cpu_index belongs to.
  *    used to provide @cpu_index to socket number mapping, allowing
  *    a machine to group CPU threads belonging to the same socket/package
@@ -210,10 +210,10 @@ typedef struct {
  *    the rejection.  If the hook is not provided, all hotplug will be
  *    allowed.
  * @default_ram_id:
- *    Specifies inital RAM MemoryRegion name to be used for default backend
+ *    Specifies initial RAM MemoryRegion name to be used for default backend
  *    creation if user explicitly hasn't specified backend with "memory-backend"
  *    property.
- *    It also will be used as a way to optin into "-m" option support.
+ *    It also will be used as a way to option into "-m" option support.
  *    If it's not set by board, '-m' will be ignored and generic code will
  *    not create default RAM MemoryRegion.
  * @fixup_ram_size:
diff --git a/include/hw/char/avr_usart.h b/include/hw/char/avr_usart.h
index 62eaa1528e..0cc599e9b1 100644
--- a/include/hw/char/avr_usart.h
+++ b/include/hw/char/avr_usart.h
@@ -34,7 +34,7 @@
 #define USART_BRRH 0x05
 #define USART_BRRL 0x04
 
-/* Relevant bits in regiters. */
+/* Relevant bits in registers. */
 #define USART_CSRA_RXC    (1 << 7)
 #define USART_CSRA_TXC    (1 << 6)
 #define USART_CSRA_DRE    (1 << 5)
diff --git a/include/hw/clock.h b/include/hw/clock.h
index 5c927cee7f..bb12117f67 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -204,7 +204,7 @@ static inline bool clock_set_ns(Clock *clk, unsigned ns)
  * Propagate the clock period that has been previously configured using
  * @clock_set(). This will update recursively all connected clocks.
  * It is an error to call this function on a clock which has a source.
- * Note: this function must not be called during device inititialization
+ * Note: this function must not be called during device initialization
  * or migration.
  */
 void clock_propagate(Clock *clk);
diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 3e8b1b737a..479713a36e 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -14,7 +14,7 @@
 
 struct TCGCPUOps {
     /**
-     * @initialize: Initalize TCG state
+     * @initialize: Initialize TCG state
      *
      * Called when the first CPU is realized.
      */
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 1978730fba..f717e3f384 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -208,7 +208,7 @@ void cxl_event_set_status(CXLDeviceState *cxl_dstate, CXLEventLogType log_type,
  * > is the maximum access size allowed for these registers. If this rule is not
  * > followed, the behavior is undefined
  *
- * CXL 2.0 Errata F4 states futher that the layouts in the specification are
+ * CXL 2.0 Errata F4 states further that the layouts in the specification are
  * shown as greater than 128 bits, but implementations are expected to
  * use any size of access up to 64 bits.
  *
diff --git a/include/hw/hyperv/vmbus.h b/include/hw/hyperv/vmbus.h
index 8ea660dd8e..5c505852f2 100644
--- a/include/hw/hyperv/vmbus.h
+++ b/include/hw/hyperv/vmbus.h
@@ -51,7 +51,7 @@ struct VMBusDeviceClass {
     uint16_t channel_flags;
     uint16_t mmio_size_mb;
 
-    /* Extentions to standard device callbacks */
+    /* Extensions to standard device callbacks */
     void (*vmdev_realize)(VMBusDevice *vdev, Error **errp);
     void (*vmdev_unrealize)(VMBusDevice *vdev);
     void (*vmdev_reset)(VMBusDevice *vdev);
diff --git a/include/hw/i2c/npcm7xx_smbus.h b/include/hw/i2c/npcm7xx_smbus.h
index 3555e6836f..dc45963c0e 100644
--- a/include/hw/i2c/npcm7xx_smbus.h
+++ b/include/hw/i2c/npcm7xx_smbus.h
@@ -58,7 +58,7 @@ typedef enum NPCM7xxSMBusStatus {
  * @sclht: The SCL high time register.
  * @fif_ctl: The FIFO control register.
  * @fif_cts: The FIFO control status register.
- * @fair_per: The fair preriod register.
+ * @fair_per: The fair period register.
  * @txf_ctl: The transmit FIFO control register.
  * @t_out: The SMBus timeout register.
  * @txf_sts: The transmit FIFO status register.
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 81573f6cfd..380cb27ded 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -31,7 +31,7 @@
  *
  * This code should be compatible with AMD's "Extended Method" described at:
  *   AMD CPUID Specification (Publication #25481)
- *   Section 3: Multiple Core Calcuation
+ *   Section 3: Multiple Core Calculation
  * as long as:
  *  nr_threads is set to 1;
  *  OFFSET_IDX is assumed to be 0;
diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
index 1ca262fbf8..6b4ae566c9 100644
--- a/include/hw/intc/armv7m_nvic.h
+++ b/include/hw/intc/armv7m_nvic.h
@@ -74,7 +74,7 @@ struct NVICState {
      */
     bool vectpending_is_s_banked;
     int exception_prio; /* group prio of the highest prio active exception */
-    int vectpending_prio; /* group prio of the exeception in vectpending */
+    int vectpending_prio; /* group prio of the exception in vectpending */
 
     MemoryRegion sysregmem;
 
diff --git a/include/hw/misc/auxbus.h b/include/hw/misc/auxbus.h
index b05799d2f7..03cacdee42 100644
--- a/include/hw/misc/auxbus.h
+++ b/include/hw/misc/auxbus.h
@@ -106,7 +106,7 @@ void aux_bus_realize(AUXBus *bus);
  *
  * Returns the reply of the request.
  *
- * @bus Ths bus where the request happen.
+ * @bus The bus where the request happen.
  * @cmd The command requested.
  * @address The 20bits address of the slave.
  * @len The length of the read or write.
diff --git a/include/hw/misc/macio/pmu.h b/include/hw/misc/macio/pmu.h
index ba76afb52a..ceb12082ae 100644
--- a/include/hw/misc/macio/pmu.h
+++ b/include/hw/misc/macio/pmu.h
@@ -76,7 +76,7 @@
 #define PMU_INT_WAITING_CHARGER    0x01    /* ??? */
 #define PMU_INT_AUTO_SRQ_POLL      0x02    /* ??? */
 
-/* Bits in the environement message (either obtained via PMU_GET_COVER,
+/* Bits in the environment message (either obtained via PMU_GET_COVER,
  * or via PMU_INT_ENVIRONMENT on core99 */
 #define PMU_ENV_LID_CLOSED     0x01    /* The lid is closed */
 
diff --git a/include/hw/net/mii.h b/include/hw/net/mii.h
index ed1bb52b0f..f7feddac9b 100644
--- a/include/hw/net/mii.h
+++ b/include/hw/net/mii.h
@@ -71,7 +71,7 @@
 #define MII_BMSR_JABBER     (1 << 1)  /* Jabber detected */
 #define MII_BMSR_EXTCAP     (1 << 0)  /* Ext-reg capability */
 
-#define MII_ANAR_PAUSE_ASYM (1 << 11) /* Try for asymetric pause */
+#define MII_ANAR_PAUSE_ASYM (1 << 11) /* Try for asymmetric pause */
 #define MII_ANAR_PAUSE      (1 << 10) /* Try for pause */
 #define MII_ANAR_TXFD       (1 << 8)
 #define MII_ANAR_TX         (1 << 7)
diff --git a/include/hw/pci-host/dino.h b/include/hw/pci-host/dino.h
index a1b0184940..fd7975c798 100644
--- a/include/hw/pci-host/dino.h
+++ b/include/hw/pci-host/dino.h
@@ -1,5 +1,5 @@
 /*
- * HP-PARISC Dino PCI chipset emulation, as in B160L and similiar machines
+ * HP-PARISC Dino PCI chipset emulation, as in B160L and similar machines
  *
  * (C) 2017-2019 by Helge Deller <deller@gmx.de>
  *
diff --git a/include/hw/pci/pcie_aer.h b/include/hw/pci/pcie_aer.h
index 1234fdc4e2..4a9f0ea69d 100644
--- a/include/hw/pci/pcie_aer.h
+++ b/include/hw/pci/pcie_aer.h
@@ -40,7 +40,7 @@ struct PCIEAERLog {
      * The specified value will be clipped down to PCIE_AER_LOG_MAX_LIMIT
      * to avoid unreasonable memory usage.
      * I bet that 128 log size would be big enough, otherwise too many errors
-     * for system to function normaly. But could consecutive errors occur?
+     * for system to function normally. But could consecutive errors occur?
      */
 #define PCIE_AER_LOG_MAX_DEFAULT        8
 #define PCIE_AER_LOG_MAX_LIMIT          128
diff --git a/include/hw/ppc/openpic.h b/include/hw/ppc/openpic.h
index bae8dafe16..9c6af8e207 100644
--- a/include/hw/ppc/openpic.h
+++ b/include/hw/ppc/openpic.h
@@ -14,7 +14,7 @@ enum {
     OPENPIC_OUTPUT_INT = 0, /* IRQ                       */
     OPENPIC_OUTPUT_CINT,    /* critical IRQ              */
     OPENPIC_OUTPUT_MCK,     /* Machine check event       */
-    OPENPIC_OUTPUT_DEBUG,   /* Inconditional debug event */
+    OPENPIC_OUTPUT_DEBUG,   /* Unconditional debug event */
     OPENPIC_OUTPUT_RESET,   /* Core reset event          */
     OPENPIC_OUTPUT_NB,
 };
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 538b2dfb89..658f9daaa1 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -197,7 +197,7 @@ struct SpaprMachineState {
     SpaprResizeHpt resize_hpt;
     void *htab;
     uint32_t htab_shift;
-    uint64_t patb_entry; /* Process tbl registed in H_REGISTER_PROC_TBL */
+    uint64_t patb_entry; /* Process tbl registered in H_REGISTER_PROC_TBL */
     SpaprPendingHpt *pending_hpt; /* in-progress resize */
 
     hwaddr rma_size;
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 884c726a87..b7fe35777e 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -35,7 +35,7 @@
  *
  * As an interim step, the #DeviceState.realized property can also be
  * set with qdev_realize(). In the future, devices will propagate this
- * state change to their children and along busses they expose. The
+ * state change to their children and along buses they expose. The
  * point in time will be deferred to machine creation, so that values
  * set in @realize will not be introspectable beforehand. Therefore
  * devices must not create children during @realize; they should
diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.h
index bbc21cdc9a..912b4a2682 100644
--- a/include/hw/riscv/riscv_hart.h
+++ b/include/hw/riscv/riscv_hart.h
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2017 SiFive, Inc.
  *
- * Holds the state of a heterogenous array of RISC-V harts
+ * Holds the state of a heterogeneous array of RISC-V harts
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index e0a9f9385b..b1bdbeaeb5 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -184,7 +184,7 @@ enum ZpciIoatDtype {
  * The following states make up the "configured" meta-state:
  * disabled: device is configured but not enabled; transition between this
  *           state and enabled via clp enable/disable
- * enbaled: device is ready for use; transition to disabled via clp disable;
+ * enabled: device is ready for use; transition to disabled via clp disable;
  *          may enter an error state
  * blocked: ignore all DMA and interrupts; transition back to enabled or from
  *          error state via mpcifc
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index d3ade40a5a..cf1f2efae2 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -87,7 +87,7 @@
  * - we work on a private copy of the SCCB, since there are several length
  *   fields, that would cause a security nightmare if we allow the guest to
  *   alter the structure while we parse it. We cannot use ldl_p and friends
- *   either without doing pointer arithmetics
+ *   either without doing pointer arithmetic
  * So we have to double check that all users of sclp data structures use the
  * right endianness wrappers.
  */
diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.h
index 06bfd18312..1386d5ac8f 100644
--- a/include/hw/ssi/xilinx_spips.h
+++ b/include/hw/ssi/xilinx_spips.h
@@ -104,7 +104,7 @@ struct XlnxZynqMPQSPIPS {
 
     uint32_t regs[XLNX_ZYNQMP_SPIPS_R_MAX];
 
-    /* GQSPI has seperate tx/rx fifos */
+    /* GQSPI has separate tx/rx fifos */
     Fifo8 rx_fifo_g;
     Fifo8 tx_fifo_g;
     Fifo32 fifo_g;
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 5f5dcb4572..e07a723027 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -109,7 +109,7 @@ typedef struct VirtioNetRscSeg {
     size_t size;
     uint16_t packets;
     uint16_t dup_ack;
-    bool is_coalesced;      /* need recal ipv4 header checksum, mark here */
+    bool is_coalesced;      /* need recall ipv4 header checksum, mark here */
     VirtioNetRscUnit unit;
     NetClientState *nc;
 } VirtioNetRscSeg;
diff --git a/include/hw/xen/interface/arch-x86/xen-x86_64.h b/include/hw/xen/interface/arch-x86/xen-x86_64.h
index 40aed14366..eae96f4f67 100644
--- a/include/hw/xen/interface/arch-x86/xen-x86_64.h
+++ b/include/hw/xen/interface/arch-x86/xen-x86_64.h
@@ -106,7 +106,7 @@
  *   RING1 -> RING3 kernel mode.
  *   RING2 -> RING3 kernel mode.
  *   RING3 -> RING3 user mode.
- * However RING0 indicates that the guest kernel should return to iteself
+ * However RING0 indicates that the guest kernel should return to itself
  * directly with
  *      orb   $3,1*8(%rsp)
  *      iretq
diff --git a/include/hw/xen/interface/arch-x86/xen.h b/include/hw/xen/interface/arch-x86/xen.h
index 7acd94c8eb..efa67d1499 100644
--- a/include/hw/xen/interface/arch-x86/xen.h
+++ b/include/hw/xen/interface/arch-x86/xen.h
@@ -139,7 +139,7 @@ typedef unsigned long xen_ulong_t;
  * The privilege level specifies which modes may enter a trap via a software
  * interrupt. On x86/64, since rings 1 and 2 are unavailable, we allocate
  * privilege levels as follows:
- *  Level == 0: Noone may enter
+ *  Level == 0: No one may enter
  *  Level == 1: Kernel may enter
  *  Level == 2: Kernel may enter
  *  Level == 3: Everyone may enter
diff --git a/include/hw/xen/interface/event_channel.h b/include/hw/xen/interface/event_channel.h
index 73c9f38ce1..9073d3852f 100644
--- a/include/hw/xen/interface/event_channel.h
+++ b/include/hw/xen/interface/event_channel.h
@@ -319,7 +319,7 @@ typedef struct evtchn_set_priority evtchn_set_priority_t;
  * ` enum neg_errnoval
  * ` HYPERVISOR_event_channel_op_compat(struct evtchn_op *op)
  * `
- * Superceded by new event_channel_op() hypercall since 0x00030202.
+ * Superseded by new event_channel_op() hypercall since 0x00030202.
  */
 struct evtchn_op {
     uint32_t cmd; /* enum event_channel_op */
diff --git a/include/hw/xen/interface/grant_table.h b/include/hw/xen/interface/grant_table.h
index 7934d7b718..f8e4398ecd 100644
--- a/include/hw/xen/interface/grant_table.h
+++ b/include/hw/xen/interface/grant_table.h
@@ -624,7 +624,7 @@ DEFINE_XEN_GUEST_HANDLE(gnttab_cache_flush_t);
  /*
   * GNTMAP_contains_pte subflag:
   *  0 => This map request contains a host virtual address.
-  *  1 => This map request contains the machine addess of the PTE to update.
+  *  1 => This map request contains the machine address of the PTE to update.
   */
 #define _GNTMAP_contains_pte    (4)
 #define GNTMAP_contains_pte     (1<<_GNTMAP_contains_pte)
diff --git a/include/hw/xen/interface/hvm/hvm_op.h b/include/hw/xen/interface/hvm/hvm_op.h
index 870ec52060..188960da7e 100644
--- a/include/hw/xen/interface/hvm/hvm_op.h
+++ b/include/hw/xen/interface/hvm/hvm_op.h
@@ -354,7 +354,7 @@ struct xen_hvm_altp2m_op {
 #define HVMOP_altp2m_vcpu_disable_notify  13
 /* Get the active vcpu p2m index */
 #define HVMOP_altp2m_get_p2m_idx          14
-/* Set the "Supress #VE" bit for a range of pages */
+/* Set the "Suppress #VE" bit for a range of pages */
 #define HVMOP_altp2m_set_suppress_ve_multi 15
 /* Set visibility for a given altp2m view */
 #define HVMOP_altp2m_set_visibility       16
diff --git a/include/hw/xen/interface/io/blkif.h b/include/hw/xen/interface/io/blkif.h
index 4cdba79aba..507d5170db 100644
--- a/include/hw/xen/interface/io/blkif.h
+++ b/include/hw/xen/interface/io/blkif.h
@@ -59,7 +59,7 @@
  * All data in the XenStore is stored as strings.  Nodes specifying numeric
  * values are encoded in decimal.  Integer value ranges listed below are
  * expressed as fixed sized integer types capable of storing the conversion
- * of a properly formated node string, without loss of information.
+ * of a properly formatted node string, without loss of information.
  *
  * Any specified default value is in effect if the corresponding XenBus node
  * is not present in the XenStore.
@@ -258,7 +258,7 @@
  *      must be a power of two with a minimum value of 512.
  *
  *      NOTE: Because of implementation bugs in some frontends this must be
- *            set to 512, unless the frontend advertizes a non-zero value
+ *            set to 512, unless the frontend advertises a non-zero value
  *            in its "feature-large-sector-size" xenbus node. (See below).
  *
  * physical-sector-size
@@ -415,7 +415,7 @@
  *     further requests may reuse these grants and require write permissions.
  * (9) Linux implementation doesn't have a limit on the maximum number of
  *     grants that can be persistently mapped in the frontend driver, but
- *     due to the frontent driver implementation it should never be bigger
+ *     due to the frontend driver implementation it should never be bigger
  *     than RING_SIZE * BLKIF_MAX_SEGMENTS_PER_REQUEST.
  *(10) The discard-secure property may be present and will be set to 1 if the
  *     backing device supports secure discard.
diff --git a/include/hw/xen/interface/io/fbif.h b/include/hw/xen/interface/io/fbif.h
index cc25aab32e..098561c55a 100644
--- a/include/hw/xen/interface/io/fbif.h
+++ b/include/hw/xen/interface/io/fbif.h
@@ -89,7 +89,7 @@ union xenfb_out_event
  * just ignore it.  Frontends that use the advice should immediately
  * refresh the framebuffer (and send an update notification event if
  * those have been requested), then use the update frequency to guide
- * their periodical refreshs.
+ * their periodical refreshes.
  */
 #define XENFB_TYPE_REFRESH_PERIOD 1
 #define XENFB_NO_REFRESH 0
diff --git a/include/hw/xen/interface/io/kbdif.h b/include/hw/xen/interface/io/kbdif.h
index a6b01c52c7..6fb73c8004 100644
--- a/include/hw/xen/interface/io/kbdif.h
+++ b/include/hw/xen/interface/io/kbdif.h
@@ -39,7 +39,7 @@
  * All data in XenStore is stored as strings.  Nodes specifying numeric
  * values are encoded in decimal. Integer value ranges listed below are
  * expressed as fixed sized integer types capable of storing the conversion
- * of a properly formated node string, without loss of information.
+ * of a properly formatted node string, without loss of information.
  *
  *****************************************************************************
  *                            Backend XenBus Nodes
diff --git a/include/hw/xen/interface/memory.h b/include/hw/xen/interface/memory.h
index 383a9468c3..b5edabf63c 100644
--- a/include/hw/xen/interface/memory.h
+++ b/include/hw/xen/interface/memory.h
@@ -184,7 +184,7 @@ struct xen_machphys_mfn_list {
 
     /*
      * Pointer to buffer to fill with list of extent starts. If there are
-     * any large discontiguities in the machine address space, 2MB gaps in
+     * any large discontinuities in the machine address space, 2MB gaps in
      * the machphys table will be represented by an MFN base of zero.
      */
     XEN_GUEST_HANDLE(xen_pfn_t) extent_start;
diff --git a/include/hw/xen/interface/physdev.h b/include/hw/xen/interface/physdev.h
index d271766ad0..55cd5892ac 100644
--- a/include/hw/xen/interface/physdev.h
+++ b/include/hw/xen/interface/physdev.h
@@ -223,7 +223,7 @@ typedef struct physdev_manage_pci_ext physdev_manage_pci_ext_t;
 DEFINE_XEN_GUEST_HANDLE(physdev_manage_pci_ext_t);
 
 /*
- * Argument to physdev_op_compat() hypercall. Superceded by new physdev_op()
+ * Argument to physdev_op_compat() hypercall. Superseded by new physdev_op()
  * hypercall since 0x00030202.
  */
 struct physdev_op {
@@ -349,7 +349,7 @@ DEFINE_XEN_GUEST_HANDLE(physdev_dbgp_op_t);
 
 #if __XEN_INTERFACE_VERSION__ < 0x00040600
 /*
- * These all-capitals physdev operation names are superceded by the new names
+ * These all-capitals physdev operation names are superseded by the new names
  * (defined above) since interface version 0x00030202. The guard above was
  * added post-4.5 only though and hence shouldn't check for 0x00030202.
  */
diff --git a/include/hw/xen/interface/sched.h b/include/hw/xen/interface/sched.h
index 811bd87c82..043900b49a 100644
--- a/include/hw/xen/interface/sched.h
+++ b/include/hw/xen/interface/sched.h
@@ -66,7 +66,7 @@
 /*
  * Block execution of this VCPU until an event is received for processing.
  * If called with event upcalls masked, this operation will atomically
- * reenable event delivery and check for pending events before blocking the
+ * re-enable event delivery and check for pending events before blocking the
  * VCPU. This avoids a "wakeup waiting" race.
  * @arg == NULL.
  */
diff --git a/include/hw/xen/interface/xen.h b/include/hw/xen/interface/xen.h
index e373592c33..8c7914bbfb 100644
--- a/include/hw/xen/interface/xen.h
+++ b/include/hw/xen/interface/xen.h
@@ -606,7 +606,7 @@ DEFINE_XEN_GUEST_HANDLE(mmuext_op_t);
 #define DOMID_XEN            xen_mk_uint(0x7FF2)
 
 /*
- * DOMID_COW is used as the owner of sharable pages */
+ * DOMID_COW is used as the owner of shareable pages */
 #define DOMID_COW            xen_mk_uint(0x7FF3)
 
 /* DOMID_INVALID is used to identify pages with unknown owner. */
@@ -750,7 +750,7 @@ struct shared_info {
      * are delivered by this mechanism:
      *  1. Bi-directional inter- and intra-domain connections. Domains must
      *     arrange out-of-band to set up a connection (usually by allocating
-     *     an unbound 'listener' port and avertising that via a storage service
+     *     an unbound 'listener' port and advertising that via a storage service
      *     such as xenstore).
      *  2. Physical interrupts. A domain with suitable hardware-access
      *     privileges can bind an event-channel port to a physical interrupt
diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index 513c428fe4..ab15577d38 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -124,7 +124,7 @@ void qio_channel_socket_connect_async(QIOChannelSocket *ioc,
  * qio_channel_socket_listen_sync:
  * @ioc: the socket channel object
  * @addr: the address to listen to
- * @num: the expected ammount of connections
+ * @num: the expected amount of connections
  * @errp: pointer to a NULL-initialized error object
  *
  * Attempt to listen to the address @addr. This method
@@ -141,7 +141,7 @@ int qio_channel_socket_listen_sync(QIOChannelSocket *ioc,
  * qio_channel_socket_listen_async:
  * @ioc: the socket channel object
  * @addr: the address to listen to
- * @num: the expected ammount of connections
+ * @num: the expected amount of connections
  * @callback: the function to invoke on completion
  * @opaque: user data to pass to @callback
  * @destroy: the function to free @opaque
diff --git a/include/io/task.h b/include/io/task.h
index beec4f5cfd..dc7d32ebd0 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -145,7 +145,7 @@ typedef void (*QIOTaskWorker)(QIOTask *task,
  * The QIOTask module can also be used to perform operations
  * in a background thread context, while still reporting the
  * results in the main event thread. This allows code which
- * cannot easily be rewritten to be asychronous (such as DNS
+ * cannot easily be rewritten to be asynchronous (such as DNS
  * lookups) to be easily run non-blocking. Reporting the
  * results in the main thread context means that the caller
  * typically does not need to be concerned about thread
diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
index 8528e5c98f..2a10a7052e 100644
--- a/include/qemu/iova-tree.h
+++ b/include/qemu/iova-tree.h
@@ -15,7 +15,7 @@
  * Currently the iova tree will only allow to keep ranges
  * information, and no extra user data is allowed for each element.  A
  * benefit is that we can merge adjacent ranges internally within the
- * tree.  It can save a lot of memory when the ranges are splitted but
+ * tree.  It can save a lot of memory when the ranges are split but
  * mostly continuous.
  *
  * Note that current implementation does not provide any thread
@@ -128,7 +128,7 @@ const DMAMap *iova_tree_find_address(const IOVATree *tree, hwaddr iova);
  * iova_tree_foreach:
  *
  * @tree: the iova tree to iterate on
- * @iterator: the interator for the mappings, return true to stop
+ * @iterator: the iterator for the mappings, return true to stop
  *
  * Iterate over the iova tree.
  *
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 9a91cb1248..d7d1051e81 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -353,7 +353,7 @@ void timerlist_notify(QEMUTimerList *timer_list);
  * Initialise a timer list group. This must already be
  * allocated in memory and zeroed. The notifier callback is
  * called whenever a clock in the timer list group is
- * reenabled or whenever a timer associated with any timer
+ * re-enabled or whenever a timer associated with any timer
  * list is modified. If @cb is specified as null, qemu_notify()
  * is used instead.
  */
diff --git a/include/qemu/yank.h b/include/qemu/yank.h
index 5375a1f195..1907150933 100644
--- a/include/qemu/yank.h
+++ b/include/qemu/yank.h
@@ -25,7 +25,7 @@ typedef void (YankFn)(void *opaque);
  * @instance: The instance.
  * @errp: Error object.
  *
- * Returns true on success or false if an error occured.
+ * Returns true on success or false if an error occurred.
  */
 bool yank_register_instance(const YankInstance *instance, Error **errp);
 
diff --git a/include/standard-headers/drm/drm_fourcc.h b/include/standard-headers/drm/drm_fourcc.h
index 72279f4d25..b782802a34 100644
--- a/include/standard-headers/drm/drm_fourcc.h
+++ b/include/standard-headers/drm/drm_fourcc.h
@@ -53,7 +53,7 @@ extern "C" {
  * Format modifiers may change any property of the buffer, including the number
  * of planes and/or the required allocation size. Format modifiers are
  * vendor-namespaced, and as such the relationship between a fourcc code and a
- * modifier is specific to the modifer being used. For example, some modifiers
+ * modifier is specific to the modifier being used. For example, some modifiers
  * may preserve meaning - such as number of planes - from the fourcc code,
  * whereas others may not.
  *
@@ -78,7 +78,7 @@ extern "C" {
  *   format.
  * - Higher-level programs interfacing with KMS/GBM/EGL/Vulkan/etc: these users
  *   see modifiers as opaque tokens they can check for equality and intersect.
- *   These users musn't need to know to reason about the modifier value
+ *   These users mustn't need to know to reason about the modifier value
  *   (i.e. they are not expected to extract information out of the modifier).
  *
  * Vendors should document their modifier usage in as much detail as
@@ -537,7 +537,7 @@ extern "C" {
  * This is a tiled layout using 4Kb tiles in row-major layout.
  * Within the tile pixels are laid out in 16 256 byte units / sub-tiles which
  * are arranged in four groups (two wide, two high) with column-major layout.
- * Each group therefore consits out of four 256 byte units, which are also laid
+ * Each group therefore consists out of four 256 byte units, which are also laid
  * out as 2x2 column-major.
  * 256 byte units are made out of four 64 byte blocks of pixels, producing
  * either a square block or a 2:1 unit.
@@ -1416,7 +1416,7 @@ drm_fourcc_canonicalize_nvidia_format_mod(uint64_t modifier)
  * Amlogic FBC Memory Saving mode
  *
  * Indicates the storage is packed when pixel size is multiple of word
- * boudaries, i.e. 8bit should be stored in this mode to save allocation
+ * boundaries, i.e. 8bit should be stored in this mode to save allocation
  * memory.
  *
  * This mode reduces body layout to 3072 bytes per 64x32 superblock with
diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-headers/linux/ethtool.h
index 99fcddf04f..e72ec42bf8 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -569,7 +569,7 @@ struct ethtool_channels {
  * @tx_pause: Flag to enable transmission of pause frames
  *
  * Drivers should reject a non-zero setting of @autoneg when
- * autoneogotiation is disabled (or not supported) for the link.
+ * autonegotiation is disabled (or not supported) for the link.
  *
  * If the link is autonegotiated, drivers should use
  * mii_advertise_flowctrl() or similar code to set the advertised
diff --git a/include/standard-headers/linux/virtio_console.h b/include/standard-headers/linux/virtio_console.h
index 71f5f648e3..8cba52198a 100644
--- a/include/standard-headers/linux/virtio_console.h
+++ b/include/standard-headers/linux/virtio_console.h
@@ -44,7 +44,7 @@
 #define VIRTIO_CONSOLE_BAD_ID		(~(uint32_t)0)
 
 struct virtio_console_config {
-	/* colums of the screens */
+	/* columns of the screens */
 	__virtio16 cols;
 	/* rows of the screens */
 	__virtio16 rows;
diff --git a/include/standard-headers/linux/virtio_i2c.h b/include/standard-headers/linux/virtio_i2c.h
index 09fa907793..d6f7c2a28d 100644
--- a/include/standard-headers/linux/virtio_i2c.h
+++ b/include/standard-headers/linux/virtio_i2c.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note */
 /*
- * Definitions for virtio I2C Adpter
+ * Definitions for virtio I2C Adapter
  *
  * Copyright (c) 2021 Intel Corporation. All rights reserved.
  */
diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
index 2325485f2c..077a714ddf 100644
--- a/include/standard-headers/linux/virtio_net.h
+++ b/include/standard-headers/linux/virtio_net.h
@@ -267,7 +267,7 @@ struct virtio_net_ctrl_mac {
  * Control VLAN filtering
  *
  * The VLAN filter table is controlled via a simple ADD/DEL interface.
- * VLAN IDs not added may be filterd by the hypervisor.  Del is the
+ * VLAN IDs not added may be filtered by the hypervisor.  Del is the
  * opposite of add.  Both commands expect an out entry containing a 2
  * byte VLAN ID.  VLAN filterting is available with the
  * VIRTIO_NET_F_CTRL_VLAN feature bit.
@@ -280,7 +280,7 @@ struct virtio_net_ctrl_mac {
  * Control link announce acknowledgement
  *
  * The command VIRTIO_NET_CTRL_ANNOUNCE_ACK is used to indicate that
- * driver has recevied the notification; device would clear the
+ * driver has received the notification; device would clear the
  * VIRTIO_NET_S_ANNOUNCE bit in the status field after it receives
  * this command.
  */
diff --git a/include/sysemu/cryptodev-vhost.h b/include/sysemu/cryptodev-vhost.h
index e8cab1356e..4c3c22acae 100644
--- a/include/sysemu/cryptodev-vhost.h
+++ b/include/sysemu/cryptodev-vhost.h
@@ -79,7 +79,7 @@ cryptodev_vhost_init(
  * cryptodev_vhost_cleanup:
  * @crypto: the cryptodev backend common vhost object
  *
- * Clean the resouce associated with @crypto that realizaed
+ * Clean the resource associated with @crypto that realizaed
  * by cryptodev_vhost_init()
  *
  */
diff --git a/include/sysemu/cryptodev.h b/include/sysemu/cryptodev.h
index bc021ce847..96d3998b93 100644
--- a/include/sysemu/cryptodev.h
+++ b/include/sysemu/cryptodev.h
@@ -339,7 +339,7 @@ void cryptodev_backend_free_client(
  * @backend: the cryptodev backend object
  * @errp: pointer to a NULL-initialized error object
  *
- * Clean the resouce associated with @backend that realizaed
+ * Clean the resource associated with @backend that realizaed
  * by the specific backend's init() callback
  */
 void cryptodev_backend_cleanup(
@@ -407,7 +407,7 @@ int cryptodev_backend_crypto_operation(
 /**
  * cryptodev_backend_set_used:
  * @backend: the cryptodev backend object
- * @used: ture or false
+ * @used: true or false
  *
  * Set the cryptodev backend is used by virtio-crypto or not
  */
@@ -427,7 +427,7 @@ bool cryptodev_backend_is_used(CryptoDevBackend *backend);
 /**
  * cryptodev_backend_set_ready:
  * @backend: the cryptodev backend object
- * @ready: ture or false
+ * @ready: true or false
  *
  * Set the cryptodev backend is ready or not, which is called
  * by the children of the cryptodev banckend interface.
diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index 8f8601d6ab..2102a90eca 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -59,7 +59,7 @@ void iothread_stop(IOThread *iothread);
 void iothread_destroy(IOThread *iothread);
 
 /*
- * Returns true if executing withing IOThread context,
+ * Returns true if executing within IOThread context,
  * false otherwise.
  */
 bool qemu_in_iothread(void);
diff --git a/include/sysemu/stats.h b/include/sysemu/stats.h
index fcf0983154..42c236c795 100644
--- a/include/sysemu/stats.h
+++ b/include/sysemu/stats.h
@@ -34,7 +34,7 @@ void add_stats_schema(StatsSchemaList **, StatsProvider, StatsTarget,
                       StatsSchemaValueList *);
 
 /*
- * True if a string matches the filter passed to the stats_fn callabck,
+ * True if a string matches the filter passed to the stats_fn callback,
  * false otherwise.
  *
  * Note that an empty list means no filtering, i.e. all strings will
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 8fd3269c11..7fabafefee 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -115,7 +115,7 @@ int tpm_backend_startup_tpm(TPMBackend *s, size_t buffersize);
 
 /**
  * tpm_backend_had_startup_error:
- * @s: the backend to query for a statup error
+ * @s: the backend to query for a startup error
  *
  * Check whether the backend had an error during startup. Returns
  * false if no error occurred and the backend can be used, true
diff --git a/include/tcg/helper-info.h b/include/tcg/helper-info.h
index 4b6c9b43e8..7c27d6164a 100644
--- a/include/tcg/helper-info.h
+++ b/include/tcg/helper-info.h
@@ -1,5 +1,5 @@
 /*
- * TCG Helper Infomation Structure
+ * TCG Helper Information Structure
  *
  * Copyright (c) 2023 Linaro Ltd
  *
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 0875971719..f2b0eaa6da 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -879,7 +879,7 @@ enum {
     /* Instruction operands are 64-bits (otherwise 32-bits).  */
     TCG_OPF_64BIT        = 0x10,
     /* Instruction is optional and not implemented by the host, or insn
-       is generic and should not be implemened by the host.  */
+       is generic and should not be implemented by the host.  */
     TCG_OPF_NOT_PRESENT  = 0x20,
     /* Instruction operands are vectors.  */
     TCG_OPF_VECTOR       = 0x40,
@@ -1123,7 +1123,7 @@ static inline int tcg_can_emit_vec_op(TCGOpcode o, TCGType t, unsigned ve)
 /* Expand the tuple (opc, type, vece) on the given arguments.  */
 void tcg_expand_vec_op(TCGOpcode, TCGType, unsigned, TCGArg, ...);
 
-/* Replicate a constant C accoring to the log2 of the element size.  */
+/* Replicate a constant C according to the log2 of the element size.  */
 uint64_t dup_const(unsigned vece, uint64_t c);
 
 #define dup_const(VECE, C)                                         \
diff --git a/include/ui/kbd-state.h b/include/ui/kbd-state.h
index eb9067dd53..fb79776128 100644
--- a/include/ui/kbd-state.h
+++ b/include/ui/kbd-state.h
@@ -65,7 +65,7 @@ void qkbd_state_key_event(QKbdState *kbd, QKeyCode qcode, bool down);
  * using qemu_input_event_send_key_delay().
  *
  * @kbd: state tracker state.
- * @delay_ms: the delay in miliseconds.
+ * @delay_ms: the delay in milliseconds.
  */
 void qkbd_state_set_delay(QKbdState *kbd, int delay_ms);
 
diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index 5aa13664d6..e1a9b36185 100644
--- a/include/ui/spice-display.h
+++ b/include/ui/spice-display.h
@@ -42,7 +42,7 @@
 #define NUM_MEMSLOTS_GROUPS 2
 
 /*
- * Internal enum to differenciate between options for
+ * Internal enum to differentiate between options for
  * io calls that have a sync (old) version and an _async (new)
  * version:
  *  QXL_SYNC: use the old version
diff --git a/include/user/safe-syscall.h b/include/user/safe-syscall.h
index ddceef12e2..195cedac04 100644
--- a/include/user/safe-syscall.h
+++ b/include/user/safe-syscall.h
@@ -91,7 +91,7 @@
  *
  * The basic setup is that we make the host syscall via a known
  * section of host native assembly. If a signal occurs, our signal
- * handler checks the interrupted host PC against the addresse of that
+ * handler checks the interrupted host PC against the address of that
  * known section. If the PC is before or at the address of the syscall
  * instruction then we change the PC to point at a "return
  * -QEMU_ERESTARTSYS" code path instead, and then exit the signal handler
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d3d1352c4e..4353ac011e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2717,7 +2717,7 @@ static void pgb_static(const char *image_name, abi_ulong orig_loaddr,
         /*
          * Extend the allocation to include the commpage.
          * For a 64-bit host, this is just 4GiB; for a 32-bit host we
-         * need to ensure there is space bellow the guest_base so we
+         * need to ensure there is space below the guest_base so we
          * can map the commpage in the place needed when the address
          * arithmetic wraps around.
          */
diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 5efec2630e..5943a68c52 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -780,7 +780,7 @@ int load_flt_binary(struct linux_binprm *bprm, struct image_info *info)
     /* Enforce final stack alignment of 16 bytes.  This is sufficient
        for all current targets, and excess alignment is harmless.  */
     stack_len = bprm->envc + bprm->argc + 2;
-    stack_len += flat_argvp_envp_on_stack() ? 2 : 0; /* arvg, argp */
+    stack_len += flat_argvp_envp_on_stack() ? 2 : 0; /* argv, argp */
     stack_len += 1; /* argc */
     stack_len *= sizeof(abi_ulong);
     sp -= (sp - stack_len) & 15;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 420bab7c68..3dc6bbc846 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -836,7 +836,7 @@ abi_long do_brk(abi_ulong brk_val)
         return target_brk;
     }
 
-    /* Release heap if necesary */
+    /* Release heap if necessary */
     if (new_brk < target_brk) {
         /* empty remaining bytes in (possibly larger) host page */
         memset(g2h_untagged(brk_val), 0, new_host_brk_page - brk_val);
@@ -1845,7 +1845,7 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
             uint32_t *dst = (uint32_t *)data;
 
             memcpy(dst, target_data, len);
-            /* fix endianess of first 32-bit word */
+            /* fix endianness of first 32-bit word */
             if (len >= sizeof(uint32_t)) {
                 *dst = tswap32(*dst);
             }
@@ -2956,7 +2956,7 @@ get_timeout:
                 unlock_user(results, optval_addr, 0);
                 return ret;
             }
-            /* swap host endianess to target endianess. */
+            /* swap host endianness to target endianness. */
             for (i = 0; i < (len / sizeof(uint32_t)); i++) {
                 results[i] = tswap32(results[i]);
             }
diff --git a/migration/migration-stats.c b/migration/migration-stats.c
index f98c8260be..f195e89732 100644
--- a/migration/migration-stats.c
+++ b/migration/migration-stats.c
@@ -48,7 +48,7 @@ uint64_t migration_rate_get(void)
 void migration_rate_set(uint64_t limit)
 {
     /*
-     * 'limit' is per second.  But we check it each BUFER_DELAY miliseconds.
+     * 'limit' is per second.  But we check it each BUFER_DELAY milliseconds.
      */
     stat64_set(&mig_stats.rate_limit_max, limit / XFER_LIMIT_RATIO);
 }
diff --git a/migration/migration.h b/migration/migration.h
index b7c8b67542..6eea18db36 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -134,7 +134,7 @@ struct MigrationIncomingState {
     /*
      * Always set by the main vm load thread only, but can be read by the
      * postcopy preempt thread.  "volatile" makes sure all reads will be
-     * uptodate across cores.
+     * up-to-date across cores.
      */
     volatile PreemptThreadStatus preempt_thread_status;
     /*
@@ -409,7 +409,7 @@ struct MigrationState {
      *   channel itself.
      *
      * - postcopy preempt channel will be created at the switching phase
-     *   from precopy -> postcopy (to avoid race condtion of misordered
+     *   from precopy -> postcopy (to avoid race condition of misordered
      *   creation of channels).
      *
      * NOTE: See message-id <ZBoShWArKDPpX/D7@work-vm> on qemu-devel
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 81701250ad..37ce48621e 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -57,7 +57,7 @@ static int zlib_send_setup(MultiFDSendParams *p, Error **errp)
         err_msg = "deflate init failed";
         goto err_free_z;
     }
-    /* This is the maxium size of the compressed buffer */
+    /* This is the maximum size of the compressed buffer */
     z->zbuff_len = compressBound(MULTIFD_PACKET_SIZE);
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index d1d29e76cc..b471daadcd 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -68,7 +68,7 @@ static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
                    p->id, ZSTD_getErrorName(res));
         return -1;
     }
-    /* This is the maxium size of the compressed buffer */
+    /* This is the maximum size of the compressed buffer */
     z->zbuff_len = ZSTD_compressBound(MULTIFD_PACKET_SIZE);
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
diff --git a/migration/multifd.c b/migration/multifd.c
index 3387d8277f..0e3ae87449 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -878,7 +878,7 @@ static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
      qemu_sem_post(&p->sem_sync);
      /*
       * Although multifd_send_thread is not created, but main migration
-      * thread neet to judge whether it is running, so we need to mark
+      * thread need to judge whether it is running, so we need to mark
       * its status.
       */
      p->quit = true;
diff --git a/migration/savevm.c b/migration/savevm.c
index 95c2abf47c..51e40e3a0b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -117,7 +117,7 @@ static struct mig_cmd_args {
  * The format of arguments is depending on postcopy mode:
  * - postcopy RAM only
  *   uint64_t host page size
- *   uint64_t taget page size
+ *   uint64_t target page size
  *
  * - postcopy RAM and postcopy dirty bitmaps
  *   format is the same as for postcopy RAM only
diff --git a/migration/trace-events b/migration/trace-events
index 5259c1044b..4e43fe20fc 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -184,7 +184,7 @@ source_return_path_thread_shut(uint32_t val) "0x%x"
 source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
 source_return_path_thread_switchover_acked(void) ""
 migration_thread_low_pending(uint64_t pending) "%" PRIu64
-migrate_transferred(uint64_t tranferred, uint64_t time_spent, uint64_t bandwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " max_size %" PRId64
+migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " max_size %" PRId64
 process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
 process_incoming_migration_co_postcopy_end_main(void) ""
 postcopy_preempt_enabled(bool value) "%d"
diff --git a/nbd/client-connection.c b/nbd/client-connection.c
index 3d14296c04..258ef81ae9 100644
--- a/nbd/client-connection.c
+++ b/nbd/client-connection.c
@@ -197,7 +197,7 @@ static void *connect_thread_func(void *opaque)
          * conn->updated_info will finally be returned to the user. Clear the
          * pointers to our internally allocated strings, which are IN parameters
          * of nbd_receive_negotiate() and therefore nbd_connect(). Caller
-         * shoudn't be interested in these fields.
+         * shouldn't be interested in these fields.
          */
         conn->updated_info.x_dirty_bitmap = NULL;
         conn->updated_info.name = NULL;
diff --git a/net/checksum.c b/net/checksum.c
index 68245fd748..1a957e4c0b 100644
--- a/net/checksum.c
+++ b/net/checksum.c
@@ -74,7 +74,7 @@ void net_checksum_calculate(uint8_t *data, int length, int csum_flag)
         return;
     }
 
-    /* Handle the optionnal VLAN headers */
+    /* Handle the optional VLAN headers */
     switch (lduw_be_p(&PKT_GET_ETH_HDR(data)->h_proto)) {
     case ETH_P_VLAN:
         mac_hdr_len = sizeof(struct eth_header) +
@@ -96,7 +96,7 @@ void net_checksum_calculate(uint8_t *data, int length, int csum_flag)
 
     length -= mac_hdr_len;
 
-    /* Now check we have an IP header (with an optionnal VLAN header) */
+    /* Now check we have an IP header (with an optional VLAN header) */
     if (length < sizeof(struct ip_header)) {
         return;
     }
diff --git a/net/filter.c b/net/filter.c
index 3fe88fa43f..3b92e04af0 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -92,7 +92,7 @@ ssize_t qemu_netfilter_pass_to_next(NetClientState *sender,
     while (next) {
         /*
          * if qemu_netfilter_pass_to_next been called, means that
-         * the packet has been hold by filter and has already retured size
+         * the packet has been hold by filter and has already returned size
          * to the sender, so sent_cb shouldn't be called later, just
          * pass NULL to next.
          */
@@ -106,7 +106,7 @@ ssize_t qemu_netfilter_pass_to_next(NetClientState *sender,
 
     /*
      * We have gone through all filters, pass it to receiver.
-     * Do the valid check again incase sender or receiver been
+     * Do the valid check again in case sender or receiver been
      * deleted while we go through filters.
      */
     if (sender && sender->peer) {
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 9795306742..34202ca009 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -821,7 +821,7 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * According to virtio_net_reset(), device turns promiscuous mode
      * on by default.
      *
-     * Addtionally, according to VirtIO standard, "Since there are
+     * Additionally, according to VirtIO standard, "Since there are
      * no guarantees, it can use a hash filter or silently switch to
      * allmulti or promiscuous mode if it is given too many addresses.".
      * QEMU marks `n->mac_table.uni_overflow` if guest sets too many
@@ -1130,7 +1130,7 @@ static int vhost_vdpa_net_excessive_mac_filter_cvq_add(VhostVDPAState *s,
      * Pack the non-multicast MAC addresses part for fake CVQ command.
      *
      * According to virtio_net_handle_mac(), QEMU doesn't verify the MAC
-     * addresses provieded in CVQ command. Therefore, only the entries
+     * addresses provided in CVQ command. Therefore, only the entries
      * field need to be prepared in the CVQ command.
      */
     mac_ptr = out->iov_base + cursor;
@@ -1141,7 +1141,7 @@ static int vhost_vdpa_net_excessive_mac_filter_cvq_add(VhostVDPAState *s,
      * Pack the multicast MAC addresses part for fake CVQ command.
      *
      * According to virtio_net_handle_mac(), QEMU doesn't verify the MAC
-     * addresses provieded in CVQ command. Therefore, only the entries
+     * addresses provided in CVQ command. Therefore, only the entries
      * field need to be prepared in the CVQ command.
      */
     mac_ptr = out->iov_base + cursor;
@@ -1202,7 +1202,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
          * rejects the flawed CVQ command.
          *
          * Therefore, QEMU must handle this situation instead of sending
-         * the CVQ command direclty.
+         * the CVQ command directly.
          */
         dev_written = vhost_vdpa_net_excessive_mac_filter_cvq_add(s, elem,
                                                                   &out);
diff --git a/qga/channel-posix.c b/qga/channel-posix.c
index 0c5175d957..465d688ecb 100644
--- a/qga/channel-posix.c
+++ b/qga/channel-posix.c
@@ -152,7 +152,7 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
 #ifdef __FreeBSD__
         /*
          * In the default state channel sends echo of every command to a
-         * client. The client programm doesn't expect this and raises an
+         * client. The client program doesn't expect this and raises an
          * error. Suppress echo by resetting ECHO terminal flag.
          */
         struct termios tio;
diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
index f3a580b8cc..236f80de44 100644
--- a/qga/commands-posix-ssh.c
+++ b/qga/commands-posix-ssh.c
@@ -382,7 +382,7 @@ test_add_keys(void)
                                       &err);
     g_assert(err == NULL);
 
-    /*  key2 came first, and should'nt be duplicated */
+    /*  key2 came first, and shouldn't be duplicated */
     test_authorized_keys_equal("algo key2 comments\n"
                                "algo key1 comments");
 }
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index def857d773..6169bbf7a0 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -3249,7 +3249,7 @@ GuestUserList *qmp_guest_get_users(Error **errp)
 
 #endif
 
-/* Replace escaped special characters with theire real values. The replacement
+/* Replace escaped special characters with their real values. The replacement
  * is done in place -- returned value is in the original string.
  */
 static void ga_osrelease_replace_special(gchar *value)
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index d23875264f..6beae659b7 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -487,7 +487,7 @@ static GuestDiskBusType win2qemu[] = {
     [BusTypeVirtual] = GUEST_DISK_BUS_TYPE_VIRTUAL,
     [BusTypeFileBackedVirtual] = GUEST_DISK_BUS_TYPE_FILE_BACKED_VIRTUAL,
     /*
-     * BusTypeSpaces currently is not suported
+     * BusTypeSpaces currently is not supported
      */
     [BusTypeSpaces] = GUEST_DISK_BUS_TYPE_UNKNOWN,
     [BusTypeNvme] = GUEST_DISK_BUS_TYPE_NVME,
@@ -2259,7 +2259,7 @@ static char *ga_get_win_product_name(Error **errp)
         }
     }
     if (err != ERROR_SUCCESS) {
-        error_setg_win32(errp, err, "failed to retrive ProductName");
+        error_setg_win32(errp, err, "failed to retrieve ProductName");
         goto fail;
     }
 
diff --git a/qga/main.c b/qga/main.c
index 002161a0cc..8668b9f3d3 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1333,7 +1333,7 @@ static bool check_is_frozen(GAState *s)
     /* check if a previous instance of qemu-ga exited with filesystems' state
      * marked as frozen. this could be a stale value (a non-qemu-ga process
      * or reboot may have since unfrozen them), but better to require an
-     * uneeded unfreeze than to risk hanging on start-up
+     * unneeded unfreeze than to risk hanging on start-up
      */
     struct stat st;
     if (stat(s->state_filepath_isfrozen, &st) == -1) {
diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index ae38662a62..84944133f7 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -343,7 +343,7 @@ STDAPI COMRegister(void)
                                    _bstr_t(dllPath), _bstr_t(tlbPath),
                                    _bstr_t("")));
 
-    /* Setup roles of the applicaion */
+    /* Setup roles of the application */
 
     chk(getNameByStringSID(administratorsGroupSID, buffer, &bufferLen));
     chk(pApps->GetCollection(_bstr_t(L"Roles"), key,
@@ -439,7 +439,7 @@ STDAPI DllRegisterServer(void)
         goto out;
     }
 
-    /* Add this module to registery */
+    /* Add this module to registry */
 
     sprintf(key, "CLSID\\%s", g_szClsid);
     if (!CreateRegistryKey(key, NULL, g_szClsid)) {
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index eeaec436eb..2dda08a859 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1621,7 +1621,7 @@ sub process {
 				my $hex =
 					qr/%[-+ *.0-9]*([hljztL]|ll|hh)?(x|X|"\s*PRI[xX][^"]*"?)/;
 
-				# don't consider groups splitted by [.:/ ], like 2A.20:12ab
+				# don't consider groups split by [.:/ ], like 2A.20:12ab
 				my $tmpline = $rawline;
 				$tmpline =~ s/($hex[.:\/ ])+$hex//g;
 
@@ -2029,7 +2029,7 @@ sub process {
 		}
 # check for static initialisers.
 		if ($line =~ /\bstatic\s.*=\s*(0|NULL|false)\s*;/) {
-			ERROR("do not initialise statics to 0 or NULL\n" .
+			ERROR("do not initialise statistics to 0 or NULL\n" .
 				$herecurr);
 		}
 
diff --git a/scripts/ci/gitlab-pipeline-status b/scripts/ci/gitlab-pipeline-status
index 924db327ff..e3343b0510 100755
--- a/scripts/ci/gitlab-pipeline-status
+++ b/scripts/ci/gitlab-pipeline-status
@@ -28,7 +28,7 @@ class CommunicationFailure(Exception):
 
 
 class NoPipelineFound(Exception):
-    """Communication is successfull but pipeline is not found."""
+    """Communication is successful but pipeline is not found."""
 
 
 def get_local_branch_commit(branch):
diff --git a/scripts/codeconverter/codeconverter/qom_macros.py b/scripts/codeconverter/codeconverter/qom_macros.py
index 2d2f2055a3..2b0c8224a1 100644
--- a/scripts/codeconverter/codeconverter/qom_macros.py
+++ b/scripts/codeconverter/codeconverter/qom_macros.py
@@ -142,7 +142,7 @@ def make_structname(self) -> str:
         return name
 
     def strip_typedef(self) -> Patch:
-        """generate patch that will strip typedef from the struct declartion
+        """generate patch that will strip typedef from the struct declaration
 
         The caller is responsible for readding the typedef somewhere else.
         """
diff --git a/scripts/oss-fuzz/minimize_qtest_trace.py b/scripts/oss-fuzz/minimize_qtest_trace.py
index 20825768c2..d1f3990c16 100755
--- a/scripts/oss-fuzz/minimize_qtest_trace.py
+++ b/scripts/oss-fuzz/minimize_qtest_trace.py
@@ -2,7 +2,7 @@
 # -*- coding: utf-8 -*-
 
 """
-This takes a crashing qtest trace and tries to remove superflous operations
+This takes a crashing qtest trace and tries to remove superfluous operations
 """
 
 import sys
@@ -38,7 +38,7 @@ def usage():
 Options:
 
 -M1: enable a loop around the remove minimizer, which may help decrease some
-     timing dependant instructions. Off by default.
+     timing dependent instructions. Off by default.
 -M2: try setting bits in operand of write/out to zero. Off by default.
 
 """.format((sys.argv[0])))
@@ -177,7 +177,7 @@ def remove_lines(newtrace, outpath):
         # it into two separate write commands. If splitting the data operand
         # from length/2^n bytes to the left does not work, try to move the pivot
         # to the right side, then add one to n, until length/2^n == 0. The idea
-        # is to prune unneccessary bytes from long writes, while accommodating
+        # is to prune unnecessary bytes from long writes, while accommodating
         # arbitrary MemoryRegion access sizes and alignments.
 
         # This algorithm will fail under some rare situations.
@@ -292,7 +292,7 @@ def minimize_trace(inpath, outpath):
     old_len = len(newtrace) + 1
     while(old_len > len(newtrace)):
         old_len = len(newtrace)
-        print("trace lenth = ", old_len)
+        print("trace length = ", old_len)
         remove_lines(newtrace, outpath)
         if not M1 and not M2:
             break
diff --git a/scripts/performance/topN_callgrind.py b/scripts/performance/topN_callgrind.py
index 67c59197af..f3f05fce55 100755
--- a/scripts/performance/topN_callgrind.py
+++ b/scripts/performance/topN_callgrind.py
@@ -4,7 +4,7 @@
 #  Syntax:
 #  topN_callgrind.py [-h] [-n] <number of displayed top functions>  -- \
 #           <qemu executable> [<qemu executable options>] \
-#           <target executable> [<target execurable options>]
+#           <target executable> [<target executable options>]
 #
 #  [-h] - Print the script arguments help message.
 #  [-n] - Specify the number of top functions to print.
diff --git a/scripts/performance/topN_perf.py b/scripts/performance/topN_perf.py
index 07be195fc8..7b19e6a742 100755
--- a/scripts/performance/topN_perf.py
+++ b/scripts/performance/topN_perf.py
@@ -4,7 +4,7 @@
 #  Syntax:
 #  topN_perf.py [-h] [-n] <number of displayed top functions>  -- \
 #           <qemu executable> [<qemu executable options>] \
-#           <target executable> [<target execurable options>]
+#           <target executable> [<target executable options>]
 #
 #  [-h] - Print the script arguments help message.
 #  [-n] - Specify the number of top functions to print.
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 70bc576a10..bf5716b5f3 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -81,7 +81,7 @@ def write(self, output_dir: str) -> None:
         if odir:
             os.makedirs(odir, exist_ok=True)
 
-        # use os.open for O_CREAT to create and read a non-existant file
+        # use os.open for O_CREAT to create and read a non-existent file
         fd = os.open(pathname, os.O_RDWR | os.O_CREAT, 0o666)
         with os.fdopen(fd, 'r+', encoding='utf-8') as fp:
             text = self.get_content()
diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc
index 90546df534..7f9686e578 100644
--- a/scripts/qapi/pylintrc
+++ b/scripts/qapi/pylintrc
@@ -11,7 +11,7 @@ ignore-patterns=schema.py,
 # can either give multiple identifiers separated by comma (,) or put this
 # option multiple times (only on the command line, not in the configuration
 # file where it should appear only once). You can also use "--disable=all" to
-# disable everything first and then reenable specific checks. For example, if
+# disable everything first and then re-enable specific checks. For example, if
 # you want to run only the similarities checker, you can use "--disable=all
 # --enable=similarities". If you want to run only the classes checker, but have
 # no Warning level messages displayed, use "--disable=all --enable=classes
diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index 3ba97a6d30..b89dc29555 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -111,7 +111,7 @@ def print_event(eid, name, string=None, event_count=None):
 # Decoders for each event type
 
 def decode_unimp(eid, name, _unused_dumpfile):
-    "Unimplimented decoder, will trigger exit"
+    "Unimplemented decoder, will trigger exit"
     print("%s not handled - will now stop" % (name))
     return False
 
diff --git a/scripts/simplebench/bench_block_job.py b/scripts/simplebench/bench_block_job.py
index 56191db44b..e575a3af10 100755
--- a/scripts/simplebench/bench_block_job.py
+++ b/scripts/simplebench/bench_block_job.py
@@ -39,7 +39,7 @@ def bench_block_job(cmd, cmd_args, qemu_args):
                  binary
 
     Returns {'seconds': int} on success and {'error': str} on failure, dict may
-    contain addional 'vm-log' field. Return value is compatible with
+    contain additional 'vm-log' field. Return value is compatible with
     simplebench lib.
     """
 
diff --git a/semihosting/config.c b/semihosting/config.c
index 89a1759687..8ca569735d 100644
--- a/semihosting/config.c
+++ b/semihosting/config.c
@@ -8,7 +8,7 @@
  * targets that support it. Architecture specific handling is handled
  * in target/HW/HW-semi.c
  *
- * Semihosting is sightly strange in that it is also supported by some
+ * Semihosting is slightly strange in that it is also supported by some
  * linux-user targets. However in that use case no configuration of
  * the outputs and command lines is supported.
  *
diff --git a/semihosting/syscalls.c b/semihosting/syscalls.c
index 68899ebb1c..d27574a1e2 100644
--- a/semihosting/syscalls.c
+++ b/semihosting/syscalls.c
@@ -720,7 +720,7 @@ void semihost_sys_read_gf(CPUState *cs, gdb_syscall_complete_cb complete,
                           GuestFD *gf, target_ulong buf, target_ulong len)
 {
     /*
-     * Bound length for 64-bit guests on 32-bit hosts, not overlowing ssize_t.
+     * Bound length for 64-bit guests on 32-bit hosts, not overflowing ssize_t.
      * Note the Linux kernel does this with MAX_RW_COUNT, so it's not a bad
      * idea to do this unconditionally.
      */
@@ -761,7 +761,7 @@ void semihost_sys_write_gf(CPUState *cs, gdb_syscall_complete_cb complete,
                            GuestFD *gf, target_ulong buf, target_ulong len)
 {
     /*
-     * Bound length for 64-bit guests on 32-bit hosts, not overlowing ssize_t.
+     * Bound length for 64-bit guests on 32-bit hosts, not overflowing ssize_t.
      * Note the Linux kernel does this with MAX_RW_COUNT, so it's not a bad
      * idea to do this unconditionally.
      */
diff --git a/softmmu/icount.c b/softmmu/icount.c
index a5cef9c60a..144e24829c 100644
--- a/softmmu/icount.c
+++ b/softmmu/icount.c
@@ -325,7 +325,7 @@ void icount_start_warp_timer(void)
              * vCPU is sleeping and warp can't be started.
              * It is probably a race condition: notification sent
              * to vCPU was processed in advance and vCPU went to sleep.
-             * Therefore we have to wake it up for doing someting.
+             * Therefore we have to wake it up for doing something.
              */
             if (replay_has_event()) {
                 qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
diff --git a/softmmu/ioport.c b/softmmu/ioport.c
index b66e0a5a8e..1824aa808c 100644
--- a/softmmu/ioport.c
+++ b/softmmu/ioport.c
@@ -22,7 +22,7 @@
  * THE SOFTWARE.
  */
 /*
- * splitted out ioport related stuffs from vl.c.
+ * split out ioport related stuffs from vl.c.
  */
 
 #include "qemu/osdep.h"
diff --git a/stubs/colo.c b/stubs/colo.c
index f33379d0fd..08c9f982d5 100644
--- a/stubs/colo.c
+++ b/stubs/colo.c
@@ -21,7 +21,7 @@ void colo_checkpoint_delay_set(void)
 
 void migrate_start_colo_process(MigrationState *s)
 {
-    error_report("Impossible happend: trying to start COLO when COLO "
+    error_report("Impossible happened: trying to start COLO when COLO "
                  "module is not built in");
     abort();
 }
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index fcd20bfd3a..13306665af 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -191,7 +191,7 @@ enum {
 
    That said, we're only emulating Unix PALcode, and not attempting VMS,
    so we don't need to implement Executive and Supervisor.  QEMU's own
-   PALcode cheats and usees the KSEG mapping for its code+data rather than
+   PALcode cheats and uses the KSEG mapping for its code+data rather than
    physical addresses.  */
 
 #define MMU_KERNEL_IDX   0
@@ -362,7 +362,7 @@ enum {
    The Unix PALcode only uses bit 4.  */
 #define PS_USER_MODE  8u
 
-/* CPUAlphaState->flags constants.  These are layed out so that we
+/* CPUAlphaState->flags constants.  These are laid out so that we
    can set or reset the pieces individually by assigning to the byte,
    or manipulated as a whole.  */
 
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 1f7dd078d8..846f3d8091 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2893,7 +2893,7 @@ static void alpha_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
        the first fp insn of the TB.  Alternately we could define a proper
        default for every TB (e.g. QUAL_RM_N or QUAL_RM_D) and make sure
        to reset the FP_STATUS to that default at the end of any TB that
-       changes the default.  We could even (gasp) dynamiclly figure out
+       changes the default.  We could even (gasp) dynamically figure out
        what default would be most efficient given the running program.  */
     ctx->tb_rm = -1;
     /* Similarly for flush-to-zero.  */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 69e2bde3c2..93c28d50e5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -677,7 +677,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
     }
 
     /*
-     * The PSTATE bits only mask the interrupt if we have not overriden the
+     * The PSTATE bits only mask the interrupt if we have not overridden the
      * ability above.
      */
     return unmasked || pstate_unmasked;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4d6c0f95d5..88e5accda6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2592,7 +2592,7 @@ static inline bool arm_el_is_aa64(CPUARMState *env, int el)
     return aa64;
 }
 
-/* Function for determing whether guest cp register reads and writes should
+/* Function for determining whether guest cp register reads and writes should
  * access the secure or non-secure bank of a cp register.  When EL3 is
  * operating in AArch32 state, the NS-bit determines whether the secure
  * instance of a cp register should be used. When EL3 is AArch64 (or if
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 6012e4ef54..96158093cc 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -95,7 +95,7 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
 
         if (kvm_enabled()) {
             /*
-             * For KVM we have to automatically enable all supported unitialized
+             * For KVM we have to automatically enable all supported uninitialized
              * lengths, even when the smaller lengths are not all powers-of-two.
              */
             vq_map |= vq_supported & ~vq_init & vq_mask;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8e836aaee1..50f61e42ca 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1674,7 +1674,7 @@ static void pmevtyper_rawwrite(CPUARMState *env, const ARMCPRegInfo *ri,
      * pmevtyper_rawwrite is called between a pair of pmu_op_start and
      * pmu_op_finish calls when loading saved state for a migration. Because
      * we're potentially updating the type of event here, the value written to
-     * c14_pmevcntr_delta by the preceeding pmu_op_start call may be for a
+     * c14_pmevcntr_delta by the preceding pmu_op_start call may be for a
      * different counter type. Therefore, we need to set this value to the
      * current count for the counter type we're writing so that pmu_op_finish
      * has the correct count for its calculation.
@@ -7009,7 +7009,7 @@ static const ARMCPRegInfo rme_reginfo[] = {
     /*
      * QEMU does not have a way to invalidate by physical address, thus
      * invalidating a range of physical addresses is accomplished by
-     * flushing all tlb entries in the outer sharable domain,
+     * flushing all tlb entries in the outer shareable domain,
      * just like PAALLOS.
      */
     { .name = "TLBI_RPALOS", .state = ARM_CP_STATE_AA64,
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 9cef70e5c9..0045c18f80 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -148,7 +148,7 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
      *  R: 0 because unpriv and A flag not set
      *  SRVALID: 0 because NS
      *  MRVALID: 0 because unpriv and A flag not set
-     *  SREGION: 0 becaus SRVALID is 0
+     *  SREGION: 0 because SRVALID is 0
      *  MREGION: 0 because MRVALID is 0
      */
     return 0;
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 7d0c8f79a7..ef0c47407a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -182,7 +182,7 @@ void gen_a64_update_pc(DisasContext *s, target_long diff)
  *  + for EL2 and EL3 there is only one TBI bit, and if it is set
  *    then the address is zero-extended, clearing bits [63:56]
  *  + for EL0 and EL1, TBI0 controls addresses with bit 55 == 0
- *    and TBI1 controls addressses with bit 55 == 1.
+ *    and TBI1 controls addresses with bit 55 == 1.
  *    If the appropriate TBI bit is set for the address then
  *    the address is sign-extended from bit 55 into bits [63:56]
  *
@@ -2313,7 +2313,7 @@ static void handle_sys(DisasContext *s, bool isread,
 
     if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
         /*
-         * A write to any coprocessor regiser that ends a TB
+         * A write to any coprocessor register that ends a TB
          * must rebuild the hflags for the next TB.
          */
         gen_rebuild_hflags(s);
diff --git a/target/arm/tcg/translate-mve.c b/target/arm/tcg/translate-mve.c
index bbc7b3f4ce..17d8e6804e 100644
--- a/target/arm/tcg/translate-mve.c
+++ b/target/arm/tcg/translate-mve.c
@@ -2182,7 +2182,7 @@ static bool trans_VMOV_to_2gp(DisasContext *s, arg_VMOV_to_2gp *a)
      * execution if it is not in an IT block. For us this means
      * only that if PSR.ECI says we should not be executing the beat
      * corresponding to the lane of the vector register being accessed
-     * then we should skip perfoming the move, and that we need to do
+     * then we should skip performing the move, and that we need to do
      * the usual check for bad ECI state and advance of ECI state.
      * (If PSR.ECI is non-zero then we cannot be in an IT block.)
      */
@@ -2225,7 +2225,7 @@ static bool trans_VMOV_from_2gp(DisasContext *s, arg_VMOV_to_2gp *a)
      * execution if it is not in an IT block. For us this means
      * only that if PSR.ECI says we should not be executing the beat
      * corresponding to the lane of the vector register being accessed
-     * then we should skip perfoming the move, and that we need to do
+     * then we should skip performing the move, and that we need to do
      * the usual check for bad ECI state and advance of ECI state.
      * (If PSR.ECI is non-zero then we cannot be in an IT block.)
      */
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 8350a65f31..2ba5efadfd 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -1841,7 +1841,7 @@ TRANS_FEAT(PNEXT, aa64_sve, do_pfirst_pnext, a, gen_helper_sve_pnext)
 
 /* Perform an inline saturating addition of a 32-bit value within
  * a 64-bit register.  The second operand is known to be positive,
- * which halves the comparisions we must perform to bound the result.
+ * which halves the comparisons we must perform to bound the result.
  */
 static void do_sat_addsub_32(TCGv_i64 reg, TCGv_i64 val, bool u, bool d)
 {
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 359b1e3e96..d3e89fda91 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -144,7 +144,7 @@ static void gen_preserve_fp_state(DisasContext *s, bool skip_context_update)
  * Generate code for M-profile FP context handling: update the
  * ownership of the FP context, and create a new context if
  * necessary. This corresponds to the parts of the pseudocode
- * ExecuteFPCheck() after the inital PreserveFPState() call.
+ * ExecuteFPCheck() after the initial PreserveFPState() call.
  */
 static void gen_update_fp_context(DisasContext *s)
 {
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index f59d3b26ea..6712a2c790 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2626,7 +2626,7 @@ void HELPER(gvec_bfmmla)(void *vd, void *vn, void *vm, void *va, uint32_t desc)
          * Process the entire segment at once, writing back the
          * results only after we've consumed all of the inputs.
          *
-         * Key to indicies by column:
+         * Key to indices by column:
          *               i   j           i   k             j   k
          */
         sum00 = a[s + H4(0 + 0)];
diff --git a/target/cris/helper.c b/target/cris/helper.c
index 81a72699b5..6011155be4 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -63,7 +63,7 @@ bool cris_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                               access_type, mmu_idx, 0);
     if (likely(!miss)) {
         /*
-         * Mask off the cache selection bit. The ETRAX busses do not
+         * Mask off the cache selection bit. The ETRAX buses do not
          * see the top bit.
          */
         phy = res.phy & ~0x80000000;
@@ -113,7 +113,7 @@ void crisv10_cpu_do_interrupt(CPUState *cs)
     assert(!(env->pregs[PR_CCS] & PFIX_FLAG));
     switch (cs->exception_index) {
     case EXCP_BREAK:
-        /* These exceptions are genereated by the core itself.
+        /* These exceptions are generated by the core itself.
            ERP should point to the insn following the brk.  */
         ex_vec = env->trap_vector;
         env->pregs[PRV10_BRP] = env->pc;
@@ -169,7 +169,7 @@ void cris_cpu_do_interrupt(CPUState *cs)
 
     switch (cs->exception_index) {
     case EXCP_BREAK:
-        /* These exceptions are genereated by the core itself.
+        /* These exceptions are generated by the core itself.
            ERP should point to the insn following the brk.  */
         ex_vec = env->trap_vector;
         env->pregs[PR_ERP] = env->pc;
@@ -228,7 +228,7 @@ void cris_cpu_do_interrupt(CPUState *cs)
        undefined.  */
     env->pc = cpu_ldl_code(env, env->pregs[PR_EBP] + ex_vec * 4);
 
-    /* Clear the excption_index to avoid spurios hw_aborts for recursive
+    /* Clear the excption_index to avoid spurious hw_aborts for recursive
        bus faults.  */
     cs->exception_index = -1;
 
diff --git a/target/cris/op_helper.c b/target/cris/op_helper.c
index d55a18a213..40cb74ce73 100644
--- a/target/cris/op_helper.c
+++ b/target/cris/op_helper.c
@@ -231,7 +231,7 @@ static inline uint32_t evaluate_flags_writeback(CPUCRISState *env,
 {
     unsigned int x, z, mask;
 
-    /* Extended arithmetics, leave the z flag alone.  */
+    /* Extended arithmetic, leave the z flag alone.  */
     x = env->cc_x;
     mask = env->cc_mask | X_FLAG;
     if (x) {
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 1445cd8bb5..0b3d724281 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -342,7 +342,7 @@ static void t_gen_cris_mstep(TCGv d, TCGv a, TCGv b, TCGv ccs)
     tcg_gen_add_tl(d, d, t);
 }
 
-/* Extended arithmetics on CRIS.  */
+/* Extended arithmetic on CRIS.  */
 static inline void t_gen_add_flag(TCGv d, int flag)
 {
     TCGv c;
@@ -646,7 +646,7 @@ static void cris_alu_op_exec(DisasContext *dc, int op,
     switch (op) {
     case CC_OP_ADD:
         tcg_gen_add_tl(dst, a, b);
-        /* Extended arithmetics.  */
+        /* Extended arithmetic.  */
         t_gen_addx_carry(dc, dst);
         break;
     case CC_OP_ADDC:
@@ -659,7 +659,7 @@ static void cris_alu_op_exec(DisasContext *dc, int op,
         break;
     case CC_OP_SUB:
         tcg_gen_sub_tl(dst, a, b);
-        /* Extended arithmetics.  */
+        /* Extended arithmetic.  */
         t_gen_subx_carry(dc, dst);
         break;
     case CC_OP_MOVE:
@@ -685,7 +685,7 @@ static void cris_alu_op_exec(DisasContext *dc, int op,
         break;
     case CC_OP_NEG:
         tcg_gen_neg_tl(dst, b);
-        /* Extended arithmetics.  */
+        /* Extended arithmetic.  */
         t_gen_subx_carry(dc, dst);
         break;
     case CC_OP_LZ:
@@ -708,7 +708,7 @@ static void cris_alu_op_exec(DisasContext *dc, int op,
         break;
     case CC_OP_CMP:
         tcg_gen_sub_tl(dst, a, b);
-        /* Extended arithmetics.  */
+        /* Extended arithmetic.  */
         t_gen_subx_carry(dc, dst);
         break;
     default:
@@ -2924,12 +2924,12 @@ static unsigned int crisv32_decoder(CPUCRISState *env, DisasContext *dc)
  * On QEMU care needs to be taken when a branch+delayslot sequence is broken
  * and the branch and delayslot don't share pages.
  *
- * The TB contaning the branch insn will set up env->btarget and evaluate 
+ * The TB containing the branch insn will set up env->btarget and evaluate 
  * env->btaken. When the translation loop exits we will note that the branch 
  * sequence is broken and let env->dslot be the size of the branch insn (those
  * vary in length).
  *
- * The TB contaning the delayslot will have the PC of its real insn (i.e no lsb
+ * The TB containing the delayslot will have the PC of its real insn (i.e no lsb
  * set). It will also expect to have env->dslot setup with the size of the 
  * delay slot so that env->pc - env->dslot point to the branch insn. This TB 
  * will execute the dslot and take the branch, either to btarget or just one 
@@ -3143,7 +3143,7 @@ static void cris_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         tcg_gen_lookup_and_goto_ptr();
         break;
     case DISAS_UPDATE:
-        /* Indicate that interupts must be re-evaluated before the next TB. */
+        /* Indicate that interrupts must be re-evaluated before the next TB. */
         tcg_gen_exit_tb(NULL, 0);
         break;
     default:
diff --git a/target/hexagon/README b/target/hexagon/README
index 43811178e9..e757bcb64a 100644
--- a/target/hexagon/README
+++ b/target/hexagon/README
@@ -239,7 +239,7 @@ helper_funcs_generated.c.inc.  There are also several helpers used for debugging
 
 VLIW packet semantics differ from serial semantics in that all input operands
 are read, then the operations are performed, then all the results are written.
-For exmaple, this packet performs a swap of registers r0 and r1
+For example, this packet performs a swap of registers r0 and r1
     { r0 = r1; r1 = r0 }
 Note that the result is different if the instructions are executed serially.
 
diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
index d3b45d494f..05a56d8c10 100644
--- a/target/hexagon/fma_emu.c
+++ b/target/hexagon/fma_emu.c
@@ -415,7 +415,7 @@ static SUFFIX accum_round_##SUFFIX(Accum a, float_status * fp_status) \
      * We want to normalize left until we have a leading one in bit 24 \
      * Theoretically, we only need to shift a maximum of one to the left if we \
      * shifted out lots of bits from B, or if we had no shift / 1 shift sticky \
-     * shoudl be 0  \
+     * should be 0  \
      */ \
     while ((int128_getlo(a.mant) & (1ULL << MANTBITS)) == 0) { \
         a = accum_norm_left(a); \
diff --git a/target/hexagon/idef-parser/README.rst b/target/hexagon/idef-parser/README.rst
index debeddfde5..d0aa34309b 100644
--- a/target/hexagon/idef-parser/README.rst
+++ b/target/hexagon/idef-parser/README.rst
@@ -440,7 +440,7 @@ interested part of the grammar.
 
 Run-time errors can be divided between lexing and parsing errors, lexing errors
 are hard to detect, since the ``var`` token will catch everything which is not
-catched by other tokens, but easy to fix, because most of the time a simple
+caught by other tokens, but easy to fix, because most of the time a simple
 regex editing will be enough.
 
 idef-parser features a fancy parsing error reporting scheme, which for each
diff --git a/target/hexagon/idef-parser/idef-parser.h b/target/hexagon/idef-parser/idef-parser.h
index d23e71f13b..3faa1deecd 100644
--- a/target/hexagon/idef-parser/idef-parser.h
+++ b/target/hexagon/idef-parser/idef-parser.h
@@ -73,7 +73,7 @@ typedef struct HexTmp {
 } HexTmp;
 
 /**
- * Enum of the possible immediated, an immediate is a value which is known
+ * Enum of the possible immediate, an immediate is a value which is known
  * at tinycode generation time, e.g. an integer value, not a TCGv
  */
 enum ImmUnionTag {
diff --git a/target/hexagon/idef-parser/parser-helpers.c b/target/hexagon/idef-parser/parser-helpers.c
index 7b5ebafec2..ec43343801 100644
--- a/target/hexagon/idef-parser/parser-helpers.c
+++ b/target/hexagon/idef-parser/parser-helpers.c
@@ -459,7 +459,7 @@ static bool try_find_variable(Context *c, YYLTYPE *locp,
     return false;
 }
 
-/* Calls `try_find_variable` and asserts succcess. */
+/* Calls `try_find_variable` and asserts success. */
 static void find_variable(Context *c, YYLTYPE *locp,
                           HexValue *dst,
                           HexValue *varid)
@@ -549,7 +549,7 @@ HexValue gen_bin_cmp(Context *c,
             ");\n");
         break;
     default:
-        fprintf(stderr, "Error in evalutating immediateness!");
+        fprintf(stderr, "Error in evaluating immediateness!");
         abort();
     }
     return res;
@@ -1164,7 +1164,7 @@ void gen_rdeposit_op(Context *c,
 {
     /*
      * Otherwise if the width is not known, we fallback on reimplementing
-     * desposit in TCG.
+     * deposit in TCG.
      */
     HexValue begin_m = *begin;
     HexValue value_m = *value;
diff --git a/target/hexagon/imported/alu.idef b/target/hexagon/imported/alu.idef
index 58477ae40a..12d2aac5d4 100644
--- a/target/hexagon/imported/alu.idef
+++ b/target/hexagon/imported/alu.idef
@@ -292,16 +292,16 @@ Q6INSN(A4_combineii,"Rdd32=combine(#s8,#U6)",ATTRIBS(),"Set two small immediates
 
 
 Q6INSN(A2_combine_hh,"Rd32=combine(Rt.H32,Rs.H32)",ATTRIBS(),
-"Combine two halfs into a register", {RdV = (fGETUHALF(1,RtV)<<16) | fGETUHALF(1,RsV);})
+"Combine two halves into a register", {RdV = (fGETUHALF(1,RtV)<<16) | fGETUHALF(1,RsV);})
 
 Q6INSN(A2_combine_hl,"Rd32=combine(Rt.H32,Rs.L32)",ATTRIBS(),
-"Combine two halfs into a register", {RdV = (fGETUHALF(1,RtV)<<16) | fGETUHALF(0,RsV);})
+"Combine two halves into a register", {RdV = (fGETUHALF(1,RtV)<<16) | fGETUHALF(0,RsV);})
 
 Q6INSN(A2_combine_lh,"Rd32=combine(Rt.L32,Rs.H32)",ATTRIBS(),
-"Combine two halfs into a register", {RdV = (fGETUHALF(0,RtV)<<16) | fGETUHALF(1,RsV);})
+"Combine two halves into a register", {RdV = (fGETUHALF(0,RtV)<<16) | fGETUHALF(1,RsV);})
 
 Q6INSN(A2_combine_ll,"Rd32=combine(Rt.L32,Rs.L32)",ATTRIBS(),
-"Combine two halfs into a register", {RdV = (fGETUHALF(0,RtV)<<16) | fGETUHALF(0,RsV);})
+"Combine two halves into a register", {RdV = (fGETUHALF(0,RtV)<<16) | fGETUHALF(0,RsV);})
 
 Q6INSN(A2_tfril,"Rx.L32=#u16",ATTRIBS(),
 "Set low 16-bits, leave upper 16 unchanged",{ fSETHALF(0,RxV,uiV);})
diff --git a/target/hexagon/imported/macros.def b/target/hexagon/imported/macros.def
index e23f91562e..4bbcfdd5e1 100755
--- a/target/hexagon/imported/macros.def
+++ b/target/hexagon/imported/macros.def
@@ -902,7 +902,7 @@ DEF_MACRO(
 )
 
 DEF_MACRO(
-    fEA_GPI, /* Calculate EA with Global Poitner + Immediate */
+    fEA_GPI, /* Calculate EA with Global Pointer + Immediate */
     do { EA=fREAD_GP()+IMM; fGP_DOCHKPAGECROSS(fREAD_GP(),EA); } while (0),
     ()
 )
diff --git a/target/hexagon/imported/mmvec/ext.idef b/target/hexagon/imported/mmvec/ext.idef
index ead32c243b..98daabfb07 100644
--- a/target/hexagon/imported/mmvec/ext.idef
+++ b/target/hexagon/imported/mmvec/ext.idef
@@ -17,7 +17,7 @@
 
 /******************************************************************************
  *
- *     HOYA: MULTI MEDIA INSTRUCITONS
+ *     HOYA: MULTI MEDIA INSTRUCTIONS
  *
  ******************************************************************************/
 
@@ -295,7 +295,7 @@ MMVEC_COND_EACH_EA(vS32Ub,"Unaligned Vector Store",ATTRIBS(ATTR_VMEMU,A_STORE,A_
 
 MMVEC_EACH_EA(vS32b_new,"Aligned Vector Store New",ATTRIBS(ATTR_VMEM,A_STORE,A_CVI_NEW,A_DOTNEWVALUE,A_RESTRICT_SLOT0ONLY),,"vmem","=Os8.new",fSTOREMMV(EA,fNEWVREG(OsN)))
 
-// V65 store relase, zero byte store
+// V65 store release, zero byte store
 MMVEC_EACH_EA(vS32b_srls,"Aligned Vector Scatter Release",ATTRIBS(ATTR_VMEM,A_STORE,A_CVI_SCATTER_RELEASE,A_CVI_NEW,A_RESTRICT_SLOT0ONLY),,"vmem",":scatter_release",fSTORERELEASE(EA,0))
 
 
@@ -2045,11 +2045,11 @@ VxV.uw[0] = RtV;)
 
 
 
-ITERATOR_INSN_MPY_SLOT_LATE(32,lvsplatw, "Vd32=vsplat(Rt32)", "Replicates scalar accross words in vector", VdV.uw[i] = RtV)
+ITERATOR_INSN_MPY_SLOT_LATE(32,lvsplatw, "Vd32=vsplat(Rt32)", "Replicates scalar across words in vector", VdV.uw[i] = RtV)
 
-ITERATOR_INSN_MPY_SLOT_LATE(16,lvsplath, "Vd32.h=vsplat(Rt32)", "Replicates scalar accross halves in vector", VdV.uh[i] = RtV)
+ITERATOR_INSN_MPY_SLOT_LATE(16,lvsplath, "Vd32.h=vsplat(Rt32)", "Replicates scalar across halves in vector", VdV.uh[i] = RtV)
 
-ITERATOR_INSN_MPY_SLOT_LATE(8,lvsplatb, "Vd32.b=vsplat(Rt32)", "Replicates scalar accross bytes in vector", VdV.ub[i] = RtV)
+ITERATOR_INSN_MPY_SLOT_LATE(8,lvsplatb, "Vd32.b=vsplat(Rt32)", "Replicates scalar across bytes in vector", VdV.ub[i] = RtV)
 
 
 ITERATOR_INSN_ANY_SLOT(32,vassign,"Vd32=Vu32","Copy a vector",VdV.w[i]=VuV.w[i])
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 7373177b55..9fe79b1242 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -35,7 +35,7 @@
 #define MMU_PHYS_IDX     4
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
-/* Hardware exceptions, interupts, faults, and traps.  */
+/* Hardware exceptions, interrupts, faults, and traps.  */
 #define EXCP_HPMC                1  /* high priority machine check */
 #define EXCP_POWER_FAIL          2
 #define EXCP_RC                  3  /* recovery counter */
@@ -276,7 +276,7 @@ static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
     /* TB lookup assumes that PC contains the complete virtual address.
        If we leave space+offset separate, we'll get ITLB misses to an
        incomplete virtual address.  This also means that we must separate
-       out current cpu priviledge from the low bits of IAOQ_F.  */
+       out current cpu privilege from the low bits of IAOQ_F.  */
 #ifdef CONFIG_USER_ONLY
     *pc = env->iaoq_f & -4;
     *cs_base = env->iaoq_b & -4;
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index d2480b163b..bebc732c97 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -37,7 +37,7 @@ static void eval_interrupt(HPPACPU *cpu)
 
 /* Each CPU has a word mapped into the GSC bus.  Anything on the GSC bus
  * can write to this word to raise an external interrupt on the target CPU.
- * This includes the system controler (DINO) for regular devices, or
+ * This includes the system controller (DINO) for regular devices, or
  * another CPU for SMP interprocessor interrupts.
  */
 static uint64_t io_eir_read(void *opaque, hwaddr addr, unsigned size)
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index d33813d173..d66fcb3e6a 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1964,7 +1964,7 @@ static void do_page_zero(DisasContext *ctx)
 {
     /* If by some means we get here with PSW[N]=1, that implies that
        the B,GATE instruction would be skipped, and we'd fault on the
-       next insn within the privilaged page.  */
+       next insn within the privileged page.  */
     switch (ctx->null_cond.c) {
     case TCG_COND_NEVER:
         break;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 97ad229d8b..fd2afd4b3c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5336,7 +5336,7 @@ static const char *x86_cpu_feature_name(FeatureWord w, int bitnr)
     return name;
 }
 
-/* Compatibily hack to maintain legacy +-feat semantic,
+/* Compatibility hack to maintain legacy +-feat semantic,
  * where +-feat overwrites any feature set by
  * feat=on|feat even if the later is parsed after +-feat
  * (i.e. "-x2apic,x2apic=on" will result in x2apic disabled)
@@ -6300,7 +6300,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              * The initial value of xcr0 and ebx == 0, On host without kvm
              * commit 412a3c41(e.g., CentOS 6), the ebx's value always == 0
              * even through guest update xcr0, this will crash some legacy guest
-             * (e.g., CentOS 6), So set ebx == ecx to workaroud it.
+             * (e.g., CentOS 6), So set ebx == ecx to workaround it.
              */
             *ebx = kvm_enabled() ? *ecx : xsave_area_size(env->xcr0, false);
         } else if (count == 1) {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e0771a1043..b3fbcae52f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -728,7 +728,7 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_EXT2_3DNOWEXT (1U << 30)
 #define CPUID_EXT2_3DNOW   (1U << 31)
 
-/* CPUID[8000_0001].EDX bits that are aliase of CPUID[1].EDX bits on AMD CPUs */
+/* CPUID[8000_0001].EDX bits that are aliases of CPUID[1].EDX bits on AMD CPUs */
 #define CPUID_EXT2_AMD_ALIASES (CPUID_EXT2_FPU | CPUID_EXT2_VME | \
                                 CPUID_EXT2_DE | CPUID_EXT2_PSE | \
                                 CPUID_EXT2_TSC | CPUID_EXT2_MSR | \
@@ -2068,7 +2068,7 @@ hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
 int cpu_get_pic_interrupt(CPUX86State *s);
 
-/* MSDOS compatibility mode FPU exception support */
+/* MS-DOS compatibility mode FPU exception support */
 void x86_register_ferr_irq(qemu_irq irq);
 void fpu_check_raise_ferr_irq(CPUX86State *s);
 void cpu_set_ignne(void);
diff --git a/target/i386/hax/hax-interface.h b/target/i386/hax/hax-interface.h
index 537ae084e9..edef4fdf5d 100644
--- a/target/i386/hax/hax-interface.h
+++ b/target/i386/hax/hax-interface.h
@@ -238,7 +238,7 @@ enum exit_status {
     HAX_EXIT_UNKNOWN_VMEXIT,
     /* HALT from guest */
     HAX_EXIT_HLT,
-    /* Reboot request, like because of tripple fault in guest */
+    /* Reboot request, like because of triple fault in guest */
     HAX_EXIT_STATECHANGE,
     /* the vcpu is now only paused when destroy, so simply return to hax */
     HAX_EXIT_PAUSED,
@@ -295,7 +295,7 @@ struct hax_qemu_version {
     uint32_t min_version;
 } __attribute__ ((__packed__));
 
-/* The mac specfic interface to qemu, mostly is ioctl related */
+/* The mac specific interface to qemu, mostly is ioctl related */
 struct hax_tunnel_info {
     uint64_t va;
     uint64_t io_va;
diff --git a/target/i386/hax/hax-windows.c b/target/i386/hax/hax-windows.c
index 4bf6cc08d2..58cf3f1a9f 100644
--- a/target/i386/hax/hax-windows.c
+++ b/target/i386/hax/hax-windows.c
@@ -174,7 +174,7 @@ int hax_mod_version(struct hax_state *hax, struct hax_module_version *version)
     if (!ret) {
         err = GetLastError();
         if (err == ERROR_INSUFFICIENT_BUFFER || err == ERROR_MORE_DATA) {
-            fprintf(stderr, "hax module verion is too long to hold.\n");
+            fprintf(stderr, "hax module version is too long to hold.\n");
         }
         fprintf(stderr, "Failed to get Hax module version:%lu\n", err);
         return -EFAULT;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index ebfaf3d24c..9d18d3336f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4724,7 +4724,7 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
     /*
      * Put MSR_IA32_FEATURE_CONTROL first, this ensures the VM gets out of VMX
      * root operation upon vCPU reset. kvm_put_msr_feature_control() should also
-     * preceed kvm_put_nested_state() when 'real' nested state is set.
+     * proceed kvm_put_nested_state() when 'real' nested state is set.
      */
     if (level >= KVM_PUT_RESET_STATE) {
         ret = kvm_put_msr_feature_control(x86_cpu);
@@ -5650,7 +5650,7 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
             }
 
             /*
-             * Handled untranslated compatibilty format interrupt with
+             * Handled untranslated compatibility format interrupt with
              * extended destination ID in the low bits 11-5. */
             dst.address = kvm_swizzle_msi_ext_dest_id(dst.address);
 
diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index d7c7eb8d9c..6695f2a0c6 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -1026,7 +1026,7 @@ static int do_set_periodic_timer(CPUState *target, uint64_t period_ns)
 #define MILLISECS(_ms)  ((int64_t)((_ms) * 1000000ULL))
 #define MICROSECS(_us)  ((int64_t)((_us) * 1000ULL))
 #define STIME_MAX ((time_t)((int64_t)~0ull >> 1))
-/* Chosen so (NOW() + delta) wont overflow without an uptime of 200 years */
+/* Chosen so (NOW() + delta) won't overflow without an uptime of 200 years */
 #define STIME_DELTA_MAX ((int64_t)((uint64_t)~0ull >> 2))
 
 static int vcpuop_set_periodic_timer(CPUState *cs, CPUState *target,
diff --git a/target/i386/machine.c b/target/i386/machine.c
index c7ac8084b2..a1041ef828 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -282,12 +282,12 @@ static int cpu_pre_save(void *opaque)
      * hypervisor, its exception payload (CR2/DR6 on #PF/#DB)
      * should not be set yet in the respective vCPU register.
      * Thus, in case an exception is pending, it is
-     * important to save the exception payload seperately.
+     * important to save the exception payload separately.
      *
      * Therefore, if an exception is not in a pending state
      * or vCPU is not in guest-mode, it is not important to
      * distinguish between a pending and injected exception
-     * and we don't need to store seperately the exception payload.
+     * and we don't need to store separately the exception payload.
      *
      * In order to preserve better backwards-compatible migration,
      * convert a pending exception to an injected exception in
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 90c7b32f36..c1ab3efba9 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1069,7 +1069,7 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
 }
 
 /* perform a conditional store into register 'reg' according to jump opcode
-   value 'b'. In the fast case, T0 is guaranted not to be used. */
+   value 'b'. In the fast case, T0 is guaranteed not to be used. */
 static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
 {
     int inv, jcc_op, cond;
@@ -1202,7 +1202,7 @@ static inline void gen_compute_eflags_c(DisasContext *s, TCGv reg)
 }
 
 /* generate a conditional jump to label 'l1' according to jump opcode
-   value 'b'. In the fast case, T0 is guaranted not to be used. */
+   value 'b'. In the fast case, T0 is guaranteed not to be used. */
 static inline void gen_jcc1_noeob(DisasContext *s, int b, TCGLabel *l1)
 {
     CCPrepare cc = gen_prepare_cc(s, b, s->T0);
@@ -1219,7 +1219,7 @@ static inline void gen_jcc1_noeob(DisasContext *s, int b, TCGLabel *l1)
 }
 
 /* Generate a conditional jump to label 'l1' according to jump opcode
-   value 'b'. In the fast case, T0 is guaranted not to be used.
+   value 'b'. In the fast case, T0 is guaranteed not to be used.
    A translation block must end soon.  */
 static inline void gen_jcc1(DisasContext *s, int b, TCGLabel *l1)
 {
@@ -5351,7 +5351,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         if (s->prefix & PREFIX_LOCK) {
             switch (op) {
             case 0: /* bt */
-                /* Needs no atomic ops; we surpressed the normal
+                /* Needs no atomic ops; we suppressed the normal
                    memory load for LOCK above so do it now.  */
                 gen_op_ld_v(s, ot, s->T0, s->A0);
                 break;
diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index 4c8ce7fed5..f8f24032cb 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -10,7 +10,7 @@
 
 #include "hw/registerfields.h"
 
-/* Base on kernal definitions: arch/loongarch/include/asm/loongarch.h */
+/* Based on kernel definitions: arch/loongarch/include/asm/loongarch.h */
 
 /* Basic CSRs */
 #define LOONGARCH_CSR_CRMD           0x0 /* Current mode info */
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 01c18a7c59..0a1544cd68 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -590,10 +590,10 @@ static void dump_address_map(CPUM68KState *env, uint32_t root_pointer)
 
 #define DUMP_CACHEFLAGS(a) \
     switch (a & M68K_DESC_CACHEMODE) { \
-    case M68K_DESC_CM_WRTHRU: /* cachable, write-through */ \
+    case M68K_DESC_CM_WRTHRU: /* cacheable, write-through */ \
         qemu_printf("T"); \
         break; \
-    case M68K_DESC_CM_COPYBK: /* cachable, copyback */ \
+    case M68K_DESC_CM_COPYBK: /* cacheable, copyback */ \
         qemu_printf("C"); \
         break; \
     case M68K_DESC_CM_SERIAL: /* noncachable, serialized */ \
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index a7b040abd4..f6cab6ce19 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -205,7 +205,7 @@ typedef struct CPUArchState CPUMBState;
 #define PVR10_TARGET_FAMILY_MASK        0xFF000000
 #define PVR10_ASIZE_SHIFT               18
 
-/* MMU descrtiption */
+/* MMU description */
 #define PVR11_USE_MMU                   0xC0000000
 #define PVR11_MMU_ITLB_SIZE             0x38000000
 #define PVR11_MMU_DTLB_SIZE             0x07000000
diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index 03185d9aa0..c0c389c59a 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -1045,7 +1045,7 @@ static void mvp_init(CPUMIPSState *env)
         return;
     }
 
-    /* MVPConf1 implemented, TLB sharable, no gating storage support,
+    /* MVPConf1 implemented, TLB shareable, no gating storage support,
        programmable cache partitioning implemented, number of allocatable
        and shareable TLB entries, MVP has allocatable TCs, 2 VPEs
        implemented, 5 TCs implemented. */
diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index 29b31d70fe..6e93a19a93 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -802,9 +802,9 @@ void helper_msa_bset_d(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
  * | HADD_S.H      | Vector Signed Horizontal Add (halfword)                  |
  * | HADD_S.W      | Vector Signed Horizontal Add (word)                      |
  * | HADD_S.D      | Vector Signed Horizontal Add (doubleword)                |
- * | HADD_U.H      | Vector Unigned Horizontal Add (halfword)                 |
- * | HADD_U.W      | Vector Unigned Horizontal Add (word)                     |
- * | HADD_U.D      | Vector Unigned Horizontal Add (doubleword)               |
+ * | HADD_U.H      | Vector Unsigned Horizontal Add (halfword)                |
+ * | HADD_U.W      | Vector Unsigned Horizontal Add (word)                    |
+ * | HADD_U.D      | Vector Unsigned Horizontal Add (doubleword)              |
  * +---------------+----------------------------------------------------------+
  */
 
@@ -3451,9 +3451,9 @@ void helper_msa_mulv_d(CPUMIPSState *env,
  * | HSUB_S.H      | Vector Signed Horizontal Subtract (halfword)             |
  * | HSUB_S.W      | Vector Signed Horizontal Subtract (word)                 |
  * | HSUB_S.D      | Vector Signed Horizontal Subtract (doubleword)           |
- * | HSUB_U.H      | Vector Unigned Horizontal Subtract (halfword)            |
- * | HSUB_U.W      | Vector Unigned Horizontal Subtract (word)                |
- * | HSUB_U.D      | Vector Unigned Horizontal Subtract (doubleword)          |
+ * | HSUB_U.H      | Vector Unsigned Horizontal Subtract (halfword)           |
+ * | HSUB_U.W      | Vector Unsigned Horizontal Subtract (word)               |
+ * | HSUB_U.D      | Vector Unsigned Horizontal Subtract (doubleword)         |
  * | SUBS_S.B      | Vector Signed Saturated Subtract (of Signed) (byte)      |
  * | SUBS_S.H      | Vector Signed Saturated Subtract (of Signed) (halfword)  |
  * | SUBS_S.W      | Vector Signed Saturated Subtract (of Signed) (word)      |
diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index deb8060a17..993e1fca05 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -2963,14 +2963,14 @@ static void gen_mxu_Q8ADD(DisasContext *ctx)
  *    to another one in XRc, with zero extending
  *    to 16-bit and put results as packed 16-bit data
  *    into XRa and XRd.
- *    aptn2 manages action add or subract of pairs of data.
+ *    aptn2 manages action add or subtract of pairs of data.
  *
  *  Q8ACCE XRa, XRb, XRc, XRd, aptn2
  *    Add/subtract quadruple of 8-bit packed in XRb
  *    to another one in XRc, with zero extending
  *    to 16-bit and accumulate results as packed 16-bit data
  *    into XRa and XRd.
- *    aptn2 manages action add or subract of pairs of data.
+ *    aptn2 manages action add or subtract of pairs of data.
  */
 static void gen_mxu_q8adde(DisasContext *ctx, bool accumulate)
 {
@@ -4042,7 +4042,7 @@ static void gen_mxu_s32sfl(DisasContext *ctx)
 
 /*
  *  Q8SAD XRa, XRd, XRb, XRc
- *    Typical SAD opration for motion estimation.
+ *    Typical SAD operation for motion estimation.
  */
 static void gen_mxu_q8sad(DisasContext *ctx)
 {
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 92c38f54c2..ce4d605eb7 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -290,7 +290,7 @@ typedef struct CPUArchState {
     int is_counting;
 
     uint32_t picmr;         /* Interrupt mask register */
-    uint32_t picsr;         /* Interrupt contrl register*/
+    uint32_t picsr;         /* Interrupt control register */
 #endif
 } CPUOpenRISCState;
 
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 7760329e75..a86360d4f5 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -273,7 +273,7 @@ static void gen_div(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
 
     tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_sr_ov, srcb, 0);
     /* The result of divide-by-zero is undefined.
-       Supress the host-side exception by dividing by 1.  */
+       Suppress the host-side exception by dividing by 1. */
     tcg_gen_or_tl(t0, srcb, cpu_sr_ov);
     tcg_gen_div_tl(dest, srca, t0);
 
@@ -287,7 +287,7 @@ static void gen_divu(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
 
     tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_sr_cy, srcb, 0);
     /* The result of divide-by-zero is undefined.
-       Supress the host-side exception by dividing by 1.  */
+       Suppress the host-side exception by dividing by 1. */
     tcg_gen_or_tl(t0, srcb, cpu_sr_cy);
     tcg_gen_divu_tl(dest, srca, t0);
 
diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index 572b5e553a..0229ef3a9a 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -44,7 +44,7 @@ enum {
     /* PowerPC 405 cores */
     CPU_POWERPC_405D2              = 0x20010000,
     CPU_POWERPC_405D4              = 0x41810000,
-    /* PowerPC 405 microcontrolers */
+    /* PowerPC 405 microcontrollers */
     /* XXX: missing 0x200108a0 */
     CPU_POWERPC_405CRa             = 0x40110041,
     CPU_POWERPC_405CRb             = 0x401100C5,
@@ -74,7 +74,7 @@ enum {
 #define CPU_POWERPC_440              CPU_POWERPC_440GXf
     /* PowerPC 440 cores */
     CPU_POWERPC_440_XILINX         = 0x7ff21910,
-    /* PowerPC 440 microcontrolers */
+    /* PowerPC 440 microcontrollers */
     CPU_POWERPC_440EPa             = 0x42221850,
     CPU_POWERPC_440EPb             = 0x422218D3,
     CPU_POWERPC_440GPb             = 0x40120440,
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 25fac9577a..fbaf41828a 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -428,7 +428,7 @@ FIELD(MSR, LE, MSR_LE, 1)
 
 /* PMU bits */
 #define MMCR0_FC     PPC_BIT(32)         /* Freeze Counters  */
-#define MMCR0_PMAO   PPC_BIT(56)         /* Perf Monitor Alert Ocurred */
+#define MMCR0_PMAO   PPC_BIT(56)         /* Perf Monitor Alert Occurred */
 #define MMCR0_PMAE   PPC_BIT(37)         /* Perf Monitor Alert Enable */
 #define MMCR0_EBE    PPC_BIT(43)         /* Perf Monitor EBB Enable */
 #define MMCR0_FCECE  PPC_BIT(38)         /* FC on Enabled Cond or Event */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 02b7aad9b0..22355f862d 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5347,7 +5347,7 @@ static void register_970_lpar_sprs(CPUPPCState *env)
 static void register_power5p_lpar_sprs(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
-    /* Logical partitionning */
+    /* Logical partitioning */
     spr_register_kvm_hv(env, SPR_LPCR, "LPCR",
                         SPR_NOACCESS, SPR_NOACCESS,
                         SPR_NOACCESS, SPR_NOACCESS,
@@ -5750,7 +5750,7 @@ static void register_power9_mmu_sprs(CPUPPCState *env)
 static void register_power10_hash_sprs(CPUPPCState *env)
 {
     /*
-     * it's the OS responsability to generate a random value for the registers
+     * it's the OS responsibility to generate a random value for the registers
      * in each process' context. So, initialize it with 0 here.
      */
     uint64_t hashkeyr_initial_value = 0, hashpkeyr_initial_value = 0;
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 003805b202..231b30e7c8 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -455,7 +455,7 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
 
     /*
      * new interrupt handler msr preserves existing ME unless
-     * explicitly overriden.
+     * explicitly overridden.
      */
     new_msr = env->msr & (((target_ulong)1 << MSR_ME));
 
@@ -578,7 +578,7 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
 
     /*
      * new interrupt handler msr preserves existing ME unless
-     * explicitly overriden
+     * explicitly overridden
      */
     new_msr = env->msr & ((target_ulong)1 << MSR_ME);
 
@@ -739,7 +739,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
 
     /*
      * new interrupt handler msr preserves existing ME unless
-     * explicitly overriden
+     * explicitly overridden
      */
     new_msr = env->msr & ((target_ulong)1 << MSR_ME);
 
@@ -910,7 +910,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
 
     /*
      * new interrupt handler msr preserves existing ME unless
-     * explicitly overriden
+     * explicitly overridden
      */
     new_msr = env->msr & ((target_ulong)1 << MSR_ME);
 
@@ -1073,7 +1073,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
 
     /*
      * new interrupt handler msr preserves existing ME unless
-     * explicitly overriden
+     * explicitly overridden
      */
     new_msr = env->msr & ((target_ulong)1 << MSR_ME);
 
@@ -1286,7 +1286,7 @@ static bool books_vhyp_handles_hcall(PowerPCCPU *cpu)
 /*
  * When running a nested KVM HV guest under vhyp, HV exceptions are not
  * delivered to the guest (because there is no concept of HV support), but
- * rather they are sent tothe vhyp to exit from the L2 back to the L1 and
+ * rather they are sent to the vhyp to exit from the L2 back to the L1 and
  * return from the H_ENTER_NESTED hypercall.
  */
 static bool books_vhyp_handles_hv_excp(PowerPCCPU *cpu)
@@ -1375,7 +1375,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 
     /*
      * new interrupt handler msr preserves existing HV and ME unless
-     * explicitly overriden
+     * explicitly overridden
      */
     new_msr = env->msr & (((target_ulong)1 << MSR_ME) | MSR_HVB);
 
diff --git a/target/ppc/power8-pmu-regs.c.inc b/target/ppc/power8-pmu-regs.c.inc
index c82feedaff..75513db894 100644
--- a/target/ppc/power8-pmu-regs.c.inc
+++ b/target/ppc/power8-pmu-regs.c.inc
@@ -16,7 +16,7 @@
  * Checks whether the Group A SPR (MMCR0, MMCR2, MMCRA, and the
  * PMCs) has problem state read access.
  *
- * Read acccess is granted for all PMCC values but 0b01, where a
+ * Read access is granted for all PMCC values but 0b01, where a
  * Facility Unavailable Interrupt will occur.
  */
 static bool spr_groupA_read_allowed(DisasContext *ctx)
@@ -33,7 +33,7 @@ static bool spr_groupA_read_allowed(DisasContext *ctx)
  * Checks whether the Group A SPR (MMCR0, MMCR2, MMCRA, and the
  * PMCs) has problem state write access.
  *
- * Write acccess is granted for PMCC values 0b10 and 0b11. Userspace
+ * Write access is granted for PMCC values 0b10 and 0b11. Userspace
  * writing with PMCC 0b00 will generate a Hypervisor Emulation
  * Assistance Interrupt. Userspace writing with PMCC 0b01 will
  * generate a Facility Unavailable Interrupt.
diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
index c8712dd7d8..28b31298f1 100644
--- a/target/ppc/translate/vmx-impl.c.inc
+++ b/target/ppc/translate/vmx-impl.c.inc
@@ -119,7 +119,7 @@ static void gen_stve##name(DisasContext *ctx)                           \
     }
 
 GEN_VR_LDX(lvx, 0x07, 0x03);
-/* As we don't emulate the cache, lvxl is stricly equivalent to lvx */
+/* As we don't emulate the cache, lvxl is strictly equivalent to lvx */
 GEN_VR_LDX(lvxl, 0x07, 0x0B);
 
 GEN_VR_LVE(bx, 0x07, 0x00, 1);
@@ -127,7 +127,7 @@ GEN_VR_LVE(hx, 0x07, 0x01, 2);
 GEN_VR_LVE(wx, 0x07, 0x02, 4);
 
 GEN_VR_STX(svx, 0x07, 0x07);
-/* As we don't emulate the cache, stvxl is stricly equivalent to stvx */
+/* As we don't emulate the cache, stvxl is strictly equivalent to stvx */
 GEN_VR_STX(svxl, 0x07, 0x0F);
 
 GEN_VR_STVE(bx, 0x07, 0x04, 1);
@@ -1528,7 +1528,7 @@ static void gen_vprtyb_vec(unsigned vece, TCGv_vec t, TCGv_vec b)
 {
     int i;
     TCGv_vec tmp = tcg_temp_new_vec_matching(b);
-    /* MO_32 is 2, so 2 iteractions for MO_32 and 3 for MO_64 */
+    /* MO_32 is 2, so 2 iterations for MO_32 and 3 for MO_64 */
     for (i = 0; i < vece; i++) {
         tcg_gen_shri_vec(vece, tmp, b, (4 << (vece - i)));
         tcg_gen_xor_vec(vece, b, tmp, b);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6ea22e0eea..6316cbcc23 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -349,7 +349,7 @@ struct CPUArchState {
     target_ulong upmmask;
     target_ulong upmbase;
 
-    /* CSRs for execution enviornment configuration */
+    /* CSRs for execution environment configuration */
     uint64_t menvcfg;
     uint64_t mstateen[SMSTATEEN_MAX_COUNT];
     uint64_t hstateen[SMSTATEEN_MAX_COUNT];
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 59f0ffd9e1..31a8d80990 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -656,7 +656,7 @@ typedef enum {
 /* Leaf page shift amount */
 #define PGSHIFT             12
 
-/* Default Reset Vector adress */
+/* Default Reset Vector address */
 #define DEFAULT_RSTVEC      0x1000
 
 /* Exception causes */
@@ -740,7 +740,7 @@ typedef enum RISCVException {
 #define PM_CURRENT      0x00000002ULL
 #define PM_INSN         0x00000004ULL
 
-/* Execution enviornment configuration bits */
+/* Execution environment configuration bits */
 #define MENVCFG_FIOM                       BIT(0)
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ea7585329e..26bc1f0ff1 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3216,7 +3216,7 @@ static int write_hvipriox(CPURISCVState *env, int first_index,
                RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
     }
 
-    /* Fill-up priority arrary */
+    /* Fill-up priority array */
     for (i = 0; i < num_irqs; i++) {
         if (riscv_cpu_hviprio_index2irq(first_index + i, &irq, &rdzero)) {
             continue;
@@ -3885,7 +3885,7 @@ static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
     if (riscv_has_ext(env, RVH) && env->priv == PRV_S &&
         !env->virt_enabled) {
         /*
-         * We are in HS mode. Add 1 to the effective privledge level to
+         * We are in HS mode. Add 1 to the effective privilege level to
          * allow us to access the Hypervisor CSRs.
          */
         effective_priv++;
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 75ee1c4971..211f5921b6 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -574,7 +574,7 @@ static void riscv_itrigger_update_count(CPURISCVState *env)
     int count, executed;
     /*
      * Record last icount, so that we can evaluate the executed instructions
-     * since last priviledge mode change or timer expire.
+     * since last privilege mode change or timer expire.
      */
     int64_t last_icount = env->last_icount, current_icount;
     current_icount = env->last_icount = icount_get_raw();
@@ -588,14 +588,14 @@ static void riscv_itrigger_update_count(CPURISCVState *env)
             continue;
         }
         /*
-         * Only when priviledge is changed or itrigger timer expires,
+         * Only when privilege is changed or itrigger timer expires,
          * the count field in itrigger tdata1 register is updated.
          * And the count field in itrigger only contains remaining value.
          */
         if (check_itrigger_priv(env, i)) {
             /*
-             * If itrigger enabled in this priviledge mode, the number of
-             * executed instructions since last priviledge change
+             * If itrigger enabled in this privilege mode, the number of
+             * executed instructions since last privilege change
              * should be reduced from current itrigger count.
              */
             executed = current_icount - last_icount;
@@ -605,7 +605,7 @@ static void riscv_itrigger_update_count(CPURISCVState *env)
             }
         } else {
             /*
-             * If itrigger is not enabled in this priviledge mode,
+             * If itrigger is not enabled in this privilege mode,
              * the number of executed instructions will be discard and
              * the count field in itrigger will not change.
              */
diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_trans/trans_rvf.c.inc
index a0da7391c7..e7ab84cd9a 100644
--- a/target/riscv/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/insn_trans/trans_rvf.c.inc
@@ -300,7 +300,7 @@ static bool trans_fsgnjn_s(DisasContext *ctx, arg_fsgnjn_s *a)
         tcg_gen_and_i64(dest, mask, rs1);
         tcg_gen_or_i64(dest, dest, rs2);
     }
-    /* signed-extended intead of nanboxing for result if enable zfinx */
+    /* signed-extended instead of nanboxing for result if enable zfinx */
     if (ctx->cfg_ptr->ext_zfinx) {
         tcg_gen_ext32s_i64(dest, dest);
     }
@@ -345,7 +345,7 @@ static bool trans_fsgnjx_s(DisasContext *ctx, arg_fsgnjx_s *a)
         tcg_gen_andi_i64(dest, rs2, MAKE_64BIT_MASK(31, 1));
         tcg_gen_xor_i64(dest, rs1, dest);
     }
-    /* signed-extended intead of nanboxing for result if enable zfinx */
+    /* signed-extended instead of nanboxing for result if enable zfinx */
     if (ctx->cfg_ptr->ext_zfinx) {
         tcg_gen_ext32s_i64(dest, dest);
     }
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index c2f7527f53..6ab63f4442 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2240,7 +2240,7 @@ GEN_OPIWI_NARROW_TRANS(vnclip_wi, IMM_ZX, vnclip_wx)
  *
  * If SEW < FLEN, check whether input fp register is a valid
  * NaN-boxed value, in which case the least-significant SEW bits
- * of the f regsiter are used, else the canonical NaN value is used.
+ * of the f register are used, else the canonical NaN value is used.
  */
 static void do_nanbox(DisasContext *s, TCGv_i64 out, TCGv_i64 in)
 {
@@ -3282,7 +3282,7 @@ static void load_element(TCGv_i64 dest, TCGv_ptr base,
     }
 }
 
-/* offset of the idx element with base regsiter r */
+/* offset of the idx element with base register r */
 static uint32_t endian_ofs(DisasContext *s, int r, int idx)
 {
 #if HOST_BIG_ENDIAN
diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/insn_trans/trans_rvzfh.c.inc
index 8b1e2519bb..4b01812fd8 100644
--- a/target/riscv/insn_trans/trans_rvzfh.c.inc
+++ b/target/riscv/insn_trans/trans_rvzfh.c.inc
@@ -305,7 +305,7 @@ static bool trans_fsgnjn_h(DisasContext *ctx, arg_fsgnjn_h *a)
         tcg_gen_and_i64(dest, mask, rs1);
         tcg_gen_or_i64(dest, dest, rs2);
     }
-    /* signed-extended intead of nanboxing for result if enable zfinx */
+    /* signed-extended instead of nanboxing for result if enable zfinx */
     if (ctx->cfg_ptr->ext_zfinx) {
         tcg_gen_ext16s_i64(dest, dest);
     }
@@ -349,7 +349,7 @@ static bool trans_fsgnjx_h(DisasContext *ctx, arg_fsgnjx_h *a)
         tcg_gen_andi_i64(dest, rs2, MAKE_64BIT_MASK(15, 1));
         tcg_gen_xor_i64(dest, rs1, dest);
     }
-    /* signed-extended intead of nanboxing for result if enable zfinx */
+    /* signed-extended instead of nanboxing for result if enable zfinx */
     if (ctx->cfg_ptr->ext_zfinx) {
         tcg_gen_ext16s_i64(dest, dest);
     }
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index f36ddfa967..f5b1ffe6c3 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -55,7 +55,7 @@ static void print_pte_header(Monitor *mon)
 static void print_pte(Monitor *mon, int va_bits, target_ulong vaddr,
                       hwaddr paddr, target_ulong size, int attr)
 {
-    /* santity check on vaddr */
+    /* sanity check on vaddr */
     if (vaddr >= (1UL << va_bits)) {
         return;
     }
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 08cabbde61..f552a0319a 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2066,7 +2066,7 @@ static inline void clrsetpsw(DisasContext *ctx, int cb, int val)
             tcg_gen_movi_i32(cpu_psw_o, val << 31);
             break;
         default:
-            qemu_log_mask(LOG_GUEST_ERROR, "Invalid distination %d", cb);
+            qemu_log_mask(LOG_GUEST_ERROR, "Invalid destination %d", cb);
             break;
         }
     } else if (is_privileged(ctx, 0)) {
@@ -2084,7 +2084,7 @@ static inline void clrsetpsw(DisasContext *ctx, int cb, int val)
             }
             break;
         default:
-            qemu_log_mask(LOG_GUEST_ERROR, "Invalid distination %d", cb);
+            qemu_log_mask(LOG_GUEST_ERROR, "Invalid destination %d", cb);
             break;
         }
     }
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index ebb155ce1c..d28eb65845 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -249,7 +249,7 @@ static void init_groups(void)
 {
     int i;
 
-    /* init all bitmaps from gnerated data initially */
+    /* init all bitmaps from generated data initially */
     for (i = 0; i < ARRAY_SIZE(s390_feature_groups); i++) {
         s390_init_feat_bitmap(s390_feature_groups[i].init,
                               s390_feature_groups[i].feat);
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 42b52afdb4..91ce896491 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -975,7 +975,7 @@ static void register_types(void)
 
     init_ignored_base_feat();
 
-    /* init all bitmaps from gnerated data initially */
+    /* init all bitmaps from generated data initially */
     s390_init_feat_bitmap(qemu_max_init, qemu_max_cpu_feat);
     for (i = 0; i < ARRAY_SIZE(s390_cpu_defs); i++) {
         s390_init_feat_bitmap(s390_cpu_defs[i].base_init,
diff --git a/target/s390x/tcg/fpu_helper.c b/target/s390x/tcg/fpu_helper.c
index 4b7fa58af3..5364372c8b 100644
--- a/target/s390x/tcg/fpu_helper.c
+++ b/target/s390x/tcg/fpu_helper.c
@@ -86,7 +86,7 @@ static void handle_exceptions(CPUS390XState *env, bool XxC, uintptr_t retaddr)
 
     /*
      * FIXME:
-     * 1. Right now, all inexact conditions are inidicated as
+     * 1. Right now, all inexact conditions are indicated as
      *    "truncated" (0) and never as "incremented" (1) in the DXC.
      * 2. Only traps due to invalid/divbyzero are suppressing. Other traps
      *    are completing, meaning the target register has to be written!
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 457ed25d2f..555c147c7c 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -529,7 +529,7 @@
 /* LOAD LOGICAL HALFWORD RELATIVE LONG */
     C(0xc402, LLHRL,   RIL_b, GIE, 0, ri2, new, r1_32, ld16u, 0)
     C(0xc406, LLGHRL,  RIL_b, GIE, 0, ri2, r1, 0, ld16u, 0)
-/* LOAD LOGICAL IMMEDATE */
+/* LOAD LOGICAL IMMEDIATE */
     D(0xc00e, LLIHF,   RIL_a, EI, 0, i2_32u_shl, 0, r1, mov2, 0, 32)
     D(0xc00f, LLILF,   RIL_a, EI, 0, i2_32u_shl, 0, r1, mov2, 0, 0)
     D(0xa50c, LLIHH,   RI_a,  Z,  0, i2_16u_shl, 0, r1, mov2, 0, 48)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 6661b27efa..94c8c1f9aa 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -429,7 +429,7 @@ static void gen_exception(int excp)
 
 static void gen_program_exception(DisasContext *s, int code)
 {
-    /* Remember what pgm exeption this was.  */
+    /* Remember what pgm exception this was.  */
     tcg_gen_st_i32(tcg_constant_i32(code), cpu_env,
                    offsetof(CPUS390XState, int_pgm_code));
 
diff --git a/target/sparc/asi.h b/target/sparc/asi.h
index bb58735ddb..3270ed0c7f 100644
--- a/target/sparc/asi.h
+++ b/target/sparc/asi.h
@@ -144,13 +144,13 @@
  * ASIs, "(4V)" designates SUN4V specific ASIs.  "(NG4)" designates SPARC-T4
  * and later ASIs.
  */
-#define ASI_REAL                0x14 /* Real address, cachable          */
+#define ASI_REAL                0x14 /* Real address, cacheable          */
 #define ASI_PHYS_USE_EC		0x14 /* PADDR, E-cachable		*/
 #define ASI_REAL_IO             0x15 /* Real address, non-cachable      */
 #define ASI_PHYS_BYPASS_EC_E	0x15 /* PADDR, E-bit			*/
 #define ASI_BLK_AIUP_4V		0x16 /* (4V) Prim, user, block ld/st	*/
 #define ASI_BLK_AIUS_4V		0x17 /* (4V) Sec, user, block ld/st	*/
-#define ASI_REAL_L              0x1c /* Real address, cachable, LE      */
+#define ASI_REAL_L              0x1c /* Real address, cacheable, LE      */
 #define ASI_PHYS_USE_EC_L	0x1c /* PADDR, E-cachable, little endian*/
 #define ASI_REAL_IO_L           0x1d /* Real address, non-cachable, LE  */
 #define ASI_PHYS_BYPASS_EC_E_L	0x1d /* PADDR, E-bit, little endian	*/
@@ -163,15 +163,15 @@
 #define ASI_BLK_INIT_QUAD_LDD_AIUS 0x23 /* (NG) init-store, twin load,
 					 * secondary, user
 					 */
-#define ASI_NUCLEUS_QUAD_LDD	0x24 /* Cachable, qword load		*/
+#define ASI_NUCLEUS_QUAD_LDD	0x24 /* Cacheable, qword load		*/
 #define ASI_QUEUE		0x25 /* (4V) Interrupt Queue Registers	*/
-#define ASI_TWINX_REAL          0x26 /* twin load, real, cachable       */
+#define ASI_TWINX_REAL          0x26 /* twin load, real, cacheable	*/
 #define ASI_QUAD_LDD_PHYS_4V	0x26 /* (4V) Physical, qword load	*/
 #define ASI_TWINX_N             0x27 /* twin load, nucleus              */
 #define ASI_TWINX_AIUP_L        0x2a /* twin load, primary user, LE     */
 #define ASI_TWINX_AIUS_L        0x2b /* twin load, secondary user, LE   */
-#define ASI_NUCLEUS_QUAD_LDD_L	0x2c /* Cachable, qword load, l-endian 	*/
-#define ASI_TWINX_REAL_L        0x2e /* twin load, real, cachable, LE   */
+#define ASI_NUCLEUS_QUAD_LDD_L	0x2c /* Cacheable, qword load, l-endian */
+#define ASI_TWINX_REAL_L        0x2e /* twin load, real, cacheable, LE	*/
 #define ASI_QUAD_LDD_PHYS_L_4V	0x2e /* (4V) Phys, qword load, l-endian	*/
 #define ASI_TWINX_NL            0x2f /* twin load, nucleus, LE          */
 #define ASI_PCACHE_DATA_STATUS	0x30 /* (III) PCache data stat RAM diag	*/
@@ -231,7 +231,7 @@
 #define ASI_INTR_ID		0x63 /* (CMT) Interrupt ID register	*/
 #define ASI_CORE_ID		0x63 /* (CMT) LP ID register		*/
 #define ASI_CESR_ID		0x63 /* (CMT) CESR ID register		*/
-#define ASI_IC_INSTR		0x66 /* Insn cache instrucion ram diag	*/
+#define ASI_IC_INSTR		0x66 /* Insn cache instruction ram diag	*/
 #define ASI_IC_TAG		0x67 /* Insn cache tag/valid ram diag 	*/
 #define ASI_IC_STAG		0x68 /* (III) Insn cache snoop tag ram	*/
 #define ASI_IC_PRE_DECODE	0x6e /* Insn cache pre-decode ram diag	*/
diff --git a/target/tricore/csfr.h.inc b/target/tricore/csfr.h.inc
index ff004cbddc..cdfaf1d662 100644
--- a/target/tricore/csfr.h.inc
+++ b/target/tricore/csfr.h.inc
@@ -1,4 +1,4 @@
-/* A(ll) access permited
+/* A(ll) access permitted
    R(ead only) access
    E(nd init protected) access
 
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 951024d491..7587c2ffe8 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -57,7 +57,7 @@ hwaddr tricore_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     return phys_addr;
 }
 
-/* TODO: Add exeption support*/
+/* TODO: Add exception support */
 static void raise_mmu_exception(CPUTriCoreState *env, target_ulong address,
                                 int rw, int tlb_error)
 {
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 2f32463d4d..1947733870 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -128,7 +128,7 @@ void tricore_cpu_dump_state(CPUState *cs, FILE *f, int flags)
  * Functions to generate micro-ops
  */
 
-/* Makros for generating helpers */
+/* Macros for generating helpers */
 
 #define gen_helper_1arg(name, arg) do {                           \
     TCGv_i32 helper_tmp = tcg_constant_i32(arg);                  \
@@ -336,8 +336,8 @@ static void gen_swapmsk(DisasContext *ctx, int reg, TCGv ea)
 
 /* We generate loads and store to core special function register (csfr) through
    the function gen_mfcr and gen_mtcr. To handle access permissions, we use 3
-   makros R, A and E, which allow read-only, all and endinit protected access.
-   These makros also specify in which ISA version the csfr was introduced. */
+   macros R, A and E, which allow read-only, all and endinit protected access.
+   These macros also specify in which ISA version the csfr was introduced. */
 #define R(ADDRESS, REG, FEATURE)                                         \
     case ADDRESS:                                                        \
         if (has_feature(ctx, FEATURE)) {                             \
@@ -362,7 +362,7 @@ static inline void gen_mfcr(DisasContext *ctx, TCGv ret, int32_t offset)
 #undef E
 
 #define R(ADDRESS, REG, FEATURE) /* don't gen writes to read-only reg,
-                                    since no execption occurs */
+                                    since no exception occurs */
 #define A(ADDRESS, REG, FEATURE) R(ADDRESS, REG, FEATURE)                \
     case ADDRESS:                                                        \
         if (has_feature(ctx, FEATURE)) {                             \
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 35ca80cd56..5471523f4c 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -3086,7 +3086,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 #if !defined(CONFIG_SOFTMMU)
     /*
      * Note that XZR cannot be encoded in the address base register slot,
-     * as that actaully encodes SP.  Depending on the guest, we may need
+     * as that actually encodes SP.  Depending on the guest, we may need
      * to zero-extend the guest address via the address index register slot,
      * therefore we need to load even a zero guest base into a register.
      */
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 83e286088f..3a14f52c51 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1216,7 +1216,7 @@ static TCGCond tcg_out_cmp2(TCGContext *s, const TCGArg *args,
     case TCG_COND_LEU:
     case TCG_COND_GTU:
     case TCG_COND_GEU:
-        /* We perform a conditional comparision.  If the high half is
+        /* We perform a conditional comparison.  If the high half is
            equal, then overwrite the flags with the comparison of the
            low half.  The resulting flags cover the whole.  */
         tcg_out_dat_rI(s, COND_AL, ARITH_CMP, 0, ah, bh, const_bh);
@@ -1250,7 +1250,7 @@ static TCGCond tcg_out_cmp2(TCGContext *s, const TCGArg *args,
 
 /*
  * Note that TCGReg references Q-registers.
- * Q-regno = 2 * D-regno, so shift left by 1 whlie inserting.
+ * Q-regno = 2 * D-regno, so shift left by 1 while inserting.
  */
 static uint32_t encode_vd(TCGReg rd)
 {
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index eeaeb6b6e3..e9e5968823 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -69,7 +69,7 @@ static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 
 static const int tcg_target_reg_alloc_order[] = {
     /* Call saved registers */
-    /* TCG_REG_S0 reservered for TCG_AREG0 */
+    /* TCG_REG_S0 reserved for TCG_AREG0 */
     TCG_REG_S1,
     TCG_REG_S2,
     TCG_REG_S3,
@@ -260,7 +260,7 @@ typedef enum {
     /* Zba: Bit manipulation extension, address generation */
     OPC_ADD_UW = 0x0800003b,
 
-    /* Zbb: Bit manipulation extension, basic bit manipulaton */
+    /* Zbb: Bit manipulation extension, basic bit manipulation */
     OPC_ANDN   = 0x40007033,
     OPC_CLZ    = 0x60001013,
     OPC_CLZW   = 0x6000101b,
diff --git a/tests/avocado/acpi-bits.py b/tests/avocado/acpi-bits.py
index 3ed286dcbd..bb3f818689 100644
--- a/tests/avocado/acpi-bits.py
+++ b/tests/avocado/acpi-bits.py
@@ -1,6 +1,6 @@
 #!/usr/bin/env python3
 # group: rw quick
-# Exercize QEMU generated ACPI/SMBIOS tables using biosbits,
+# Exercise QEMU generated ACPI/SMBIOS tables using biosbits,
 # https://biosbits.org/
 #
 # This program is free software; you can redistribute it and/or modify
@@ -366,7 +366,7 @@ def tearDown(self):
         super().tearDown()
 
     def test_acpi_smbios_bits(self):
-        """The main test case implementaion."""
+        """The main test case implementation."""
 
         iso_file = os.path.join(self._workDir,
                                 'bits-%d.iso' %self._bitsInternalVer)
diff --git a/tests/avocado/acpi-bits/bits-tests/testacpi.py2 b/tests/avocado/acpi-bits/bits-tests/testacpi.py2
index f818a9cce6..7bf9075c1b 100644
--- a/tests/avocado/acpi-bits/bits-tests/testacpi.py2
+++ b/tests/avocado/acpi-bits/bits-tests/testacpi.py2
@@ -273,8 +273,8 @@ def test_rsdp():
 
     # Checksum the first 20 bytes per ACPI 1.0
     csum = sum(ord(c) for c in data[:20]) % 0x100
-    testsuite.test('ACPI 1.0 table first 20 bytes cummulative checksum must equal 0', csum == 0)
-    testsuite.print_detail("Cummulative checksum = {} (Expected 0)".format(csum))
+    testsuite.test('ACPI 1.0 table first 20 bytes cumulative checksum must equal 0', csum == 0)
+    testsuite.print_detail("Cumulative checksum = {} (Expected 0)".format(csum))
 
     test_table_checksum(data)
     rsdp = acpi.parse_rsdp()
diff --git a/tests/decode/err_pattern_group_ident2.decode b/tests/decode/err_pattern_group_ident2.decode
index bc859233b1..0abb7513e9 100644
--- a/tests/decode/err_pattern_group_ident2.decode
+++ b/tests/decode/err_pattern_group_ident2.decode
@@ -7,5 +7,5 @@
 {
   top      00000000 00000000 00000000 00000000
   sub1     00000000 00000000 00000000 ........ %sub1
-# comments are suposed to be indented
+# comments are supposed to be indented
 }
diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 9a33df2832..a611e6adf9 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -12,7 +12,7 @@
 # the top-level directory.
 
 # This might be set by ENV of a docker container... it is always
-# overriden by TARGET_LIST if the user sets it. We special case
+# overridden by TARGET_LIST if the user sets it. We special case
 # "none" to allow for other options like --disable-tcg to restrict the
 # builds we eventually do.
 if test "$DEF_TARGET_LIST" = "none"; then
diff --git a/tests/migration/guestperf-batch.py b/tests/migration/guestperf-batch.py
index ab6bdb9d38..9485eefe49 100755
--- a/tests/migration/guestperf-batch.py
+++ b/tests/migration/guestperf-batch.py
@@ -1,6 +1,6 @@
 #!/usr/bin/env python3
 #
-# Migration test batch comparison invokation
+# Migration test batch comparison invocation
 #
 # Copyright (c) 2016 Red Hat, Inc.
 #
diff --git a/tests/migration/guestperf.py b/tests/migration/guestperf.py
index e8cc127fd0..07182f211e 100755
--- a/tests/migration/guestperf.py
+++ b/tests/migration/guestperf.py
@@ -1,6 +1,6 @@
 #!/usr/bin/env python3
 #
-# Migration test direct invokation command
+# Migration test direct invocation command
 #
 # Copyright (c) 2016 Red Hat, Inc.
 #
diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
index f3b9f696a0..44e91065ba 100644
--- a/tests/plugin/mem.c
+++ b/tests/plugin/mem.c
@@ -98,7 +98,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
             } else if (g_strcmp0(tokens[1], "rw") == 0) {
                 rw = QEMU_PLUGIN_MEM_RW;
             } else {
-                fprintf(stderr, "invaild value for argument track: %s\n", opt);
+                fprintf(stderr, "invalid value for argument track: %s\n", opt);
                 return -1;
             }
         } else if (g_strcmp0(tokens[0], "inline") == 0) {
diff --git a/tests/qapi-schema/bad-if-not.json b/tests/qapi-schema/bad-if-not.json
index 9fdaacc47b..660fc4feb2 100644
--- a/tests/qapi-schema/bad-if-not.json
+++ b/tests/qapi-schema/bad-if-not.json
@@ -1,3 +1,3 @@
-# check 'if not' with empy argument
+# check 'if not' with empty argument
 { 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
   'if': { 'not': '' } }
diff --git a/tests/qemu-iotests/029 b/tests/qemu-iotests/029
index bd71dd2f22..7f4849b97b 100755
--- a/tests/qemu-iotests/029
+++ b/tests/qemu-iotests/029
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 . ./common.pattern
 
-# Any format supporting intenal snapshots
+# Any format supporting internal snapshots
 _supported_fmt qcow2
 _supported_proto generic
 # Internal snapshots are (currently) impossible with refcount_bits=1,
diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 30eb97829e..5601a4873c 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -845,7 +845,7 @@ class TestCommitWithFilters(iotests.QMPTestCase):
         self.assertIsNone(self.vm.node_info('cow-2'))
         self.assertIsNotNone(self.vm.node_info('cow-1'))
 
-        # 2 has been comitted into 1
+        # 2 has been committed into 1
         self.pattern_files[2] = self.img1
 
     def test_commit_through_filter(self):
@@ -863,7 +863,7 @@ class TestCommitWithFilters(iotests.QMPTestCase):
         self.assertIsNone(self.vm.node_info('bottom-filter'))
         self.assertIsNotNone(self.vm.node_info('cow-0'))
 
-        # 1 has been comitted into 0
+        # 1 has been committed into 0
         self.pattern_files[1] = self.img0
 
     def test_filtered_active_commit_with_filter(self):
@@ -900,7 +900,7 @@ class TestCommitWithFilters(iotests.QMPTestCase):
         drv0 = next(dev for dev in blockdevs if dev['qdev'] == 'drv0')
         self.assertEqual(drv0['inserted']['node-name'], 'cow-2')
 
-        # 3 has been comitted into 2
+        # 3 has been committed into 2
         self.pattern_files[3] = self.img2
 
     def test_filtered_active_commit_without_filter(self):
@@ -916,7 +916,7 @@ class TestCommitWithFilters(iotests.QMPTestCase):
         self.assertIsNone(self.vm.node_info('cow-3'))
         self.assertIsNotNone(self.vm.node_info('cow-2'))
 
-        # 3 has been comitted into 2
+        # 3 has been committed into 2
         self.pattern_files[3] = self.img2
 
 class TestCommitWithOverriddenBacking(iotests.QMPTestCase):
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index 517b162508..4c9ed4d26e 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -125,7 +125,7 @@ aio_flush
 EOF
 
 # Sequential write, but the next cluster is already allocated
-# and phyiscally in the right position
+# and physically in the right position
 cat  <<EOF
 write -P 89 0x80000 0x1000
 write -P 90 0x96000 0x8000
diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index e8be217e1f..2bcb1f7f9c 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -182,7 +182,7 @@ done
 echo
 echo "=== Testing afl image with a very large capacity ==="
 _use_sample_img afl9.vmdk.bz2
-_img_info | grep -q 'Cannot allocate memory' && _notrun "Insufficent memory, skipped test"
+_img_info | grep -q 'Cannot allocate memory' && _notrun "Insufficient memory, skipped test"
 _img_info
 _cleanup_test_img
 
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index 509ad247cd..53c7d428e3 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -49,7 +49,7 @@ _supported_os Linux
 # we have explicit tests for various cluster sizes, the remaining tests
 # require the default 64k cluster
 # we don't have explicit tests for zstd qcow2 compression type, as zstd may be
-# not compiled in. And we can't create compat images with comression type
+# not compiled in. And we can't create compat images with compression type
 # extension
 _unsupported_imgopts 'refcount_bits=\([^1]\|.\([^6]\|$\)\)' data_file \
     cluster_size compression_type
diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 27bc7305bf..331f8cfddc 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -41,7 +41,7 @@ _supported_fmt qcow2
 _supported_proto file fuse
 _require_drivers blkdebug blkverify
 # blkdebug can only inject errors on bs->file, not on the data_file,
-# so thie test does not work with external data files
+# so this test does not work with external data files
 _unsupported_imgopts data_file
 
 do_run_qemu()
diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index a2547bc280..08d9b49906 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -93,7 +93,7 @@ output=$($QEMU_IO -f qcow2 -C -c "read -P 0 1k $((2*1024*1024*1024 - 512))" \
         "$TEST_WRAP" 2>&1 | _filter_qemu_io)
 case $output in
     *allocate*)
-        _notrun "Insufficent memory to run test" ;;
+        _notrun "Insufficient memory to run test" ;;
     *) printf '%s\n' "$output" ;;
 esac
 $QEMU_IO -f qcow2 -C -c "read -P 0 $((3*1024*1024*1024 + 1024)) 1k" \
diff --git a/tests/qemu-iotests/215 b/tests/qemu-iotests/215
index d464596f14..6babbcdc1f 100755
--- a/tests/qemu-iotests/215
+++ b/tests/qemu-iotests/215
@@ -95,7 +95,7 @@ output=$($QEMU_IO \
          2>&1 | _filter_qemu_io)
 case $output in
     *allocate*)
-        _notrun "Insufficent memory to run test" ;;
+        _notrun "Insufficient memory to run test" ;;
     *) printf '%s\n' "$output" ;;
 esac
 $QEMU_IO \
diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
index ad560e2941..4e22567d95 100755
--- a/tests/qemu-iotests/298
+++ b/tests/qemu-iotests/298
@@ -141,7 +141,7 @@ class TestTruncate(iotests.QMPTestCase):
         refstat = os.stat(refdisk)
 
         # Probably we'll want preallocate filter to keep align to cluster when
-        # shrink preallocation, so, ignore small differece
+        # shrink preallocation, so, ignore small difference
         self.assertLess(abs(stat.st_size - refstat.st_size), 64 * 1024)
 
         # Preallocate filter may leak some internal clusters (for example, if
diff --git a/tests/qemu-iotests/pylintrc b/tests/qemu-iotests/pylintrc
index f4f823a991..1f996f26c1 100644
--- a/tests/qemu-iotests/pylintrc
+++ b/tests/qemu-iotests/pylintrc
@@ -4,7 +4,7 @@
 # can either give multiple identifiers separated by comma (,) or put this
 # option multiple times (only on the command line, not in the configuration
 # file where it should appear only once). You can also use "--disable=all" to
-# disable everything first and then reenable specific checks. For example, if
+# disable everything first and then re-enable specific checks. For example, if
 # you want to run only the similarities checker, you can use "--disable=all
 # --enable=similarities". If you want to run only the classes checker, but have
 # no Warning level messages displayed, use "--disable=all --enable=classes
@@ -19,7 +19,7 @@ disable=invalid-name,
         too-many-public-methods,
         # pylint warns about Optional[] etc. as unsubscriptable in 3.9
         unsubscriptable-object,
-        # pylint's static analysis causes false positivies for file_path();
+        # pylint's static analysis causes false positives for file_path();
         # If we really care to make it statically knowable, we'll use mypy.
         unbalanced-tuple-unpacking,
         # Sometimes we need to disable a newly introduced pylint warning.
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index abab761c26..eea8b5f77b 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -330,7 +330,7 @@ static void ahci_test_pci_spec(AHCIQState *ahci)
     ASSERT_BIT_CLEAR(datal, ~0xFF);
     g_assert_cmphex(datal, !=, 0);
 
-    /* Check specification adherence for capability extenstions. */
+    /* Check specification adherence for capability extensions. */
     data = qpci_config_readw(ahci->dev, datal);
 
     switch (ahci->fingerprint) {
diff --git a/tests/qtest/bcm2835-dma-test.c b/tests/qtest/bcm2835-dma-test.c
index 8293d822b9..18901b76d2 100644
--- a/tests/qtest/bcm2835-dma-test.c
+++ b/tests/qtest/bcm2835-dma-test.c
@@ -25,7 +25,7 @@
 
 #define BCM2708_DMA_INT_STATUS 0xfe0
 
-/* DMA Trasfer Info fields: */
+/* DMA Transfer Info fields: */
 #define BCM2708_DMA_INT_EN     (1 << 0)
 #define BCM2708_DMA_D_INC      (1 << 4)
 #define BCM2708_DMA_S_INC      (1 << 8)
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 47ba20b957..0e0b1db47d 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -26,7 +26,7 @@
  * 4. Run
  *      make check V=2
  * this will produce a bunch of warnings about differences
- * beween actual and expected ACPI tables. If you have IASL installed,
+ * between actual and expected ACPI tables. If you have IASL installed,
  * they will also be disassembled so you can look at the disassembled
  * output. If not - disassemble them yourself in any way you like.
  * Look at the differences - make sure they make sense and match what the
diff --git a/tests/qtest/ds1338-test.c b/tests/qtest/ds1338-test.c
index f6ade9a050..d12424d27f 100644
--- a/tests/qtest/ds1338-test.c
+++ b/tests/qtest/ds1338-test.c
@@ -38,7 +38,7 @@ static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
 
     i2c_read_block(i2cdev, 0, resp, sizeof(resp));
 
-    /* check retrieved time againt local time */
+    /* check retrieved time against local time */
     g_assert_cmpuint(bcd2bin(resp[4]), == , tm_ptr->tm_mday);
     g_assert_cmpuint(bcd2bin(resp[5]), == , 1 + tm_ptr->tm_mon);
     g_assert_cmpuint(2000 + bcd2bin(resp[6]), == , 1900 + tm_ptr->tm_year);
diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index 11256abf6c..357e1f9dc2 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -846,9 +846,9 @@ static void generic_pre_fuzz(QTestState *s)
  *          functionality B
  *
  * This function attempts to produce an input that:
- * Ouptut: maps a device's BARs, set up three DMA patterns, triggers
+ * Output: maps a device's BARs, set up three DMA patterns, triggers
  *          functionality A device, replaces the DMA patterns with a single
- *          patten, and triggers device functionality B.
+ *          pattern, and triggers device functionality B.
  */
 static size_t generic_fuzz_crossover(const uint8_t *data1, size_t size1, const
                                      uint8_t *data2, size_t size2, uint8_t *out,
diff --git a/tests/qtest/libqos/qgraph.c b/tests/qtest/libqos/qgraph.c
index 0a2dddfafa..2029bf9804 100644
--- a/tests/qtest/libqos/qgraph.c
+++ b/tests/qtest/libqos/qgraph.c
@@ -54,7 +54,7 @@ struct QOSStackElement {
     int length;
 };
 
-/* Each enty in these hash table will consist of <string, node/edge> pair. */
+/* Each entry in these hash table will consist of <string, node/edge> pair. */
 static GHashTable *edge_table;
 static GHashTable *node_table;
 
@@ -214,7 +214,7 @@ static QOSGraphEdge *search_list_edges(QOSGraphEdgeList *edgelist,
 /**
  * search_machine(): search for a machine @name in the node hash
  * table. A machine is the child of the root node.
- * This function forces the research in the childs of the root,
+ * This function forces the research in the children of the root,
  * to check the node is a proper machine
  *
  * Returns: on success: the %QOSGraphNode
diff --git a/tests/qtest/libqos/qgraph_internal.h b/tests/qtest/libqos/qgraph_internal.h
index 7d62fd17af..87fab1f9f0 100644
--- a/tests/qtest/libqos/qgraph_internal.h
+++ b/tests/qtest/libqos/qgraph_internal.h
@@ -197,7 +197,7 @@ char *qos_graph_edge_get_name(QOSGraphEdge *edge);
  * qos_graph_get_machine(): returns the machine assigned
  * to that @node name.
  *
- * It performs a search only trough the list of machines
+ * It performs a search only through the list of machines
  * (i.e. the QOS_ROOT child).
  *
  * Returns: on success: the %QOSGraphNode
diff --git a/tests/qtest/libqos/virtio-gpio.c b/tests/qtest/libqos/virtio-gpio.c
index f22d7b5eb5..9220d287fe 100644
--- a/tests/qtest/libqos/virtio-gpio.c
+++ b/tests/qtest/libqos/virtio-gpio.c
@@ -28,7 +28,7 @@ static void virtio_gpio_cleanup(QVhostUserGPIO *gpio)
 
 /*
  * This handles the VirtIO setup from the point of view of the driver
- * frontend and therefor doesn't present any vhost specific features
+ * frontend and therefore doesn't present any vhost specific features
  * and in fact masks of the re-used bit.
  */
 static void virtio_gpio_setup(QVhostUserGPIO *gpio)
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index c22dfc30d3..7bbac5b9d0 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -112,7 +112,7 @@ static int socket_accept(int sock)
     socklen_t addrlen;
     int ret;
     /*
-     * timeout unit of blocking receive calls is different among platfoms.
+     * timeout unit of blocking receive calls is different among platforms.
      * It's in seconds on non-Windows platforms but milliseconds on Windows.
      */
 #ifndef _WIN32
@@ -1691,7 +1691,7 @@ QTestState *qtest_inproc_init(QTestState **s, bool log, const char* arch,
 
     qtest_client_set_rx_handler(qts, qtest_client_inproc_recv_line);
 
-    /* send() may not have a matching protoype, so use a type-safe wrapper */
+    /* send() may not have a matching prototype, so use a type-safe wrapper */
     qts->ops.external_send = send;
     qtest_client_set_tx_handler(qts, send_wrapper);
 
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index efa8c729db..525b7d34b0 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -486,7 +486,7 @@ static void migrate_ensure_converge(QTestState *who)
  * transferred.
  *
  * Finally we go back to the source and read a byte just
- * before the marker untill we see it flip in value. This
+ * before the marker until we see it flip in value. This
  * is proof that start_address -> MAGIC_OFFSET_BASE
  * is now dirty again.
  *
@@ -832,7 +832,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
 
     /*
      * Remove shmem file immediately to avoid memory leak in test failed case.
-     * It's valid becase QEMU has already opened this file
+     * It's valid because QEMU has already opened this file
      */
     if (args->use_shmem) {
         unlink(shmem_path);
@@ -2107,7 +2107,7 @@ static void test_migrate_auto_converge(void)
 
     /*
      * We want the test to be stable and as fast as possible.
-     * E.g., with 1Gb/s bandwith migration may pass without throttling,
+     * E.g., with 1Gb/s bandwidth migration may pass without throttling,
      * so we need to decrease a bandwidth.
      */
     const int64_t init_pct = 5, inc_pct = 25, max_pct = 95;
diff --git a/tests/qtest/npcm7xx_timer-test.c b/tests/qtest/npcm7xx_timer-test.c
index 83774a5b90..43711049ca 100644
--- a/tests/qtest/npcm7xx_timer-test.c
+++ b/tests/qtest/npcm7xx_timer-test.c
@@ -384,7 +384,7 @@ static void test_pause_resume(gconstpointer test_data)
     g_assert_true(qtest_get_irq(global_qtest, tim_timer_irq(td)));
 }
 
-/* Verifies that the prescaler can be changed while the timer is runnin. */
+/* Verifies that the prescaler can be changed while the timer is running. */
 static void test_prescaler_change(gconstpointer test_data)
 {
     const TestData *td = test_data;
diff --git a/tests/qtest/tpm-emu.c b/tests/qtest/tpm-emu.c
index f05fe12f01..2bf8ff4c86 100644
--- a/tests/qtest/tpm-emu.c
+++ b/tests/qtest/tpm-emu.c
@@ -77,7 +77,7 @@ static void *tpm_emu_tpm_thread(void *data)
             s->tpm_msg->code = cpu_to_be32(TPM_FAIL);
             break;
         default:
-            g_debug("unsupport TPM version %u", s->tpm_version);
+            g_debug("unsupported TPM version %u", s->tpm_version);
             g_assert_not_reached();
         }
         qio_channel_write(ioc, (char *)s->tpm_msg, be32_to_cpu(s->tpm_msg->len),
diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
index 25073d1f9e..fb94496bbd 100644
--- a/tests/qtest/tpm-tests.c
+++ b/tests/qtest/tpm-tests.c
@@ -1,5 +1,5 @@
 /*
- * QTest TPM commont test code
+ * QTest TPM common test code
  *
  * Copyright (c) 2018 IBM Corporation
  * Copyright (c) 2018 Red Hat, Inc.
diff --git a/tests/qtest/tpm-tests.h b/tests/qtest/tpm-tests.h
index a5df35ab5b..07ba60d26e 100644
--- a/tests/qtest/tpm-tests.h
+++ b/tests/qtest/tpm-tests.h
@@ -1,5 +1,5 @@
 /*
- * QTest TPM commont test code
+ * QTest TPM common test code
  *
  * Copyright (c) 2018 IBM Corporation
  *
diff --git a/tests/qtest/tpm-tis-i2c-test.c b/tests/qtest/tpm-tis-i2c-test.c
index 7a590ac551..3a1af026f2 100644
--- a/tests/qtest/tpm-tis-i2c-test.c
+++ b/tests/qtest/tpm-tis-i2c-test.c
@@ -468,7 +468,7 @@ static void tpm_tis_i2c_test_check_access_reg_release(const void *data)
                            TPM_TIS_ACCESS_ACTIVE_LOCALITY);
         /*
          * highest locality should now be active; release it and make sure the
-         * next higest locality is active afterwards
+         * next highest locality is active afterwards
          */
         for (l = TPM_TIS_NUM_LOCALITIES - 2; l >= 0; l--) {
             if (l == locty) {
diff --git a/tests/qtest/tpm-tis-util.c b/tests/qtest/tpm-tis-util.c
index 728cd3e065..862bb53248 100644
--- a/tests/qtest/tpm-tis-util.c
+++ b/tests/qtest/tpm-tis-util.c
@@ -340,7 +340,7 @@ void tpm_tis_test_check_access_reg_release(const void *data)
                TPM_TIS_ACCESS_ACTIVE_LOCALITY);
         /*
          * highest locality should now be active; release it and make sure the
-         * next higest locality is active afterwards
+         * next highest locality is active afterwards
          */
         for (l = TPM_TIS_NUM_LOCALITIES - 2; l >= 0; l--) {
             if (l == locty) {
diff --git a/tests/qtest/vhost-user-blk-test.c b/tests/qtest/vhost-user-blk-test.c
index dc37f5af4d..117b9acd10 100644
--- a/tests/qtest/vhost-user-blk-test.c
+++ b/tests/qtest/vhost-user-blk-test.c
@@ -961,7 +961,7 @@ static void *vhost_user_blk_test_setup(GString *cmd_line, void *arg)
  * Setup for hotplug.
  *
  * Since vhost-user server only serves one vhost-user client one time,
- * another exprot
+ * another export
  *
  */
 static void *vhost_user_blk_hotplug_test_setup(GString *cmd_line, void *arg)
diff --git a/tests/qtest/virtio-net-test.c b/tests/qtest/virtio-net-test.c
index dff43f0f60..fab5dd8b05 100644
--- a/tests/qtest/virtio-net-test.c
+++ b/tests/qtest/virtio-net-test.c
@@ -212,7 +212,7 @@ static void announce_self(void *obj, void *data, QGuestAllocator *t_alloc)
     g_assert_cmpint(*proto, ==, htons(ETH_P_RARP));
 
     /*
-     * Stop the announcment by settings rounds to 0 on the
+     * Stop the announcement by settings rounds to 0 on the
      * existing timer.
      */
     rsp = qmp("{ 'execute' : 'announce-self', "
diff --git a/tests/qtest/vmgenid-test.c b/tests/qtest/vmgenid-test.c
index 324db08c7a..29fee9e7c0 100644
--- a/tests/qtest/vmgenid-test.c
+++ b/tests/qtest/vmgenid-test.c
@@ -19,7 +19,7 @@
 
 #define VGID_GUID "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
 #define VMGENID_GUID_OFFSET 40   /* allow space for
-                                  * OVMF SDT Header Probe Supressor
+                                  * OVMF SDT Header Probe Suppressor
                                   */
 #define RSDP_ADDR_INVALID 0x100000 /* RSDP must be below this address */
 
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 2462c26000..462289f47c 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -120,7 +120,7 @@ endif
 %: %.S
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
 else
-# For softmmu targets we include a different Makefile fragement as the
+# For softmmu targets we include a different Makefile fragment as the
 # build options for bare programs are usually pretty different. They
 # are expected to provide their own build recipes.
 EXTRA_CFLAGS += -ffreestanding
@@ -154,7 +154,7 @@ PLUGINS=$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c)))
 # pre-requistes manually here as we can't use stems to handle it. We
 # only expand MULTIARCH_TESTS which are common on most of our targets
 # to avoid an exponential explosion as new tests are added. We also
-# add some special helpers the run-plugin- rules can use bellow.
+# add some special helpers the run-plugin- rules can use below.
 
 ifneq ($(MULTIARCH_TESTS),)
 $(foreach p,$(PLUGINS), \
diff --git a/tests/tcg/aarch64/gdbstub/test-sve.py b/tests/tcg/aarch64/gdbstub/test-sve.py
index b96bdbb99a..ef57c7412c 100644
--- a/tests/tcg/aarch64/gdbstub/test-sve.py
+++ b/tests/tcg/aarch64/gdbstub/test-sve.py
@@ -1,6 +1,6 @@
 from __future__ import print_function
 #
-# Test the SVE registers are visable and changeable via gdbstub
+# Test the SVE registers are visible and changeable via gdbstub
 #
 # This is launched via tests/guest-debug/run-test.py
 #
diff --git a/tests/tcg/aarch64/sme-outprod1.c b/tests/tcg/aarch64/sme-outprod1.c
index 6e5972d75e..0c814ed529 100644
--- a/tests/tcg/aarch64/sme-outprod1.c
+++ b/tests/tcg/aarch64/sme-outprod1.c
@@ -28,7 +28,7 @@ asm(
 "	fmopa za1.s, p0/m, p0/m, z0.s, z0.s\n"
 /*
  * Read the first 4x4 sub-matrix of elements from tile 1:
- * Note that za1h should be interchangable here.
+ * Note that za1h should be interchangeable here.
  */
 "	mov w12, #0\n"
 "	mova z0.s, p0/m, za1v.s[w12, #0]\n"
diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
index f136363d2a..501685d0ec 100644
--- a/tests/tcg/aarch64/system/boot.S
+++ b/tests/tcg/aarch64/system/boot.S
@@ -9,7 +9,7 @@
 
 /*
  * Semihosting interface on ARM AArch64
- * See "Semihosting for AArch32 and AArch64 Relase 2.0" by ARM
+ * See "Semihosting for AArch32 and AArch64 Release 2.0" by ARM
  * w0 - semihosting call number
  * x1 - semihosting parameter
  */
@@ -147,7 +147,7 @@ __start:
 	 * T0SZ[5:0]  = 2^(64 - 25)
 	 *
 	 * The size of T0SZ controls what the initial lookup level. It
-	 * would be nice to start at level 2 but unfortunatly for a
+	 * would be nice to start at level 2 but unfortunately for a
 	 * flat-mapping on the virt machine we need to handle IA's
 	 * with at least 1gb range to see RAM. So we start with a
 	 * level 1 lookup.
@@ -189,7 +189,7 @@ __start:
 	msr	cpacr_el1, x0
 
 	/* Setup some stack space and enter the test code.
-	 * Assume everthing except the return value is garbage when we
+	 * Assume everything except the return value is garbage when we
 	 * return, we won't need it.
 	 */
 	adrp	x0, stack_end
diff --git a/tests/tcg/aarch64/system/semiheap.c b/tests/tcg/aarch64/system/semiheap.c
index 693a1b037d..1a8c0f31a0 100644
--- a/tests/tcg/aarch64/system/semiheap.c
+++ b/tests/tcg/aarch64/system/semiheap.c
@@ -86,7 +86,7 @@ int main(int argc, char *argv[argc])
         }
         ptr_to_heap++;
     }
-    ml_printf("r/w to heap upto %p\n", ptr_to_heap);
+    ml_printf("r/w to heap up to %p\n", ptr_to_heap);
 
     ml_printf("Passed HeapInfo checks\n");
     return 0;
diff --git a/tests/tcg/hexagon/fpstuff.c b/tests/tcg/hexagon/fpstuff.c
index 344b9f7772..6aadaccabd 100644
--- a/tests/tcg/hexagon/fpstuff.c
+++ b/tests/tcg/hexagon/fpstuff.c
@@ -52,7 +52,7 @@ static void check_compare_exception(void)
     uint32_t cmp;
     uint32_t usr;
 
-    /* Check that FP compares are quiet (don't raise any execptions) */
+    /* Check that FP compares are quiet (don't raise any exceptions) */
     asm (CLEAR_FPSTATUS
          "p0 = sfcmp.eq(%2, %3)\n\t"
          "%0 = p0\n\t"
diff --git a/tests/tcg/hexagon/test_clobber.S b/tests/tcg/hexagon/test_clobber.S
index a7aeb2b60c..10046c30d2 100644
--- a/tests/tcg/hexagon/test_clobber.S
+++ b/tests/tcg/hexagon/test_clobber.S
@@ -1,5 +1,5 @@
 /*
- * Purpose: demonstrate the succesful operation of the register save mechanism,
+ * Purpose: demonstrate the successful operation of the register save mechanism,
  * in which the caller saves the registers that will be clobbered, and restores
  * them after the call.
  */
diff --git a/tests/tcg/i386/system/boot.S b/tests/tcg/i386/system/boot.S
index 794c2cb0ad..9e8920cbfe 100644
--- a/tests/tcg/i386/system/boot.S
+++ b/tests/tcg/i386/system/boot.S
@@ -71,7 +71,7 @@ _start:
         add $8,%esp
 
         /*
-         * Don't worry about stack frame, assume everthing
+         * Don't worry about stack frame, assume everything
          * is garbage when we return, we won't need it.
          */
         call main
diff --git a/tests/tcg/i386/x86.csv b/tests/tcg/i386/x86.csv
index c43bf42dd3..5c0f628e35 100644
--- a/tests/tcg/i386/x86.csv
+++ b/tests/tcg/i386/x86.csv
@@ -19,7 +19,7 @@
 #
 # 4. The instruction encoding. For example, "C1 /4 ib".
 #
-# 5. The validity of the instruction in 32-bit (aka compatiblity, legacy) mode.
+# 5. The validity of the instruction in 32-bit (aka compatibility, legacy) mode.
 #
 # 6. The validity of the instruction in 64-bit mode.
 #
diff --git a/tests/tcg/multiarch/sha512.c b/tests/tcg/multiarch/sha512.c
index 9e701bcf20..12c2b6c2b7 100644
--- a/tests/tcg/multiarch/sha512.c
+++ b/tests/tcg/multiarch/sha512.c
@@ -453,7 +453,7 @@ void sha512(struct sha512 *sha, const void *p, size_t size)
 /* From hex.h */
 /**
  * hex_decode - Unpack a hex string.
- * @str: the hexidecimal string
+ * @str: the hexadecimal string
  * @slen: the length of @str
  * @buf: the buffer to write the data into
  * @bufsize: the length of @buf
diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/tcg/multiarch/system/Makefile.softmmu-target
index fe40195d39..7ba9053375 100644
--- a/tests/tcg/multiarch/system/Makefile.softmmu-target
+++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
@@ -3,7 +3,7 @@
 # Multiarch system tests
 #
 # We just collect the tests together here and rely on the actual guest
-# architecture to add to the test dependancies and deal with the
+# architecture to add to the test dependencies and deal with the
 # complications of building.
 #
 
diff --git a/tests/tcg/s390x/mvc.c b/tests/tcg/s390x/mvc.c
index 7ae4c44550..b572aa3ced 100644
--- a/tests/tcg/s390x/mvc.c
+++ b/tests/tcg/s390x/mvc.c
@@ -85,7 +85,7 @@ int main(void)
         }
     }
 
-    /* test if MVC works now correctly accross page boundaries */
+    /* test if MVC works now correctly across page boundaries */
     mvc_256(dst + 4096 - 128, src + 4096 - 128);
     for (i = 0; i < ALLOC_SIZE; i++) {
         if (src[i] != 0xff) {
diff --git a/tests/tcg/tricore/c/crt0-tc2x.S b/tests/tcg/tricore/c/crt0-tc2x.S
index 3100da123c..399f112c35 100644
--- a/tests/tcg/tricore/c/crt0-tc2x.S
+++ b/tests/tcg/tricore/c/crt0-tc2x.S
@@ -263,7 +263,7 @@ __copy_table_next:
     ld.w    %d3,[%a13+]4            # %d3 = block length
     jeq %d3,-1,__copy_table_done    # length == -1 => end of table
     sh  %d0,%d3,-3          # %d0 = length / 8 (doublewords)
-    and %d1,%d3,7           # %d1 = lenght % 8 (rem. bytes)
+    and %d1,%d3,7           # %d1 = length % 8 (rem. bytes)
     jz  %d0,__copy_word         # block size < 8 => copy word
     addi    %d0,%d0,-1          # else doublewords -= 1
     mov.a   %a2,%d0             # %a2 = loop counter
@@ -274,7 +274,7 @@ __copy_dword:
 __copy_word:
     jz  %d1,__copy_table_next
     sh  %d0,%d1,-2          # %d0 = length / 4 (words)
-    and %d1,%d1,3           # %d1 = lenght % 4 (rem. bytes)
+    and %d1,%d1,3           # %d1 = length % 4 (rem. bytes)
     jz  %d0,__copy_hword        # block size < 4 => copy hword
     ld.w    %d14,[%a15+]4           # copy one word
     st.w    [%a14+]4,%d14
diff --git a/tests/tcg/x86_64/system/boot.S b/tests/tcg/x86_64/system/boot.S
index ed0f638406..dac9bd534d 100644
--- a/tests/tcg/x86_64/system/boot.S
+++ b/tests/tcg/x86_64/system/boot.S
@@ -121,7 +121,7 @@ _start:
 	// Setup stack ASAP
 	movq $stack_end,%rsp
 
-        /* don't worry about stack frame, assume everthing is garbage when we return */
+        /* don't worry about stack frame, assume everything is garbage when we return */
 	call main
 
 _exit:	/* output any non-zero result in eax to isa-debug-exit device */
@@ -195,7 +195,7 @@ idt_1F: .int 0, 0
 	 *
 	 * This describes various memory areas (segments) through
 	 * segment descriptors. In 32 bit mode each segment each
-	 * segement is associated with segment registers which are
+	 * segment is associated with segment registers which are
 	 * implicitly (or explicitly) referenced depending on the
 	 * instruction. However in 64 bit mode selectors are flat and
 	 * segmented addressing isn't used.
diff --git a/tests/tsan/suppressions.tsan b/tests/tsan/suppressions.tsan
index 73414b9ebd..d9a002a2ef 100644
--- a/tests/tsan/suppressions.tsan
+++ b/tests/tsan/suppressions.tsan
@@ -7,7 +7,7 @@
 mutex:aio_context_acquire
 mutex:pthread_mutex_lock
 
-# TSan reports a race betwen pthread_mutex_init() and
+# TSan reports a race between pthread_mutex_init() and
 # pthread_mutex_lock().  Since this is outside of QEMU,
 # we choose to ignore it.
 race:pthread_mutex_init
diff --git a/tests/uefi-test-tools/Makefile b/tests/uefi-test-tools/Makefile
index 471f0de981..0c003f2877 100644
--- a/tests/uefi-test-tools/Makefile
+++ b/tests/uefi-test-tools/Makefile
@@ -87,7 +87,7 @@ Build/%.fat: Build/%.efi
 .NOTPARALLEL:
 
 # In turn, the "build" utility of edk2 BaseTools invokes another "make".
-# Although the outer "make" process advertizes its job server to all child
+# Although the outer "make" process advertises its job server to all child
 # processes via MAKEFLAGS in the environment, the outer "make" closes the job
 # server file descriptors (exposed in MAKEFLAGS) before executing a recipe --
 # unless the recipe is recognized as a recursive "make" recipe. Recipes that
diff --git a/tests/unit/check-qjson.c b/tests/unit/check-qjson.c
index c4e0f851bf..a89293ce51 100644
--- a/tests/unit/check-qjson.c
+++ b/tests/unit/check-qjson.c
@@ -1486,7 +1486,7 @@ int main(int argc, char **argv)
     g_test_add_func("/literals/keyword", keyword_literal);
 
     g_test_add_func("/literals/interpolation/valid", interpolation_valid);
-    g_test_add_func("/literals/interpolation/unkown", interpolation_unknown);
+    g_test_add_func("/literals/interpolation/unknown", interpolation_unknown);
     g_test_add_func("/literals/interpolation/string", interpolation_string);
 
     g_test_add_func("/dicts/simple_dict", simple_dict);
diff --git a/tests/unit/test-aio.c b/tests/unit/test-aio.c
index 519440eed3..71ed31a4db 100644
--- a/tests/unit/test-aio.c
+++ b/tests/unit/test-aio.c
@@ -454,7 +454,7 @@ static void test_timer_schedule(void)
 
     g_assert_cmpint(data.n, ==, 0);
 
-    /* timer_mod may well cause an event notifer to have gone off,
+    /* timer_mod may well cause an event notifier to have gone off,
      * so clear that
      */
     do {} while (aio_poll(ctx, false));
diff --git a/tests/unit/test-bdrv-graph-mod.c b/tests/unit/test-bdrv-graph-mod.c
index c522591531..36eed4b464 100644
--- a/tests/unit/test-bdrv-graph-mod.c
+++ b/tests/unit/test-bdrv-graph-mod.c
@@ -98,9 +98,9 @@ static BlockDriverState *exclusive_writer_node(const char *name)
  *                                    | perm: write, read
  *                                    | shared: except write
  *                                    v
- *  +-------------------+           +----------------+
- *  | passtrough filter |---------->|  null-co node  |
- *  +-------------------+           +----------------+
+ *  +--------------------+          +----------------+
+ *  | passthrough filter |--------->|  null-co node  |
+ *  +--------------------+          +----------------+
  *
  *
  * and then, tries to append filter under node. Expected behavior: fail.
@@ -114,9 +114,9 @@ static BlockDriverState *exclusive_writer_node(const char *name)
  *                         | perm: write, read
  *                         | shared: except write
  *                         v
- *                +-------------------+
- *                | passtrough filter |
- *                +-------------------+
+ *                +--------------------+
+ *                | passthrough filter |
+ *                +--------------------+
  *                       |   |
  *     perm: write, read |   | perm: write, read
  *  shared: except write |   | shared: except write
diff --git a/tests/unit/test-crypto-secret.c b/tests/unit/test-crypto-secret.c
index 147b4af828..ffd13ff70e 100644
--- a/tests/unit/test-crypto-secret.c
+++ b/tests/unit/test-crypto-secret.c
@@ -244,7 +244,7 @@ static void test_secret_keyring_bad_key_access_right(void)
     char key_str[16];
     Object *sec;
 
-    g_test_skip("TODO: Need responce from Linux kernel maintainers");
+    g_test_skip("TODO: Need response from Linux kernel maintainers");
     return;
 
     int32_t key = add_key("user", DESCRIPTION, PAYLOAD,
diff --git a/tests/unit/test-qobject-input-visitor.c b/tests/unit/test-qobject-input-visitor.c
index 9b3e2dbe14..024e26c49e 100644
--- a/tests/unit/test-qobject-input-visitor.c
+++ b/tests/unit/test-qobject-input-visitor.c
@@ -94,7 +94,7 @@ Visitor *visitor_input_test_init(TestInputVisitorData *data,
 
 /* similar to visitor_input_test_init(), but does not expect a string
  * literal/format json_string argument and so can be used for
- * programatically generated strings (and we can't pass in programatically
+ * programmatically generated strings (and we can't pass in programmatically
  * generated strings via %s format parameters since qobject_from_jsonv()
  * will wrap those in double-quotes and treat the entire object as a
  * string)
diff --git a/tests/unit/test-throttle.c b/tests/unit/test-throttle.c
index 7adb5e6652..9ba1c73c35 100644
--- a/tests/unit/test-throttle.c
+++ b/tests/unit/test-throttle.c
@@ -135,7 +135,7 @@ static void test_compute_wait(void)
         g_assert(double_cmp(bkt.burst_level, 0));
         g_assert(double_cmp(bkt.level, (i + 1) * (bkt.max - bkt.avg) / 10));
         /* We can do bursts for the 2 seconds we have configured in
-         * burst_length. We have 100 extra miliseconds of burst
+         * burst_length. We have 100 extra milliseconds of burst
          * because bkt.level has been leaking during this time.
          * After that, we have to wait. */
         result = i < 21 ? 0 : 1.8 * NANOSECONDS_PER_SECOND;
@@ -379,7 +379,7 @@ static void test_is_valid(void)
     test_is_valid_for_value(-1, false);
     /* zero are valids */
     test_is_valid_for_value(0, true);
-    /* positives numers are valids */
+    /* positives numbers are valids */
     test_is_valid_for_value(1, true);
 }
 
diff --git a/tests/unit/test-util-filemonitor.c b/tests/unit/test-util-filemonitor.c
index b629e10857..a22de27595 100644
--- a/tests/unit/test-util-filemonitor.c
+++ b/tests/unit/test-util-filemonitor.c
@@ -132,7 +132,7 @@ qemu_file_monitor_test_record_free(QFileMonitorTestRecord *rec)
  * the file monitor event handler. Since events are
  * emitted in the background thread running the event
  * loop, we can't assume there is a record available
- * immediately. Thus we will sleep for upto 5 seconds
+ * immediately. Thus we will sleep for up to 5 seconds
  * to wait for the event to be queued for us.
  */
 static QFileMonitorTestRecord *
diff --git a/tests/unit/test-xs-node.c b/tests/unit/test-xs-node.c
index b80d10ff98..ac94e7ed6c 100644
--- a/tests/unit/test-xs-node.c
+++ b/tests/unit/test-xs-node.c
@@ -362,7 +362,7 @@ static void test_xs_node_simple(void)
     g_assert(data->len == strlen("something"));
     g_assert(!memcmp(data->data, "something", data->len));
 
-    /* Even if we use an abolute path */
+    /* Even if we use an absolute path */
     g_byte_array_set_size(data, 0);
     err = xs_impl_read(s, DOMID_GUEST, XBT_NULL,
                        "/local/domain/1/some/relative/path", data);
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index c2a8ca1c17..e87dd7cd7a 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -81,7 +81,7 @@ endif
 	@echo "    QEMU_IMG=/path/to/qemu-img	 - Change path to qemu-img tool"
 	@echo "    QEMU_LOCAL=1                 - Use QEMU binary local to this build."
 	@echo "    TARGET_LIST=a,b,c    	 - Override target list in builds"
-	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
+	@echo "    V=1				 - Enable verbose output on host and guest commands"
 
 vm-build-all: $(addprefix vm-build-, $(IMAGES))
 
diff --git a/tests/vm/ubuntuvm.py b/tests/vm/ubuntuvm.py
index 6689ad87aa..15c530c571 100644
--- a/tests/vm/ubuntuvm.py
+++ b/tests/vm/ubuntuvm.py
@@ -51,7 +51,7 @@ def build_image(self, img):
         # then we will jump right to the graceful shutdown
         if self._config['install_cmds'] != "":
             # Issue the install commands.
-            # This can be overriden by the user in the config .yml.
+            # This can be overridden by the user in the config .yml.
             install_cmds = self._config['install_cmds'].split(',')
             for cmd in install_cmds:
                 self.ssh_root(cmd)
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 0c2153d17c..4d8989c4eb 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -2045,7 +2045,7 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 
     /*
      * Create the menu entries which depend on QEMU state (for consoles
-     * and removeable devices). These make calls back into QEMU functions,
+     * and removable devices). These make calls back into QEMU functions,
      * which is OK because at this point we know that the second thread
      * holds the iothread lock and is synchronously waiting for us to
      * finish.
diff --git a/ui/keymaps.h b/ui/keymaps.h
index 6473405485..3d52c0882a 100644
--- a/ui/keymaps.h
+++ b/ui/keymaps.h
@@ -44,7 +44,7 @@ typedef struct {
 /* "up" flag */
 #define SCANCODE_UP     0x80
 
-/* Additional modifiers to use if not catched another way. */
+/* Additional modifiers to use if not caught another way. */
 #define SCANCODE_SHIFT  0x100
 #define SCANCODE_CTRL   0x200
 #define SCANCODE_ALT    0x400
diff --git a/ui/sdl2-2d.c b/ui/sdl2-2d.c
index bfebbdeaea..06468cd493 100644
--- a/ui/sdl2-2d.c
+++ b/ui/sdl2-2d.c
@@ -150,7 +150,7 @@ bool sdl2_2d_check_format(DisplayChangeListener *dcl,
 {
     /*
      * We let SDL convert for us a few more formats than,
-     * the native ones. Thes are the ones I have tested.
+     * the native ones. These are the ones I have tested.
      */
     return (format == PIXMAN_x8r8g8b8 ||
             format == PIXMAN_a8r8g8b8 ||
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 0d91b555e3..ea4a92cd36 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -860,7 +860,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
     SDL_SetHint(SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR, "0");
 #endif
 #ifndef CONFIG_WIN32
-    /* QEMU uses its own low level keyboard hook procecure on Windows */
+    /* QEMU uses its own low level keyboard hook procedure on Windows */
     SDL_SetHint(SDL_HINT_GRAB_KEYBOARD, "1");
 #endif
 #ifdef SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED
diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index 09200d71b8..ee853dcfcb 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -77,7 +77,7 @@ static int tight_send_framebuffer_update(VncState *vs, int x, int y,
 
 #ifdef CONFIG_VNC_JPEG
 static const struct {
-    double jpeg_freq_min;       /* Don't send JPEG if the freq is bellow */
+    double jpeg_freq_min;       /* Don't send JPEG if the freq is below */
     double jpeg_freq_threshold; /* Always send JPEG if the freq is above */
     int jpeg_idx;               /* Allow indexed JPEG */
     int jpeg_full;              /* Allow full color JPEG */
diff --git a/ui/vnc-enc-zrle.c.inc b/ui/vnc-enc-zrle.c.inc
index c107d8affc..a8ca37d05e 100644
--- a/ui/vnc-enc-zrle.c.inc
+++ b/ui/vnc-enc-zrle.c.inc
@@ -110,7 +110,7 @@ static void ZRLE_ENCODE_TILE(VncState *vs, ZRLE_PIXEL *data, int w, int h,
     ZRLE_PIXEL *end = ptr + h * w;
     *end = ~*(end-1); /* one past the end is different so the while loop ends */
 
-    /* Real limit is 127 but we wan't a way to know if there is more than 127 */
+    /* Real limit is 127 but we want a way to know if there is more than 127 */
     palette_init(palette, 256, ZRLE_BPP);
 
     while (ptr < end) {
diff --git a/ui/vnc-enc-zywrle.h b/ui/vnc-enc-zywrle.h
index e661ec117d..64fbc90ee7 100644
--- a/ui/vnc-enc-zywrle.h
+++ b/ui/vnc-enc-zywrle.h
@@ -485,7 +485,7 @@ static inline void wavelet(int *buf, int width, int height, int level)
 
 /*
   RGB <=> YUV conversion stuffs.
-  YUV coversion is explained as following formula in strict meaning:
+  YUV conversion is explained as following formula in strict meaning:
   Y =  0.299R + 0.587G + 0.114B (   0<=Y<=255)
   U = -0.169R - 0.331G + 0.500B (-128<=U<=127)
   V =  0.500R - 0.419G - 0.081B (-128<=V<=127)
@@ -539,7 +539,7 @@ static inline void wavelet(int *buf, int width, int height, int level)
    +------+------+
 
  So, we must transfer each sub images individually in strict meaning.
- But at least ZRLE meaning, following one decompositon image is same as
+ But at least ZRLE meaning, following one decomposition image is same as
  avobe individual sub image. I use this format.
  (Strictly saying, transfer order is reverse(Hxy->Hy->Hx->L)
   for simplified procedure for any wavelet level.)
diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
index ababc39550..7d39f47e3b 100644
--- a/util/cpuinfo-aarch64.c
+++ b/util/cpuinfo-aarch64.c
@@ -1,6 +1,6 @@
 /*
  * SPDX-License-Identifier: GPL-2.0-or-later
- * Host specific cpu indentification for AArch64.
+ * Host specific cpu identification for AArch64.
  */
 
 #include "qemu/osdep.h"
@@ -33,7 +33,7 @@ static bool sysctl_for_bool(const char *name)
     /*
      * We might in the future ask for properties not present in older kernels,
      * but we're only asking about static properties, all of which should be
-     * 'int'.  So we shouln't see ENOMEM (val too small), or any of the other
+     * 'int'.  So we shouldn't see ENOMEM (val too small), or any of the other
      * more exotic errors.
      */
     assert(errno == ENOENT);
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index 3a7b7e0ad1..b2ed65bb10 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -1,6 +1,6 @@
 /*
  * SPDX-License-Identifier: GPL-2.0-or-later
- * Host specific cpu indentification for x86.
+ * Host specific cpu identification for x86.
  */
 
 #include "qemu/osdep.h"
@@ -74,7 +74,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
                  * of their memory operands to be 16-byte aligned.
                  *
                  * AMD has provided an even stronger guarantee that processors
-                 * with AVX provide 16-byte atomicity for all cachable,
+                 * with AVX provide 16-byte atomicity for all cacheable,
                  * naturally aligned single loads and stores, e.g. MOVDQU.
                  *
                  * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104688
diff --git a/util/cpuinfo-ppc.c b/util/cpuinfo-ppc.c
index 7212afa45d..1ea3db0ac8 100644
--- a/util/cpuinfo-ppc.c
+++ b/util/cpuinfo-ppc.c
@@ -1,6 +1,6 @@
 /*
  * SPDX-License-Identifier: GPL-2.0-or-later
- * Host specific cpu indentification for ppc.
+ * Host specific cpu identification for ppc.
  */
 
 #include "qemu/osdep.h"
diff --git a/util/main-loop.c b/util/main-loop.c
index 014c795916..797b640c41 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -47,7 +47,7 @@
  */
 /*
  * Disable CFI checks.
- * We are going to call a signal hander directly. Such handler may or may not
+ * We are going to call a signal handler directly. Such handler may or may not
  * have been defined in our binary, so there's no guarantee that the pointer
  * used to set the handler is a cfi-valid pointer. Since the handlers are
  * stored in kernel memory, changing the handler to an attacker-defined
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 760390b31e..4d583da7ce 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -671,7 +671,7 @@ void qemu_free_stack(void *stack, size_t sz)
 
 /*
  * Disable CFI checks.
- * We are going to call a signal hander directly. Such handler may or may not
+ * We are going to call a signal handler directly. Such handler may or may not
  * have been defined in our binary, so there's no guarantee that the pointer
  * used to set the handler is a cfi-valid pointer. Since the handlers are
  * stored in kernel memory, changing the handler to an attacker-defined
diff --git a/util/qdist.c b/util/qdist.c
index 5f75e24c29..ef3566b03a 100644
--- a/util/qdist.c
+++ b/util/qdist.c
@@ -210,7 +210,7 @@ void qdist_bin__internal(struct qdist *to, const struct qdist *from, size_t n)
 
         /*
          * To avoid double-counting we capture [left, right) ranges, except for
-         * the righmost bin, which captures a [left, right] range.
+         * the rightmost bin, which captures a [left, right] range.
          */
         while (j < from->n && (from->entries[j].x < right || i == n - 1)) {
             struct qdist_entry *o = &from->entries[j];
diff --git a/util/qemu-progress.c b/util/qemu-progress.c
index aa994668f1..35574487c9 100644
--- a/util/qemu-progress.c
+++ b/util/qemu-progress.c
@@ -95,7 +95,7 @@ static void progress_dummy_init(void)
     /*
      * SIGUSR1 is SIG_IPI and gets blocked in qemu_init_main_loop(). In the
      * tools that use the progress report SIGUSR1 isn't used in this meaning
-     * and instead should print the progress, so reenable it.
+     * and instead should print the progress, so re-enable it.
      */
     sigemptyset(&set);
     sigaddset(&set, SIGUSR1);
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 892d33f5e6..83e84b1186 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -929,7 +929,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
 
     if (pathbuf != NULL) {
         /*
-         * This dummy fd usage silences the mktemp() unsecure warning.
+         * This dummy fd usage silences the mktemp() insecure warning.
          * Using mkstemp() doesn't make things more secure here
          * though.  bind() complains about existing files, so we have
          * to unlink first and thus re-open the race window.  The
diff --git a/util/rcu.c b/util/rcu.c
index 30a7e22026..e587bcc483 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -355,7 +355,7 @@ void drain_call_rcu(void)
      *
      * Note that since we have only one global queue of the RCU callbacks,
      * we also end up waiting for most of RCU callbacks that were registered
-     * on the other threads, but this is a side effect that shoudn't be
+     * on the other threads, but this is a side effect that shouldn't be
      * assumed.
      */
 
-- 
2.39.2


