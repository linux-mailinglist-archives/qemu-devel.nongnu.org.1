Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B4C8313AF
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 09:00:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQNE6-0000MD-2R; Thu, 18 Jan 2024 02:54:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNE2-0000Kf-4C; Thu, 18 Jan 2024 02:54:10 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNDz-0007JD-VK; Thu, 18 Jan 2024 02:54:09 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CAEE14502A;
 Thu, 18 Jan 2024 10:54:34 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E582D66193;
 Thu, 18 Jan 2024 10:54:04 +0300 (MSK)
Received: (nullmailer pid 2381626 invoked by uid 1000);
 Thu, 18 Jan 2024 07:54:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 00/38] Patch Round-up for stable 8.2.1,
 freeze on 2024-01-27
Date: Thu, 18 Jan 2024 10:52:27 +0300
Message-Id: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v8.2.1:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-8.2

Patch freeze is 2024-01-27, and the release is planned for 2024-01-29:

  https://wiki.qemu.org/Planning/8.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 d3007d348ada Kevin Wolf:
   block: Fix crash when loading snapshot on inactive node
02 5a7f21efaf99 Kevin Wolf:
   vl: Improve error message for conflicting -incoming and -loadvm
03 bb6e2511eb48 Kevin Wolf:
   iotests: Basic tests for internal snapshots
04 d424db235434 Natanael Copa:
   target/riscv/kvm: do not use non-portable strerrorname_np()
05 9d5b42beb697 Elen Avan:
   include/ui/rect.h: fix qemu_rect_init() mis-assignment
06 007531586aa8 Paolo Bonzini:
   configure: use a native non-cross compiler for linux-user
07 219615740425 Paolo Bonzini:
   target/i386: the sgx_epc_get_section stub is reachable
08 25145a7d7735 Pavel Pisa:
   hw/net/can/sja1000: fix bug for single acceptance filter and standard frame
09 5cb0e7abe163 Xu Lu:
   target/riscv: Fix mcycle/minstret increment behavior
10 4ad87cd4b225 Michael Tokarev:
   chardev/char.c: fix "abstract device type" error message
11 09a36158c283 Michael Tokarev:
   audio/audio.c: remove trailing newline in error_setg
12 0c7ffc977195 Bin Meng:
   hw/net: cadence_gem: Fix MDIO_OP_xxx values
13 2c5107e1b455 Max Erenberg:
   edu: fix DMA range upper bound check
14 213ae3ffda46 Cédric Le Goater:
   vfio/container: Replace basename with g_path_get_basename
15 9353b6da430f Volker Rümelin:
   hw/vfio: fix iteration over global VFIODevice list
16 82a65e3188ab Peter Maydell:
   hw/intc/arm_gicv3_cpuif: handle LPIs in in the list registers
17 ca5bed07d0e7 Richard Henderson:
   tcg/ppc: Use new registers for LQ destination
18 1d513e06d966 Natanael Copa:
   util: fix build with musl libc on ppc64le
19 ca8b0cc8e917 Gerd Hoffmann:
   tests/acpi: allow tests/data/acpi/virt/SSDT.memhp changes
20 c3667412582c Gerd Hoffmann:
   edk2: update to git snapshot
21 6f79fa5f097a Gerd Hoffmann:
   edk2: update build config, set PcdUninstallMemAttrProtocol = TRUE.
22 505872015196 Gerd Hoffmann:
   edk2: update binaries to git snapshot
23 55abfc1ffbe5 Gerd Hoffmann:
   tests/acpi: update expected data files
24 704f7cad5105 Gerd Hoffmann:
   tests/acpi: disallow tests/data/acpi/virt/SSDT.memhp changes
25 c98873ee4a0c Samuel Tardieu:
   tests/qtest/virtio-ccw: Fix device presence checking
26 e358a25a97c7 Ilya Leoshkevich:
   target/s390x: Fix LAE setting a wrong access register
27 52a21689cd82 Peter Maydell:
   .gitlab-ci.d/buildtest.yml: Work around htags bug when environment is large
28 b16a45bc5e0e Alex Bennée:
   readthodocs: fully specify a build environment
29 92039f61af89 Helge Deller:
   hw/hppa/machine: Allow up to 3840 MB total memory
30 d8a3220005d7 Helge Deller:
   hw/hppa/machine: Disable default devices with --nodefaults option
31 3b57c15f0205 Helge Deller:
   hw/pci-host/astro: Add missing astro & elroy registers for NetBSD
32 6ce18d530638 Helge Deller:
   target/hppa: Fix PDC address translation on PA2.0 with PSW.W=0
33 ed35afcb331a Helge Deller:
   hw/hppa: Move software power button address back into PDC
34 5915b67013eb Helge Deller:
   target/hppa: Avoid accessing %gr0 when raising exception
35 3824e0d643f3 Helge Deller:
   target/hppa: Export function hppa_set_ior_and_isr()
36 910ada0225d1 Helge Deller:
   target/hppa: Fix IOR and ISR on unaligned access trap
37 31efbe72c6cc Helge Deller:
   target/hppa: Fix IOR and ISR on error in probe
38 4bda8224fa89 Helge Deller:
   target/hppa: Update SeaBIOS-hppa to version 15

