Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A778C2E9E
	for <lists+qemu-devel@lfdr.de>; Sat, 11 May 2024 03:50:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5bpj-0007Zn-UK; Fri, 10 May 2024 21:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5box-0005DB-Jy; Fri, 10 May 2024 21:46:46 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5boo-0003c0-TG; Fri, 10 May 2024 21:46:43 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 74B1F4E677C;
 Sat, 11 May 2024 03:46:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id duayewdYu6cP; Sat, 11 May 2024 03:46:11 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 893424E6778; Sat, 11 May 2024 03:46:11 +0200 (CEST)
Message-Id: <1ab4666839e1027d122e3e0bde074b9c38314c68.1715390232.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715390232.git.balaton@eik.bme.hu>
References: <cover.1715390232.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 31/48] target/ppc: Split off common embedded TLB init
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Sat, 11 May 2024 03:46:11 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Several 4xx CPUs and e200 share the same TLB settings enclosed in an
ifdef. Split it off in a common function to reduce code duplication
and the number of ifdefs.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 46 ++++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 07ad788e54..92c71b2a09 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2107,18 +2107,22 @@ static int check_pow_hid0_74xx(CPUPPCState *env)
     return 0;
 }
 
+static void init_tlbs_emb(CPUPPCState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    env->nb_tlb = 64;
+    env->nb_ways = 1;
+    env->tlb_type = TLB_EMB;
+#endif
+}
+
 static void init_proc_405(CPUPPCState *env)
 {
     register_40x_sprs(env);
     register_405_sprs(env);
     register_usprgh_sprs(env);
 
-    /* Memory management */
-#if !defined(CONFIG_USER_ONLY)
-    env->nb_tlb = 64;
-    env->nb_ways = 1;
-    env->tlb_type = TLB_EMB;
-#endif
+    init_tlbs_emb(env);
     init_excp_4xx(env);
     env->dcache_line_size = 32;
     env->icache_line_size = 32;
@@ -2185,12 +2189,8 @@ static void init_proc_440EP(CPUPPCState *env)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
                  0x00000000);
-    /* Memory management */
-#if !defined(CONFIG_USER_ONLY)
-    env->nb_tlb = 64;
-    env->nb_ways = 1;
-    env->tlb_type = TLB_EMB;
-#endif
+
+    init_tlbs_emb(env);
     init_excp_BookE(env);
     env->dcache_line_size = 32;
     env->icache_line_size = 32;
@@ -2282,12 +2282,7 @@ static void init_proc_440GP(CPUPPCState *env)
     register_440_sprs(env);
     register_usprgh_sprs(env);
 
-    /* Memory management */
-#if !defined(CONFIG_USER_ONLY)
-    env->nb_tlb = 64;
-    env->nb_ways = 1;
-    env->tlb_type = TLB_EMB;
-#endif
+    init_tlbs_emb(env);
     init_excp_BookE(env);
     env->dcache_line_size = 32;
     env->icache_line_size = 32;
@@ -2355,12 +2350,8 @@ static void init_proc_440x5(CPUPPCState *env)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
                  0x00000000);
-    /* Memory management */
-#if !defined(CONFIG_USER_ONLY)
-    env->nb_tlb = 64;
-    env->nb_ways = 1;
-    env->tlb_type = TLB_EMB;
-#endif
+
+    init_tlbs_emb(env);
     init_excp_BookE(env);
     env->dcache_line_size = 32;
     env->icache_line_size = 32;
@@ -2717,11 +2708,8 @@ static void init_proc_e200(CPUPPCState *env)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
                  0x00000000);
-#if !defined(CONFIG_USER_ONLY)
-    env->nb_tlb = 64;
-    env->nb_ways = 1;
-    env->tlb_type = TLB_EMB;
-#endif
+
+    init_tlbs_emb(env);
     init_excp_e200(env, 0xFFFF0000UL);
     env->dcache_line_size = 32;
     env->icache_line_size = 32;
-- 
2.30.9


