Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B062799869
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:12:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexeL-0006VG-6Q; Sat, 09 Sep 2023 09:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexeI-0006Uw-NA; Sat, 09 Sep 2023 09:05:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexeD-0003Of-S2; Sat, 09 Sep 2023 09:05:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2AF11205CD;
 Sat,  9 Sep 2023 16:06:03 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 028AD26E20;
 Sat,  9 Sep 2023 16:05:11 +0300 (MSK)
Received: (nullmailer pid 354258 invoked by uid 1000);
 Sat, 09 Sep 2023 13:05:11 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.6 00/37] Patch Round-up for stable 7.2.6,
 freeze on 2023-09-19
Date: Sat,  9 Sep 2023 16:04:30 +0300
Message-Id: <qemu-stable-7.2.6-20230909160328@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v7.2.6:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2

Patch freeze is 2023-09-19, and the release is planned for 2023-09-21:

  https://wiki.qemu.org/Planning/7.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 a1d027be95bc Zhao Liu:
   machine: Add helpers to get cores/threads per socket
02 d79a284a44bb Zhao Liu:
   hw/smbios: Fix smbios_smp_sockets caculation
03 7298fd7de555 Zhao Liu:
   hw/smbios: Fix thread count in type4
04 196ea60a734c Zhao Liu:
   hw/smbios: Fix core count in type4
05 8a64609eea8c Dongli Zhang:
   dump: kdump-zlib data pages not dumped with pvtime/aarch64
06 dbdb13f931d7 Ankit Kumar:
   hw/nvme: fix CRC64 for guard tag
07 4333f0924c2f Nathan Egge:
   linux-user/elfload: Set V in ELF_HWCAP for RISC-V
08 e73f27003e77 Richard Henderson:
   include/exec/user: Set ABI_LLONG_ALIGNMENT to 4 for microblaze
09 ea9812d93f9c Richard Henderson:
   include/exec/user: Set ABI_LLONG_ALIGNMENT to 4 for nios2
10 6ee960823da8 Luca Bonissi:
   Fixed incorrect LLONG alignment for openrisc and cris
11 791b2b6a9302 Ilya Leoshkevich:
   target/s390x: Fix the "ignored match" case in VSTRS
12 23e87d419f34 Ilya Leoshkevich:
   target/s390x: Use a 16-bit immediate in VREP
13 6db3518ba4fc Ilya Leoshkevich:
   target/s390x: Fix VSTL with a large length
14 6a2ea6151835 Ilya Leoshkevich:
   target/s390x: Check reserved bits of VFMIN/VFMAX's M5
15 d19436291013 Thomas Huth:
   include/hw/virtio/virtio-gpu: Fix virtio-gpu with blob on big endian hosts
16 5e0d65909c6f Akihiko Odaki:
   kvm: Introduce kvm_arch_get_default_type hook
17 1ab445af8cd9 Akihiko Odaki:
   accel/kvm: Specify default IPA size for arm64
18 4b3520fd93cd Richard Henderson:
   target/arm: Fix SME ST1Q
19 cd1e4db73646 Richard Henderson:
   target/arm: Fix 64-bit SSRA
20 09a3fffae00b Philippe Mathieu-Daudé:
   docs/about/license: Update LICENSE URL
21 f187609f27b2 Fabiano Rosas:
   block-migration: Ensure we don't crash during migration cleanup
22 6ec65b69ba17 Maksim Kostin:
   hw/ppc/e500: fix broken snapshot replay
23 7b8589d7ce7e Nicholas Piggin:
   ppc/vof: Fix missed fields in VOF cleanup
24 af03aeb631ee Richard Henderson:
   target/ppc: Flush inputs to zero with NJ in ppc_store_vscr
25 c3461c6264a7 Niklas Cassel:
   hw/ide/core: set ERR_STAT in unsupported command completion
26 2967dc8209dd Niklas Cassel:
   hw/ide/ahci: write D2H FIS when processing NCQ command
27 e2a5d9b3d9c3 Niklas Cassel:
   hw/ide/ahci: simplify and document PxCI handling
28 d73b84d0b664 Niklas Cassel:
   hw/ide/ahci: PxSACT and PxCI is cleared when PxCMD.ST is cleared
29 1a16ce64fda1 Niklas Cassel:
   hw/ide/ahci: PxCI should not get cleared when ERR_STAT is set
30 7e85cb0db4c6 Niklas Cassel:
   hw/ide/ahci: fix ahci_write_fis_sdb()
31 9f8942353765 Niklas Cassel:
   hw/ide/ahci: fix broken SError handling
32 97b8aa5ae9ff Hang Yu:
   hw/i2c/aspeed: Fix Tx count and Rx size error in buffer pool mode
33 961faf3ddbd8 Hang Yu:
   hw/i2c/aspeed: Fix TXBUF transmission start position error
34 bcd8e243083c Thomas Huth:
   qemu-options.hx: Rephrase the descriptions of the -hd* and -cdrom options
35 b21a6e31a182 Markus Armbruster:
   docs tests: Fix use of migrate_set_parameter
36 90a0778421ac Thomas Huth:
   hw/net/vmxnet3: Fix guest-triggerable assert()
37 95bef686e490 Marc-André Lureau:
   qxl: don't assert() if device isn't yet initialized

