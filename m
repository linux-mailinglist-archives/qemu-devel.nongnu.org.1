Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2407A7E50
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 14:17:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiw7l-00026r-K8; Wed, 20 Sep 2023 08:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qiw7i-00023K-DU; Wed, 20 Sep 2023 08:16:06 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qiw7b-0005Ei-4i; Wed, 20 Sep 2023 08:16:06 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5E3FB239F9;
 Wed, 20 Sep 2023 15:16:13 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C0EB5296F0;
 Wed, 20 Sep 2023 15:15:53 +0300 (MSK)
Received: (nullmailer pid 105869 invoked by uid 1000);
 Wed, 20 Sep 2023 12:15:53 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.6 00/63] v3 Patch Round-up for stable 7.2.6,
 freeze on 2023-09-19
Date: Wed, 20 Sep 2023 15:15:36 +0300
Message-Id: <qemu-stable-7.2.6-20230920151401@cover.tls.msk.ru>
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

Patch freeze is 2023-09-19 (frozen), and the release is planned for 2023-09-21:

  https://wiki.qemu.org/Planning/7.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

v3:

-  pick up more fixes from master

v2:

- I decided to pick up dma/mmio reentrancy fixes from 8.1 now once
  (hopefully) all issues has been addressed.  This is

  commit a2e1753b8054344f32cf94f31c6399a58794a380
  Author: Alexander Bulekov <alxndr@bu.edu>
  Date:   Thu Apr 27 17:10:06 2023 -0400

    memory: prevent dma-reentracy issues

  with all subsequent changes, up to
  76f9ebffcd41 pnv_lpc: disable reentrancy detection for lpc-hc

  I haven't picked this series sooner (while had it backported
  and tested for quite some time) because with time, some more
  places were found where reentrancy detection has to be disabled
  too (like this pnv_lpc change).

  What prompted me to look at this series again: one of the ide/ahci
  change had to be context-edited to apply to 7.2, and the context
  was the one from this reentrancy patch series.  So instead of
  editing context, I decided to pick the reentrancy series and
  apply subsequent changed cleanly.

- I've added 2 patches (one cherry-pick and one specific to stable-7.2)
  just to fix gitlab-CI failed jobs, so CI status will not be "failed"

Thanks!

/mjt

--------------------------------------
01* b8d1fc55b5 Michael Tokarev:
   gitlab-ci: check-dco.py: switch from master to stable-7.2 branch
02* 6832189fd791 John Snow:
   python: drop pipenv
03* a2e1753b8054 Alexander Bulekov:
   memory: prevent dma-reentracy issues
04* 9c86c97f12c0 Alexander Bulekov:
   async: Add an optional reentrancy guard to the BH API
05* 7915bd06f25e Alexander Bulekov:
   async: avoid use-after-free on re-entrancy guard
06* ef56ffbdd6b0 Alexander Bulekov:
   checkpatch: add qemu_bh_new/aio_bh_new checks
07* f63192b0544a Alexander Bulekov:
   hw: replace most qemu_bh_new calls with qemu_bh_new_guarded
08* bfd6e7ae6a72 Alexander Bulekov:
   lsi53c895a: disable reentrancy detection for script RAM
09* d139fe9ad8a2 Thomas Huth:
   lsi53c895a: disable reentrancy detection for MMIO region, too
10* 985c4a4e547a Alexander Bulekov:
   bcm2835_property: disable reentrancy detection for iomem
11* 6dad5a6810d9 Alexander Bulekov:
   raven: disable reentrancy detection for iomem
12* 50795ee051a3 Alexander Bulekov:
   apic: disable reentrancy detection for apic-msi
13* 6d0589e0e6c6 Alexander Bulekov:
   loongarch: mark loongarch_ipi_iocsr re-entrnacy safe
14* 76f9ebffcd41 Alexander Bulekov:
   pnv_lpc: disable reentrancy detection for lpc-hc
15* a1d027be95bc Zhao Liu:
   machine: Add helpers to get cores/threads per socket
16* d79a284a44bb Zhao Liu:
   hw/smbios: Fix smbios_smp_sockets caculation
17* 7298fd7de555 Zhao Liu:
   hw/smbios: Fix thread count in type4
18* 196ea60a734c Zhao Liu:
   hw/smbios: Fix core count in type4
19* 8a64609eea8c Dongli Zhang:
   dump: kdump-zlib data pages not dumped with pvtime/aarch64
20* dbdb13f931d7 Ankit Kumar:
   hw/nvme: fix CRC64 for guard tag
21* 4333f0924c2f Nathan Egge:
   linux-user/elfload: Set V in ELF_HWCAP for RISC-V
22* e73f27003e77 Richard Henderson:
   include/exec/user: Set ABI_LLONG_ALIGNMENT to 4 for microblaze
