Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFC77D177D
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:50:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwOw-0001of-D1; Fri, 20 Oct 2023 16:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOq-0001mZ-Ul
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:16 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOo-0001Ag-OQ
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:16 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6bd32d1a040so1216234b3a.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834833; x=1698439633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iceGonzdaVmnQSlk4xLAZNOj4sU0L4Dh8hQYUhsbnsk=;
 b=RUIZOgt8U72/28jbE5LeTnVldja5hDu+KRCmAazFLotW62Mg06DdUcPDJrPv2tZueO
 MYLdT61K+spYpaxr/yYyYU607dFkmLMjbDieMxrVxuNaAH2Qw0g1IZvYNmFal1ahQONr
 KlI8fZ5BBwD2VsR/jySAel5/MuGALJa+X/7n5es2zZ1HUineVuIK8NXyq46xGNRvsSr9
 cf/Jgvo4Tz5yvB2xxRDn6jXkMHEhXmGDM4lHapL49ucJ0PSmwAXrci9OiEPckRZrWteg
 Mq6dqVq09h6EUw7gEjrc86725Tk57VuKZqGn9XO77By92cQFlXQU3yePYXKyPKZVhcn0
 WT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834833; x=1698439633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iceGonzdaVmnQSlk4xLAZNOj4sU0L4Dh8hQYUhsbnsk=;
 b=NAyaXWPIK7yHSwAB+2f30yfjp9nV29FTGBwkZGN/Ill9ry6xg4LGcVoSkORGxIYjDc
 4nAD1RPjZNQt9fbuijDbKI49UWAEx4R1e87Ihpdf6XKeAlWCDxrilg7dvg6KaAQApvyK
 2pW/zAHnoODRxBMIsHlFZpwymyMYU3WcU1WOrc9g/Hr/KJ40JOLjFHsVfs3nEJTek69x
 /x/nlPZg97XwL76hK8tr5aBEWd0HBZGg6d/YGUiX3fSQNSyjvfExJ1GZO5hgtabJ9aV9
 lgeDevDvplq90HFf01cAAif00K8tFLfkFUs+SsKohYG6F++SxuzBF+j7l+4oEWJWoiTo
 FpSA==
X-Gm-Message-State: AOJu0Yy6g44+m/20metD0XJkH6eS6qIBSY3C6h1VWBfHakfI3iQkhbDa
 iycBqdygf66PSP2dKF5A4CRrxu6skbBnGjnWQaI=
X-Google-Smtp-Source: AGHT+IGIw8dsdh9CoEJColH8n+ld3/QaZkus9Pm4STZ4qD/bvX93gG5GRd5Xp5KjiMDNrRy6C3DIVQ==
X-Received: by 2002:a05:6a21:3889:b0:179:f761:4348 with SMTP id
 yj9-20020a056a21388900b00179f7614348mr2111249pzb.34.1697834833450; 
 Fri, 20 Oct 2023 13:47:13 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u7-20020aa78487000000b00694fee1011asm1946775pfn.208.2023.10.20.13.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:47:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 45/65] target/hppa: Implement IDTLBT, IITLBT
Date: Fri, 20 Oct 2023 13:43:11 -0700
Message-Id: <20231020204331.139847-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Rename the existing insert tlb helpers to emphasize that they
are for pa1.1 cpus.  Implement a combined i/d tlb for pa2.0.
Still missing is the new 'P' tlb bit.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.h     |  5 ++--
 target/hppa/insns.decode |  4 +++
 target/hppa/mem_helper.c | 63 +++++++++++++++++++++++++++++++++-------
 target/hppa/translate.c  | 35 ++++++++++++++++++----
 4 files changed, 89 insertions(+), 18 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 9920d38ded..58b6754dbe 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -94,8 +94,9 @@ DEF_HELPER_FLAGS_2(write_interval_timer, TCG_CALL_NO_RWG, void, env, tr)
 DEF_HELPER_FLAGS_2(write_eirr, TCG_CALL_NO_RWG, void, env, tr)
 DEF_HELPER_FLAGS_2(write_eiem, TCG_CALL_NO_RWG, void, env, tr)
 DEF_HELPER_FLAGS_2(swap_system_mask, TCG_CALL_NO_RWG, tr, env, tr)
