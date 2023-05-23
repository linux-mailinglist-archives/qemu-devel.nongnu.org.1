Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 080E670DA2F
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:18:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1P3R-0006gr-Tu; Tue, 23 May 2023 06:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P3P-0006et-FC; Tue, 23 May 2023 06:15:43 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P3N-0001jw-0n; Tue, 23 May 2023 06:15:43 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A9F007CF2;
 Tue, 23 May 2023 13:15:37 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0191D7282;
 Tue, 23 May 2023 13:15:36 +0300 (MSK)
Received: (nullmailer pid 85484 invoked by uid 1000);
 Tue, 23 May 2023 10:15:36 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.1 v2 00/59] Patch Round-up for stable 8.0.1,
 freeze on 2023-05-27
Date: Tue, 23 May 2023 13:14:56 +0300
Message-Id: qemu-stable-8.0.1-20230523131351@cover.tls.msk.ru
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, INVALID_MSGID=0.568,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following patches are queued for QEMU stable v8.0.1:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-8.0

Patch freeze is 2023-05-27, and the release is planned for 2023-05-29:

  https://wiki.qemu.org/Planning/8.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* 3f9c41c5df96 Paolo Bonzini:
   vnc: avoid underflow when accessing user-provided address
02* 72497cff896f Yang Zhong:
   target/i386: Change wrong XFRM value in SGX CPUID leaf
03* 542fd43d7932 Axel Heider:
   hw/timer/imx_epit: don't shadow variable
04* 25d758175dfb Axel Heider:
   hw/timer/imx_epit: fix limit check
05* 0f689cf5ada4 Igor Mammedov:
   acpi: pcihp: allow repeating hot-unplug requests
06* 8c1e8fb2e7fc Wang Liang:
   block/monitor: Fix crash when executing HMP commit
07* c1654c3e37c3 Alex Bennée:
   qemu-options: finesse the recommendations around -blockdev
08* ac64ebbecf80 Peter Maydell:
   docs/about/deprecated.rst: Add "since 7.1" tag to dtb-kaslr-seed 
   deprecation
09* ad5c6ddea327 Akihiko Odaki:
   target/arm: Initialize debug capabilities only once
10* d565f58b3842 Peter Maydell:
   hw/net/msf2-emac: Don't modify descriptor in-place in emac_store_desc()
11* 0fe43f0abf19 Cédric Le Goater:
   hw/arm/boot: Make write_bootloader() public as arm_write_bootloader()
12* 902bba549fc3 Cédric Le Goater:
   hw/arm/aspeed: Use arm_write_bootloader() to write the bootloader
13* 0acbdb4c4ab6 Peter Maydell:
   hw/arm/raspi: Use arm_write_bootloader() to write boot code
14* 2c5fa0778c3b Peter Maydell:
   hw/intc/allwinner-a10-pic: Don't use set_bit()/clear_bit()
15* 7f3a3d3dc433 Peter Maydell:
   target/arm: Define and use new load_cpu_field_low32()
16* 3e20d90824c2 Peter Maydell:
   hw/sd/allwinner-sdhost: Correctly byteswap descriptor fields
17* a4ae17e5ec51 Peter Maydell:
   hw/net/allwinner-sun8i-emac: Correctly byteswap descriptor fields
18* de79b52604e4 Stefan Hajnoczi:
   block/export: call blk_set_dev_ops(blk, NULL, NULL)
19* 1098cc3fcf95 Shivaprasad G Bhat:
   softfloat: Fix the incorrect computation in float32_exp2
20* ef709860ea12 Paolo Bonzini:
   meson: leave unnecessary modules out of the build
21* e2626874a326 Kevin Wolf:
   block: Fix use after free in blockdev_mark_auto_del()
22* da4afaff074e Kevin Wolf:
   block: Consistently call bdrv_activate() outside coroutine
23* b2ab5f545fa1 Kevin Wolf:
   block: bdrv/blk_co_unref() for calls in coroutine context
24* 0c7d204f50c3 Kevin Wolf:
   block: Don't call no_coroutine_fns in qmp_block_resize()
