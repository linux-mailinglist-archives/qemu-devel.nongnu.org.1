Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B16E7E33E6
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:14:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRv-0005mZ-B9; Mon, 06 Nov 2023 22:08:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRm-0005Lr-SQ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:11 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRh-0001SX-Uc
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:10 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1ccbb7f79cdso14873915ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326484; x=1699931284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fx5PVYgkzONHTrx9HhmWBx4agYvNtL8/PELtgHgITdc=;
 b=Np+PR9mZXfXrFaiMkBJ2vGQ/wVXEKaweCcJTMS9Vw8uYX+CKGj7OmznAnThg066t6P
 p9gVRkPX1ItBrkjRaMAuGo+OhdZAAfeLv6DdtKbffEqcAw20Ik4eitmMSfjjd70Yo3lp
 VY89DFQH8pcHGilxNguoi5g4RXru5RsoUIjsbYN2eH2k6qSF09YITexXVbpJBrYUqmzg
 pcyJSbruDMs5aqiaGYoJ3kWIxPm6b0GNWF0OG5I4uE+smxa19GD5kDxrjTf1BIjQzylL
 KZLFwzHU4eWka/AZ/RDfwIjFiwiMp61w2C7wT5yvbQolw71rZZDFj1+7CVu0TEcOmSAe
 9SrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326484; x=1699931284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fx5PVYgkzONHTrx9HhmWBx4agYvNtL8/PELtgHgITdc=;
 b=KfwJKsSDsPPV0L4vx+MjdT0+h7dISnaHiVDjZVgvOxvhpuBf4XBWG/T/G45Z8DW0p7
 +AdcZYVJ/QQYkaRJ2vTo5SDHXc1m0mHnCjmHWKZnyhgEU5dxjdNeN+8cPp+JH+If1gDw
 00l1qSUBpsPDBOp9C8xxJqKTPwfhwzUZr7V8VEGwZO+9JYikbOkj/k8iRGAEkoxPUI5y
 lqjWlRbmqCnJEhB3dSu0d+aPrLsk5P+KRIUKjoj40wDA4L+2dklNYyrqpNhaS3J/zlP3
 ZcHTGZwcRLXHoXnMFAKZEOUZVxCPoaFPz2gKwYiBIDyAlx85qKBLMwkxlPtGSkX4SZfU
 Iomg==
X-Gm-Message-State: AOJu0YyhP6ncLUQFbXCNJTIRuNiz0a+Tf4wTJfjOMLbG+gO4wD8okBGm
 sFh5l/G7M5r1MfTwd37Z93ABEzEt4rq3ggxKVRE=
X-Google-Smtp-Source: AGHT+IE0TBDKDOD3ERjMtE/qBF6Tb4qtrRkSQH/lu49KgcpmWpNSfXnXq7p+9vQRiOqh26d7C7aSiQ==
X-Received: by 2002:a17:90b:1bd1:b0:280:8778:c4ab with SMTP id
 oa17-20020a17090b1bd100b002808778c4abmr4747760pjb.24.1699326484388; 
 Mon, 06 Nov 2023 19:08:04 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:08:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 75/85] target/hppa: Add pa2.0 cpu local tlb flushes
Date: Mon,  6 Nov 2023 19:03:57 -0800
Message-Id: <20231107030407.8979-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The previous decoding misnamed the bit it called "local".
Other than the name, the implementation was correct for pa1.x.
Rename this field to "tlbe".

