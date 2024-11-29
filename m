Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AE39D1FFB
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Nov 2024 07:07:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDHLr-0000xG-Rw; Tue, 19 Nov 2024 01:04:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tDHLl-0000il-4Z; Tue, 19 Nov 2024 01:04:34 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tDHLh-0004aL-9O; Tue, 19 Nov 2024 01:04:31 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 87B94A625F;
 Tue, 19 Nov 2024 09:04:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id AF58D1738D5;
 Tue, 19 Nov 2024 09:04:18 +0300 (MSK)
Received: (nullmailer pid 2368921 invoked by uid 1000);
 Tue, 19 Nov 2024 06:04:18 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 v2 00/72] Patch Round-up for stable 9.1.2,
 freeze on 2024-11-18
Date: Tue, 19 Nov 2024 09:03:58 +0300
Message-Id: <qemu-stable-9.1.2-20241118224223@cover.tls.msk.ru>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following patches are queued for QEMU stable v9.1.2:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-9.1

Patch freeze is 2024-11-18 (today), and the release is planned for 2024-11-20:

  https://wiki.qemu.org/Planning/9.1

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* 615586cb3568 Paolo Bonzini:
   tcg/s390x: fix constraint for 32-bit TSTEQ/TSTNE
02* 5504a8126115 Peter Xu:
   KVM: Dynamic sized kvm memslots array
03* e136648c5c95 Paolo Bonzini:
   target/i386/tcg: Use DPL-level accesses for interrupts and call gates
04* 64e0e63ea16a Tom Dohrmann:
   accel/kvm: check for KVM_CAP_READONLY_MEM on VM
05* 15d955975bd4 Richard Henderson:
   target/i386: Use only 16 and 32-bit operands for IN/OUT
06* d9280ea31747 Stefan Berger:
   tests: Wait for migration completion on destination QEMU to avoid failures
07* 68ad89b75ad2 Thomas Huth:
   Revert "hw/sh4/r2d: Realize IDE controller before accessing it"
08* d60bd080e783 Peter Maydell:
   tests/qemu-iotests/211.out: Update to expect MapEntry 'compressed' field
09* 04bbc3ee52b3 Kevin Wolf:
   raw-format: Fix error message for invalid offset/size
10* a7cfd751fb26 Richard Henderson:
   tcg: Reset data_gen_ptr correctly
11* b56617bbcb47 Alexander Graf:
   target/i386: Walk NPT in guest real mode
12* 115ade42d501 Richard Henderson:
   target/i386: Use probe_access_full_mmu in ptw_translate
13* bbd5630a75e7 Ilya Leoshkevich:
   linux-user: Emulate /proc/self/maps under mmap_lock
14* 8704132805cf Ilya Leoshkevich:
   linux-user/ppc: Fix sigmask endianness issue in sigreturn
15* 310df7a9fe40 Yao Zi:
   linux-user/riscv: Fix definition of RISCV_HWPROBE_EXT_ZVFHMIN
16* 3b5948f808e3 Avihai Horon:
   vfio/migration: Report only stop-copy size in vfio_state_pending_exact()
17* 97f116f9c6fd Alex Bennée:
   gitlab: make check-[dco|patch] a little more verbose
18* 24be5341fbee Pierrick Bouvier:
   dockerfiles: fix default targets for debian-loongarch-cross
19* b56f7dd203c3 Pierrick Bouvier:
   plugins: fix qemu_plugin_reset
20* 76240dd2a37c Akihiko Odaki:
   net: Check if nc is NULL in qemu_get_vnet_hdr_len()
21* e29bc931e169 Stefan Weil:
   Fix calculation of minimum in colo_compare_tcp
22* 1f37280b37db Daniel P. Berrangé:
   net: fix build when libbpf is disabled, but libxdp is enabled
23* 75fe36b4e8a9 Bernhard Beschow:
   net/tap-win32: Fix gcc 14 format truncation errors
24* 1505b651fdbd Peter Maydell:
   target/arm: Don't assert in regime_is_user() for E10 mmuidx values
25* 77dd098a5e79 Peter Maydell:
   hw/sd/omap_mmc: Don't use sd_cmd_type_t
26* bab209af3503 Ido Plat:
   target/arm: Fix arithmetic underflow in SETM instruction
27* d9c7adb6019f Peter Maydell:
   target/arm: Store FPSR cumulative exception bits in env->vfp.fpsr
28* 388b849fb6c3 Paolo Bonzini:
   stubs: avoid duplicate symbols in libqemuutil.a
29* 5a60026cad4e Evgenii Prokopiev:
   target/riscv/csr.c: Fix an access to VXSAT
30* 929e4277c128 TANG Tiancheng:
   target/riscv: Correct SXL return value for RV32 in RV64 QEMU
31* a84be2baa9ec Sergey Makarov:
   hw/intc: Don't clear pending bits on IRQ lowering
32* f8c1f36a2e3d Rob Bradford:
   target/riscv: Set vtype.vill on CPU reset