25* df3ac6da476e LIU Zhiwei:
   target/riscv: Fix itrigger when icount is used
26* eae04c4c131a Bin Meng:
   target/riscv: Restore the predicate() NULL check behavior
27* 9136f661c727 Jonathan Cameron:
   hw/pci-bridge: pci_expander_bridge fix type in pxb_cxl_dev_reset()
28* 8c313254e61e Richard Henderson:
   accel/tcg: Fix atomic_mmu_lookup for reads
29* fcc0b0418fff Peter Maydell:
   target/arm: Fix handling of SW and NSW bits for stage 2 walks
30* cd22a0f520f4 Peter Maydell:
   ui: Fix pixel colour channel order for PNG screenshots
31* 478dccbb99db Peter Maydell:
   target/arm: Correct AArch64.S2MinTxSZ 32-bit EL1 input size check
32* d66ba6dc1cce Cédric Le Goater:
   async: Suppress GCC13 false positive in aio_bh_poll()
33* 6a5d81b17201 Shivaprasad G Bhat:
   tcg: ppc64: Fix mask generation for vextractdm
34* e8ecdfeb30f0 Ilya Leoshkevich:
   target/s390x: Fix EXECUTE of relative branches
35 970641de0190 Ilya Leoshkevich:
   s390x/tcg: Fix LDER instruction format
36* 92e667f6fd58 Jason Andryuk:
   9pfs/xen: Fix segfault on shutdown
37* 988998503bc6 Richard Henderson:
   tcg/i386: Set P_REXW in tcg_out_addi_ptr
38 88693ab2a53f Claudio Imbrenda:
   s390x/pv: Fix spurious warning with asynchronous teardown
39 80bd81cadd12 Claudio Imbrenda:
   util/async-teardown: wire up query-command-line-options
40 c70bb9a771d4 Lizhi Yang:
   docs/about/emulation: fix typo
41 3217b84f3cd8 Alex Bennée:
   tests/docker: bump the xtensa base to debian:11-slim
42 a0f8d2701b20 Daniil Kovalev:
   linux-user: Fix mips fp64 executables loading
43 1e35d327890b Michael Tokarev:
   linux-user: fix getgroups/setgroups allocations
44 403d18ae3842 Eric Blake:
   migration: Handle block device inactivation failures better
45 5d39f44d7ac5 Eric Blake:
   migration: Minor control flow simplification
46 6dab4c93ecfa Eric Blake:
   migration: Attempt disk reactivation in more failure scenarios
47 a6771f2f5cbf Richard Henderson:
   target/arm: Fix vd == vm overlap in sve_ldff1_z
48 9bd634b2f5e2 Paolo Bonzini:
   scsi-generic: fix buffer overflow on block limits inquiry
49 2b55e479e6fc Paolo Bonzini:
   target/i386: fix operand size for VCOMI/VUCOMI instructions
50 056d649007bc Xinyu Li:
   target/i386: fix avx2 instructions vzeroall and vpermdq
51 5d410557dea4 Hawkins Jiawei:
   vhost: fix possible wrap in SVQ descriptor ring
52 5ed3dabe57dd Leonardo Bras:
   hw/pci: Disable PCI_ERR_UNCOR_MASK register for machine type < 8.0
53 1fac00f70b32 Eugenio Pérez:
   virtio-net: not enable vq reset feature unconditionally
54 3e69908907f8 Mauro Matteo Cascella:
   virtio-crypto: fix NULL pointer dereference in virtio_crypto_free_request
55 6d740fb01b9f Stefan Hajnoczi:
   aio-posix: do not nest poll handlers
56 844a12a63e12 Stefan Hajnoczi:
   tested: add test for nested aio_poll() in poll handlers
57 58a2e3f5c37b Stefan Hajnoczi:
   block: compile out assert_bdrv_graph_readable() by default
58 80fc5d260002 Kevin Wolf:
   graph-lock: Disable locking for now
59 7c1f51bf38de Kevin Wolf:
   nbd/server: Fix drained_poll to wake coroutine in right AioContext

(commit(s) marked with * were in previous series and are not resent)

