Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EEE7AB4A0
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:19:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjhv1-0007vc-Ck; Fri, 22 Sep 2023 11:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjhux-0007pT-HD; Fri, 22 Sep 2023 11:18:07 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjhuu-000663-O0; Fri, 22 Sep 2023 11:18:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D88CF24595;
 Fri, 22 Sep 2023 18:18:23 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1E5D12A1BC;
 Fri, 22 Sep 2023 18:18:00 +0300 (MSK)
Message-ID: <d0d2ac8f-313a-c937-dc3a-88e45fce933c@tls.msk.ru>
Date: Fri, 22 Sep 2023 18:18:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: [ANNOUNCE] QEMU 8.1.1 Stable released
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

The QEMU v8.1.1 stable release is now available.

You can grab the tarball from our download page here:

   https://www.qemu.org/download/#source

v8.1.1 is now tagged in the official qemu.git repository, and the
stable-8.1 branch has been updated accordingly:

   https://gitlab.com/qemu-project/qemu/-/commits/stable-8.1?ref_type=heads

This update contains a pile of fixes for various architectures/subsystems,
fixing a number of various bugs.  Unfortunately some known bugs remain
unfixed still, and hopefully will be addressed in subsequent 8.1.x releases.
In particular, the following issues (which exists in 8.1.0 release too)
remain unfixed in this release:

    https://gitlab.com/qemu-project/qemu/-/issues/1826
    https://gitlab.com/qemu-project/qemu/-/issues/1834
    https://gitlab.com/qemu-project/qemu/-/issues/1846