33* 2ae6cca1d338 Yong-Xuan Wang:
   hw/intc/riscv_aplic: Check and update pending when write sourcecfg
34* d201a127e164 Daniel Henrique Barboza:
   target/riscv/kvm: set 'aia_mode' to default in error path
35* fd16cfb2995e Daniel Henrique Barboza:
   target/riscv/kvm: clarify how 'riscv-aia' default works
36* c128d39edeff Anton Blanchard:
   target/riscv: Fix vcompress with rvv_ta_all_1s
37* c9b8a13a8841 Ilya Leoshkevich:
   target/ppc: Set ctx->opcode for decode_insn32()
38* 7b4820a3e1df Ilya Leoshkevich:
   target/ppc: Make divd[u] handler method decodetree compatible
39* 899e488650bb Nicholas Piggin:
   ppc/pnv: Fix LPC serirq routing calculation
40* 84416e262ea1 Nicholas Piggin:
   ppc/pnv: Fix LPC POWER8 register sanity check
41* 0324d236d291 Nicholas Piggin:
   target/ppc: Fix mtDPDES targeting SMT siblings
42* 87de77f6aeba Nicholas Piggin:
   target/ppc: Fix HFSCR facility checks
43* ddd2a060a0da Nicholas Piggin:
   ppc/pnv: ADU fix possible buffer overrun with invalid size
44* 65f53702d2e4 Philippe Mathieu-Daudé:
   hw/ssi/pnv_spi: Match _xfer_buffer_free() with _xfer_buffer_new()
45* 3feabc18ad4d Philippe Mathieu-Daudé:
   hw/ssi/pnv_spi: Return early in transfer()
46* 031324472eee Chalapathi V:
   hw/ssi/pnv_spi: Fixes Coverity CID 1558831
47* ddf4dd46e5c3 Ilya Leoshkevich:
   tests/tcg: Replace -mpower8-vector with -mcpu=power8
48* c078298301a8 Jan Luebbe:
   hw/sd/sdcard: Fix calculation of size when using eMMC boot partitions
49* 9cfe110d9fc0 Sunil Nimmagadda:
   qemu-ga: Fix a SIGSEGV in ga_run_command() helper
50* 16c687d84574 Jonathan Cameron:
   hw/acpi: Fix ordering of BDF in Generic Initiator PCI Device Handle.
51* feb58e3b261d Michael S. Tsirkin:
   acpi/disassemle-aml.sh: fix up after dir reorg
52* 056c5c90c171 Peter Maydell:
   Revert "target/arm: Fix usage of MMU indexes when EL3 is AArch32"
53* efbe180ad2ed Peter Maydell:
   target/arm: Add new MMU indexes for AArch32 Secure PL1&0
54* e6b2fa1b81ac Peter Maydell:
   target/arm: Fix SVE SDOT/UDOT/USDOT (4-way, indexed)
55* 37dfcba1a049 Hanna Czenczek:
   migration: Ensure vmstate_save() sets errp
56* 9529aa6bb4d1 Klaus Jensen:
   hw/nvme: fix handling of over-committed queues
57* 042b4ebfd229 Christian Schoenebeck:
   9pfs: fix crash on 'Treaddir' request
58 8fa11a4df344 Alexander Graf:
   target/i386: Fix legacy page table walk
59 bd0e501e1a48 Peter Maydell:
   hw/i386/pc: Don't try to init PCI NICs if there is no PCI bus
60 8491026a08b4 Helge Deller:
   linux-user: Fix setreuid and setregid to use direct syscalls
61 f27550804688 Richard Henderson:
   target/arm: Drop user-only special case in sve_stN_r
62 2a339fee4506 Richard Henderson:
   accel/tcg: Fix user-only probe_access_internal plugin check
63 fb7f3572b111 Ilya Leoshkevich:
   linux-user: Tolerate CONFIG_LSM_MMAP_MIN_ADDR
64 f7150b215139 Richard Henderson:
   linux-user/arm: Reduce vdso alignment to 4k
65 95c9e2209cc0 Richard Henderson:
   linux-user/arm: Select vdso for be8 and be32 modes
66 8377e3fb854d Peter Maydell:
   tcg: Allow top bit of SIMD_DATA_BITS to be set in simd_desc()
67 7ba055b49b74 Pierrick Bouvier:
   target/i386: fix hang when using slow path for ptw_setl
68 ebbf7c60bbd1 Cédric Le Goater:
   vfio/container: Fix container object destruction
69 c3d7c18b0d61 Thomas Huth:
   hw/misc/mos6522: Fix bad class definition of the MOS6522 device
70 e125d9835b89 Paolo Bonzini:
   Revert "hw/audio/hda: fix memory leak on audio setup"
71 626b39006d2f Paolo Bonzini:
   hw/audio/hda: fix memory leak on audio setup
72 b2cc69997924 Guenter Roeck:
   usb-hub: Fix handling port power control messages

(commit(s) marked with * were in previous series and are not resent)

