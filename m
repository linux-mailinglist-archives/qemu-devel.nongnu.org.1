Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 844E2A21704
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Jan 2025 05:09:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tczN2-0001Md-TK; Tue, 28 Jan 2025 23:08:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tczMe-0001MJ-RC
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 23:07:45 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tczMc-0004HI-Ey
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 23:07:44 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EB6205C01DA;
 Wed, 29 Jan 2025 04:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20CCC4CED3;
 Wed, 29 Jan 2025 04:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738123658;
 bh=DapCS/Lwt6yEz8EDtPldxl8Gd28zVQ+LiiwMOkAfJpU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qIaM4l0o0r+0y1Aqe1eKitZD9/NPRRTWTq+nXrshMRPIUQMt8XSHkVqQS9OzqMOM/
 Civ42X+TBkO5TlwUpVVJ8bx+0BG5OrsBhmU9BYCWVH1P2EQLC8sSY9sIRvuq0om/DC
 67uJb4R/R0iDllLXCSJUHOZ6PXXdtBVbk3SDgUC0jxGyA4B7qZ6bpGOwn6NuMWrQq7
 X9Qiu4tSbvLORjPutWZS7df3fBZnoWx8XBov3YHd52tnhjF9Al7DF4RC13mYxfVtPl
 wEQmb18xHL3w6We2CyhmEVNggouTqfNbKGj7aTxf8MRxHyr4UC4LbPTbZOtKRYd+wl
 OC+V31deXn6/Q==
Date: Wed, 29 Jan 2025 05:07:35 +0100
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH 4/4] target/hppa: Implement space register hashing for
 64-bit HP-UX
Message-ID: <Z5mph0gdQHbCsKit@p100>
References: <20250128224817.24715-1-deller@kernel.org>
 <20250128224817.24715-5-deller@kernel.org>
 <34f4e42f-b08a-42dd-ad11-f720f6d8a440@linaro.org>
 <6f445eb1-2626-4a08-abbb-580cdd7fe682@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f445eb1-2626-4a08-abbb-580cdd7fe682@linaro.org>
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

* Richard Henderson <richard.henderson@linaro.org>:
> On 1/28/25 17:52, Richard Henderson wrote:
> > On 1/28/25 14:45, deller@kernel.org wrote:
> > > +��� if (ctx->is_pa20 && (a->dr == 2)) {
> > > +������� /* Exit TB to recalculate gva_offset_mask on %dr2 */
> > > +������� ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
> > > +��� }
> > 
> > Where does this update happen?� I think you've missed that step.
> 
> To expand on this, I believe you want a new helper, invoked here, which
> calls update_gva_offset_mask().  Then exit the tb as you do above.
> 
> We don't really have to go back to the main loop, but we can't chain with
> DISAS_IAQ_N_STALE either.  We'd have to invent another DISAS thingy for an
> exact fit.  For something that's probably called once at boot and never
> again, it hardly seems worth the effort.

I adjusted it, please see current patch version at the end of the mail.

What I'm not sure about is gva_offset_mask in those hunks and where you
said I can't read from env:

