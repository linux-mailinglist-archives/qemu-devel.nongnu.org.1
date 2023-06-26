Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE8073EB14
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 21:16:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrNO-0005be-7x; Mon, 26 Jun 2023 14:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrNB-0004Ff-K2; Mon, 26 Jun 2023 14:55:37 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrN9-00064g-Ao; Mon, 26 Jun 2023 14:55:37 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 13DEFEF4E;
 Mon, 26 Jun 2023 21:50:32 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 969F3F7DD;
 Mon, 26 Jun 2023 21:50:30 +0300 (MSK)
Received: (nullmailer pid 1574124 invoked by uid 1000);
 Mon, 26 Jun 2023 18:50:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 00/54] Patch Round-up for stable 8.0.3,
 freeze on 2023-07-06
Date: Mon, 26 Jun 2023 21:50:02 +0300
Message-Id: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v8.0.3:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-8.0

Patch freeze is 2023-07-06, and the release is planned for 2023-07-08:

  https://wiki.qemu.org/Planning/8.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 4d3bd91b26a6 Thomas Huth:
   gitlab-ci: Avoid to re-run "configure" in the device-crash-test jobs
02 8b869aa59109 Thomas Huth:
   scripts/device-crash-test: Add a parameter to run with TCG only
03 5260ecffd24e Richard Purdie:
   target/ppc: Fix fallback to MFSS for MFFS* instructions on pre 3.0 ISAs
04 2237af5e60ad Bernhard Beschow:
   hw/ppc/prep: Fix wiring of PIC -> CPU interrupt
05 94400fa53f81 Erico Nunes:
   ui/gtk: fix passing y0_top parameter to scanout
06 2f31663ed4b5 Erico Nunes:
   ui/gtk: use widget size for cursor motion event
07 f8a951bb9511 Erico Nunes:
   ui/gtk-egl: fix scaling for cursor position in scanout mode
08 b3a654d82ecf Marc-André Lureau:
   ui/sdl2: fix surface_gl_update_texture: Assertion 'gls' failed
09 0b31e48d62c8 Marc-André Lureau:
   ui/dbus: fix compilation when GBM && !OPENGL
10 efc00a37090e Bernhard Beschow:
   ui/sdl2: Grab Alt+Tab also in fullscreen mode
11 083db9db44c8 Bernhard Beschow:
   ui/sdl2: Grab Alt+F4 also under Windows
12 1dfea3f212e4 Volker Rümelin:
   ui/sdl2: disable SDL_HINT_GRAB_KEYBOARD on Windows
13 31afe04586ef Tommy Wu:
   hw/dma/xilinx_axidma: Check DMASR.HALTED to prevent infinite loop.
14 c9ba1c9f02cf Clément Chigot:
   hw/arm/xlnx-zynqmp: fix unsigned error when checking the RPUs number
15 d7fe699be54b Peter Maydell:
   target/arm: Explicitly select short-format FSR for M-profile
16 bfa72590df14 Ilya Leoshkevich:
   tests/tcg/s390x: Test EXECUTE of relative branches
17 079181b9bc60 Ilya Leoshkevich:
   target/s390x: Fix LCBB overwriting the top 32 bits
18 05d000fb4dca Ilya Leoshkevich:
   tests/tcg/s390x: Test LCBB
19 3180b1736210 Ilya Leoshkevich:
   target/s390x: Fix LOCFHR taking the wrong half of R2
20 230976232f4f Ilya Leoshkevich:
   tests/tcg/s390x: Test LOCFHR
21 01b9990a3fb8 Ilya Leoshkevich:
   linux-user/s390x: Fix single-stepping SVC
22 be4a4cb42961 Ilya Leoshkevich:
   tests/tcg/s390x: Test single-stepping SVC
23 a7f4add7931e Ilya Leoshkevich:
   target/s390x: Fix MXDB and MXDBR
24 2b956244a9d1 Ilya Leoshkevich:
   tests/tcg/s390x: Test MXDB and MXDBR
25 71b11cbe1c34 Ilya Leoshkevich:
   s390x/tcg: Fix CPU address returned by STIDP
26 dc96009afd8c Thomas Huth:
   hw/mips/malta: Fix the malta machine on big endian hosts
27 8442232eba1b David Woodhouse:
   hw/xen: Fix memory leak in libxenstore_open() for Xen
28 c9bdfe8d587c David Woodhouse:
   hw/xen: Fix broken check for invalid state in xs_be_open()
29 7771e8b86335 Jagannathan Raman:
   docs: fix multi-process QEMU documentation
30 86dcb6ab9b60 Mark Somerville:
   qga: Fix suspend on Linux guests without systemd
31 f6b0de53fb87 Christian Schoenebeck:
   9pfs: prevent opening special files (CVE-2023-2861)
32 5fb9e8295531 Mattias Nissler:
   hw/remote: Fix vfu_cfg trace offset format
33 bdfca8a22f41 Anastasia Belova:
   vnc: move assert in vnc_worker_thread_loop
34 e025e8f5a8a7 Nicholas Piggin:
   target/ppc: Fix lqarx to set cpu_reserve
35 6c242e79b876 Nicholas Piggin:
   target/ppc: Fix nested-hv HEAI delivery
36 6494d2c1fd4e Nicholas Piggin:
   target/ppc: Fix PMU hflags calculation
37 b9cedbf19cb4 Yin Wang:
   hw/riscv: qemu crash when NUMA nodes exceed available CPUs
38 c8f48b120b31 Cédric Le Goater:
   aspeed/hace: Initialize g_autofree pointer
39 243705aa6ea3 Peter Maydell:
   target/arm: Fix return value from LDSMIN/LDSMAX 8/16 bit atomics
40 7e2788471f9e Peter Maydell:
   target/arm: Return correct result for LDG when ATA=0
41 f837b468cdaa Peter Maydell:
   hw/intc/allwinner-a10-pic: Handle IRQ levels other than 0 or 1
42 d2f9a79a8cf6 Peter Maydell:
   hw/timer/nrf51_timer: Don't lose time when timer is queried in tight loop
43 d34b092cab60 Siqi Chen:
   target/tricore: Fix out-of-bounds index in imask instruction
44 6991777ec4b2 Bastian Koppelmann:
   target/tricore: Add CHECK_REG_PAIR() for insn accessing 64 bit regs
45 b0438861efe1 Peter Maydell:
   host-utils: Avoid using __builtin_subcll on buggy versions of Apple Clang
46 497fad38979c Peter Maydell:
   pc-bios/keymaps: Use the official xkb name for Arabic layout, not the 
   legacy synonym
47 50ba97e928b4 Helge Deller:
   target/hppa: Fix OS reboot issues
48 069d29666944 Helge Deller:
   target/hppa: Provide qemu version via fw_cfg to firmware
49 bb9c998ca934 Helge Deller:
   target/hppa: New SeaBIOS-hppa version 7
50 34ec3aea5436 Helge Deller:
   target/hppa: Update to SeaBIOS-hppa version 8
51 1e3ffb34f764 Prasad Pandit:
   vhost: release memory_listener object in error path
52 77ece20ba045 Prasad Pandit:
   vhost: release virtqueue objects in error path
53 d45243bcfc61 Eugenio Pérez:
   vdpa: fix not using CVQ buffer in case of error
54 a0d7215e339b Ani Sinha:
   vhost-vdpa: do not cleanup the vdpa/vhost-net structures if peer nic is 
   present

