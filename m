Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DC5760CA6
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 10:08:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOD55-0006pM-4b; Tue, 25 Jul 2023 04:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinglimin@cmss.chinamobile.com>)
 id 1qOD4Y-0006p2-Kg
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 04:07:10 -0400
Received: from cmccmta4.chinamobile.com ([111.22.67.137]
 helo=cmccmta1.chinamobile.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinglimin@cmss.chinamobile.com>) id 1qOD4Q-00063h-MX
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 04:07:10 -0400
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee464bf8291fbd-180ad;
 Tue, 25 Jul 2023 16:06:44 +0800 (CST)
X-RM-TRANSID: 2ee464bf8291fbd-180ad
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.108.79.99])
 by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee564bf8292062-4e28b;
 Tue, 25 Jul 2023 16:06:43 +0800 (CST)
X-RM-TRANSID: 2ee564bf8292062-4e28b
From: dinglimin <dinglimin@cmss.chinamobile.com>
To: richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org,
	dinglimin <dinglimin@cmss.chinamobile.com>
Subject: [PATCH] semihosting/uaccess.c: Replaced a malloc call with g_malloc.
Date: Tue, 25 Jul 2023 16:06:30 +0800
Message-Id: <20230725080630.1083-1-dinglimin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.30.0.windows.2
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
---
 semihosting/uaccess.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
index 8018828069..8f2e6f63ee 100644
--- a/semihosting/uaccess.c
+++ b/semihosting/uaccess.c
@@ -14,11 +14,10 @@
 void *softmmu_lock_user(CPUArchState *env, target_ulong addr,
                         target_ulong len, bool copy)
 {
-    void *p = malloc(len);
+    void *p = g_malloc(len);
     if (p && copy) {
         if (cpu_memory_rw_debug(env_cpu(env), addr, p, len, 0)) {
-            free(p);
-            p = NULL;
+            g_free(p);
         }
     }
     return p;
-- 
2.30.0.windows.2