+++ b/target/hppa/translate.c
@@ -73,6 +73,7 @@ typedef struct DisasContext {
 
     /* IAOQ_Front at entry to TB. */
     uint64_t iaoq_first;
+    uint64_t gva_offset_mask;
 
     DisasCond null_cond;
     TCGLabel *null_lab;
@@ -1577,7 +1578,7 @@ static void form_gva(DisasContext *ctx, TCGv_i64 *pgva, TCGv_i64 *pofs,
     *pofs = ofs;
     *pgva = addr = tcg_temp_new_i64();
     tcg_gen_andi_i64(addr, modify <= 0 ? ofs : base,
-                     gva_offset_mask(ctx->tb_flags));
+                     ctx->gva_offset_mask);
 #ifndef CONFIG_USER_ONLY
     if (!is_phys) {
         tcg_gen_or_i64(addr, addr, space_select(ctx, sp, base));
@@ -4635,6 +4641,7 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->tb_flags = ctx->base.tb->flags;
     ctx->is_pa20 = hppa_is_pa20(cpu_env(cs));
     ctx->psw_xb = ctx->tb_flags & (PSW_X | PSW_B);
+    ctx->gva_offset_mask = cpu_env(cs)->gva_offset_mask;
 
Do I need to change the code in form_gva() to read at runtime from env
instead?

Helge








Current patch:

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index c86f9190d2..c64495332f 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -45,8 +45,9 @@ static vaddr hppa_cpu_get_pc(CPUState *cs)
 {
     CPUHPPAState *env = cpu_env(cs);
 
-    return hppa_form_gva_psw(env->psw, (env->psw & PSW_C ? env->iasq_f : 0),
-                             env->iaoq_f & -4);
+    return hppa_form_gva_mask(env->gva_offset_mask,
+                         (env->psw & PSW_C ? env->iasq_f : 0),
+                         env->iaoq_f & -4);
 }
 
 void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index b858986c41..52dc6ec700 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -223,6 +223,7 @@ typedef struct CPUArchState {
     target_ulong psw_cb;     /* in least significant bit of next nibble */
     target_ulong psw_cb_msb; /* boolean */
 
+    uint64_t gva_offset_mask; /* cached address mask based on PSW and %dr2 */
     uint64_t iasq_f;
     uint64_t iasq_b;
 
@@ -320,27 +321,20 @@ void hppa_translate_code(CPUState *cs, TranslationBlock *tb,
 
 #define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
 
-static inline uint64_t gva_offset_mask(target_ulong psw)
-{
-    return (psw & PSW_W
-            ? MAKE_64BIT_MASK(0, 62)
-            : MAKE_64BIT_MASK(0, 32));
-}
-
-static inline target_ulong hppa_form_gva_psw(target_ulong psw, uint64_t spc,
-                                             target_ulong off)
+static inline target_ulong hppa_form_gva_mask(uint64_t gva_offset_mask,
+                                        uint64_t spc, target_ulong off)
 {
 #ifdef CONFIG_USER_ONLY
-    return off & gva_offset_mask(psw);
+    return off & gva_offset_mask;
 #else
-    return spc | (off & gva_offset_mask(psw));
+    return spc | (off & gva_offset_mask);
 #endif
 }
 
 static inline target_ulong hppa_form_gva(CPUHPPAState *env, uint64_t spc,
                                          target_ulong off)
 {
-    return hppa_form_gva_psw(env->psw, spc, off);
+    return hppa_form_gva_mask(env->gva_offset_mask, spc, off);
 }
 
 hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr);
@@ -362,6 +356,7 @@ void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
 
 target_ulong cpu_hppa_get_psw(CPUHPPAState *env);
 void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong);
+void update_gva_offset_mask(CPUHPPAState *env);
 void cpu_hppa_loaded_fr0(CPUHPPAState *env);
 
 #ifdef CONFIG_USER_ONLY
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index d4b1a3cd5a..ac7f58f0af 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -24,6 +24,7 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "qemu/qemu-print.h"
+#include "hw/hppa/hppa_hardware.h"
 
 target_ulong cpu_hppa_get_psw(CPUHPPAState *env)
 {
@@ -59,6 +60,22 @@ target_ulong cpu_hppa_get_psw(CPUHPPAState *env)
     return psw;
 }
 
+void update_gva_offset_mask(CPUHPPAState *env)
+{
+    uint64_t gom;
+
+    if (env->psw & PSW_W) {
+        gom = (env->dr[2] & HPPA64_DIAG_SPHASH_ENABLE)
+            ? MAKE_64BIT_MASK(0, 62) &
+                ~((uint64_t)HPPA64_PDC_CACHE_RET_SPID_VAL << 48)
+            : MAKE_64BIT_MASK(0, 62);
+    } else {
+        gom = MAKE_64BIT_MASK(0, 32);
+    }
+
+    env->gva_offset_mask = gom;
+}
+
 void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong psw)
 {
     uint64_t reserved;
@@ -98,6 +115,8 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong psw)
     cb |= ((psw >>  9) & 1) <<  8;
     cb |= ((psw >>  8) & 1) <<  4;
     env->psw_cb = cb;
+
+    update_gva_offset_mask(env);
 }
 
 void hppa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
@@ -133,9 +152,11 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, "IA_F %08" PRIx64 ":%0*" PRIx64 " (" TARGET_FMT_lx ")\n"
                     "IA_B %08" PRIx64 ":%0*" PRIx64 " (" TARGET_FMT_lx ")\n",
                  env->iasq_f >> 32, w, m & env->iaoq_f,
-                 hppa_form_gva_psw(psw, env->iasq_f, env->iaoq_f),
+                 hppa_form_gva_mask(env->gva_offset_mask, env->iasq_f,
+				    env->iaoq_f),
                  env->iasq_b >> 32, w, m & env->iaoq_b,
-                 hppa_form_gva_psw(psw, env->iasq_b, env->iaoq_b));
+                 hppa_form_gva_mask(env->gva_offset_mask, env->iasq_b,
+				    env->iaoq_b));
 
     psw_c[0]  = (psw & PSW_W ? 'W' : '-');
     psw_c[1]  = (psw & PSW_E ? 'E' : '-');
diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index de411923d9..8369855d78 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -99,6 +99,7 @@ DEF_HELPER_FLAGS_2(ptlb_l, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_1(ptlbe, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(lpa, TCG_CALL_NO_WG, tl, env, tl)
 DEF_HELPER_FLAGS_1(change_prot_id, TCG_CALL_NO_RWG, void, env)
+DEF_HELPER_FLAGS_1(update_gva_offset_mask, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_1(diag_btlb, void, env)
 DEF_HELPER_1(diag_console_output, void, env)
 #endif
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 58695def82..7d48643bb6 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -94,11 +94,12 @@ void hppa_cpu_do_interrupt(CPUState *cs)
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
     int i = cs->exception_index;
-    uint64_t old_psw;
+    uint64_t old_psw, old_gva_offset_mask;
 
     /* As documented in pa2.0 -- interruption handling.  */
     /* step 1 */
     env->cr[CR_IPSW] = old_psw = cpu_hppa_get_psw(env);
+    old_gva_offset_mask = env->gva_offset_mask;
 
     /* step 2 -- Note PSW_W is masked out again for pa1.x */
     cpu_hppa_put_psw(env,
@@ -112,9 +113,9 @@ void hppa_cpu_do_interrupt(CPUState *cs)
      */
     if (old_psw & PSW_C) {
         env->cr[CR_IIASQ] =
-            hppa_form_gva_psw(old_psw, env->iasq_f, env->iaoq_f) >> 32;
+            hppa_form_gva_mask(old_gva_offset_mask, env->iasq_f, env->iaoq_f) >> 32;
         env->cr_back[0] =
-            hppa_form_gva_psw(old_psw, env->iasq_b, env->iaoq_b) >> 32;
+            hppa_form_gva_mask(old_gva_offset_mask, env->iasq_b, env->iaoq_b) >> 32;
     } else {
         env->cr[CR_IIASQ] = 0;
         env->cr_back[0] = 0;
@@ -165,7 +166,8 @@ void hppa_cpu_do_interrupt(CPUState *cs)
                 if (old_psw & PSW_C) {
                     int prot, t;
 
-                    vaddr = hppa_form_gva_psw(old_psw, env->iasq_f, vaddr);
+                    vaddr = hppa_form_gva_mask(old_gva_offset_mask,
+					       env->iasq_f, vaddr);
                     t = hppa_get_physical_address(env, vaddr, MMU_KERNEL_IDX,
                                                   0, 0, &paddr, &prot);
                     if (t >= 0) {
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index b8c3e55170..304f0b61e2 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -824,3 +824,8 @@ uint64_t HELPER(b_gate_priv)(CPUHPPAState *env, uint64_t iaoq_f)
     }
     return iaoq_f;
 }
+
+void HELPER(update_gva_offset_mask)(CPUHPPAState *env)
+{
+    update_gva_offset_mask(env);
+}
diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index da5b569de8..052a6a88a2 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -73,7 +73,7 @@ target_ulong HELPER(swap_system_mask)(CPUHPPAState *env, target_ulong nsm)
      * machines set the Q bit from 0 to 1 without an exception,
      * so let this go without comment.
      */
-    env->psw = (psw & ~PSW_SM) | (nsm & PSW_SM);
+    cpu_hppa_put_psw(env, (psw & ~PSW_SM) | (nsm & PSW_SM));
     return psw & PSW_SM;
 }
 
@@ -88,7 +88,7 @@ void HELPER(rfi)(CPUHPPAState *env)
      * To recreate the space identifier, remove the offset bits.
      * For pa1.x, the mask reduces to no change to space.
      */
-    mask = gva_offset_mask(env->psw);
+    mask = env->gva_offset_mask;
 
     env->iaoq_f = env->cr[CR_IIAOQ];
     env->iaoq_b = env->cr_back[1];
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 7b9d3deb39..5508c55378 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -73,6 +73,7 @@ typedef struct DisasContext {
 
     /* IAOQ_Front at entry to TB. */
     uint64_t iaoq_first;
+    uint64_t gva_offset_mask;
 
     DisasCond null_cond;
     TCGLabel *null_lab;
@@ -1577,7 +1578,7 @@ static void form_gva(DisasContext *ctx, TCGv_i64 *pgva, TCGv_i64 *pofs,
     *pofs = ofs;
     *pgva = addr = tcg_temp_new_i64();
     tcg_gen_andi_i64(addr, modify <= 0 ? ofs : base,
-                     gva_offset_mask(ctx->tb_flags));
+                     ctx->gva_offset_mask);
 #ifndef CONFIG_USER_ONLY
     if (!is_phys) {
         tcg_gen_or_i64(addr, addr, space_select(ctx, sp, base));
@@ -4615,6 +4616,11 @@ static bool trans_diag_mtdiag(DisasContext *ctx, arg_diag_mtdiag *a)
     nullify_over(ctx);
     tcg_gen_st_i64(load_gpr(ctx, a->r1), tcg_env,
                         offsetof(CPUHPPAState, dr[a->dr]));
+    if (ctx->is_pa20 && (a->dr == 2)) {
+        gen_helper_update_gva_offset_mask(tcg_env);
+        /* Exit TB to recalculate gva_offset_mask on %dr2 */
+        ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
+    }
     return nullify_end(ctx);
 }
 
@@ -4635,6 +4641,7 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->tb_flags = ctx->base.tb->flags;
     ctx->is_pa20 = hppa_is_pa20(cpu_env(cs));
     ctx->psw_xb = ctx->tb_flags & (PSW_X | PSW_B);
+    ctx->gva_offset_mask = cpu_env(cs)->gva_offset_mask;
 
 #ifdef CONFIG_USER_ONLY
     ctx->privilege = PRIV_USER;

