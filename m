Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A54D7A7EAA
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 14:19:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiwAO-0000eh-K9; Wed, 20 Sep 2023 08:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qiwAI-0000CS-M1; Wed, 20 Sep 2023 08:18:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qiwAG-0005pv-3S; Wed, 20 Sep 2023 08:18:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 88DC023A1C;
 Wed, 20 Sep 2023 15:19:01 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E68D429703;
 Wed, 20 Sep 2023 15:18:41 +0300 (MSK)
Received: (nullmailer pid 106022 invoked by uid 1000);
 Wed, 20 Sep 2023 12:18:41 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.5 00/70] v3 Patch Round-up for stable 8.0.5,
 freeze on 2023-09-19
Date: Wed, 20 Sep 2023 15:18:35 +0300
Message-Id: <qemu-stable-8.0.5-20230920151433@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v8.0.5:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-8.0

Patch freeze is 2023-09-19 (frozen), and the release is planned for 2023-09-21:

  https://wiki.qemu.org/Planning/8.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

v3:
- picked up more changes from master
- picked up 24be3369ad63c388 "include/exec: Provide the tswap() functions.."
  before 058096f1c5 "riscv_htif: Fix the console syscall"

v2:

The v2 version includes reentrancy fixes the same way as staging-7.2, -
thought I'd not make the two different from each other in this context.
It also includes a few more changes accumulated to date.

Thanks!

/mjt

--------------------------------------
01* a2e1753b8054 Alexander Bulekov:
   memory: prevent dma-reentracy issues
02* 9c86c97f12c0 Alexander Bulekov:
   async: Add an optional reentrancy guard to the BH API
03* 7915bd06f25e Alexander Bulekov:
   async: avoid use-after-free on re-entrancy guard
04* ef56ffbdd6b0 Alexander Bulekov:
   checkpatch: add qemu_bh_new/aio_bh_new checks
05* f63192b0544a Alexander Bulekov:
   hw: replace most qemu_bh_new calls with qemu_bh_new_guarded
06* bfd6e7ae6a72 Alexander Bulekov:
   lsi53c895a: disable reentrancy detection for script RAM
07* d139fe9ad8a2 Thomas Huth:
   lsi53c895a: disable reentrancy detection for MMIO region, too
08* 985c4a4e547a Alexander Bulekov:
   bcm2835_property: disable reentrancy detection for iomem
09* 6dad5a6810d9 Alexander Bulekov:
   raven: disable reentrancy detection for iomem
10* 50795ee051a3 Alexander Bulekov:
   apic: disable reentrancy detection for apic-msi
11* 6d0589e0e6c6 Alexander Bulekov:
   loongarch: mark loongarch_ipi_iocsr re-entrnacy safe
12* 76f9ebffcd41 Alexander Bulekov:
   pnv_lpc: disable reentrancy detection for lpc-hc
13* a1d027be95bc Zhao Liu:
   machine: Add helpers to get cores/threads per socket
14* d79a284a44bb Zhao Liu:
   hw/smbios: Fix smbios_smp_sockets caculation
15* 7298fd7de555 Zhao Liu:
   hw/smbios: Fix thread count in type4
16* 196ea60a734c Zhao Liu:
   hw/smbios: Fix core count in type4
17* 8ada214a9022 BALATON Zoltan:
   hw/i2c: Fix bitbang_i2c_data trace event
18* 8a64609eea8c Dongli Zhang:
   dump: kdump-zlib data pages not dumped with pvtime/aarch64
19* ecb1b7b082d3 Klaus Jensen:
   hw/nvme: fix oob memory read in fdp events log
20* 6a33f2e920ec Klaus Jensen:
   hw/nvme: fix compliance issue wrt. iosqes/iocqes
21* dbdb13f931d7 Ankit Kumar:
   hw/nvme: fix CRC64 for guard tag
22* 6c8f8456cb0b Klaus Jensen:
   hw/nvme: fix null pointer access in directive receive
23* 3439ba9c5da9 Klaus Jensen:
   hw/nvme: fix null pointer access in ruh update
24* 4333f0924c2f Nathan Egge:
   linux-user/elfload: Set V in ELF_HWCAP for RISC-V
25* e73f27003e77 Richard Henderson:
   include/exec/user: Set ABI_LLONG_ALIGNMENT to 4 for microblaze
26* ea9812d93f9c Richard Henderson:
   include/exec/user: Set ABI_LLONG_ALIGNMENT to 4 for nios2
27* 6ee960823da8 Luca Bonissi:
   Fixed incorrect LLONG alignment for openrisc and cris
28* 3b830790151f Bernhard Beschow:
   hw/sd/sdhci: Do not force sdhci_mmio_*_ops onto all SD controllers
29* 791b2b6a9302 Ilya Leoshkevich:
   target/s390x: Fix the "ignored match" case in VSTRS
