Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2459EB1320C
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Jul 2025 23:57:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ug9M6-0004dM-3J; Sun, 27 Jul 2025 17:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ug9Ky-00043V-Lt; Sun, 27 Jul 2025 17:55:20 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ug9Kw-00073w-Lu; Sun, 27 Jul 2025 17:55:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A28AA13A97E;
 Mon, 28 Jul 2025 00:55:06 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8195F25118F;
 Mon, 28 Jul 2025 00:55:12 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org,
 Hao Wu <wuhaotsh@google.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH trivial for 10.1] roms/Makefile: fix npcmNxx_bootrom build
 rules
Date: Mon, 28 Jul 2025 00:55:07 +0300
Message-ID: <20250727215511.807880-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Since commit 70ce076fa6dff60, the actual rom source dirs
are subdirs of vbootrom/ submodule, not in top-level of it.

Fixes: 70ce076fa6dff60 "roms: Update vbootrom to 1287b6e"

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 roms/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/roms/Makefile b/roms/Makefile
index beff58d9d5..6af68a922f 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -193,12 +193,12 @@ qboot:
 	cp qboot/build/bios.bin ../pc-bios/qboot.rom
 
 npcm7xx_bootrom:
-	$(MAKE) -C vbootrom CROSS_COMPILE=$(arm_cross_prefix)
-	cp vbootrom/npcm7xx_bootrom.bin ../pc-bios/npcm7xx_bootrom.bin
+	$(MAKE) -C vbootrom/npcm7xx CROSS_COMPILE=$(arm_cross_prefix)
+	cp vbootrom/npcm7xx/npcm7xx_bootrom.bin ../pc-bios/npcm7xx_bootrom.bin
 
 npcm8xx_bootrom:
-	$(MAKE) -C vbootrom CROSS_COMPILE=$(aarch64_cross_prefix)
-	cp vbootrom/npcm8xx_bootrom.bin ../pc-bios/npcm8xx_bootrom.bin
+	$(MAKE) -C vbootrom/npcm8xx CROSS_COMPILE=$(aarch64_cross_prefix)
+	cp vbootrom/npcm8xx/npcm8xx_bootrom.bin ../pc-bios/npcm8xx_bootrom.bin
 
 hppa-firmware:
 	$(MAKE) -C seabios-hppa parisc
-- 
2.47.2


