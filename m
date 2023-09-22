Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A65F7AB421
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 16:53:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjhVJ-0003KG-M8; Fri, 22 Sep 2023 10:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjhVG-0003K3-Bx; Fri, 22 Sep 2023 10:51:34 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjhVD-00009X-4T; Fri, 22 Sep 2023 10:51:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4D12924574;
 Fri, 22 Sep 2023 17:51:49 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 84C6F2A189;
 Fri, 22 Sep 2023 17:51:25 +0300 (MSK)
Message-ID: <bf422038-5f0a-e9ca-1eb3-ed25442c747c@tls.msk.ru>
Date: Fri, 22 Sep 2023 17:51:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: qemu-stable <qemu-stable@nongnu.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: [ANNOUNCE] QEMU 7.2.6 Stable released
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

The QEMU v7.2.6 stable release is now available.

You can grab the tarball from our download page here:

   https://www.qemu.org/download/#source

v7.2.6 is now tagged in the official qemu.git repository, and the
stable-7.2 branch has been updated accordingly:

   https://gitlab.com/qemu-project/qemu/-/commits/stable-7.2?ref_type=heads

This update contains usual pile of general fixes for various architectures
and subsystems, and brings up a backport of re-entrancy fixes which landed
in 8.1, together with all follow-ups and refinements to date:
https://gitlab.com/qemu-project/qemu/-/issues/556

I plan to maintain 7.2.x branch for a while still, to see how it goes,
so hopefully there will be some more regular 7.2.x stable releases.

Thank you everyone who has been involved and helped with the stable series!

Changelog:

7be98a0583 Update version for 7.2.6 release
feb0d5a932 tpm: fix crash when FD >= 1024 and unnecessary errors due to EINTR
2021c2d539 s390x/ap: fix missing subsystem reset registration
d0f8b52fc1 ui: fix crash when there are no active_console
9eda3b6874 hw/tpm: TIS on sysbus: Remove unsupport ppi command line option
b5fad36452 target/riscv/pmp.c: respect mseccfg.RLB for pmpaddrX changes
7601c960b6 hw/riscv: virt: Fix riscv,pmu DT node path
f44ffdcef9 linux-user/riscv: Use abi type for target_ucontext
d4a3464109 hw/intc: Make rtc variable names consistent
6097d3cbba hw/intc: Fix upper/lower mtime write calculation
ec0afe3c0b hw/char/riscv_htif: Fix printing of console characters on big endian hosts
c04c0123bd arm64: Restore trapless ptimer access
217ab2b86c virtio: Drop out of coroutine context in virtio_load()
3c99de0aa7 qxl: don't assert() if device isn't yet initialized
ebac7b1bef hw/net/vmxnet3: Fix guest-triggerable assert()
721c4c8692 docs tests: Fix use of migrate_set_parameter
af144c17b5 qemu-options.hx: Rephrase the descriptions of the -hd* and -cdrom options
a5d911beb6 hw/i2c/aspeed: Fix TXBUF transmission start position error
2ed40ec1e0 hw/i2c/aspeed: Fix Tx count and Rx size error in buffer pool mode
ccac65fbd1 hw/ide/ahci: fix broken SError handling
2aa37f5fa5 hw/ide/ahci: fix ahci_write_fis_sdb()
74d9ef9d0b hw/ide/ahci: PxCI should not get cleared when ERR_STAT is set
458a5f95de hw/ide/ahci: PxSACT and PxCI is cleared when PxCMD.ST is cleared
1e5ad6b06b hw/ide/ahci: simplify and document PxCI handling
131bf5d20d hw/ide/ahci: write D2H FIS when processing NCQ command
f86c6ff824 hw/ide/core: set ERR_STAT in unsupported command completion
d4d975bb11 target/ppc: Flush inputs to zero with NJ in ppc_store_vscr
86b40ee537 ppc/vof: Fix missed fields in VOF cleanup
13f9872a10 hw/ppc/e500: fix broken snapshot replay
8b1eac90bb block-migration: Ensure we don't crash during migration cleanup
8f364b5b86 docs/about/license: Update LICENSE URL
a451382580 target/arm: Fix 64-bit SSRA
7400b82afb target/arm: Fix SME ST1Q
0b133e1435 accel/kvm: Specify default IPA size for arm64
bfe41c8f65 kvm: Introduce kvm_arch_get_default_type hook
204ff2b8bb include/hw/virtio/virtio-gpu: Fix virtio-gpu with blob on big endian hosts
e7ecf6a45f target/s390x: Check reserved bits of VFMIN/VFMAX's M5
7760cfd9c8 target/s390x: Fix VSTL with a large length
7c4ce14b41 target/s390x: Use a 16-bit immediate in VREP
08a4e6da12 target/s390x: Fix the "ignored match" case in VSTRS
0434ea16fe Fixed incorrect LLONG alignment for openrisc and cris
e29b1ef53c include/exec/user: Set ABI_LLONG_ALIGNMENT to 4 for nios2
14e2c1c4ce include/exec/user: Set ABI_LLONG_ALIGNMENT to 4 for microblaze
a568abcf17 linux-user/elfload: Set V in ELF_HWCAP for RISC-V
04535fb7b5 hw/nvme: fix CRC64 for guard tag
408179de49 dump: kdump-zlib data pages not dumped with pvtime/aarch64
5de2b51ebb hw/smbios: Fix core count in type4
9238e669ed hw/smbios: Fix thread count in type4
056bada5d2 hw/smbios: Fix smbios_smp_sockets caculation
9bb8c4fb6b machine: Add helpers to get cores/threads per socket
bf202262e5 pnv_lpc: disable reentrancy detection for lpc-hc
c34e604bf6 loongarch: mark loongarch_ipi_iocsr re-entrnacy safe
79873ecad0 apic: disable reentrancy detection for apic-msi
1247481530 raven: disable reentrancy detection for iomem
65ad790287 bcm2835_property: disable reentrancy detection for iomem
f5072ff503 lsi53c895a: disable reentrancy detection for MMIO region, too
c2cf7829a5 lsi53c895a: disable reentrancy detection for script RAM
ae96dce3b7 hw: replace most qemu_bh_new calls with qemu_bh_new_guarded
bb3522b4f8 checkpatch: add qemu_bh_new/aio_bh_new checks
f88ebe0c7d async: avoid use-after-free on re-entrancy guard
61dacb401b async: Add an optional reentrancy guard to the BH API
c40ca2301c memory: prevent dma-reentracy issues
590e71e536 python: drop pipenv
b8d1fc55b5 gitlab-ci: check-dco.py: switch from master to stable-7.2 branch

