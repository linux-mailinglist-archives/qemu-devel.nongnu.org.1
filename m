Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE4B73EAF6
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 21:11:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrUI-0004Ga-0S; Mon, 26 Jun 2023 15:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrUC-0003z9-Ow; Mon, 26 Jun 2023 15:02:52 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrUA-00083O-GU; Mon, 26 Jun 2023 15:02:52 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1398DEFCF;
 Mon, 26 Jun 2023 21:59:16 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 96F56F809;
 Mon, 26 Jun 2023 21:59:14 +0300 (MSK)
Received: (nullmailer pid 1575409 invoked by uid 1000);
 Mon, 26 Jun 2023 18:59:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.4 00/43] Patch Round-up for stable 7.2.4,
 freeze on 2023-07-06
Date: Mon, 26 Jun 2023 21:59:02 +0300
Message-Id: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
References: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v7.2.4:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2

Patch freeze is 2023-07-06, and the release is planned for 2023-07-08:

  https://wiki.qemu.org/Planning/7.2

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
03 2237af5e60ad Bernhard Beschow:
   hw/ppc/prep: Fix wiring of PIC -> CPU interrupt
04 94400fa53f81 Erico Nunes:
   ui/gtk: fix passing y0_top parameter to scanout
05 2f31663ed4b5 Erico Nunes:
   ui/gtk: use widget size for cursor motion event
06 f8a951bb9511 Erico Nunes:
   ui/gtk-egl: fix scaling for cursor position in scanout mode
07 b3a654d82ecf Marc-André Lureau:
   ui/sdl2: fix surface_gl_update_texture: Assertion 'gls' failed
08 efc00a37090e Bernhard Beschow:
   ui/sdl2: Grab Alt+Tab also in fullscreen mode
09 083db9db44c8 Bernhard Beschow:
   ui/sdl2: Grab Alt+F4 also under Windows
10 1dfea3f212e4 Volker Rümelin:
   ui/sdl2: disable SDL_HINT_GRAB_KEYBOARD on Windows
11 31afe04586ef Tommy Wu:
   hw/dma/xilinx_axidma: Check DMASR.HALTED to prevent infinite loop.
12 c9ba1c9f02cf Clément Chigot:
   hw/arm/xlnx-zynqmp: fix unsigned error when checking the RPUs number
13 d7fe699be54b Peter Maydell:
   target/arm: Explicitly select short-format FSR for M-profile
14 079181b9bc60 Ilya Leoshkevich:
   target/s390x: Fix LCBB overwriting the top 32 bits
15 05d000fb4dca Ilya Leoshkevich:
   tests/tcg/s390x: Test LCBB
16 3180b1736210 Ilya Leoshkevich:
   target/s390x: Fix LOCFHR taking the wrong half of R2
17 230976232f4f Ilya Leoshkevich:
   tests/tcg/s390x: Test LOCFHR
18 01b9990a3fb8 Ilya Leoshkevich:
   linux-user/s390x: Fix single-stepping SVC
19 be4a4cb42961 Ilya Leoshkevich:
   tests/tcg/s390x: Test single-stepping SVC
20 71b11cbe1c34 Ilya Leoshkevich:
   s390x/tcg: Fix CPU address returned by STIDP
21 7771e8b86335 Jagannathan Raman:
   docs: fix multi-process QEMU documentation
22 86dcb6ab9b60 Mark Somerville:
   qga: Fix suspend on Linux guests without systemd
23 f6b0de53fb87 Christian Schoenebeck:
   9pfs: prevent opening special files (CVE-2023-2861)
24 5fb9e8295531 Mattias Nissler:
   hw/remote: Fix vfu_cfg trace offset format
25 bdfca8a22f41 Anastasia Belova:
   vnc: move assert in vnc_worker_thread_loop
26 e025e8f5a8a7 Nicholas Piggin:
   target/ppc: Fix lqarx to set cpu_reserve
27 6c242e79b876 Nicholas Piggin:
   target/ppc: Fix nested-hv HEAI delivery
28 6494d2c1fd4e Nicholas Piggin:
   target/ppc: Fix PMU hflags calculation
29 b9cedbf19cb4 Yin Wang:
   hw/riscv: qemu crash when NUMA nodes exceed available CPUs
30 c8f48b120b31 Cédric Le Goater:
   aspeed/hace: Initialize g_autofree pointer
31 243705aa6ea3 Peter Maydell:
   target/arm: Fix return value from LDSMIN/LDSMAX 8/16 bit atomics
32 7e2788471f9e Peter Maydell:
   target/arm: Return correct result for LDG when ATA=0
33 f837b468cdaa Peter Maydell:
   hw/intc/allwinner-a10-pic: Handle IRQ levels other than 0 or 1
34 d2f9a79a8cf6 Peter Maydell:
   hw/timer/nrf51_timer: Don't lose time when timer is queried in tight loop
35 b0438861efe1 Peter Maydell:
   host-utils: Avoid using __builtin_subcll on buggy versions of Apple Clang
36 497fad38979c Peter Maydell:
   pc-bios/keymaps: Use the official xkb name for Arabic layout, not the 
   legacy synonym
37 50ba97e928b4 Helge Deller:
   target/hppa: Fix OS reboot issues
38 069d29666944 Helge Deller:
   target/hppa: Provide qemu version via fw_cfg to firmware
39 bb9c998ca934 Helge Deller:
   target/hppa: New SeaBIOS-hppa version 7
40 34ec3aea5436 Helge Deller:
   target/hppa: Update to SeaBIOS-hppa version 8
41 1e3ffb34f764 Prasad Pandit:
   vhost: release memory_listener object in error path
42 d45243bcfc61 Eugenio Pérez:
   vdpa: fix not using CVQ buffer in case of error
43 a0d7215e339b Ani Sinha:
   vhost-vdpa: do not cleanup the vdpa/vhost-net structures if peer nic is 
   present

