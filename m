Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8B3754E89
	for <lists+qemu-devel@lfdr.de>; Sun, 16 Jul 2023 13:59:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qL0OM-0004Dc-Tz; Sun, 16 Jul 2023 07:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qL0OK-0004Ce-4z; Sun, 16 Jul 2023 07:58:20 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qL0OI-0001r4-34; Sun, 16 Jul 2023 07:58:19 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9F91C14245;
 Sun, 16 Jul 2023 14:58:24 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A373F14F2E;
 Sun, 16 Jul 2023 14:58:04 +0300 (MSK)
Received: (nullmailer pid 1505314 invoked by uid 1000);
 Sun, 16 Jul 2023 11:58:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 0/6] trivial-patches for 2023-07-16
Date: Sun, 16 Jul 2023 14:57:55 +0300
Message-Id: <20230716115801.1505288-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
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

The following changes since commit 7d07a21ec003724475566073404c5893e36de5e5:

  tree-wide spelling fixes in comments and some messages: hw/9pfs (2023-07-16 13:59:17 +0300)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git/ tags/trivial-patches-pull

for you to fetch changes up to 7d07a21ec003724475566073404c5893e36de5e5:

  tree-wide spelling fixes in comments and some messages: hw/9pfs (2023-07-16 13:59:17 +0300)

----------------------------------------------------------------
trivial-patches for 2023-07-16

This contains a doc fix for riscv and reviewed spelling fixes.
----------------------------------------------------------------

Daniel Henrique Barboza (1):
  docs/system/target-riscv.rst: tidy CPU firmware section

Michael Tokarev (5):
  tree-wide spelling fixes in comments and some messages: migration/
  tree-wide spelling fixes in comments and some messages: s390x
  tree-wide spelling fixes in comments and some messages: arm
  tree-wide spelling fixes in comments and some messages: other
    architectures
  tree-wide spelling fixes in comments and some messages: hw/9pfs

 docs/system/target-riscv.rst                  | 24 ++++++++++++-------
 host/include/aarch64/host/cpuinfo.h           |  2 +-
 host/include/generic/host/cpuinfo.h           |  2 +-
 hw/9pfs/9p-local.c                            |  8 +++----
 hw/9pfs/9p-proxy.c                            |  2 +-
 hw/9pfs/9p-synth.c                            |  2 +-
 hw/9pfs/9p-util.h                             |  2 +-
 hw/9pfs/9p.c                                  |  4 ++--
 hw/9pfs/9p.h                                  |  2 +-
 hw/arm/aspeed.c                               |  2 +-
 hw/arm/mps2-tz.c                              |  2 +-
 hw/intc/arm_gic.c                             |  4 ++--
 hw/intc/arm_gicv3_redist.c                    |  2 +-
 hw/intc/armv7m_nvic.c                         |  2 +-
 hw/intc/s390_flic_kvm.c                       |  2 +-
 hw/m68k/next-cube.c                           |  2 +-
 hw/m68k/next-kbd.c                            |  2 +-
 hw/m68k/virt.c                                |  2 +-
 hw/microblaze/petalogix_ml605_mmu.c           |  2 +-
 hw/misc/allwinner-r40-dramc.c                 |  2 +-
 hw/misc/exynos4210_rng.c                      |  2 +-
 hw/sparc/sun4m_iommu.c                        |  8 +++----
 include/hw/arm/fsl-imx7.h                     |  2 +-
 include/hw/intc/armv7m_nvic.h                 |  2 +-
 include/hw/s390x/s390-pci-bus.h               |  2 +-
 include/hw/s390x/sclp.h                       |  2 +-
 migration/migration-stats.c                   |  2 +-
 migration/migration.h                         |  4 ++--
 migration/multifd-zlib.c                      |  2 +-
 migration/multifd-zstd.c                      |  2 +-
 migration/multifd.c                           |  2 +-
 migration/savevm.c                            |  2 +-
 migration/trace-events                        |  2 +-
 target/alpha/cpu.h                            |  4 ++--
 target/alpha/translate.c                      |  2 +-
 target/arm/cpu.c                              |  2 +-
 target/arm/cpu.h                              |  2 +-
 target/arm/cpu64.c                            |  2 +-
 target/arm/helper.c                           |  4 ++--
 target/arm/tcg/m_helper.c                     |  2 +-
 target/arm/tcg/translate-a64.c                |  4 ++--
 target/arm/tcg/translate-mve.c                |  4 ++--
 target/arm/tcg/translate-sve.c                |  2 +-
 target/arm/tcg/translate-vfp.c                |  2 +-
 target/arm/tcg/vec_helper.c                   |  2 +-
 target/cris/helper.c                          |  6 ++---
 target/cris/op_helper.c                       |  2 +-
 target/cris/translate.c                       | 16 ++++++-------
 target/hppa/cpu.h                             |  4 ++--
 target/hppa/int_helper.c                      |  2 +-
 target/hppa/translate.c                       |  2 +-
 target/loongarch/cpu-csr.h                    |  2 +-
 target/m68k/helper.c                          |  4 ++--
 target/microblaze/cpu.h                       |  2 +-
 target/openrisc/cpu.h                         |  2 +-
 target/openrisc/translate.c                   |  4 ++--
 target/rx/translate.c                         |  4 ++--
 target/s390x/cpu_features.c                   |  2 +-
 target/s390x/cpu_models.c                     |  2 +-
 target/s390x/tcg/fpu_helper.c                 |  2 +-
 target/s390x/tcg/insn-data.h.inc              |  2 +-
 target/s390x/tcg/translate.c                  |  2 +-
 target/sparc/asi.h                            | 14 +++++------
 target/tricore/csfr.h.inc                     |  2 +-
 target/tricore/helper.c                       |  2 +-
 target/tricore/translate.c                    |  8 +++----
 tests/tcg/Makefile.target                     |  4 ++--
 tests/tcg/aarch64/gdbstub/test-sve.py         |  2 +-
 tests/tcg/aarch64/sme-outprod1.c              |  2 +-
 tests/tcg/aarch64/system/boot.S               |  6 ++---
 tests/tcg/aarch64/system/semiheap.c           |  2 +-
 tests/tcg/multiarch/sha512.c                  |  2 +-
 .../multiarch/system/Makefile.softmmu-target  |  2 +-
 tests/tcg/s390x/mvc.c                         |  2 +-
 tests/tcg/tricore/c/crt0-tc2x.S               |  4 ++--
 tests/tcg/x86_64/system/boot.S                |  4 ++--
 76 files changed, 131 insertions(+), 123 deletions(-)

-- 
2.39.2


