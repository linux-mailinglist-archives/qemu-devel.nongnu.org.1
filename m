Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E797539FB
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:46:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKH8Y-0000IQ-LL; Fri, 14 Jul 2023 07:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH8V-0000Gd-1V; Fri, 14 Jul 2023 07:38:59 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH8T-00049g-AO; Fri, 14 Jul 2023 07:38:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8FA4113D91;
 Fri, 14 Jul 2023 14:38:55 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8B83E14BA0;
 Fri, 14 Jul 2023 14:38:39 +0300 (MSK)
Received: (nullmailer pid 1186210 invoked by uid 1000);
 Fri, 14 Jul 2023 11:38:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH, trivial 05/29] tree-wide spelling fixes in comments and some
 messages: tcg
Date: Fri, 14 Jul 2023 14:38:10 +0300
Message-Id: <20230714113834.1186117-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714113834.1186117-1-mjt@tls.msk.ru>
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
MIME-Version: 1.0
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 tcg/aarch64/tcg-target.c.inc | 2 +-
 tcg/arm/tcg-target.c.inc     | 4 ++--
 tcg/riscv/tcg-target.c.inc   | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 35ca80cd56..5471523f4c 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -3088,3 +3088,3 @@ static void tcg_target_qemu_prologue(TCGContext *s)
      * Note that XZR cannot be encoded in the address base register slot,
-     * as that actaully encodes SP.  Depending on the guest, we may need
+     * as that actually encodes SP.  Depending on the guest, we may need
      * to zero-extend the guest address via the address index register slot,
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 83e286088f..3a14f52c51 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1218,3 +1218,3 @@ static TCGCond tcg_out_cmp2(TCGContext *s, const TCGArg *args,
     case TCG_COND_GEU:
-        /* We perform a conditional comparision.  If the high half is
+        /* We perform a conditional comparison.  If the high half is
            equal, then overwrite the flags with the comparison of the
@@ -1252,3 +1252,3 @@ static TCGCond tcg_out_cmp2(TCGContext *s, const TCGArg *args,
  * Note that TCGReg references Q-registers.
- * Q-regno = 2 * D-regno, so shift left by 1 whlie inserting.
+ * Q-regno = 2 * D-regno, so shift left by 1 while inserting.
  */
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index eeaeb6b6e3..e9e5968823 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -71,3 +71,3 @@ static const int tcg_target_reg_alloc_order[] = {
     /* Call saved registers */
-    /* TCG_REG_S0 reservered for TCG_AREG0 */
+    /* TCG_REG_S0 reserved for TCG_AREG0 */
     TCG_REG_S1,
@@ -262,3 +262,3 @@ typedef enum {
 
-    /* Zbb: Bit manipulation extension, basic bit manipulaton */
+    /* Zbb: Bit manipulation extension, basic bit manipulation */
     OPC_ANDN   = 0x40007033,
-- 
2.39.2


