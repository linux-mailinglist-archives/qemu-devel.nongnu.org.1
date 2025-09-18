Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D92B13236
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Jul 2025 00:21:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ug9iP-0000E4-MC; Sun, 27 Jul 2025 18:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1ug9iL-0000Cc-Db
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 18:19:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1ug9iJ-0001Ea-Ir
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 18:19:29 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 07CC113A985;
 Mon, 28 Jul 2025 01:19:16 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3EFAB2511A8;
 Mon, 28 Jul 2025 01:19:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Hao Wu <wuhaotsh@google.com>, Havard Skinnemoen <hskinnemoen@google.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH for 10.1 1/2] roms/vbootrom: update to 601d410
Date: Mon, 28 Jul 2025 01:19:18 +0300
Message-ID: <2a89ad4c8f5665d07952a4f1749caa6ec0cd3d9c.1753654515.git.mjt@tls.msk.ru>
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

Changes:

601d410 ast27x0: Fix missing SCU module reset for SSP and TSP initialization
80768e4 ast27x0: Initialize and enable SSP/TSP using SCU with reserved-memory from DTB
f8ab635 ast27x0: Show build date and git version
53294f5 Add initial support for AST27x0
b1c2803 Dynamically detects NPCM8XX UBOOT destination and size.
4f54dfc Automatically search for UBOOT location for NPCM8xx images.

The actual bootroms are not updated yet.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
Mjt: this is just the submodule update, not the actual ROM file(s)
update.  There are at least 2 commits in there wich modifies NPCM8XX
boot code -- we probably should update pc-bios/npcm8xx_bootrom.bin too.

 roms/vbootrom | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/vbootrom b/roms/vbootrom
index 1287b6e42e..f9eb0bb57d 160000
--- a/roms/vbootrom
+++ b/roms/vbootrom
@@ -1 +1 @@
-Subproject commit 1287b6e42e839ba2ab0f06268c5b53ae60df3537
+Subproject commit f9eb0bb57decbab860a81712c56132c2102fa98e
-- 
2.47.2


