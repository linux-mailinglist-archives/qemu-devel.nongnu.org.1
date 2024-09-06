Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAA396E931
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Sep 2024 07:24:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smRPU-0008Vj-25; Fri, 06 Sep 2024 01:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smROY-000577-CZ; Fri, 06 Sep 2024 01:20:30 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smROV-0000CM-AK; Fri, 06 Sep 2024 01:20:29 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ADD208C13D;
 Fri,  6 Sep 2024 08:15:18 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5E5A0133382;
 Fri,  6 Sep 2024 08:16:36 +0300 (MSK)
Received: (nullmailer pid 10508 invoked by uid 1000);
 Fri, 06 Sep 2024 05:16:34 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jianzhou Yue <JianZhou.Yue@verisilicon.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.14 40/40] hw/core/ptimer: fix timer zero period condition
 for freq > 1GHz
Date: Fri,  6 Sep 2024 08:16:28 +0300
Message-Id: <20240906051633.10288-40-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
References: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
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

From: Jianzhou Yue <JianZhou.Yue@verisilicon.com>

The real period is zero when both period and period_frac are zero.
Check the method ptimer_set_freq, if freq is larger than 1000 MHz,
the period is zero, but the period_frac is not, in this case, the
ptimer will work but the current code incorrectly recognizes that
the ptimer is disabled.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2306
Signed-off-by: JianZhou Yue <JianZhou.Yue@verisilicon.com>
Message-id: 3DA024AEA8B57545AF1B3CAA37077D0FB75E82C8@SHASXM03.verisilicon.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 446e5e8b4515e9a7be69ef6a29852975289bb6f0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index eb5ba1aff7..f1f8109385 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -83,7 +83,7 @@ static void ptimer_reload(ptimer_state *s, int delta_adjust)
         delta = s->delta = s->limit;
     }
 
-    if (s->period == 0) {
+    if (s->period == 0 && s->period_frac == 0) {
         if (!qtest_enabled()) {
             fprintf(stderr, "Timer with period zero, disabling\n");
         }
@@ -309,7 +309,7 @@ void ptimer_run(ptimer_state *s, int oneshot)
 
     assert(s->in_transaction);
 
-    if (was_disabled && s->period == 0) {
+    if (was_disabled && s->period == 0 && s->period_frac == 0) {
         if (!qtest_enabled()) {
             fprintf(stderr, "Timer with period zero, disabling\n");
         }
diff --git a/tests/unit/ptimer-test.c b/tests/unit/ptimer-test.c
index 04b5f4e3d0..08240594bb 100644
--- a/tests/unit/ptimer-test.c
+++ b/tests/unit/ptimer-test.c
@@ -763,6 +763,33 @@ static void check_oneshot_with_load_0(gconstpointer arg)
     ptimer_free(ptimer);
 }
 
+static void check_freq_more_than_1000M(gconstpointer arg)
+{
+    const uint8_t *policy = arg;
+    ptimer_state *ptimer = ptimer_init(ptimer_trigger, NULL, *policy);
+    bool no_round_down = (*policy & PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
+
+    triggered = false;
+
+    ptimer_transaction_begin(ptimer);
+    ptimer_set_freq(ptimer, 2000000000);
+    ptimer_set_limit(ptimer, 8, 1);
+    ptimer_run(ptimer, 1);
+    ptimer_transaction_commit(ptimer);
+
+    qemu_clock_step(3);
+
+    g_assert_cmpuint(ptimer_get_count(ptimer), ==, no_round_down ? 3 : 2);
+    g_assert_false(triggered);
+
+    qemu_clock_step(1);
+
+    g_assert_cmpuint(ptimer_get_count(ptimer), ==, 0);
+    g_assert_true(triggered);
+
+    ptimer_free(ptimer);
+}
+
 static void add_ptimer_tests(uint8_t policy)
 {
     char policy_name[256] = "";
@@ -857,6 +884,12 @@ static void add_ptimer_tests(uint8_t policy)
                               policy_name),
         g_memdup2(&policy, 1), check_oneshot_with_load_0, g_free);
     g_free(tmp);
+
+    g_test_add_data_func_full(
+        tmp = g_strdup_printf("/ptimer/freq_more_than_1000M policy=%s",
+                              policy_name),
+        g_memdup2(&policy, 1), check_freq_more_than_1000M, g_free);
+    g_free(tmp);
 }
 
 static void add_all_ptimer_policies_comb_tests(void)
-- 
2.39.2


