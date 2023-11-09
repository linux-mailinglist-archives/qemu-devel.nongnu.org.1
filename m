Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5E97E6BDF
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:01:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15ZO-00057b-UQ; Thu, 09 Nov 2023 08:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15ZK-00056w-HU; Thu, 09 Nov 2023 08:59:38 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15ZH-0005N0-CQ; Thu, 09 Nov 2023 08:59:38 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1007D31BB6;
 Thu,  9 Nov 2023 16:59:41 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1BD89344EF;
 Thu,  9 Nov 2023 16:59:33 +0300 (MSK)
Received: (nullmailer pid 1462752 invoked by uid 1000);
 Thu, 09 Nov 2023 13:59:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.7 00/62] Patch Round-up for stable 7.2.7,
 freeze on 2023-11-19
Date: Thu,  9 Nov 2023 16:58:28 +0300
Message-Id: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following patches are queued for QEMU stable v7.2.7:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2

Patch freeze is 2023-11-19, and the release is planned for 2023-11-21:

  https://wiki.qemu.org/Planning/7.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

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
06 17dd1354c1d1 Nicholas Piggin:
   target/ppc: Decrementer fix BookE semantics
07 febb71d543a8 Nicholas Piggin:
   hw/ppc: Always store the decrementer value
08 2529497cb6b2 Mikulas Patocka:
   linux-user/hppa: clear the PSW 'N' bit when delivering signals
09 5b1270ef1477 Mikulas Patocka:
   linux-user/hppa: lock both words of function descriptor
10 7b165fa16402 Li Zhijian:
   hw/cxl: Fix CFMW config memory leak
11 903dbefc2b69 Peter Maydell:
   target/arm: Don't skip MTE checks for LDRT/STRT at EL0
12 0e5903436de7 Nicholas Piggin:
   accel/tcg: mttcg remove false-negative halted assertion
13 7cfcc79b0ab8 Thomas Huth:
   hw/scsi/scsi-disk: Disallow block sizes smaller than 512 [CVE-2023-42467]
14 0cb9c5880e6b Paolo Bonzini:
   ui/vnc: fix debug output for invalid audio message
15 477b301000d6 Paolo Bonzini:
   ui/vnc: fix handling of VNC_FEATURE_XVP
16 35ed01ba5448 Fabiano Rosas:
   optionrom: Remove build-id section
17 b86dc5cb0b41 Mark Cave-Ayland:
   esp: use correct type for esp_dma_enable() in sysbus_esp_gpio_demux()
18 77668e4b9bca Mark Cave-Ayland:
   esp: restrict non-DMA transfer length to that of available data
19 be2b619a1734 Mark Cave-Ayland:
   scsi-disk: ensure that FORMAT UNIT commands are terminated
20 3d304620ec6c Paolo Bonzini:
   target/i386: fix operand size of unary SSE operations
21 9e65829699f9 Paolo Bonzini:
   tests/tcg/i386: correct mask for VPERM2F128/VPERM2I128
22 afa94dabc52b Ricky Zhou:
   target/i386: Fix and add some comments next to SSE/AVX instructions.
23 cab529b0dc15 Ricky Zhou:
   target/i386: Fix exception classes for SSE/AVX instructions.
24 8bf171c2d126 Ricky Zhou:
   target/i386: Fix exception classes for MOVNTPS/MOVNTPD.
25 a48b26978a09 Paolo Bonzini:
   target/i386: generalize operand size "ph" for use in CVTPS2PD
26 abd41884c530 Paolo Bonzini:
   target/i386: fix memory operand size for CVTPS2PD
27 e0288a778473 Laszlo Ersek:
   hw/display/ramfb: plug slight guest-triggerable leak on mode setting
28 4f7689f0817a Thomas Huth:
   chardev/char-pty: Avoid losing bytes when the other side just 
   (re-)connected
29 33bc4fa78b06 Richard Henderson:
   linux-user/hppa: Fix struct target_sigcontext layout
