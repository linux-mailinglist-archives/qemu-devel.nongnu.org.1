Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC10832B9F
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:49:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQqBA-0002Us-5l; Fri, 19 Jan 2024 09:49:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQqB8-0002Tw-TE
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:49:06 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQqB7-00084U-5w
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gGawoAgwRn7U45zRJr37/ElW2N0IWtg60b7mBd+yI5E=; b=mDdTbCnW8oduKLOi8d7CnJnU9h
 rc80szcojOv9JUaIVrTzLUOB3a7wW8ZS2sqa/5fPMzcM1Pvu+bDuGMgLBr5HrkjQMHPRjO4AI4ac0
 U12EJcO+OgM/JDHysFfv/ac06RBwl5d8BR9JtClJRDJYuW7ZDRTkfxeJgXaVvWzjYV9E=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [RFC PATCH 30/34] accel/tcg: Make tcg-all.c target indpendent
Date: Fri, 19 Jan 2024 15:40:20 +0100
Message-ID: <20240119144024.14289-31-anjo@rev.ng>
In-Reply-To: <20240119144024.14289-1-anjo@rev.ng>
References: <20240119144024.14289-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Uses target_supports_mttcg() and target_long_bits() to turn ifdefs into
runtime branches.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 accel/tcg/tcg-all.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index a40e0aee37..b8e920e3a8 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -28,7 +28,6 @@
 #include "exec/replay-core.h"
 #include "sysemu/cpu-timers.h"
 #include "tcg/tcg.h"
-#include "tcg/oversized-guest.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/accel.h"
@@ -67,20 +66,13 @@ DECLARE_INSTANCE_CHECKER(TCGState, TCG_STATE,
  * there is one remaining limitation to check:
  *   - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
  */
-
 static bool default_mttcg_enabled(void)
 {
-    if (icount_enabled() || TCG_OVERSIZED_GUEST) {
+    const bool oversized_guest = target_long_bits() > TCG_TARGET_REG_BITS;
+    if (icount_enabled() || oversized_guest) {
         return false;
     }
-#ifdef TARGET_SUPPORTS_MTTCG
-# ifndef TCG_GUEST_DEFAULT_MO
-#  error "TARGET_SUPPORTS_MTTCG without TCG_GUEST_DEFAULT_MO"
-# endif
-    return true;
-#else
-    return false;
-#endif
+    return target_supports_mttcg();
 }
 
 static void tcg_accel_instance_init(Object *obj)
@@ -137,17 +129,18 @@ static char *tcg_get_thread(Object *obj, Error **errp)
 static void tcg_set_thread(Object *obj, const char *value, Error **errp)
 {
     TCGState *s = TCG_STATE(obj);
+    const bool oversized_guest = target_long_bits() > TCG_TARGET_REG_BITS;
 
     if (strcmp(value, "multi") == 0) {
-        if (TCG_OVERSIZED_GUEST) {
+        if (oversized_guest) {
             error_setg(errp, "No MTTCG when guest word size > hosts");
         } else if (icount_enabled()) {
             error_setg(errp, "No MTTCG when icount is enabled");
         } else {
-#ifndef TARGET_SUPPORTS_MTTCG
-            warn_report("Guest not yet converted to MTTCG - "
-                        "you may get unexpected results");
-#endif
+            if (target_supports_mttcg()) {
+                warn_report("Guest not yet converted to MTTCG - "
+                            "you may get unexpected results");
+            }
             s->mttcg_enabled = true;
         }
     } else if (strcmp(value, "single") == 0) {
-- 
2.43.0


