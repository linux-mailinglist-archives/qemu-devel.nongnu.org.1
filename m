Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A83811260
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 14:03:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDOri-00083W-Ta; Wed, 13 Dec 2023 08:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rDOrG-00082T-EZ; Wed, 13 Dec 2023 08:01:02 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rDOrC-0006sp-UZ; Wed, 13 Dec 2023 08:01:01 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A9B803B433;
 Wed, 13 Dec 2023 16:01:00 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4D2B53C8C4;
 Wed, 13 Dec 2023 16:00:41 +0300 (MSK)
Received: (nullmailer pid 1024691 invoked by uid 1000);
 Wed, 13 Dec 2023 13:00:41 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.8 00/24] Patch Round-up for stable 7.2.8,
 freeze on 2023-12-23
Date: Wed, 13 Dec 2023 16:00:09 +0300
Message-Id: <qemu-stable-7.2.8-20231213160018@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v7.2.8:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2

Patch freeze is 2023-12-23, and the release is planned for 2023-12-25:

  https://wiki.qemu.org/Planning/7.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 3efd8495735c Richard Henderson:
   target/arm: Fix SME FMOPA (16-bit), BFMOPA
02 eabb92125066 Niklas Cassel:
   hw/ide/ahci: fix legacy software reset
03 7d0fefdf81f5 Akihiko Odaki:
   net: Provide MemReentrancyGuard * to qemu_new_nic()
04 9050f976e447 Akihiko Odaki:
   net: Update MemReentrancyGuard for NIC
05 82d70a84c8ee Richard Henderson:
   linux-user: Fix loaddr computation for some elf files
06 861f724d03e1 Thomas Huth:
   tests/avocado: Replace assertEquals() for Python 3.12 compatibility
07 f0a663b4ced2 Philippe Mathieu-Daudé:
   tests/avocado: Replace assertRegexpMatches() for Python 3.12 compatibility
08 11a3c4a286d5 Peter Maydell:
   target/arm: Set IL bit for pauth, SVE access, BTI trap syndromes
09 c9a4aa06dfce Philippe Mathieu-Daudé:
   hw/virtio: Free VirtIOIOMMUPCI::vdev.reserved_regions[] on finalize()
10 896dd6ff7b9f Philippe Mathieu-Daudé:
   hw/misc/mps2-scc: Free MPS2SCC::oscclk[] array on finalize()
11 49b3e28b7bdf Philippe Mathieu-Daudé:
   hw/nvram/xlnx-efuse: Free XlnxEFuse::ro_bits[] array on finalize()
12 4f10c66077e3 Philippe Mathieu-Daudé:
   hw/nvram/xlnx-efuse-ctrl: Free XlnxVersalEFuseCtrl[] "pg0-lock" array
13 837053a7f491 Philippe Mathieu-Daudé:
   hw/virtio: Add VirtioPCIDeviceTypeInfo::instance_finalize field
14 9fb7b350ba98 Fam Zheng:
   vmdk: Don't corrupt desc file in vmdk_write_cid
15 dc96009afd8c Thomas Huth:
   hw/mips/malta: Fix the malta machine on big endian hosts
16 74e8593e7e51 Volker Rümelin:
   hw/audio/hda-codec: fix multiplication overflow
17 714a1415d7a6 Akihiko Odaki:
   pcie_sriov: Remove g_new assertion
18 20bc50137f3a Philippe Mathieu-Daudé:
   hw/acpi/erst: Do not ignore Error* in realize handler
19 2d37fe9e5e61 Robert Hoo:
   msix: unset PCIDevice::msix_vector_poll_notifier in rollback
20 6f189a08c1b0 Antonio Caggiano:
   ui/gtk-egl: Check EGLSurface before doing scanout
21 53a939f1bf8e Volker Rümelin:
   ui/gtk-egl: move function calls back to regular code path
22 ebfbf3946711 Fiona Ebner:
   ui/vnc-clipboard: fix inflate_buffer
23 f7767ca30179 Peter Maydell:
   target/arm: Disable SME if SVE is disabled
24 2b8fe81b3c2e Patrick Venture:
   system/memory: use ldn_he_p/stn_he_p

