Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CD9713841
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 09:03:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3ANX-00041W-Rf; Sun, 28 May 2023 02:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3ANU-0003vT-MH; Sun, 28 May 2023 02:59:44 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3ANS-0001pC-25; Sun, 28 May 2023 02:59:44 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9C50B8E1C;
 Sun, 28 May 2023 09:59:40 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 305987E26;
 Sun, 28 May 2023 09:59:40 +0300 (MSK)
Received: (nullmailer pid 42611 invoked by uid 1000);
 Sun, 28 May 2023 06:59:40 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.3 v3 00/42] Patch Round-up for stable 7.2.3,
 frozen on 2023-05-27
Date: Sun, 28 May 2023 09:59:18 +0300
Message-Id: qemu-stable-7.2.3-20230528095720@cover.tls.msk.ru
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

The following patches are queued for QEMU stable v7.2.3:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2

Patch freeze is 2023-05-27, and the release is planned for 2023-05-29:

  https://wiki.qemu.org/Planning/7.2

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
03* 0f689cf5ada4 Igor Mammedov:
   acpi: pcihp: allow repeating hot-unplug requests
04* c1654c3e37c3 Alex Bennée:
   qemu-options: finesse the recommendations around -blockdev
05* ac64ebbecf80 Peter Maydell:
   docs/about/deprecated.rst: Add "since 7.1" tag to dtb-kaslr-seed 
   deprecation
06* ad5c6ddea327 Akihiko Odaki:
   target/arm: Initialize debug capabilities only once
07* d565f58b3842 Peter Maydell:
   hw/net/msf2-emac: Don't modify descriptor in-place in emac_store_desc()
08* 0fe43f0abf19 Cédric Le Goater:
   hw/arm/boot: Make write_bootloader() public as arm_write_bootloader()
09* 902bba549fc3 Cédric Le Goater:
   hw/arm/aspeed: Use arm_write_bootloader() to write the bootloader
10* 0acbdb4c4ab6 Peter Maydell:
   hw/arm/raspi: Use arm_write_bootloader() to write boot code
11* 2c5fa0778c3b Peter Maydell:
   hw/intc/allwinner-a10-pic: Don't use set_bit()/clear_bit()
12* 7f3a3d3dc433 Peter Maydell:
   target/arm: Define and use new load_cpu_field_low32()
13* 3e20d90824c2 Peter Maydell:
   hw/sd/allwinner-sdhost: Correctly byteswap descriptor fields
14* a4ae17e5ec51 Peter Maydell:
   hw/net/allwinner-sun8i-emac: Correctly byteswap descriptor fields
15* 1098cc3fcf95 Shivaprasad G Bhat:
   softfloat: Fix the incorrect computation in float32_exp2
16* ef709860ea12 Paolo Bonzini:
   meson: leave unnecessary modules out of the build
17* e2626874a326 Kevin Wolf:
   block: Fix use after free in blockdev_mark_auto_del()
18* df3ac6da476e LIU Zhiwei:
   target/riscv: Fix itrigger when icount is used
19* 8c313254e61e Richard Henderson:
   accel/tcg: Fix atomic_mmu_lookup for reads
20* cd22a0f520f4 Peter Maydell:
   ui: Fix pixel colour channel order for PNG screenshots
21* d66ba6dc1cce Cédric Le Goater:
   async: Suppress GCC13 false positive in aio_bh_poll()
22* 6a5d81b17201 Shivaprasad G Bhat:
   tcg: ppc64: Fix mask generation for vextractdm
23* 90e31232cf8f Albert Esteve:
   hw/virtio/vhost-user: avoid using unitialized errp
24* bbc1c327d797 Carlos López:
   virtio: fix reachable assertion due to stale value of cached region size
25* 8c1e8fb2e7fc Wang Liang:
   block/monitor: Fix crash when executing HMP commit
26* e8ecdfeb30f0 Ilya Leoshkevich:
   target/s390x: Fix EXECUTE of relative branches
27* 970641de0190 Ilya Leoshkevich:
   s390x/tcg: Fix LDER instruction format
28* 92e667f6fd58 Jason Andryuk:
   9pfs/xen: Fix segfault on shutdown
29* 4f67543bb8c5 Chuck Zmudzinski:
   xen/pt: reserve PCI slot 2 for Intel igd-passthru
30* f340a59d5a85 Greg Kurz:
   Revert "vhost-user: Monitor slave channel in vhost_user_read()"
31* 4382138f642f Greg Kurz:
   Revert "vhost-user: Introduce nested event loop in vhost_user_read()"
32* 07e4804fcde1 Cédric Le Goater:
   target/ppc: Fix helper_pminsn() prototype
33* 3217b84f3cd8 Alex Bennée:
   tests/docker: bump the xtensa base to debian:11-slim
34* a0f8d2701b20 Daniil Kovalev:
   linux-user: Fix mips fp64 executables loading
35* 1e35d327890b Michael Tokarev:
   linux-user: fix getgroups/setgroups allocations
36* 403d18ae3842 Eric Blake:
   migration: Handle block device inactivation failures better
37* 5d39f44d7ac5 Eric Blake:
   migration: Minor control flow simplification
38* 6dab4c93ecfa Eric Blake:
   migration: Attempt disk reactivation in more failure scenarios
39* a6771f2f5cbf Richard Henderson:
   target/arm: Fix vd == vm overlap in sve_ldff1_z
40* 9bd634b2f5e2 Paolo Bonzini:
   scsi-generic: fix buffer overflow on block limits inquiry
41* 2b55e479e6fc Paolo Bonzini:
   target/i386: fix operand size for VCOMI/VUCOMI instructions
42* 056d649007bc Xinyu Li:
   target/i386: fix avx2 instructions vzeroall and vpermdq
43* 5d410557dea4 Hawkins Jiawei:
   vhost: fix possible wrap in SVQ descriptor ring
44* 1fac00f70b32 Eugenio Pérez:
   virtio-net: not enable vq reset feature unconditionally
45* 3e69908907f8 Mauro Matteo Cascella:
   virtio-crypto: fix NULL pointer dereference in virtio_crypto_free_request
46 c50b152485d4 Akihiko Odaki:
   e1000: Count CRC in Tx statistics
47 8d689f6aae8b timothee.cocault@gmail.com:
   e1000e: Fix tx/rx counters
48 f3f9b726afba Akihiko Odaki:
   e1000x: Fix BPRC and MPRC
49 792676c16515 Stefan Hajnoczi:
   rtl8139: fix large_send_mss divide-by-zero
50 dbdea0dbfe2c Akihiko Odaki:
   util/vfio-helpers: Use g_file_read_link()
51 6301460ce9f5 Paolo Bonzini:
   usb/ohci: Set pad to 0 after frame update
52 b987718bbb1d Thomas Huth:
   hw/scsi/lsi53c895a: Fix reentrancy issues in the LSI controller 
   (CVE-2023-0330)
53 a37531f2381c Igor Mammedov:
   machine: do not crash if default RAM backend name has been stolen

(commit(s) marked with * were in previous series and are not resent)

