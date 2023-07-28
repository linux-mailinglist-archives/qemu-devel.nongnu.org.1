Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD9A7663A1
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 07:28:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPFnB-0006ai-3S; Fri, 28 Jul 2023 01:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinglimin@cmss.chinamobile.com>)
 id 1qPFn7-0006aY-Lo
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 01:13:29 -0400
Received: from cmccmta4.chinamobile.com ([111.22.67.137]
 helo=cmccmta1.chinamobile.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinglimin@cmss.chinamobile.com>) id 1qPFn4-0005Fd-Ce
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 01:13:29 -0400
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee464c34e6b3dc-2e54f;
 Fri, 28 Jul 2023 13:13:16 +0800 (CST)
X-RM-TRANSID: 2ee464c34e6b3dc-2e54f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.108.79.99])
 by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee864c34e623f6-94852;
 Fri, 28 Jul 2023 13:13:16 +0800 (CST)
X-RM-TRANSID: 2ee864c34e623f6-94852
From: dinglimin <dinglimin@cmss.chinamobile.com>
To: peter.maydell@linaro.org,
	mjt@tls.msk.ru,
	richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org,
	dinglimin <dinglimin@cmss.chinamobile.com>
Subject: [PATCH] semihosting/uaccess.c: Replaced a malloc call with g_malloc.
Date: Fri, 28 Jul 2023 13:12:52 +0800
Message-Id: <20230728051253.551-1-dinglimin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.30.0.windows.2
In-Reply-To: <ebdf2692-a155-6d2f-d46c-ddef02f4752a@linaro.org>
References: <ebdf2692-a155-6d2f-d46c-ddef02f4752a@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=111.22.67.137;
 envelope-from=dinglimin@cmss.chinamobile.com; helo=cmccmta1.chinamobile.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Replaced a call to malloc() and its respective call to free() with g_malloc() and g_free().

Signed-off-by: dinglimin <dinglimin@cmss.chinamobile.com>

v4 -> V5:Use g_try_malloc() instead of malloc()
V3 -> V4:Delete null checks after g malloc().
V2 -> V3:softmmu_unlock_user changes free to g free.
V1 -> V2:if cpu_memory_rw_debug failed, still need to set p=NULL

Signed-off-by: dinglimin <dinglimin@cmss.chinamobile.com>
---
 semihosting/uaccess.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
index 8018828069..35fdcd69db 100644
--- a/semihosting/uaccess.c
+++ b/semihosting/uaccess.c
@@ -14,13 +14,20 @@
 void *softmmu_lock_user(CPUArchState *env, target_ulong addr,
                         target_ulong len, bool copy)
 {
-    void *p = malloc(len);
-    if (p && copy) {
+    void *p = g_try_malloc(len);
+
+    if (!p) {
+        p = NULL;
+        return p;
+    }
+
+    if (copy) {
         if (cpu_memory_rw_debug(env_cpu(env), addr, p, len, 0)) {
-            free(p);
+            g_free(p);
             p = NULL;
         }
     }
+
     return p;
 }
 
@@ -87,5 +94,5 @@ void softmmu_unlock_user(CPUArchState *env, void *p,
     if (len) {
         cpu_memory_rw_debug(env_cpu(env), addr, p, len, 1);
     }
-    free(p);
+    g_free(p);
 }
-- 
2.30.0.windows.2




