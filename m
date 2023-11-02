Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C92B7DEA48
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:42:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMcY-000850-0R; Wed, 01 Nov 2023 21:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbM-0006iB-Nh
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:30 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbJ-0002B2-LI
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:27 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc7077d34aso3212445ad.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888863; x=1699493663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6DhUgnJx2bDPyCGWWiMXujGb/uA1mvQXQHcYK+Blx5U=;
 b=I5NYW8wBib7cTL4c7zkOBjcJ6jPxBqqA9o2xBIVD20y91m0mlWHHmfvDLjWF695tUd
 ZsR4VSIuGA6Nmf4l7gQRws9LuEZpEcsoJzU1DQVmo9dccWfvbBFVqnFIQb7quNP4jxx7
 wf+1eTvHphQhHhsMdsq+zPD/cy5qu+TVimr6pAyMmLt79yuC97fqKkCuTB3YIa2wtLf4
 z2qQxDKdzYa0hmDjysZk+Y51S6Z/XvdSDRWq3ideyxUds001TzIieS5mHv5aYMiNDFpL
 iI/aq1pgEgjZFERCtOLXStTWFM31hUbwpgBxhMR2F4L4WBrqAte8fttpjLZcGavAmnL2
 GHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888863; x=1699493663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6DhUgnJx2bDPyCGWWiMXujGb/uA1mvQXQHcYK+Blx5U=;
 b=iCqN9XcfrrGqRBNb16W1E0VJP01iIrORHwi83a67YNHZUkQ3nUKf1GfDQWMqu7Q45u
 fpPqa6dDdDVY11cyZRL+KZ3I3j/1V3ap3ZrmU4yq9/uQfmapXZoPcXnDsLI/3nygm1wb
 ppymobhhMazisAyQV/vDDTZdBzKfbG0y1VZjU97+OqbB/hkpWyHf8ym4NjN5zE8jljZw
 oaaKK5nRuW7NMKDzE6/1zWwtTSm/YPwlJEEhRqUQEpSmLV8FNfxDI/de6w5cJsNLPzxZ
 TR8oAYN0jMK3osugCHP8id18OYOt5Isuelu6VPCYbrq6Twect9/C8L5+HJzF8j68ThM6
 kWZw==
X-Gm-Message-State: AOJu0Yx9Fk7S5ZvuUPM+7e8N1nSDGcVjXTX80dt9Jj9NIaBXHEHhEBjA
 V7kcQHBUpbis0fm+sr/FFkSXR3YdfGzH0rxwYEU=
X-Google-Smtp-Source: AGHT+IH13xV/qsiLmmNdycpLpMfYOQ2ZDzN3qaN7VFnTAxB9NgyFBj8gd0lAT4/vDdM/vM2b4iXPhA==
X-Received: by 2002:a17:902:d4c3:b0:1cc:5aef:f2d2 with SMTP id
 o3-20020a170902d4c300b001cc5aeff2d2mr9480172plg.60.1698888862712; 
 Wed, 01 Nov 2023 18:34:22 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 77/88] target/hppa: Add pa2.0 cpu local tlb flushes
Date: Wed,  1 Nov 2023 18:30:05 -0700
Message-Id: <20231102013016.369010-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
index c5f1db574b..c38539c76e 100644
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
index 0883b146a9..d9595c5c7c 100644
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