30* 23e87d419f34 Ilya Leoshkevich:
   target/s390x: Use a 16-bit immediate in VREP
31* 6db3518ba4fc Ilya Leoshkevich:
   target/s390x: Fix VSTL with a large length
32* 6a2ea6151835 Ilya Leoshkevich:
   target/s390x: Check reserved bits of VFMIN/VFMAX's M5
33* d19436291013 Thomas Huth:
   include/hw/virtio/virtio-gpu: Fix virtio-gpu with blob on big endian hosts
34* 5e0d65909c6f Akihiko Odaki:
   kvm: Introduce kvm_arch_get_default_type hook
35* 1ab445af8cd9 Akihiko Odaki:
   accel/kvm: Specify default IPA size for arm64
36* 4b3520fd93cd Richard Henderson:
   target/arm: Fix SME ST1Q
37* cd1e4db73646 Richard Henderson:
   target/arm: Fix 64-bit SSRA
38* 09a3fffae00b Philippe Mathieu-Daudé:
   docs/about/license: Update LICENSE URL
39* f187609f27b2 Fabiano Rosas:
   block-migration: Ensure we don't crash during migration cleanup
40* 6ec65b69ba17 Maksim Kostin:
   hw/ppc/e500: fix broken snapshot replay
41* 7b8589d7ce7e Nicholas Piggin:
   ppc/vof: Fix missed fields in VOF cleanup
42* af03aeb631ee Richard Henderson:
   target/ppc: Flush inputs to zero with NJ in ppc_store_vscr
43* c3461c6264a7 Niklas Cassel:
   hw/ide/core: set ERR_STAT in unsupported command completion
44* 2967dc8209dd Niklas Cassel:
   hw/ide/ahci: write D2H FIS when processing NCQ command
45* e2a5d9b3d9c3 Niklas Cassel:
   hw/ide/ahci: simplify and document PxCI handling
46* d73b84d0b664 Niklas Cassel:
   hw/ide/ahci: PxSACT and PxCI is cleared when PxCMD.ST is cleared
47* 1a16ce64fda1 Niklas Cassel:
   hw/ide/ahci: PxCI should not get cleared when ERR_STAT is set
48* 7e85cb0db4c6 Niklas Cassel:
   hw/ide/ahci: fix ahci_write_fis_sdb()
49* 9f8942353765 Niklas Cassel:
   hw/ide/ahci: fix broken SError handling
50* 97b8aa5ae9ff Hang Yu:
   hw/i2c/aspeed: Fix Tx count and Rx size error in buffer pool mode
51* 961faf3ddbd8 Hang Yu:
   hw/i2c/aspeed: Fix TXBUF transmission start position error
52* bcd8e243083c Thomas Huth:
   qemu-options.hx: Rephrase the descriptions of the -hd* and -cdrom options
53* b21a6e31a182 Markus Armbruster:
   docs tests: Fix use of migrate_set_parameter
54* 90a0778421ac Thomas Huth:
   hw/net/vmxnet3: Fix guest-triggerable assert()
55* 95bef686e490 Marc-André Lureau:
   qxl: don't assert() if device isn't yet initialized
56* 92e2e6a86733 Kevin Wolf:
   virtio: Drop out of coroutine context in virtio_load()
57* 682814e2a3c8 Colton Lewis:
   arm64: Restore trapless ptimer access
58* c255946e3df4 Thomas Huth:
   hw/char/riscv_htif: Fix printing of console characters on big endian hosts
59 24be3369ad63 Thomas Huth:
   include/exec: Provide the tswap() functions for target independent code, 
   too
60* 058096f1c55a Thomas Huth:
   hw/char/riscv_htif: Fix the console syscall on big endian hosts
61* e0922b73baf0 Jason Chien:
   hw/intc: Fix upper/lower mtime write calculation
62* 9382a9eafcca Jason Chien:
   hw/intc: Make rtc variable names consistent
63* ae7d4d625cab LIU Zhiwei:
   linux-user/riscv: Use abi type for target_ucontext
64* 9ff314063125 Conor Dooley:
   hw/riscv: virt: Fix riscv,pmu DT node path
65* 3a2fc2356388 Daniel Henrique Barboza:
   target/riscv: fix satp_mode_finalize() when satp_mode.supported = 0
66* 4e3adce1244e Leon Schuermann:
   target/riscv/pmp.c: respect mseccfg.RLB for pmpaddrX changes
67* 4c46fe2ed492 Stefan Berger:
   hw/tpm: TIS on sysbus: Remove unsupport ppi command line option
68 48a35e12faf9 Marc-André Lureau:
   ui: fix crash when there are no active_console
69 297ec01f0b98 Janosch Frank:
   s390x/ap: fix missing subsystem reset registration
70 8e32ddff69b6 Marc-André Lureau:
   tpm: fix crash when FD >= 1024 and unnecessary errors due to EINTR

(commit(s) marked with * were in previous series and are not resent)

