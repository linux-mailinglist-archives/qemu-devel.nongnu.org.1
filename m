Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CFD7B796E
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:03:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwqa-00049b-5Q; Wed, 04 Oct 2023 04:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwpx-0003dt-4E; Wed, 04 Oct 2023 04:02:32 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwpu-00084W-QM; Wed, 04 Oct 2023 04:02:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7DDE12758A;
 Wed,  4 Oct 2023 11:02:22 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C4F932CBC6;
 Wed,  4 Oct 2023 11:02:21 +0300 (MSK)
Received: (nullmailer pid 2702748 invoked by uid 1000);
 Wed, 04 Oct 2023 08:02:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 00/45] Patch Round-up for stable 8.1.2,
 freeze on 2023-10-14
Date: Wed,  4 Oct 2023 11:01:21 +0300
Message-Id: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v8.1.2:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-8.1

Patch freeze is 2023-10-14, and the release is planned for 2023-10-16:

  https://wiki.qemu.org/Planning/8.1

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

This release supposed to finally fix some long-standing issues in 8.1.x series,
by including commit 0d58c660689f "softmmu: Use async_run_on_cpu in tcg_commit"
and follow-up series fixing issues in other areas it uncovered, among other
fixes.

Thanks!

/mjt

--------------------------------------
01 7798f5c576d8 Nicholas Piggin:
   hw/ppc: Introduce functions for conversion between timebase and 
   nanoseconds
02 47de6c4c2870 Nicholas Piggin:
   host-utils: Add muldiv64_round_up
03 eab0888418ab Nicholas Piggin:
   hw/ppc: Round up the decrementer interval when converting to ns
04 8e0a5ac87800 Nicholas Piggin:
   hw/ppc: Avoid decrementer rounding errors
05 c8fbc6b9f2f3 Nicholas Piggin:
   target/ppc: Sign-extend large decrementer to 64-bits
06 febb71d543a8 Nicholas Piggin:
   hw/ppc: Always store the decrementer value
07 30d0647bcfa9 Nicholas Piggin:
   hw/ppc: Reset timebase facilities on machine reset
08 ea62f8a5172c Nicholas Piggin:
   hw/ppc: Read time only once to perform decrementer write
09 2529497cb6b2 Mikulas Patocka:
   linux-user/hppa: clear the PSW 'N' bit when delivering signals
10 5b1270ef1477 Mikulas Patocka:
   linux-user/hppa: lock both words of function descriptor
11 7b165fa16402 Li Zhijian:
   hw/cxl: Fix CFMW config memory leak
12 de5bbfc602ef Dmitry Frolov:
   hw/cxl: Fix out of bound array access
13 56d1a022a77e Hanna Czenczek:
   file-posix: Clear bs->bl.zoned on error
14 4b5d80f3d020 Hanna Czenczek:
   file-posix: Check bs->bl.zoned for zone info
15 deab5c9a4ed7 Hanna Czenczek:
   file-posix: Fix zone update in I/O error path
16 d31b50a15dd2 Hanna Czenczek:
   file-posix: Simplify raw_co_prw's 'out' zone code
17 380448464dd8 Hanna Czenczek:
   tests/file-io-error: New test
18 c78edb563942 Anton Johansson:
   include/exec: Widen tlb_hit/tlb_hit_page()
19 32b214384e1e Fabian Vogt:
   hw/arm/boot: Set SCR_EL3.FGTEn when booting kernel
20 903dbefc2b69 Peter Maydell:
   target/arm: Don't skip MTE checks for LDRT/STRT at EL0
21 c64023b0ba67 Thomas Huth:
   meson.build: Make keyutils independent from keyring
22 0e5903436de7 Nicholas Piggin:
   accel/tcg: mttcg remove false-negative halted assertion
23 7cfcc79b0ab8 Thomas Huth:
   hw/scsi/scsi-disk: Disallow block sizes smaller than 512 [CVE-2023-42467]
24 0cb9c5880e6b Paolo Bonzini:
   ui/vnc: fix debug output for invalid audio message
25 477b301000d6 Paolo Bonzini:
   ui/vnc: fix handling of VNC_FEATURE_XVP
26 cf02f29e1e38 Peter Xu:
   migration: Fix race that dest preempt thread close too early
27 28a8347281e2 Fabiano Rosas:
   migration: Fix possible race when setting rp_state.error
28 639decf52979 Fabiano Rosas:
   migration: Fix possible races when shutting down the return path
29 7478fb0df914 Fabiano Rosas:
   migration: Fix possible race when shutting down to_dst_file
30 b3b101157d46 Fabiano Rosas:
   migration: Remove redundant cleanup of postcopy_qemufile_src
31 d50f5dc075cb Fabiano Rosas:
   migration: Consolidate return path closing code
32 ef796ee93b31 Fabiano Rosas:
   migration: Replace the return path retry logic
33 36e9aab3c569 Fabiano Rosas:
   migration: Move return path cleanup to main migration thread
34 0d58c660689f Richard Henderson:
   softmmu: Use async_run_on_cpu in tcg_commit
35 f47a90dacca8 Richard Henderson:
   accel/tcg: Avoid load of icount_decr if unused
36 5d97e9463810 Richard Henderson:
   accel/tcg: Hoist CF_MEMI_ONLY check outside translation loop
37 0ca41ccf1c55 Richard Henderson:
   accel/tcg: Track current value of can_do_io in the TB
38 a2f99d484c54 Richard Henderson:
   accel/tcg: Improve setting of can_do_io at start of TB
39 200c1f904f46 Richard Henderson:
   accel/tcg: Always set CF_LAST_IO with CF_NOIRQ
40 18a536f1f8d6 Richard Henderson:
   accel/tcg: Always require can_do_io
41 23fa6f56b33f Bastian Koppelmann:
   target/tricore: Fix RCPW/RRPW_INSERT insns for width = 0
42 35ed01ba5448 Fabiano Rosas:
   optionrom: Remove build-id section
43 b86dc5cb0b41 Mark Cave-Ayland:
   esp: use correct type for esp_dma_enable() in sysbus_esp_gpio_demux()
44 77668e4b9bca Mark Cave-Ayland:
   esp: restrict non-DMA transfer length to that of available data
45 be2b619a1734 Mark Cave-Ayland:
   scsi-disk: ensure that FORMAT UNIT commands are terminated

