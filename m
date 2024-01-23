Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE4283897E
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 09:50:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSCSa-0001MF-UU; Tue, 23 Jan 2024 03:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSCSX-0001LG-VZ; Tue, 23 Jan 2024 03:48:41 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSCSV-0004tg-FN; Tue, 23 Jan 2024 03:48:41 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 80DF24666F;
 Tue, 23 Jan 2024 11:49:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 42B06699ED;
 Tue, 23 Jan 2024 11:48:31 +0300 (MSK)
Received: (nullmailer pid 3828105 invoked by uid 1000);
 Tue, 23 Jan 2024 08:48:31 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.9 10/20] target/i386: Fix 32-bit wrapping of pc/eip
 computation
Date: Tue, 23 Jan 2024 11:48:20 +0300
Message-Id: <20240123084831.3828060-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.9-20240123114733@cover.tls.msk.ru>
References: <qemu-stable-7.2.9-20240123114733@cover.tls.msk.ru>
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

From: Richard Henderson <richard.henderson@linaro.org>

In 32-bit mode, pc = eip + cs_base is also 32-bit, and must wrap.
Failure to do so results in incorrect memory exceptions to the guest.
Before 732d548732ed, this was implicitly done via truncation to
target_ulong but only in qemu-system-i386, not qemu-system-x86_64.

To fix this, we must add conditional zero-extensions.
Since we have to test for 32 vs 64-bit anyway, note that cs_base
is always zero in 64-bit mode.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2022
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20231212172510.103305-1-richard.henderson@linaro.org>
(cherry picked from commit b5e0d5d22fbffc3d8f7d3e86d7a2d05a1a974e27)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: context fix in target/i386/tcg/tcg-cpu.c for v8.1.0-1190-gb77af26e97
 "accel/tcg: Replace CPUState.env_ptr with cpu_env()")
(Mjt: fixup in target/i386/tcg/tcg-cpu.c for v7.2.0-1854-g34a39c2443
 "target/i386: Replace `tb_pc()` with `tb->pc`")

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index d4bc19577a..f67cee477a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2217,10 +2217,15 @@ static inline int cpu_mmu_index_kernel(CPUX86State *env)
 static inline void cpu_get_tb_cpu_state(CPUX86State *env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
 {
-    *cs_base = env->segs[R_CS].base;
-    *pc = *cs_base + env->eip;
     *flags = env->hflags |
         (env->eflags & (IOPL_MASK | TF_MASK | RF_MASK | VM_MASK | AC_MASK));
+    if (env->hflags & HF_CS64_MASK) {
+        *cs_base = 0;
+        *pc = env->eip;
+    } else {
+        *cs_base = env->segs[R_CS].base;
+        *pc = (uint32_t)(*cs_base + env->eip);
+    }
 }
 
 void do_cpu_init(X86CPU *cpu);
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 79ac5908f7..563f42ee4e 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -52,7 +52,12 @@ static void x86_cpu_synchronize_from_tb(CPUState *cs,
     /* The instruction pointer is always up to date with TARGET_TB_PCREL. */
     if (!TARGET_TB_PCREL) {
         CPUX86State *env = cs->env_ptr;
-        env->eip = tb_pc(tb) - tb->cs_base;
+
+        if (tb->flags & HF_CS64_MASK) {
+            env->eip = tb_pc(tb);
+        } else {
+            env->eip = (uint32_t)(tb_pc(tb) - tb->cs_base);
+        }
     }
 }
 
@@ -66,8 +71,10 @@ static void x86_restore_state_to_opc(CPUState *cs,
 
     if (TARGET_TB_PCREL) {
         env->eip = (env->eip & TARGET_PAGE_MASK) | data[0];
+    } else if (tb->flags & HF_CS64_MASK) {
+        env->eip = data[0];
     } else {
-        env->eip = data[0] - tb->cs_base;
+        env->eip = (uint32_t)(data[0] - tb->cs_base);
     }
     if (cc_op != CC_OP_DYNAMIC) {
         env->cc_op = cc_op;
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 7e0b2a709a..15b030d84b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -547,8 +547,10 @@ static void gen_update_eip_cur(DisasContext *s)
     assert(s->pc_save != -1);
     if (TARGET_TB_PCREL) {
         tcg_gen_addi_tl(cpu_eip, cpu_eip, s->base.pc_next - s->pc_save);
+    } else if (CODE64(s)) {
+        tcg_gen_movi_tl(cpu_eip, s->base.pc_next);
     } else {
-        tcg_gen_movi_tl(cpu_eip, s->base.pc_next - s->cs_base);
+        tcg_gen_movi_tl(cpu_eip, (uint32_t)(s->base.pc_next - s->cs_base));
     }
     s->pc_save = s->base.pc_next;
 }
@@ -558,8 +560,10 @@ static void gen_update_eip_next(DisasContext *s)
     assert(s->pc_save != -1);
     if (TARGET_TB_PCREL) {
         tcg_gen_addi_tl(cpu_eip, cpu_eip, s->pc - s->pc_save);
+    } else if (CODE64(s)) {
+        tcg_gen_movi_tl(cpu_eip, s->base.pc_next);
     } else {
-        tcg_gen_movi_tl(cpu_eip, s->pc - s->cs_base);
+        tcg_gen_movi_tl(cpu_eip, (uint32_t)(s->base.pc_next - s->cs_base));
     }
     s->pc_save = s->pc;
 }
@@ -605,8 +609,10 @@ static TCGv eip_next_tl(DisasContext *s)
         TCGv ret = tcg_temp_new();
         tcg_gen_addi_tl(ret, cpu_eip, s->pc - s->pc_save);
         return ret;
+    } else if (CODE64(s)) {
+        return tcg_constant_tl(s->pc);
     } else {
-        return tcg_constant_tl(s->pc - s->cs_base);
+        return tcg_constant_tl((uint32_t)(s->pc - s->cs_base));
     }
 }
 
@@ -617,8 +623,10 @@ static TCGv eip_cur_tl(DisasContext *s)
         TCGv ret = tcg_temp_new();
         tcg_gen_addi_tl(ret, cpu_eip, s->base.pc_next - s->pc_save);
         return ret;
+    } else if (CODE64(s)) {
+        return tcg_constant_tl(s->base.pc_next);
     } else {
-        return tcg_constant_tl(s->base.pc_next - s->cs_base);
+        return tcg_constant_tl((uint32_t)(s->base.pc_next - s->cs_base));
     }
 }
 
@@ -2875,6 +2883,10 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
         }
     }
     new_eip &= mask;
+    new_pc = new_eip + s->cs_base;
+    if (!CODE64(s)) {
+        new_pc = (uint32_t)new_pc;
+    }
 
     gen_update_cc_op(s);
     set_cc_op(s, CC_OP_DYNAMIC);
@@ -2892,8 +2904,7 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
         }
     }
 
-    if (use_goto_tb &&
-        translator_use_goto_tb(&s->base, new_eip + s->cs_base)) {
+    if (use_goto_tb && translator_use_goto_tb(&s->base, new_pc)) {
         /* jump to same page: we can use a direct jump */
         tcg_gen_goto_tb(tb_num);
         if (!TARGET_TB_PCREL) {
-- 
2.39.2


