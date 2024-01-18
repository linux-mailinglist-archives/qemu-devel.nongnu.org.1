Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA3B831EE5
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 19:02:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQWhP-0005Fn-6K; Thu, 18 Jan 2024 13:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQWh8-0005Ao-TP; Thu, 18 Jan 2024 13:00:56 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQWh3-0001jd-Iv; Thu, 18 Jan 2024 13:00:50 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 573404545B;
 Thu, 18 Jan 2024 21:01:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 43BCC66C24;
 Thu, 18 Jan 2024 21:00:36 +0300 (MSK)
Received: (nullmailer pid 2513362 invoked by uid 1000);
 Thu, 18 Jan 2024 18:00:31 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Xu Lu <luxu.kernel@bytedance.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.9 4/8] target/riscv: Fix mcycle/minstret increment
 behavior
Date: Thu, 18 Jan 2024 21:00:23 +0300
Message-Id: <20240118180031.2513319-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.9-20240118170458@cover.tls.msk.ru>
References: <qemu-stable-7.2.9-20240118170458@cover.tls.msk.ru>
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

From: Xu Lu <luxu.kernel@bytedance.com>

The mcycle/minstret counter's stop flag is mistakenly updated on a copy
on stack. Thus the counter increments even when the CY/IR bit in the
mcountinhibit register is set. This commit corrects its behavior.

Fixes: 3780e33732f88 (target/riscv: Support mcycle/minstret write operation)
Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit 5cb0e7abe1635cb82e0033260dac2b910d142f8c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5c9a7ee287..15dba5f653 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -697,11 +697,11 @@ static int write_mhpmcounterh(CPURISCVState *env, int csrno, target_ulong val)
 static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
                                          bool upper_half, uint32_t ctr_idx)
 {
-    PMUCTRState counter = env->pmu_ctrs[ctr_idx];
-    target_ulong ctr_prev = upper_half ? counter.mhpmcounterh_prev :
-                                         counter.mhpmcounter_prev;
-    target_ulong ctr_val = upper_half ? counter.mhpmcounterh_val :
-                                        counter.mhpmcounter_val;
+    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
+    target_ulong ctr_prev = upper_half ? counter->mhpmcounterh_prev :
+                                         counter->mhpmcounter_prev;
+    target_ulong ctr_val = upper_half ? counter->mhpmcounterh_val :
+                                        counter->mhpmcounter_val;
 
     if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
         /**
@@ -709,12 +709,12 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
          * stop the icount counting. Just return the counter value written by
          * the supervisor to indicate that counter was not incremented.
          */
-        if (!counter.started) {
+        if (!counter->started) {
             *val = ctr_val;
             return RISCV_EXCP_NONE;
         } else {
             /* Mark that the counter has been stopped */
-            counter.started = false;
+            counter->started = false;
         }
     }
 
-- 
2.39.2