-DEF_HELPER_FLAGS_3(itlba, TCG_CALL_NO_RWG, void, env, tl, tr)
-DEF_HELPER_FLAGS_3(itlbp, TCG_CALL_NO_RWG, void, env, tl, tr)
+DEF_HELPER_FLAGS_3(itlba_pa11, TCG_CALL_NO_RWG, void, env, tl, tr)
+DEF_HELPER_FLAGS_3(itlbp_pa11, TCG_CALL_NO_RWG, void, env, tl, tr)
+DEF_HELPER_FLAGS_3(itlbt_pa20, TCG_CALL_NO_RWG, void, env, tr, tr)
 DEF_HELPER_FLAGS_2(ptlb, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_1(ptlbe, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(lpa, TCG_CALL_NO_WG, tr, env, tl)
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 9d8c6a1a16..db1b9f750f 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -152,6 +152,10 @@ ixtlbx          000001 b:5 r:5 ... 000000 addr:1 0 00000        \
 # pcxl and pcxl2 Fast TLB Insert instructions
 ixtlbxf         000001 00000 r:5 00 0 data:1 01000 addr:1 0 00000
 
+# pa2.0 tlb insert instructions
+ixtlbt          000001 r2:5 r1:5 000 1100000 0 00000    # idtlbt
+ixtlbt          000001 r2:5 r1:5 000 0100000 0 00000    # iitlbt
+
 pxtlbx          000001 b:5 x:5 sp:2 0100100 local:1 m:1 -----   data=1
 pxtlbx          000001 b:5 x:5 ... 000100 local:1 m:1 -----     \
                 sp=%assemble_sr3x data=0
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 1a63717571..356746654c 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -312,7 +312,7 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
 }
 
 /* Insert (Insn/Data) TLB Address.  Note this is PA 1.1 only.  */
-void HELPER(itlba)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
+void HELPER(itlba_pa11)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
 {
     hppa_tlb_entry *empty = NULL;
     int i;
@@ -338,15 +338,12 @@ void HELPER(itlba)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
     /* Note that empty->entry_valid == 0 already.  */
     empty->va_b = addr & TARGET_PAGE_MASK;
     empty->va_e = empty->va_b + TARGET_PAGE_SIZE - 1;
-    /*
-     * FIXME: This is wrong, as this is a pa1.1 function.
-     * But for the moment translate abs address for pa2.0.
-     */
-    empty->pa = hppa_abs_to_phys(env, extract32(reg, 5, 20) << TARGET_PAGE_BITS);
+    empty->pa = extract32(reg, 5, 20) << TARGET_PAGE_BITS;
     trace_hppa_tlb_itlba(env, empty, empty->va_b, empty->va_e, empty->pa);
 }
 
-static void set_access_bits(CPUHPPAState *env, hppa_tlb_entry *ent, target_ureg reg)
+static void set_access_bits_pa11(CPUHPPAState *env, hppa_tlb_entry *ent,
+                                 target_ureg reg)
 {
     ent->access_id = extract32(reg, 1, 18);
     ent->u = extract32(reg, 19, 1);
@@ -362,7 +359,7 @@ static void set_access_bits(CPUHPPAState *env, hppa_tlb_entry *ent, target_ureg
 }
 
 /* Insert (Insn/Data) TLB Protection.  Note this is PA 1.1 only.  */
-void HELPER(itlbp)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
+void HELPER(itlbp_pa11)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
 {
     hppa_tlb_entry *ent = hppa_find_tlb(env, addr);
 
@@ -370,8 +367,54 @@ void HELPER(itlbp)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
         qemu_log_mask(LOG_GUEST_ERROR, "ITLBP not following ITLBA\n");
         return;
     }
+    set_access_bits_pa11(env, ent, reg);
+}
 
-    set_access_bits(env, ent, reg);
+void HELPER(itlbt_pa20)(CPUHPPAState *env, target_ureg r1, target_ureg r2)
+{
+    hppa_tlb_entry *ent, *empty = NULL;
+    vaddr va_b, va_e;
+    uint64_t page_size;
+
+    va_b = deposit64(env->cr[CR_IIAOQ], 32, 32, env->cr[CR_IIASQ]);
+    va_b &= TARGET_PAGE_MASK;
+    page_size = TARGET_PAGE_SIZE << (2 * (r1 & 0xf));
+    va_e = va_b + page_size - 1;
+
+    for (int i = 0; i < ARRAY_SIZE(env->tlb); ++i) {
+        ent = &env->tlb[i];
+        if (ent->entry_valid) {
+            if (ent->va_b <= va_e && va_b <= ent->va_e) {
+                hppa_flush_tlb_ent(env, ent, false);
+                empty = ent;
+            }
+        } else {
+            empty = ent;
+        }
+    }
+
+    /* If we didn't see an empty entry, evict one.  */
+    ent = empty ? empty : hppa_alloc_tlb_ent(env);
+
+    ent->va_b = va_b;
+    ent->va_e = va_e;
+    ent->pa = (r1 << 7) & TARGET_PAGE_MASK;
+    ent->t = extract64(r2, 61, 1);
+    ent->d = extract64(r2, 60, 1);
+    ent->b = extract64(r2, 59, 1);
+    ent->ar_type = extract64(r2, 56, 3);
+    ent->ar_pl1 = extract64(r2, 54, 2);
+    ent->ar_pl2 = extract64(r2, 52, 2);
+    ent->u = extract64(r2, 51, 1);
+    /* o = bit 50 */
+    /* p = bit 49 */
+    ent->access_id = extract64(r2, 1, 31);
+    ent->entry_valid = 1;
+
+    trace_hppa_tlb_itlba(env, ent, ent->va_b, ent->va_e, ent->pa);
+    trace_hppa_tlb_itlbp(env, ent, ent->access_id, ent->u,
+                         ent->ar_pl2, ent->ar_pl1, ent->ar_type,
+                         ent->b, ent->d, ent->t);
 }
 
 /* Purge (Insn/Data) TLB.  This is explicitly page-based, and is
@@ -519,7 +562,7 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
             btlb->va_b = virt_page << TARGET_PAGE_BITS;
             btlb->va_e = btlb->va_b + len * TARGET_PAGE_SIZE - 1;
             btlb->pa = phys_page << TARGET_PAGE_BITS;
-            set_access_bits(env, btlb, env->gr[20]);
+            set_access_bits_pa11(env, btlb, env->gr[20]);
             btlb->t = 0;
             btlb->d = 1;
         } else {
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 650f5812dd..2a09e1cdad 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2493,6 +2493,9 @@ static bool trans_probe(DisasContext *ctx, arg_probe *a)
 
 static bool trans_ixtlbx(DisasContext *ctx, arg_ixtlbx *a)
 {
+    if (ctx->is_pa20) {
+        return false;
+    }
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
 #ifndef CONFIG_USER_ONLY
     TCGv_tl addr;
@@ -2503,9 +2506,9 @@ static bool trans_ixtlbx(DisasContext *ctx, arg_ixtlbx *a)
     form_gva(ctx, &addr, &ofs, a->b, 0, 0, 0, a->sp, 0, false);
     reg = load_gpr(ctx, a->r);
     if (a->addr) {
-        gen_helper_itlba(tcg_env, addr, reg);
+        gen_helper_itlba_pa11(tcg_env, addr, reg);
     } else {
-        gen_helper_itlbp(tcg_env, addr, reg);
+        gen_helper_itlbp_pa11(tcg_env, addr, reg);
     }
 
     /* Exit TB for TLB change if mmu is enabled.  */
@@ -2551,6 +2554,9 @@ static bool trans_pxtlbx(DisasContext *ctx, arg_pxtlbx *a)
  */
 static bool trans_ixtlbxf(DisasContext *ctx, arg_ixtlbxf *a)
 {
+    if (ctx->is_pa20) {
+        return false;
+    }
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
 #ifndef CONFIG_USER_ONLY
     TCGv_tl addr, atl, stl;
@@ -2562,8 +2568,6 @@ static bool trans_ixtlbxf(DisasContext *ctx, arg_ixtlbxf *a)
      * FIXME:
      *  if (not (pcxl or pcxl2))
      *    return gen_illegal(ctx);
-     *
-     * Note for future: these are 32-bit systems; no hppa64.
      */
 
     atl = tcg_temp_new_tl();
@@ -2581,9 +2585,9 @@ static bool trans_ixtlbxf(DisasContext *ctx, arg_ixtlbxf *a)
 
     reg = load_gpr(ctx, a->r);
     if (a->addr) {
-        gen_helper_itlba(tcg_env, addr, reg);
+        gen_helper_itlba_pa11(tcg_env, addr, reg);
     } else {
-        gen_helper_itlbp(tcg_env, addr, reg);
+        gen_helper_itlbp_pa11(tcg_env, addr, reg);
     }
 
     /* Exit TB for TLB change if mmu is enabled.  */
@@ -2594,6 +2598,25 @@ static bool trans_ixtlbxf(DisasContext *ctx, arg_ixtlbxf *a)
 #endif
 }
 
+static bool trans_ixtlbt(DisasContext *ctx, arg_ixtlbt *a)
+{
+    if (!ctx->is_pa20) {
+        return false;
+    }
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+#ifndef CONFIG_USER_ONLY
+    nullify_over(ctx);
+
+    gen_helper_itlbt_pa20(tcg_env, load_gpr(ctx, a->r1), load_gpr(ctx, a->r2));
+
+    /* Exit TB for TLB change if mmu is enabled.  */
+    if (ctx->tb_flags & PSW_C) {
+        ctx->base.is_jmp = DISAS_IAQ_N_STALE;
+    }
+    return nullify_end(ctx);
+#endif
+}
+
 static bool trans_lpa(DisasContext *ctx, arg_ldst *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
-- 
2.34.1


