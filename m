Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A125A7063CF
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 11:16:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzDBM-000073-Mh; Wed, 17 May 2023 05:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDBJ-0008VE-MK; Wed, 17 May 2023 05:10:49 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDBF-0006LL-Q6; Wed, 17 May 2023 05:10:49 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DCB806826;
 Wed, 17 May 2023 12:10:42 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4F0645EF2;
 Wed, 17 May 2023 12:10:42 +0300 (MSK)
Received: (nullmailer pid 3626664 invoked by uid 1000);
 Wed, 17 May 2023 09:10:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Subject: [PATCH v7.2.3 00/30]  Patch Round-up for stable 7.2.3,
 freeze on 2023-05-27
Date: Wed, 17 May 2023 12:10:12 +0300
Message-Id: <cover.1684310574.git.mjt@msgid.tls.msk.ru>
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

Hi everyone,

I intend to release at least one more 7.2.x release, maybe keep it
going for a while.  This is another attempt at it.

The following new patches are queued for QEMU stable v7.2.3:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2

Patch freeze is 2023-05-27, and the release is planned for 2023-05-29:

  https://wiki.qemu.org/Planning/7.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

Thanks!

/mjt

--------------------------------------------------------------
Akihiko Odaki (1):
  target/arm: Initialize debug capabilities only once

Albert Esteve (1):
  hw/virtio/vhost-user: avoid using unitialized errp

Alex Bennée (1):
  qemu-options: finesse the recommendations around -blockdev

Carlos López (1):
  virtio: fix reachable assertion due to stale value of cached region
    size

Chuck Zmudzinski (1):
  xen/pt: reserve PCI slot 2 for Intel igd-passthru

Cédric Le Goater (3):
  hw/arm/boot: Make write_bootloader() public as arm_write_bootloader()
  hw/arm/aspeed: Use arm_write_bootloader() to write the bootloader
  async: Suppress GCC13 false positive in aio_bh_poll()

Greg Kurz (2):
  Revert "vhost-user: Monitor slave channel in vhost_user_read()"
  Revert "vhost-user: Introduce nested event loop in vhost_user_read()"

Igor Mammedov (1):
  acpi: pcihp: allow repeating hot-unplug requests

Ilya Leoshkevich (1):
  target/s390x: Fix EXECUTE of relative branches

Jason Andryuk (1):
  9pfs/xen: Fix segfault on shutdown

Kevin Wolf (1):
  block: Fix use after free in blockdev_mark_auto_del()

LIU Zhiwei (1):
  target/riscv: Fix itrigger when icount is used

Paolo Bonzini (2):
  vnc: avoid underflow when accessing user-provided address
  meson: leave unnecessary modules out of the build

Peter Maydell (8):
  docs/about/deprecated.rst: Add "since 7.1" tag to dtb-kaslr-seed
    deprecation
  hw/net/msf2-emac: Don't modify descriptor in-place in
    emac_store_desc()
  hw/arm/raspi: Use arm_write_bootloader() to write boot code
  hw/intc/allwinner-a10-pic: Don't use set_bit()/clear_bit()
  target/arm: Define and use new load_cpu_field_low32()
  hw/sd/allwinner-sdhost: Correctly byteswap descriptor fields
  hw/net/allwinner-sun8i-emac: Correctly byteswap descriptor fields
  ui: Fix pixel colour channel order for PNG screenshots

Richard Henderson (1):
  accel/tcg: Fix atomic_mmu_lookup for reads

Shivaprasad G Bhat (2):
  softfloat: Fix the incorrect computation in float32_exp2
  tcg: ppc64: Fix mask generation for vextractdm

Wang Liang (1):
  block/monitor: Fix crash when executing HMP commit

Yang Zhong (1):
  target/i386: Change wrong XFRM value in SGX CPUID leaf

 accel/tcg/cputlb.c                            |   2 +-
 block/monitor/block-hmp-cmds.c                |  10 +-
 blockdev.c                                    |  18 ++-
 docs/about/deprecated.rst                     |   4 +-
 fpu/softfloat.c                               |   2 +-
 hw/9pfs/trace-events                          |   6 +
 hw/9pfs/xen-9p-backend.c                      |  35 +++---
 hw/acpi/pcihp.c                               |  10 ++
 hw/arm/aspeed.c                               |  42 +++----
 hw/arm/boot.c                                 |  35 ++----
 hw/arm/raspi.c                                |  64 ++++++-----
 hw/i386/pc_piix.c                             |   1 +
 hw/intc/allwinner-a10-pic.c                   |   7 +-
 hw/net/allwinner-sun8i-emac.c                 |  22 ++--
 hw/net/msf2-emac.c                            |  18 +--
 hw/sd/allwinner-sdhost.c                      |  31 +++++-
 hw/virtio/vhost-user.c                        | 104 ++----------------
 hw/virtio/virtio.c                            |  11 +-
 hw/xen/xen_pt.c                               |  64 +++++++++--
 hw/xen/xen_pt.h                               |  20 ++++
 hw/xen/xen_pt_stub.c                          |   4 +
 include/hw/arm/boot.h                         |  49 +++++++++
 meson.build                                   |   4 +
 qemu-options.hx                               |  24 +++-
 target/arm/kvm.c                              |   2 +
 target/arm/kvm64.c                            |  18 +--
 target/arm/kvm_arm.h                          |   8 ++
 target/arm/translate-a32.h                    |   7 ++
 target/arm/translate.c                        |   4 +-
 target/i386/cpu.c                             |   4 +-
 target/ppc/translate/vmx-impl.c.inc           |   2 +-
 .../riscv/insn_trans/trans_privileged.c.inc   |   6 +
 target/s390x/tcg/translate.c                  |  81 ++++++++++----
 ui/console.c                                  |   4 +-
 ui/vnc.c                                      |   2 +-
 util/async.c                                  |  14 +++
 36 files changed, 455 insertions(+), 284 deletions(-)

-- 
2.39.2