The fix for these are available (which is commit 0d58c66068 "softmmu: Use
async_run_on_cpu in tcg_commit", thanks to Richard Henderson), but it uncovers
problems in other areas (eg https://gitlab.com/qemu-project/qemu/-/issues/1866
with at least two different issues) for which there's no fix in qemu master
branch yet, so I had to delay inclusion of this one to stable-8.1.

Thank you everyone who has been involved and helped with the stable series!

Changelog:

6bb4a8a47a: Update version for 8.1.1 release (Michael Tokarev)
045fa84784 8e32ddff69: tpm: fix crash when FD >= 1024 and unnecessary errors due to EINTR (Marc-André Lureau)
56270e5d3d fb0a8b0e23: meson: Fix targetos match for illumos and Solaris. (Jonathan Perkin)
60da8301fe 297ec01f0b: s390x/ap: fix missing subsystem reset registration (Janosch Frank)
8b479229ff 48a35e12fa: ui: fix crash when there are no active_console (Marc-André Lureau)
d4919bbcc2 04562ee88e: virtio-gpu/win32: set the destroy function on load (Marc-André Lureau)
cae7dc1452 a7c272df82: target/riscv: Allocate itrigger timers only once (Akihiko Odaki)
7385e00665 4e3adce124: target/riscv/pmp.c: respect mseccfg.RLB for pmpaddrX changes (Leon Schuermann)
1d4fb5815c 3a2fc23563: target/riscv: fix satp_mode_finalize() when satp_mode.supported = 0 (Daniel Henrique Barboza)
b822207513 9ff3140631: hw/riscv: virt: Fix riscv,pmu DT node path (Conor Dooley)
2947da750e ae7d4d625c: linux-user/riscv: Use abi type for target_ucontext (LIU Zhiwei)
60a7f5c8fe 9382a9eafc: hw/intc: Make rtc variable names consistent (Jason Chien)
566dac7127 e0922b73ba: hw/intc: Fix upper/lower mtime write calculation (Jason Chien)
8ae20123b6 eda633a534: target/riscv: Fix zfa fleq.d and fltq.d (LIU Zhiwei)
6c24b6000b 4cc9f284d5: target/riscv: Fix page_check_range use in fault-only-first (LIU Zhiwei)
987e90cfd2 50f9464962: target/riscv/cpu.c: add zmmul isa string (Daniel Henrique Barboza)
b9f83298b9 058096f1c5: hw/char/riscv_htif: Fix the console syscall on big endian hosts (Thomas Huth)
3d6251f416 c255946e3d: hw/char/riscv_htif: Fix printing of console characters on big endian hosts (Thomas Huth)
9832a670b3 682814e2a3: arm64: Restore trapless ptimer access (Colton Lewis)
df33ce9b6d 92e2e6a867: virtio: Drop out of coroutine context in virtio_load() (Kevin Wolf)
eeee989f72 95bef686e4: qxl: don't assert() if device isn't yet initialized (Marc-André Lureau)
93d4107937 90a0778421: hw/net/vmxnet3: Fix guest-triggerable assert() (Thomas Huth)
6356785daa b21a6e31a1: docs tests: Fix use of migrate_set_parameter (Markus Armbruster)
01bf87c8e3 bcd8e24308: qemu-options.hx: Rephrase the descriptions of the -hd* and -cdrom options (Thomas Huth)
25ec23ab3f 961faf3ddb: hw/i2c/aspeed: Fix TXBUF transmission start position error (Hang Yu)
9dc6f05cc8 97b8aa5ae9: hw/i2c/aspeed: Fix Tx count and Rx size error in buffer pool mode (Hang Yu)
d5361580ac 9f89423537: hw/ide/ahci: fix broken SError handling (Niklas Cassel)
e8f5ca57e4 7e85cb0db4: hw/ide/ahci: fix ahci_write_fis_sdb() (Niklas Cassel)
4448c345bc 1a16ce64fd: hw/ide/ahci: PxCI should not get cleared when ERR_STAT is set (Niklas Cassel)
4fbd5a5202 d73b84d0b6: hw/ide/ahci: PxSACT and PxCI is cleared when PxCMD.ST is cleared (Niklas Cassel)
16cc9594d2 e2a5d9b3d9: hw/ide/ahci: simplify and document PxCI handling (Niklas Cassel)
1efefd13ca 2967dc8209: hw/ide/ahci: write D2H FIS when processing NCQ command (Niklas Cassel)
c2e0495e3c c3461c6264: hw/ide/core: set ERR_STAT in unsupported command completion (Niklas Cassel)
f64f1f8704 718209358f: target/ppc: Fix LQ, STQ register-pair order for big-endian (Nicholas Piggin)
9f54fef2c0 af03aeb631: target/ppc: Flush inputs to zero with NJ in ppc_store_vscr (Richard Henderson)
5358980d33 6ec65b69ba: hw/ppc/e500: fix broken snapshot replay (Maksim Kostin)
6864f05cb1 7b8589d7ce: ppc/vof: Fix missed fields in VOF cleanup (Nicholas Piggin)
0175121c6c cb6ccdc9ca: ui/dbus: Properly dispose touch/mouse dbus objects (Bilal Elmoussaoui)
e975434d62 c1f27a0c6a: target/i386: raise FERR interrupt with iothread locked (Paolo Bonzini)
e5e77f256f aec338d63b: linux-user: Adjust brk for load_bias (Richard Henderson)
645b87f650 9e771a2fc6: target/arm: properly document FEAT_CRC32 (Alex Bennée)
86d7b08d71 f187609f27: block-migration: Ensure we don't crash during migration cleanup (Fabiano Rosas)
5691fbf440 86e4f93d82: softmmu: Assert data in bounds in iotlb_to_section (Richard Henderson)
441106eebb 09a3fffae0: docs/about/license: Update LICENSE URL (Philippe Mathieu-Daudé)
63188a00bb cd1e4db736: target/arm: Fix 64-bit SSRA (Richard Henderson)
7012e20b2d 4b3520fd93: target/arm: Fix SME ST1Q (Richard Henderson)
c8e381d672 1ab445af8c: accel/kvm: Specify default IPA size for arm64 (Akihiko Odaki)
34808d041c 5e0d65909c: kvm: Introduce kvm_arch_get_default_type hook (Akihiko Odaki)
01f6417f15 d194362910: include/hw/virtio/virtio-gpu: Fix virtio-gpu with blob on big endian hosts (Thomas Huth)
14a8213b75 6a2ea61518: target/s390x: Check reserved bits of VFMIN/VFMAX's M5 (Ilya Leoshkevich)
c12eddbd48 6db3518ba4: target/s390x: Fix VSTL with a large length (Ilya Leoshkevich)
880e82ed78 23e87d419f: target/s390x: Use a 16-bit immediate in VREP (Ilya Leoshkevich)
5980189e96 791b2b6a93: target/s390x: Fix the "ignored match" case in VSTRS (Ilya Leoshkevich)

