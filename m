Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A18697CB501
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 23:02:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsUis-0000u6-VB; Mon, 16 Oct 2023 17:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qsUiq-0000s3-KB; Mon, 16 Oct 2023 17:01:56 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qsUio-0006VI-CA; Mon, 16 Oct 2023 17:01:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 852A42ACF2;
 Tue, 17 Oct 2023 00:02:08 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7BEAC2F78C;
 Tue, 17 Oct 2023 00:01:52 +0300 (MSK)
Message-ID: <24dfb1c2-dc40-4841-893d-5d530638b684@tls.msk.ru>
Date: Tue, 17 Oct 2023 00:01:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: qemu-stable <qemu-stable@nongnu.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: [ANNOUNCE] QEMU 8.1.2 Stable released
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

The QEMU v8.1.2 stable release is now available.

You can grab the tarball from our download page here:

   https://www.qemu.org/download/#source

v8.1.2 is now tagged in the official qemu.git repository, and the
stable-8.1 branch has been updated accordingly:

   https://gitlab.com/qemu-project/qemu/-/commits/stable-8.1?ref_type=heads

This update finally contains fixes for a few issues which were part of
8.1.0 release and which remained unfixed in 8.1.1 stable release, namely:

    https://gitlab.com/qemu-project/qemu/-/issues/1826
    https://gitlab.com/qemu-project/qemu/-/issues/1834
    https://gitlab.com/qemu-project/qemu/-/issues/1846

Also a fix for CVE-2023-42467 is included in this release.

There's at least one known regression in 8.1.1 which is not fixed in 8.1.2,
causing systems using legacy reset mechanism for SATA devices instead of using
more robust COMRESET mechanism.  Notable this causes FreeBSD to hang:
https://lore.kernel.org/qemu-devel/20231005100407.1136484-1-nks@flawful.org/ ,
thanks to Niklas Cassel for the fix.  Hopefully it will be included in the next
8.1 stable release, among a few other fixes waiting to be included into the
master branch.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-8.1-hash master-hash Author: commmit-subject):

78385bc738 Michael Tokarev:
  Update version for 8.1.2 release
cc33ee45d6 837570cef2 Max Chou:
  target/riscv: Fix vfwmaccbf16.vf
a8c0d82f7b cffa995490 Alvin Chang:
  disas/riscv: Fix the typo of inverted order of pmpaddr13 and pmpaddr14
2e42ba01f1 17b8d8ac33 Olaf Hering:
  roms: use PYTHON to invoke python
5dddba9f38 00e3b29d06 Volker Rümelin:
  hw/audio/es1370: reset current sample counter
b6170717ea 86dec715a7 Peter Xu:
  migration/qmp: Fix crash on setting tls-authz with null
d8b9e0c8bc f05142d511 Fiona Ebner:
  util/log: re-allow switching away from stderr log file
0f1d63d824 931150e56b Alex Williamson:
  vfio/display: Fix missing update to set backing fields
2adbc3b1e5 0114c45130 Akihiko Odaki:
  amd_iommu: Fix APIC address check
fe3afc06fa 845ec38ae1 Eugenio Pérez:
  vdpa net: follow VirtIO initialization properly at cvq isolation probing
e6d9dd102d f1085882d0 Eugenio Pérez:
  vdpa net: stop probing if cannot set features
197cc86a12 cbc9ae87b5 Eugenio Pérez:
  vdpa net: fix error message setting virtio status
809d5995c8 0a7a164bc3 Eugenio Pérez:
  vdpa net: zero vhost_vdpa iova_tree pointer at cleanup
2990ba5471 33bc4fa78b Richard Henderson:
  linux-user/hppa: Fix struct target_sigcontext layout
19159a7f01 4f7689f081 Thomas Huth:
  chardev/char-pty: Avoid losing bytes when the other side just (re-)connected
7771e35b39 e0288a7784 Laszlo Ersek:
  hw/display/ramfb: plug slight guest-triggerable leak on mode setting
ab6314506d 75b773d84c Marc-André Lureau:
  win32: avoid discarding the exception handler
1e5839828d abd41884c5 Paolo Bonzini:
  target/i386: fix memory operand size for CVTPS2PD
db2d4bcb8e a48b26978a Paolo Bonzini:
  target/i386: generalize operand size "ph" for use in CVTPS2PD
6831048324 c01196bddd Thomas Huth:
  subprojects/berkeley-testfloat-3: Update to fix a problem with compiler warnings
f9f1d0906b be2b619a17 Mark Cave-Ayland:
  scsi-disk: ensure that FORMAT UNIT commands are terminated
e855a6ec51 77668e4b9b Mark Cave-Ayland:
  esp: restrict non-DMA transfer length to that of available data
8194d5827e b86dc5cb0b Mark Cave-Ayland:
  esp: use correct type for esp_dma_enable() in sysbus_esp_gpio_demux()
ee7ce8a949 35ed01ba54 Fabiano Rosas:
  optionrom: Remove build-id section
