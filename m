Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC84798546
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 11:58:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeYDm-00070b-VX; Fri, 08 Sep 2023 05:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeYDe-0006xi-2x; Fri, 08 Sep 2023 05:56:07 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeYDX-0006OF-0D; Fri, 08 Sep 2023 05:56:04 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 060D9200C8;
 Fri,  8 Sep 2023 12:56:45 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0A5282690E;
 Fri,  8 Sep 2023 12:55:56 +0300 (MSK)
Received: (nullmailer pid 275939 invoked by uid 1000);
 Fri, 08 Sep 2023 09:55:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 00/23] trivial patches for 2023-09-08
Date: Fri,  8 Sep 2023 12:54:57 +0300
Message-Id: <20230908095520.275866-1-mjt@tls.msk.ru>
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

The following changes since commit 03a3a62fbd0aa5227e978eef3c67d3978aec9e5f:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-09-07 10:29:06 -0400)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to 84ef79c01336c90561c1901dca7dbcde775038ba:

  qxl: don't assert() if device isn't yet initialized (2023-09-08 12:46:01 +0300)

----------------------------------------------------------------
trivial-patches for 2023-09-08

There are some more or less minor things here and there,
and a bunch of spelling fixes (the ones which were reviewed,
there are some which are pending still).

----------------------------------------------------------------
Daniel Henrique Barboza (2):
      hw/ppc: use g_free() in spapr_tce_table_post_load()
      target/ppc: use g_free() in test_opcode_table()

Marc-André Lureau (1):
      qxl: don't assert() if device isn't yet initialized

Markus Armbruster (2):
      docs tests: Fix use of migrate_set_parameter
      tests/qtest/test-hmp: Fix migrate_set_parameter xbzrle-cache-size test

Michael Tokarev (11):
      qemu-img: omit errno value in error message
      hexagon: spelling fixes
      riscv: spelling fixes
      xen: spelling fix
      audio: spelling fixes
      include/: spelling fixes
      scripts/: spelling fixes
      tests/: spelling fixes
      qga/: spelling fixes
      misc/other: spelling fixes
      block: spelling fixes

Peter Maydell (1):
      hw/display/xlnx_dp: update comments

Philippe Mathieu-Daudé (1):
      accel/tcg: Fix typo in translator_io_start() description

