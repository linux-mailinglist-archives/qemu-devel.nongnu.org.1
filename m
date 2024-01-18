Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C2B831396
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:59:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQNHH-0002Nf-7L; Thu, 18 Jan 2024 02:57:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNH0-0001wF-6J; Thu, 18 Jan 2024 02:57:15 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNGy-000817-36; Thu, 18 Jan 2024 02:57:13 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 345C34504E;
 Thu, 18 Jan 2024 10:54:37 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5F164661B6;
 Thu, 18 Jan 2024 10:54:07 +0300 (MSK)
Received: (nullmailer pid 2381735 invoked by uid 1000);
 Thu, 18 Jan 2024 07:54:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 35/38] target/hppa: Export function
 hppa_set_ior_and_isr()
Date: Thu, 18 Jan 2024 10:53:02 +0300
Message-Id: <20240118075404.2381519-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
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

From: Helge Deller <deller@gmx.de>

Move functionality to set IOR and ISR on fault into own
function. This will be used by follow-up patches.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 3824e0d643f34ee09e0cc75190c0c4b60928b78c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 8be45c69c9..9556e95fab 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -385,6 +385,7 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f, int);
 #ifndef CONFIG_USER_ONLY
 void hppa_ptlbe(CPUHPPAState *env);
 hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr);
+void hppa_set_ior_and_isr(CPUHPPAState *env, vaddr addr, bool mmu_disabled);
 bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool probe, uintptr_t retaddr);
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 1387f4a64b..4fcc612754 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -305,14 +305,8 @@ hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     return excp == EXCP_DTLB_MISS ? -1 : phys;
 }
 
-G_NORETURN static void
-raise_exception_with_ior(CPUHPPAState *env, int excp, uintptr_t retaddr,
-                         vaddr addr, bool mmu_disabled)
+void hppa_set_ior_and_isr(CPUHPPAState *env, vaddr addr, bool mmu_disabled)
 {
-    CPUState *cs = env_cpu(env);
-
-    cs->exception_index = excp;
-
     if (env->psw & PSW_Q) {
         /*
          * For pa1.x, the offset and space never overlap, and so we
@@ -339,16 +333,23 @@ raise_exception_with_ior(CPUHPPAState *env, int excp, uintptr_t retaddr,
                  */
                 uint64_t b;
 
-                cpu_restore_state(cs, retaddr);
-
                 b = env->unwind_breg ? env->gr[env->unwind_breg] : 0;
                 b >>= (env->psw & PSW_W ? 62 : 30);
                 env->cr[CR_IOR] |= b << 62;
-
-                cpu_loop_exit(cs);
             }
         }
     }
+}
+
+G_NORETURN static void
+raise_exception_with_ior(CPUHPPAState *env, int excp, uintptr_t retaddr,
+                         vaddr addr, bool mmu_disabled)
+{
+    CPUState *cs = env_cpu(env);
+
+    cs->exception_index = excp;
+    hppa_set_ior_and_isr(env, addr, mmu_disabled);
+
     cpu_loop_exit_restore(cs, retaddr);
 }
 
-- 
2.39.2