d1b867cca6 23fa6f56b3 Bastian Koppelmann:
  target/tricore: Fix RCPW/RRPW_INSERT insns for width = 0
9fb45b0558 18a536f1f8 Richard Henderson:
  accel/tcg: Always require can_do_io
d6cca99ecd 200c1f904f Richard Henderson:
  accel/tcg: Always set CF_LAST_IO with CF_NOIRQ
6c2e2e4f77 a2f99d484c Richard Henderson:
  accel/tcg: Improve setting of can_do_io at start of TB
a98097d3a9 0ca41ccf1c Richard Henderson:
  accel/tcg: Track current value of can_do_io in the TB
de11111ee8 5d97e94638 Richard Henderson:
  accel/tcg: Hoist CF_MEMI_ONLY check outside translation loop
837ca790c6 f47a90dacc Richard Henderson:
  accel/tcg: Avoid load of icount_decr if unused
d9ec18a0fc 0d58c66068 Richard Henderson:
  softmmu: Use async_run_on_cpu in tcg_commit
4ade907b30 36e9aab3c5 Fabiano Rosas:
  migration: Move return path cleanup to main migration thread
dec7785fab ef796ee93b Fabiano Rosas:
  migration: Replace the return path retry logic
1ad3fa152c d50f5dc075 Fabiano Rosas:
  migration: Consolidate return path closing code
d37260b9f0 b3b101157d Fabiano Rosas:
  migration: Remove redundant cleanup of postcopy_qemufile_src
73393af917 7478fb0df9 Fabiano Rosas:
  migration: Fix possible race when shutting down to_dst_file
f5480c4d82 639decf529 Fabiano Rosas:
  migration: Fix possible races when shutting down the return path
cc3a33400c 28a8347281 Fabiano Rosas:
  migration: Fix possible race when setting rp_state.error
0b246f8e9e cf02f29e1e Peter Xu:
  migration: Fix race that dest preempt thread close too early
3b86b92bfb 477b301000 Paolo Bonzini:
  ui/vnc: fix handling of VNC_FEATURE_XVP
17f3a6221f 0cb9c5880e Paolo Bonzini:
  ui/vnc: fix debug output for invalid audio message
6b7fa3cbab 7cfcc79b0a Thomas Huth:
  hw/scsi/scsi-disk: Disallow block sizes smaller than 512 [CVE-2023-42467]
b9b84b2d41 0e5903436d Nicholas Piggin:
  accel/tcg: mttcg remove false-negative halted assertion
0215e8e872 c64023b0ba Thomas Huth:
  meson.build: Make keyutils independent from keyring
7329cc1c19 903dbefc2b Peter Maydell:
  target/arm: Don't skip MTE checks for LDRT/STRT at EL0
d0cd94e2b6 32b214384e Fabian Vogt:
  hw/arm/boot: Set SCR_EL3.FGTEn when booting kernel
cb6ed2f7f7 c78edb5639 Anton Johansson:
  include/exec: Widen tlb_hit/tlb_hit_page()
8a043309ad 380448464d Hanna Czenczek:
  tests/file-io-error: New test
8ef6104413 d31b50a15d Hanna Czenczek:
  file-posix: Simplify raw_co_prw's 'out' zone code
31a471430f deab5c9a4e Hanna Czenczek:
  file-posix: Fix zone update in I/O error path
825af96d6a 4b5d80f3d0 Hanna Czenczek:
  file-posix: Check bs->bl.zoned for zone info
c2e6a00b5f 56d1a022a7 Hanna Czenczek:
  file-posix: Clear bs->bl.zoned on error
f59caeca76 de5bbfc602 Dmitry Frolov:
  hw/cxl: Fix out of bound array access
6970f5ba0e 7b165fa164 Li Zhijian:
  hw/cxl: Fix CFMW config memory leak
fda70be0c5 5b1270ef14 Mikulas Patocka:
  linux-user/hppa: lock both words of function descriptor
f7f97b9ad8 2529497cb6 Mikulas Patocka:
  linux-user/hppa: clear the PSW 'N' bit when delivering signals
fb9e03529c ea62f8a517 Nicholas Piggin:
  hw/ppc: Read time only once to perform decrementer write
b6fa8e42d1 30d0647bcf Nicholas Piggin:
  hw/ppc: Reset timebase facilities on machine reset
1c2343cc61 febb71d543 Nicholas Piggin:
  hw/ppc: Always store the decrementer value
97fec8f2c4 c8fbc6b9f2 Nicholas Piggin:
  target/ppc: Sign-extend large decrementer to 64-bits
0e35c812b9 8e0a5ac878 Nicholas Piggin:
  hw/ppc: Avoid decrementer rounding errors
73b7a81107 eab0888418 Nicholas Piggin:
  hw/ppc: Round up the decrementer interval when converting to ns
4bff0a8287 47de6c4c28 Nicholas Piggin:
  host-utils: Add muldiv64_round_up
ded5edee00 7798f5c576 Nicholas Piggin:
  hw/ppc: Introduce functions for conversion between timebase and nanoseconds