PA2.0 adds (a real) local bit to PxTLB, and also adds a range
of pages to flush in GR[b].

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.h     |  1 +
 target/hppa/insns.decode | 20 ++++++++++++++---
 target/hppa/mem_helper.c | 26 ++++++++++++++++++----
 target/hppa/translate.c  | 48 +++++++++++++++++++++++++++++++++++-----
 target/hppa/trace-events |  1 +
 5 files changed, 84 insertions(+), 12 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index d586be3f15..20698f68ed 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -98,6 +98,7 @@ DEF_HELPER_FLAGS_3(itlbp_pa11, TCG_CALL_NO_RWG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(idtlbt_pa20, TCG_CALL_NO_RWG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(iitlbt_pa20, TCG_CALL_NO_RWG, void, env, tl, tl)
 DEF_HELPER_FLAGS_2(ptlb, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_FLAGS_2(ptlb_l, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_1(ptlbe, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(lpa, TCG_CALL_NO_WG, tl, env, tl)
 DEF_HELPER_FLAGS_1(change_prot_id, TCG_CALL_NO_RWG, void, env)
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 19e537df24..f5a3f02fd1 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -161,9 +161,23 @@ ixtlbxf         000001 00000 r:5 00 0 data:1 01000 addr:1 0 00000
 # pa2.0 tlb insert idtlbt and iitlbt instructions
 ixtlbt          000001 r2:5 r1:5 000 data:1 100000 0 00000    # idtlbt
 
-pxtlbx          000001 b:5 x:5 sp:2 0100100 local:1 m:1 -----   data=1
-pxtlbx          000001 b:5 x:5 ... 000100 local:1 m:1 -----     \
-                sp=%assemble_sr3x data=0
+# pdtlb, pitlb
+pxtlb           000001 b:5 x:5 sp:2 01001000 m:1 ----- \
+                &ldst disp=0 scale=0 size=0 t=0
+pxtlb           000001 b:5 x:5 ...   0001000 m:1 ----- \
+                &ldst disp=0 scale=0 size=0 t=0 sp=%assemble_sr3x
+
+# ... pa20 local
+pxtlb_l         000001 b:5 x:5 sp:2 01011000 m:1 ----- \
+                &ldst disp=0 scale=0 size=0 t=0
+pxtlb_l         000001 b:5 x:5 ...   0011000 m:1 ----- \
+                &ldst disp=0 scale=0 size=0 t=0 sp=%assemble_sr3x
+
+# pdtlbe, pitlbe
+pxtlbe          000001 b:5 x:5 sp:2 01001001 m:1 ----- \
+                &ldst disp=0 scale=0 size=0 t=0
+pxtlbe          000001 b:5 x:5 ...   0001001 m:1 ----- \
+                &ldst disp=0 scale=0 size=0 t=0 sp=%assemble_sr3x
 
 lpa             000001 b:5 x:5 sp:2 01001101 m:1 t:5    \
                 &ldst disp=0 scale=0 size=0
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 9be68b860b..7132ea221c 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -448,16 +448,34 @@ void HELPER(iitlbt_pa20)(CPUHPPAState *env, target_ulong r1, target_ulong r2)
     itlbt_pa20(env, r1, r2, va_b);
 }
 
-/* Purge (Insn/Data) TLB.  This is explicitly page-based, and is
-   synchronous across all processors.  */
+/* Purge (Insn/Data) TLB. */
 static void ptlb_work(CPUState *cpu, run_on_cpu_data data)
 {
     CPUHPPAState *env = cpu_env(cpu);
-    target_ulong addr = (target_ulong) data.target_ptr;
+    vaddr start = data.target_ptr;
+    vaddr end;
 
-    hppa_flush_tlb_range(env, addr, addr);
+    /*
+     * PA2.0 allows a range of pages encoded into GR[b], which we have
+     * copied into the bottom bits of the otherwise page-aligned address.
+     * PA1.x will always provide zero here, for a single page flush.
+     */
+    end = start & 0xf;
+    start &= TARGET_PAGE_MASK;
+    end = TARGET_PAGE_SIZE << (2 * end);
+    end = start + end - 1;
+
+    hppa_flush_tlb_range(env, start, end);
 }
 
+/* This is local to the current cpu. */
+void HELPER(ptlb_l)(CPUHPPAState *env, target_ulong addr)
+{
+    trace_hppa_tlb_ptlb_local(env);
+    ptlb_work(env_cpu(env), RUN_ON_CPU_TARGET_PTR(addr));
+}
+
+/* This is synchronous across all processors.  */
 void HELPER(ptlb)(CPUHPPAState *env, target_ulong addr)
 {
     CPUState *src = env_cpu(env);
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index e7f379d648..9f129a230b 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2320,7 +2320,7 @@ static bool trans_ixtlbx(DisasContext *ctx, arg_ixtlbx *a)
 #endif
 }
 
-static bool trans_pxtlbx(DisasContext *ctx, arg_pxtlbx *a)
+static bool do_pxtlb(DisasContext *ctx, arg_ldst *a, bool local)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
 #ifndef CONFIG_USER_ONLY
@@ -2330,15 +2330,53 @@ static bool trans_pxtlbx(DisasContext *ctx, arg_pxtlbx *a)
     nullify_over(ctx);
 
     form_gva(ctx, &addr, &ofs, a->b, a->x, 0, 0, a->sp, a->m, false);
-    if (a->m) {
-        save_gpr(ctx, a->b, ofs);
+
+    /*
+     * Page align now, rather than later, so that we can add in the
+     * page_size field from pa2.0 from the low 4 bits of GR[b].
+     */
+    tcg_gen_andi_i64(addr, addr, TARGET_PAGE_MASK);
+    if (ctx->is_pa20) {
+        tcg_gen_deposit_i64(addr, addr, load_gpr(ctx, a->b), 0, 4);
     }
-    if (a->local) {
-        gen_helper_ptlbe(tcg_env);
+
+    if (local) {
+        gen_helper_ptlb_l(tcg_env, addr);
     } else {
         gen_helper_ptlb(tcg_env, addr);
     }
 
+    if (a->m) {
+        save_gpr(ctx, a->b, ofs);
+    }
+
+    /* Exit TB for TLB change if mmu is enabled.  */
+    if (ctx->tb_flags & PSW_C) {
+        ctx->base.is_jmp = DISAS_IAQ_N_STALE;
+    }
+    return nullify_end(ctx);
+#endif
+}
+
+static bool trans_pxtlb(DisasContext *ctx, arg_ldst *a)
+{
+    return do_pxtlb(ctx, a, false);
+}
+
+static bool trans_pxtlb_l(DisasContext *ctx, arg_ldst *a)
+{
+    return ctx->is_pa20 && do_pxtlb(ctx, a, true);
+}
+
+static bool trans_pxtlbe(DisasContext *ctx, arg_ldst *a)
+{
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+#ifndef CONFIG_USER_ONLY
+    nullify_over(ctx);
+
+    trans_nop_addrx(ctx, a);
+    gen_helper_ptlbe(tcg_env);
+
     /* Exit TB for TLB change if mmu is enabled.  */
     if (ctx->tb_flags & PSW_C) {
         ctx->base.is_jmp = DISAS_IAQ_N_STALE;
diff --git a/target/hppa/trace-events b/target/hppa/trace-events
index 8931517890..a10ba73d5d 100644
--- a/target/hppa/trace-events
+++ b/target/hppa/trace-events
@@ -10,6 +10,7 @@ disable hppa_tlb_fill_success(void *env, uint64_t addr, uint64_t phys, int size,
 disable hppa_tlb_itlba(void *env, void *ent, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=%p ent=%p va_b=0x%lx va_e=0x%lx pa=0x%lx"
 disable hppa_tlb_itlbp(void *env, void *ent, int access_id, int u, int pl2, int pl1, int type, int b, int d, int t) "env=%p ent=%p access_id=%x u=%d pl2=%d pl1=%d type=%d b=%d d=%d t=%d"
 disable hppa_tlb_ptlb(void *env) "env=%p"
+disable hppa_tlb_ptlb_local(void *env) "env=%p"
 disable hppa_tlb_ptlbe(void *env) "env=%p"
 disable hppa_tlb_lpa_success(void *env, uint64_t addr, uint64_t phys) "env=%p addr=0x%lx phys=0x%lx"
 disable hppa_tlb_lpa_failed(void *env, uint64_t addr) "env=%p addr=0x%lx"
-- 
2.34.1


