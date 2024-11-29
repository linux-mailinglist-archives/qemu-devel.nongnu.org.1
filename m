Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EA09D1A2F
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Nov 2024 22:12:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD90G-00033y-3A; Mon, 18 Nov 2024 16:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tD8zT-0001w0-Ao; Mon, 18 Nov 2024 16:08:59 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tD8zR-0005PS-Cz; Mon, 18 Nov 2024 16:08:58 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C44B7A5610;
 Tue, 19 Nov 2024 00:08:31 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5D939173629;
 Tue, 19 Nov 2024 00:08:35 +0300 (MSK)
Received: (nullmailer pid 2366125 invoked by uid 1000);
 Mon, 18 Nov 2024 21:08:34 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.4 67/71] target/i386: fix hang when using slow path for
 ptw_setl
Date: Tue, 19 Nov 2024 00:08:24 +0300
Message-Id: <20241118210834.2366046-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.0.4-20241118223714@cover.tls.msk.ru>
References: <qemu-stable-9.0.4-20241118223714@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

When instrumenting memory accesses for plugin, we force memory accesses
to use the slow path for mmu [1]. This create a situation where we end
up calling ptw_setl_slow. This was fixed recently in [2] but the issue
still could appear out of plugins use case.

Since this function gets called during a cpu_exec, start_exclusive then
hangs. This exclusive section was introduced initially for security
reasons [3].

I suspect this code path was never triggered, because ptw_setl_slow
would always be called transitively from cpu_exec, resulting in a hang.

[1] https://gitlab.com/qemu-project/qemu/-/commit/6d03226b42247b68ab2f0b3663e0f624335a4055
[2] https://gitlab.com/qemu-project/qemu/-/commit/115ade42d50144c15b74368d32dc734ea277d853
[2] https://gitlab.com/qemu-project/qemu/-/commit/88442869cf709f885a9c09fad00b96f802d58ffe in 9.0.x series
[3] https://gitlab.com/qemu-project/qemu/-/issues/279

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2566
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241025175857.2554252-2-pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 7ba055b49b74c4d2f4a338c5198485bdff373fb1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: mention [2] in 9.0.x series)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index bdf7b0df42..44b1b2ded6 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -106,6 +106,10 @@ static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
 {
     uint32_t cmp;
 
+    CPUState *cpu = env_cpu(in->env);
+    /* We are in cpu_exec, and start_exclusive can't be called directly.*/
+    g_assert(cpu->running);
+    cpu_exec_end(cpu);
     /* Does x86 really perform a rmw cycle on mmio for ptw? */
     start_exclusive();
     cmp = cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
@@ -113,6 +117,7 @@ static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
         cpu_stl_mmuidx_ra(in->env, in->gaddr, new, in->ptw_idx, 0);
     }
     end_exclusive();
+    cpu_exec_start(cpu);
     return cmp == old;
 }
 
-- 
2.39.5