30 0114c4513095 Akihiko Odaki:
   amd_iommu: Fix APIC address check
31 86dec715a733 Peter Xu:
   migration/qmp: Fix crash on setting tls-authz with null
32 00e3b29d065f Volker Rümelin:
   hw/audio/es1370: reset current sample counter
33 cffa99549088 Alvin Chang:
   disas/riscv: Fix the typo of inverted order of pmpaddr13 and pmpaddr14
34 85fc35afa93c Yuval Shaia:
   hw/pvrdma: Protect against buggy or malicious guest driver
35 caea03279e11 Fabiano Rosas:
   migration: Fix analyze-migration read operation signedness
36 6fad9b4bb91d Mikulas Patocka:
   linux-user/mips: fix abort on integer overflow
37 3b894b699c9a Mikulas Patocka:
   linux-user/sh4: Fix crashes on signal delivery
38 a1e6a5c46219 Helge Deller:
   lasips2: LASI PS/2 devices are not user-createable
39 ae5f70baf549 Lu Gao:
   hw/sd/sdhci: Block Size Register bits [14:12] is lost
40 6f83dc67168d Glenn Miles:
   misc/led: LED state is set opposite of what is expected
41 7a06a8fec9df Akihiko Odaki:
   tests/migration: Add -fno-stack-protector
42 580731dcc87e Akihiko Odaki:
   tests/tcg: Add -fno-stack-protector
43 8b097fd6b06e Andrey Drobyshev:
   qemu-img: rebase: stop when reaching EOF of old backing file
44 827171c31805 Andrey Drobyshev:
   qemu-iotests: 024: add rebasing test case for overlay_size > backing_size
45 9f0246539ae8 Daniel P. Berrangé:
   Revert "linux-user: add more compat ioctl definitions"
46 6003159ce18f Daniel P. Berrangé:
   Revert "linux-user: fix compat with glibc >= 2.36 sys/mount.h"
47 0d3de77a07f4 Fabiano Rosas:
   target/arm: Don't access TCG code when debugging with KVM
48 21a4ab8318ba Peter Maydell:
   target/arm: Don't allow stage 2 page table walks to downgrade to NS
49 fcc0b0418fff Peter Maydell:
   target/arm: Fix handling of SW and NSW bits for stage 2 walks
50 4c09abeae870 Peter Maydell:
   target/arm: Correctly propagate stage 1 BTI guarded bit in a two-stage 
   walk
51 cc8fb0c3ae3c Vladimir Sementsov-Ogievskiy:
   block/nvme: nvme_process_completion() fix bound for cid
52 08730ee0cc01 BALATON Zoltan:
   ati-vga: Implement fallback for pixman routines
53 565f85a9c293 Marc-André Lureau:
   ui/gtk: force realization of drawing area
54 47fd6ab1e334 Dongwon Kim:
   ui/gtk-egl: apply scale factor when calculating window's dimension
55 6f189a08c1b0 Antonio Caggiano:
   ui/gtk-egl: Check EGLSurface before doing scanout
56 04591b3ddd9a Philippe Mathieu-Daudé:
   target/mips: Fix MSA BZ/BNZ opcodes displacement
57 18f86aecd6a1 Philippe Mathieu-Daudé:
   target/mips: Fix TX79 LQ/SQ opcodes
58 7d7512019fc4 Fiona Ebner:
   hw/ide: reset: cancel async DMA operation before resetting state
59 cc610857bbd3 Fiona Ebner:
   tests/qtest: ahci-test: add test exposing reset issue with pending 
   callback
60 bea402482a8c Ilya Leoshkevich:
   target/s390x: Fix LAALG not updating cc_src
61 ebc14107f1f3 Ilya Leoshkevich:
   tests/tcg/s390x: Test LAALG with negative cc_src
62 b523a3d54f3d Niklas Cassel:
   hw/ide/ahci: trigger either error IRQ or regular IRQ, not both