Thomas Huth (5):
      trace-events: Fix the name of the tracing.rst file
      qemu-options.hx: Rephrase the descriptions of the -hd* and -cdrom options
      trivial: Simplify the spots that use TARGET_BIG_ENDIAN as a numeric value
      tests/qtest/usb-hcd: Remove the empty "init" tests
      hw/net/vmxnet3: Fix guest-triggerable assert()

 audio/mixeng.h                                    |  2 +-
 backends/tpm/tpm_ioctl.h                          |  2 +-
 block.c                                           |  2 +-
 block/block-copy.c                                |  4 ++--
 block/export/vduse-blk.c                          |  2 +-
 block/export/vhost-user-blk-server.c              |  2 +-
 block/export/vhost-user-blk-server.h              |  2 +-
 block/file-posix.c                                |  8 ++++----
 block/graph-lock.c                                |  2 +-
 block/io.c                                        |  2 +-
 block/linux-aio.c                                 |  2 +-
 block/mirror.c                                    |  2 +-
 block/qcow2-refcount.c                            |  2 +-
 block/vhdx.c                                      |  2 +-
 block/vhdx.h                                      |  4 ++--
 bsd-user/trace-events                             |  2 +-
 chardev/char-socket.c                             |  6 +++---
 chardev/char.c                                    |  2 +-
 cpu.c                                             |  6 +-----
 crypto/afalg.c                                    |  2 +-
 crypto/block-luks.c                               |  6 +++---
 crypto/der.c                                      |  2 +-
 crypto/der.h                                      |  6 +++---
 docs/multi-thread-compression.txt                 | 12 ++++++------
 docs/rdma.txt                                     |  2 +-
 ebpf/trace-events                                 |  2 +-
 hw/audio/fmopl.c                                  |  8 ++++----
 hw/audio/fmopl.h                                  |  2 +-
 hw/audio/gusemu_hal.c                             |  4 ++--
 hw/audio/intel-hda-defs.h                         |  4 ++--
 hw/display/qxl.c                                  |  5 ++++-
 hw/display/xlnx_dp.c                              |  9 ++++++---
 hw/microblaze/boot.c                              |  9 ++-------
 hw/mips/jazz.c                                    | 10 ++--------
 hw/mips/malta.c                                   | 21 ++++-----------------
 hw/mips/mipssim.c                                 |  9 +--------
 hw/net/vmxnet3.c                                  |  5 ++++-
 hw/nios2/boot.c                                   |  9 ++-------
 hw/nubus/trace-events                             |  2 +-
 hw/ppc/spapr_iommu.c                              |  2 +-
 hw/riscv/microchip_pfsoc.c                        |  2 +-
 hw/riscv/virt.c                                   |  4 ++--
 hw/xen/xen_pvdev.c                                |  2 +-
 hw/xtensa/sim.c                                   |  7 +------
 hw/xtensa/xtfpga.c                                | 10 +++-------
 include/block/block_int-common.h                  |  2 +-
 include/chardev/char-fe.h                         |  4 ++--
 include/crypto/akcipher.h                         |  2 +-
 include/crypto/ivgen.h                            |  4 ++--
 include/exec/translator.h                         |  2 +-
 include/hw/acpi/aml-build.h                       |  2 +-
 include/hw/acpi/pc-hotplug.h                      |  2 +-
 include/hw/acpi/vmgenid.h                         |  2 +-
 include/hw/boards.h                               |  6 +++---
 include/hw/char/avr_usart.h                       |  2 +-
 include/hw/clock.h                                |  2 +-
 include/hw/cxl/cxl_device.h                       |  2 +-
 include/hw/hyperv/vmbus.h                         |  2 +-
 include/hw/misc/macio/pmu.h                       |  2 +-
 include/hw/net/mii.h                              |  2 +-
 include/hw/pci-host/dino.h                        |  2 +-
 include/hw/pci/pcie_aer.h                         |  2 +-
 include/hw/riscv/riscv_hart.h                     |  2 +-
 include/hw/ssi/xilinx_spips.h                     |  2 +-
 include/hw/virtio/virtio-net.h                    |  2 +-
 include/sysemu/cryptodev-vhost.h                  |  2 +-
 include/sysemu/cryptodev.h                        |  6 +++---
 include/sysemu/iothread.h                         |  2 +-
 include/sysemu/stats.h                            |  2 +-
 include/sysemu/tpm_backend.h                      |  2 +-
 nbd/client-connection.c                           |  2 +-
 net/checksum.c                                    |  4 ++--
 net/filter.c                                      |  6 +++---
 net/vhost-vdpa.c                                  |  8 ++++----
 qemu-img.c                                        |  4 ++--
 qemu-options.hx                                   | 20 ++++++++++++--------
 qga/channel-posix.c                               |  2 +-
 qga/commands-posix-ssh.c                          |  2 +-
 qga/commands-posix.c                              |  2 +-
 qga/commands-win32.c                              |  4 ++--
 qga/main.c                                        |  2 +-
 qga/vss-win32/install.cpp                         |  4 ++--
 scripts/checkpatch.pl                             |  2 +-
 scripts/ci/gitlab-pipeline-status                 |  2 +-
 scripts/codeconverter/codeconverter/qom_macros.py |  2 +-
 scripts/oss-fuzz/minimize_qtest_trace.py          |  8 ++++----
 scripts/performance/topN_callgrind.py             |  2 +-
 scripts/performance/topN_perf.py                  |  2 +-
 scripts/qapi/gen.py                               |  2 +-
 scripts/replay-dump.py                            |  2 +-
 scripts/simplebench/bench_block_job.py            |  2 +-
 target/arm/cpu.h                                  | 12 ++----------
 target/hexagon/README                             |  2 +-
 target/hexagon/fma_emu.c                          |  2 +-
 target/hexagon/idef-parser/README.rst             |  2 +-
 target/hexagon/idef-parser/idef-parser.h          |  2 +-
 target/hexagon/idef-parser/parser-helpers.c       |  6 +++---
 target/hexagon/imported/alu.idef                  |  8 ++++----
 target/hexagon/imported/macros.def                |  2 +-
 target/hexagon/imported/mmvec/ext.idef            | 10 +++++-----
 target/ppc/translate.c                            |  2 +-
 target/riscv/cpu.h                                |  2 +-
 target/riscv/cpu_bits.h                           |  4 ++--
 target/riscv/csr.c                                |  4 ++--
 target/riscv/debug.c                              | 10 +++++-----
 target/riscv/insn_trans/trans_rvf.c.inc           |  4 ++--
 target/riscv/insn_trans/trans_rvv.c.inc           |  4 ++--
 target/riscv/insn_trans/trans_rvzfh.c.inc         |  4 ++--
 target/riscv/monitor.c                            |  2 +-
 target/s390x/kvm/trace-events                     |  2 +-
 tests/avocado/acpi-bits.py                        |  4 ++--
 tests/avocado/acpi-bits/bits-tests/testacpi.py2   |  4 ++--
 tests/decode/err_pattern_group_ident2.decode      |  2 +-
 tests/docker/common.rc                            |  2 +-
 tests/migration/guestperf-batch.py                |  2 +-
 tests/migration/guestperf.py                      |  2 +-
 tests/plugin/mem.c                                |  2 +-
 tests/qapi-schema/bad-if-not.json                 |  2 +-
 tests/qemu-iotests/029                            |  2 +-
 tests/qemu-iotests/040                            |  8 ++++----
 tests/qemu-iotests/046                            |  2 +-
 tests/qemu-iotests/059                            |  2 +-
 tests/qemu-iotests/061                            |  2 +-
 tests/qemu-iotests/071                            |  2 +-
 tests/qemu-iotests/080.out                        |  6 +++---
 tests/qemu-iotests/112.out                        |  6 +++---
 tests/qemu-iotests/181                            |  2 +-
 tests/qemu-iotests/197                            |  2 +-
 tests/qemu-iotests/215                            |  2 +-
 tests/qemu-iotests/244.out                        |  2 +-
 tests/qemu-iotests/298                            |  4 ++--
 tests/qemu-iotests/pylintrc                       |  2 +-
 tests/qtest/ahci-test.c                           |  2 +-
 tests/qtest/bcm2835-dma-test.c                    |  2 +-
 tests/qtest/bios-tables-test.c                    |  2 +-
 tests/qtest/ds1338-test.c                         |  2 +-
 tests/qtest/fuzz/generic_fuzz.c                   |  6 +++---
 tests/qtest/libqos/qgraph.c                       |  4 ++--
 tests/qtest/libqos/qgraph_internal.h              |  2 +-
 tests/qtest/libqos/virtio-gpio.c                  |  2 +-
 tests/qtest/libqtest.c                            |  4 ++--
 tests/qtest/migration-test.c                      |  6 +++---
 tests/qtest/npcm7xx_timer-test.c                  |  2 +-
 tests/qtest/test-hmp.c                            |  6 +++---
 tests/qtest/tpm-emu.c                             |  2 +-
 tests/qtest/tpm-tests.c                           |  2 +-
 tests/qtest/tpm-tests.h                           |  2 +-
 tests/qtest/tpm-tis-i2c-test.c                    |  2 +-
 tests/qtest/tpm-tis-util.c                        |  2 +-
 tests/qtest/usb-hcd-uhci-test.c                   |  5 -----
 tests/qtest/usb-hcd-xhci-test.c                   |  6 ------
 tests/qtest/vhost-user-blk-test.c                 |  2 +-
 tests/qtest/virtio-net-test.c                     |  2 +-
 tests/qtest/vmgenid-test.c                        |  2 +-
 tests/tcg/hexagon/fpstuff.c                       |  2 +-
 tests/tcg/hexagon/test_clobber.S                  |  2 +-
 tests/tsan/suppressions.tsan                      |  2 +-
 tests/uefi-test-tools/Makefile                    |  2 +-
 tests/unit/check-qjson.c                          |  2 +-
 tests/unit/test-aio.c                             |  2 +-
 tests/unit/test-bdrv-graph-mod.c                  | 12 ++++++------
 tests/unit/test-crypto-secret.c                   |  2 +-
 tests/unit/test-qobject-input-visitor.c           |  2 +-
 tests/unit/test-throttle.c                        |  8 ++++----
 tests/unit/test-util-filemonitor.c                |  2 +-
 tests/unit/test-xs-node.c                         |  2 +-
 tests/vm/Makefile.include                         |  2 +-
 tests/vm/ubuntuvm.py                              |  2 +-
 168 files changed, 281 insertions(+), 336 deletions(-)