23* ea9812d93f9c Richard Henderson:
   include/exec/user: Set ABI_LLONG_ALIGNMENT to 4 for nios2
24* 6ee960823da8 Luca Bonissi:
   Fixed incorrect LLONG alignment for openrisc and cris
25* 791b2b6a9302 Ilya Leoshkevich:
   target/s390x: Fix the "ignored match" case in VSTRS
26* 23e87d419f34 Ilya Leoshkevich:
   target/s390x: Use a 16-bit immediate in VREP
27* 6db3518ba4fc Ilya Leoshkevich:
   target/s390x: Fix VSTL with a large length
28* 6a2ea6151835 Ilya Leoshkevich:
   target/s390x: Check reserved bits of VFMIN/VFMAX's M5
29* d19436291013 Thomas Huth:
   include/hw/virtio/virtio-gpu: Fix virtio-gpu with blob on big endian hosts
30* 5e0d65909c6f Akihiko Odaki:
   kvm: Introduce kvm_arch_get_default_type hook
31* 1ab445af8cd9 Akihiko Odaki:
   accel/kvm: Specify default IPA size for arm64
32* 4b3520fd93cd Richard Henderson:
   target/arm: Fix SME ST1Q
33* cd1e4db73646 Richard Henderson:
   target/arm: Fix 64-bit SSRA
34* 09a3fffae00b Philippe Mathieu-Daudé:
   docs/about/license: Update LICENSE URL
35* f187609f27b2 Fabiano Rosas:
   block-migration: Ensure we don't crash during migration cleanup
36* 6ec65b69ba17 Maksim Kostin:
   hw/ppc/e500: fix broken snapshot replay
37* 7b8589d7ce7e Nicholas Piggin:
   ppc/vof: Fix missed fields in VOF cleanup
38* af03aeb631ee Richard Henderson:
   target/ppc: Flush inputs to zero with NJ in ppc_store_vscr
39* c3461c6264a7 Niklas Cassel:
   hw/ide/core: set ERR_STAT in unsupported command completion
40* 2967dc8209dd Niklas Cassel:
   hw/ide/ahci: write D2H FIS when processing NCQ command
41* e2a5d9b3d9c3 Niklas Cassel:
   hw/ide/ahci: simplify and document PxCI handling
42* d73b84d0b664 Niklas Cassel:
   hw/ide/ahci: PxSACT and PxCI is cleared when PxCMD.ST is cleared
43* 1a16ce64fda1 Niklas Cassel:
   hw/ide/ahci: PxCI should not get cleared when ERR_STAT is set
44* 7e85cb0db4c6 Niklas Cassel:
   hw/ide/ahci: fix ahci_write_fis_sdb()
45* 9f8942353765 Niklas Cassel:
   hw/ide/ahci: fix broken SError handling
46* 97b8aa5ae9ff Hang Yu:
   hw/i2c/aspeed: Fix Tx count and Rx size error in buffer pool mode
47* 961faf3ddbd8 Hang Yu:
   hw/i2c/aspeed: Fix TXBUF transmission start position error
48* bcd8e243083c Thomas Huth:
   qemu-options.hx: Rephrase the descriptions of the -hd* and -cdrom options
49* b21a6e31a182 Markus Armbruster:
   docs tests: Fix use of migrate_set_parameter
50* 90a0778421ac Thomas Huth:
   hw/net/vmxnet3: Fix guest-triggerable assert()
51* 95bef686e490 Marc-André Lureau:
   qxl: don't assert() if device isn't yet initialized
52 92e2e6a86733 Kevin Wolf:
   virtio: Drop out of coroutine context in virtio_load()
53 682814e2a3c8 Colton Lewis:
   arm64: Restore trapless ptimer access
54 c255946e3df4 Thomas Huth:
   hw/char/riscv_htif: Fix printing of console characters on big endian hosts
55 e0922b73baf0 Jason Chien:
   hw/intc: Fix upper/lower mtime write calculation
56 9382a9eafcca Jason Chien:
   hw/intc: Make rtc variable names consistent
57 ae7d4d625cab LIU Zhiwei:
   linux-user/riscv: Use abi type for target_ucontext
58 9ff314063125 Conor Dooley:
   hw/riscv: virt: Fix riscv,pmu DT node path
59 4e3adce1244e Leon Schuermann:
   target/riscv/pmp.c: respect mseccfg.RLB for pmpaddrX changes
60 4c46fe2ed492 Stefan Berger:
   hw/tpm: TIS on sysbus: Remove unsupport ppi command line option
61 48a35e12faf9 Marc-André Lureau:
   ui: fix crash when there are no active_console
62 297ec01f0b98 Janosch Frank:
   s390x/ap: fix missing subsystem reset registration
63 8e32ddff69b6 Marc-André Lureau:
   tpm: fix crash when FD >= 1024 and unnecessary errors due to EINTR

(commit(s) marked with * were in previous series and are not resent)

