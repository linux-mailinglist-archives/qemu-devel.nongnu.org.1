Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F23791456
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:07:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5YB-0001sK-E1; Mon, 04 Sep 2023 05:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Y5-0001gy-3u; Mon, 04 Sep 2023 05:07:10 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Y2-0003f7-Qb; Mon, 04 Sep 2023 05:07:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RfN7F5x2sz4wxW;
 Mon,  4 Sep 2023 19:07:05 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfN7D01ptz4wy8;
 Mon,  4 Sep 2023 19:07:03 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 11/35] hw/ppc/ppc.c: Tidy over-long lines
Date: Mon,  4 Sep 2023 11:06:06 +0200
Message-ID: <20230904090630.725952-12-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904090630.725952-1-clg@kaod.org>
References: <20230904090630.725952-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=kZzc=EU=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ppc/ppc.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 0e0a3d93c3bf..09b82f68a84e 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -497,7 +497,8 @@ uint64_t cpu_ppc_load_tbl (CPUPPCState *env)
         return env->spr[SPR_TBL];
     }
 
-    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tb_env->tb_offset);
+    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                        tb_env->tb_offset);
     trace_ppc_tb_load(tb);
 
     return tb;
@@ -508,7 +509,8 @@ static inline uint32_t _cpu_ppc_load_tbu(CPUPPCState *env)
     ppc_tb_t *tb_env = env->tb_env;
     uint64_t tb;
 
-    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tb_env->tb_offset);
+    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                        tb_env->tb_offset);
     trace_ppc_tb_load(tb);
 
     return tb >> 32;
@@ -565,7 +567,8 @@ uint64_t cpu_ppc_load_atbl (CPUPPCState *env)
     ppc_tb_t *tb_env = env->tb_env;
     uint64_t tb;
 
-    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tb_env->atb_offset);
+    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                        tb_env->atb_offset);
     trace_ppc_tb_load(tb);
 
     return tb;
@@ -576,7 +579,8 @@ uint32_t cpu_ppc_load_atbu (CPUPPCState *env)
     ppc_tb_t *tb_env = env->tb_env;
     uint64_t tb;
 
-    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tb_env->atb_offset);
+    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                        tb_env->atb_offset);
     trace_ppc_tb_load(tb);
 
     return tb >> 32;
@@ -1040,10 +1044,11 @@ clk_setup_cb cpu_ppc_tb_init (CPUPPCState *env, uint32_t freq)
         tb_env->flags |= PPC_DECR_UNDERFLOW_LEVEL;
     }
     /* Create new timer */
-    tb_env->decr_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &cpu_ppc_decr_cb, cpu);
+    tb_env->decr_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                      &cpu_ppc_decr_cb, cpu);
     if (env->has_hv_mode && !cpu->vhyp) {
-        tb_env->hdecr_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &cpu_ppc_hdecr_cb,
-                                                cpu);
+        tb_env->hdecr_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                           &cpu_ppc_hdecr_cb, cpu);
     } else {
         tb_env->hdecr_timer = NULL;
     }
-- 
2.41.0


