Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD957AB46F
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:07:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjhkZ-0003lM-NZ; Fri, 22 Sep 2023 11:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjhkO-0003ZJ-W2; Fri, 22 Sep 2023 11:07:13 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjhkM-0003pb-2U; Fri, 22 Sep 2023 11:07:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 940A82458A;
 Fri, 22 Sep 2023 18:07:22 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D5B0D2A1A9;
 Fri, 22 Sep 2023 18:06:58 +0300 (MSK)
Message-ID: <06fa93ff-ac3f-8786-4f02-ae2ecacdbb4d@tls.msk.ru>
Date: Fri, 22 Sep 2023 18:06:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: [ANNOUNCE] QEMU 8.0.5 Stable released
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: qemu-stable <qemu-stable@nongnu.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi everyone,

The QEMU v8.0.5 stable release is now available.

You can grab the tarball from our download page here:

   https://www.qemu.org/download/#source

v8.0.5 is now tagged in the official qemu.git repository, and the
stable-8.0 branch has been updated accordingly:

   https://gitlab.com/qemu-project/qemu/-/commits/stable-8.0?ref_type=heads

This update contains usual pile of general fixes for various architectures
and subsystems, and brings up a backport of re-entrancy fixes which landed
in 8.1, together with all follow-ups and refinements to date:
https://gitlab.com/qemu-project/qemu/-/issues/556

This should be last 8.0.x stable release, unless there's good compelling
reason or big interest to continue 8.0.x branch maintenance.

Thank you everyone who has been involved and helped with the stable series!

Changelog:

6bbce8b464: Update version for 8.0.5 release (Michael Tokarev)
fcf58d6f20 8e32ddff69: tpm: fix crash when FD >= 1024 and unnecessary errors due to EINTR (Marc-André Lureau)
0ef930a29f 297ec01f0b: s390x/ap: fix missing subsystem reset registration (Janosch Frank)
6c575436cd 48a35e12fa: ui: fix crash when there are no active_console (Marc-André Lureau)
36540b367e 4c46fe2ed4: hw/tpm: TIS on sysbus: Remove unsupport ppi command line option (Stefan Berger)
70c97e75d7 4e3adce124: target/riscv/pmp.c: respect mseccfg.RLB for pmpaddrX changes (Leon Schuermann)
1805e05db3 3a2fc23563: target/riscv: fix satp_mode_finalize() when satp_mode.supported = 0 (Daniel Henrique Barboza)
e94ea3c6db 9ff3140631: hw/riscv: virt: Fix riscv,pmu DT node path (Conor Dooley)
9bac2bcf10 ae7d4d625c: linux-user/riscv: Use abi type for target_ucontext (LIU Zhiwei)
c00a9ec061 9382a9eafc: hw/intc: Make rtc variable names consistent (Jason Chien)
fd1a0c89c6 e0922b73ba: hw/intc: Fix upper/lower mtime write calculation (Jason Chien)
a57e4cc6fe 058096f1c5: hw/char/riscv_htif: Fix the console syscall on big endian hosts (Thomas Huth)
aeb931d82b 24be3369ad: include/exec: Provide the tswap() functions for target independent code, too (Thomas Huth)
3af03de983 c255946e3d: hw/char/riscv_htif: Fix printing of console characters on big endian hosts (Thomas Huth)
53a4e7ef42 682814e2a3: arm64: Restore trapless ptimer access (Colton Lewis)
41af7a9bc4 92e2e6a867: virtio: Drop out of coroutine context in virtio_load() (Kevin Wolf)
5929f53091 95bef686e4: qxl: don't assert() if device isn't yet initialized (Marc-André Lureau)
c68b844d33 90a0778421: hw/net/vmxnet3: Fix guest-triggerable assert() (Thomas Huth)
42edb4723a b21a6e31a1: docs tests: Fix use of migrate_set_parameter (Markus Armbruster)
45b61f730d bcd8e24308: qemu-options.hx: Rephrase the descriptions of the -hd* and -cdrom options (Thomas Huth)
c2ec46c694 961faf3ddb: hw/i2c/aspeed: Fix TXBUF transmission start position error (Hang Yu)
4a398e64ba 97b8aa5ae9: hw/i2c/aspeed: Fix Tx count and Rx size error in buffer pool mode (Hang Yu)
4f6c553717 9f89423537: hw/ide/ahci: fix broken SError handling (Niklas Cassel)
9c7e2253eb 7e85cb0db4: hw/ide/ahci: fix ahci_write_fis_sdb() (Niklas Cassel)
f7cca09987 1a16ce64fd: hw/ide/ahci: PxCI should not get cleared when ERR_STAT is set (Niklas Cassel)
2eaf7775fc d73b84d0b6: hw/ide/ahci: PxSACT and PxCI is cleared when PxCMD.ST is cleared (Niklas Cassel)
7bcd32128b e2a5d9b3d9: hw/ide/ahci: simplify and document PxCI handling (Niklas Cassel)
362a4d8658 2967dc8209: hw/ide/ahci: write D2H FIS when processing NCQ command (Niklas Cassel)
67894ec9fd c3461c6264: hw/ide/core: set ERR_STAT in unsupported command completion (Niklas Cassel)
956b96f9e2 af03aeb631: target/ppc: Flush inputs to zero with NJ in ppc_store_vscr (Richard Henderson)
ea25506b5d 7b8589d7ce: ppc/vof: Fix missed fields in VOF cleanup (Nicholas Piggin)
fcb49ea23c 6ec65b69ba: hw/ppc/e500: fix broken snapshot replay (Maksim Kostin)
e8bb4dc55a f187609f27: block-migration: Ensure we don't crash during migration cleanup (Fabiano Rosas)
3c934310ff 09a3fffae0: docs/about/license: Update LICENSE URL (Philippe Mathieu-Daudé)
d4c0ac705d cd1e4db736: target/arm: Fix 64-bit SSRA (Richard Henderson)
09640031ed 4b3520fd93: target/arm: Fix SME ST1Q (Richard Henderson)
f5cb21416e 1ab445af8c: accel/kvm: Specify default IPA size for arm64 (Akihiko Odaki)
aa152711db 5e0d65909c: kvm: Introduce kvm_arch_get_default_type hook (Akihiko Odaki)
f2f8e74ff4 d194362910: include/hw/virtio/virtio-gpu: Fix virtio-gpu with blob on big endian hosts (Thomas Huth)
96fd3b8508 6a2ea61518: target/s390x: Check reserved bits of VFMIN/VFMAX's M5 (Ilya Leoshkevich)
62ac9cbb6f 6db3518ba4: target/s390x: Fix VSTL with a large length (Ilya Leoshkevich)
14f78932e0 23e87d419f: target/s390x: Use a 16-bit immediate in VREP (Ilya Leoshkevich)
179a37924d 791b2b6a93: target/s390x: Fix the "ignored match" case in VSTRS (Ilya Leoshkevich)
b4b3aac5b5 3b83079015: hw/sd/sdhci: Do not force sdhci_mmio_*_ops onto all SD controllers (Bernhard Beschow)
af0c16fae9 6ee960823d: Fixed incorrect LLONG alignment for openrisc and cris (Luca Bonissi)
40cfe12cb6 ea9812d93f: include/exec/user: Set ABI_LLONG_ALIGNMENT to 4 for nios2 (Richard Henderson)
43d2db4928 e73f27003e: include/exec/user: Set ABI_LLONG_ALIGNMENT to 4 for microblaze (Richard Henderson)
ee638bc5b5 4333f0924c: linux-user/elfload: Set V in ELF_HWCAP for RISC-V (Nathan Egge)
bb5f9036d5 3439ba9c5d: hw/nvme: fix null pointer access in ruh update (Klaus Jensen)
43328764f7 6c8f8456cb: hw/nvme: fix null pointer access in directive receive (Klaus Jensen)
f47369c3d1 dbdb13f931: hw/nvme: fix CRC64 for guard tag (Ankit Kumar)
cbd3c5db76 6a33f2e920: hw/nvme: fix compliance issue wrt. iosqes/iocqes (Klaus Jensen)
dd496f92b9 ecb1b7b082: hw/nvme: fix oob memory read in fdp events log (Klaus Jensen)
a11a2007a5 8a64609eea: dump: kdump-zlib data pages not dumped with pvtime/aarch64 (Dongli Zhang)
07b7ec0af0 8ada214a90: hw/i2c: Fix bitbang_i2c_data trace event (BALATON Zoltan)
abb4828d5d 196ea60a73: hw/smbios: Fix core count in type4 (Zhao Liu)
ce2e3879a4 7298fd7de5: hw/smbios: Fix thread count in type4 (Zhao Liu)
c107dab494 d79a284a44: hw/smbios: Fix smbios_smp_sockets caculation (Zhao Liu)
cfff72b21e a1d027be95: machine: Add helpers to get cores/threads per socket (Zhao Liu)
e7f12ce43d 76f9ebffcd: pnv_lpc: disable reentrancy detection for lpc-hc (Alexander Bulekov)
48c04e42f0 6d0589e0e6: loongarch: mark loongarch_ipi_iocsr re-entrnacy safe (Alexander Bulekov)
305ffdeca8 50795ee051: apic: disable reentrancy detection for apic-msi (Alexander Bulekov)
151649da1b 6dad5a6810: raven: disable reentrancy detection for iomem (Alexander Bulekov)
83d080e85a 985c4a4e54: bcm2835_property: disable reentrancy detection for iomem (Alexander Bulekov)
0f0fb19d2b d139fe9ad8: lsi53c895a: disable reentrancy detection for MMIO region, too (Thomas Huth)
db43c7db20 bfd6e7ae6a: lsi53c895a: disable reentrancy detection for script RAM (Alexander Bulekov)
fd9de51ea3 f63192b054: hw: replace most qemu_bh_new calls with qemu_bh_new_guarded (Alexander Bulekov)
db56206f78 ef56ffbdd6: checkpatch: add qemu_bh_new/aio_bh_new checks (Alexander Bulekov)
6a33d4b345 7915bd06f2: async: avoid use-after-free on re-entrancy guard (Alexander Bulekov)
932cf49f06 9c86c97f12: async: Add an optional reentrancy guard to the BH API (Alexander Bulekov)
a08c78dda7 a2e1753b80: memory: prevent dma-reentracy issues (Alexander Bulekov)

