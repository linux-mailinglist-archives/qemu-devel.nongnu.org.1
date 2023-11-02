Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F787DEA3E
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:41:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMbj-0006uo-0M; Wed, 01 Nov 2023 21:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMb2-0006Rk-Rw
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:09 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMb0-0001wz-R2
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:08 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c9b7c234a7so3426625ad.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888845; x=1699493645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aI6+kytQPkdhBU7NzYvCZ/HQ2OkcLrTJZGXElUg607g=;
 b=mAj9vkOWiEQdSgb9QUVOXmTONFgwV0A56eZldvldPMNt6B8SijHB0BdzWK8kOChdet
 znLX8MtO/q3+/nCy7yoGmnxkvdfn2ymPRbGAJzBZsoDPAOCzgRkktZyUL0h8sP8WBxQY
 xSrbuVqxwZnjGWFrB6PUNw8hhoWaPDzSkTfCvcz83M2zxI31sHEi5M1sd2P1Ri0kgbi7
 C9L/reiA6cudEQR67f/tcoG1Esx7hxVY6TloqeMGrBjgUlRePHEOFNC9bs2m6+zYCzzX
 BYuGYYk3aYCw+y4uK2aA/PweXx8G/Rd1JIZuBBmh4rVxp14O0PycGnwaDfZtVIL7JKvp
 0j9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888845; x=1699493645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aI6+kytQPkdhBU7NzYvCZ/HQ2OkcLrTJZGXElUg607g=;
 b=PQnrFRTpzWAq9GY3oNcHAdQilyQlu+uiJinaObI2oRVkf3GlDqxeboY+2lkPlja0+b
 N/uZ9UjoMm2mePYBV/2Xxy3Vhy+d7zLcxSE2FNsk/yQg6wcDfAWMZHtwXeFHiMKitGC0
 LXZpIpmZyxh49Zr/3wSsAowfFJeFY//BJieLUK2N/z89b/j6UuDJWdTXrxU73nEJ0lHu
 9v3pqjh0wSXXiF3ar1Dib5Hrvu/iXK/vCHQCXp65ijGyxzo7IvTtsKmpJmG92JAYa5sN
 08UKif7ula6Z16h2wrHrnVRIXJtn5ZQlL5scl/YUlu+zpynn9VV7qF/Zi9nfkJI1xiLY
 zXXg==
X-Gm-Message-State: AOJu0YxVPlRA3RhLALN4fAQwNhObBudqWww/iW2Iv/G5Afqm0yMoz34P
 /FP0bcqb4b3g1uCIJ7//sPUNGikraRt40Zz9rIE=
X-Google-Smtp-Source: AGHT+IELiryIiXDxDXqF40TtNfjxjs7RNUlTg1tqaNGtNZR2dJ5gQqRfum5Dg8vsbOR3yeQjsaeHvA==
X-Received: by 2002:a17:903:c4:b0:1cc:3b86:cfc5 with SMTP id
 x4-20020a17090300c400b001cc3b86cfc5mr11095325plc.4.1698888845603; 
 Wed, 01 Nov 2023 18:34:05 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 55/88] target/hppa: Implement IDTLBT, IITLBT
Date: Wed,  1 Nov 2023 18:29:43 -0700
Message-Id: <20231102013016.369010-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Rename the existing insert tlb helpers to emphasize that they
are for pa1.1 cpus.  Implement a combined i/d tlb for pa2.0.
Still missing is the new 'P' tlb bit.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.h     |  6 ++--
 target/hppa/insns.decode |  4 +++
 target/hppa/mem_helper.c | 61 ++++++++++++++++++++++++++++++++++++----
 target/hppa/translate.c  | 42 +++++++++++++++++++++++----
 4 files changed, 100 insertions(+), 13 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 9920d38ded..0b346e24f3 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -94,8 +94,10 @@ DEF_HELPER_FLAGS_2(write_interval_timer, TCG_CALL_NO_RWG, void, env, tr)
 DEF_HELPER_FLAGS_2(write_eirr, TCG_CALL_NO_RWG, void, env, tr)
 DEF_HELPER_FLAGS_2(write_eiem, TCG_CALL_NO_RWG, void, env, tr)
 DEF_HELPER_FLAGS_2(swap_system_mask, TCG_CALL_NO_RWG, tr, env, tr)
-DEF_HELPER_FLAGS_3(itlba, TCG_CALL_NO_RWG, void, env, tl, tr)
-DEF_HELPER_FLAGS_3(itlbp, TCG_CALL_NO_RWG, void, env, tl, tr)
+DEF_HELPER_FLAGS_3(itlba_pa11, TCG_CALL_NO_RWG, void, env, tl, tr)
+DEF_HELPER_FLAGS_3(itlbp_pa11, TCG_CALL_NO_RWG, void, env, tl, tr)
+DEF_HELPER_FLAGS_3(idtlbt_pa20, TCG_CALL_NO_RWG, void, env, tr, tr)
+DEF_HELPER_FLAGS_3(iitlbt_pa20, TCG_CALL_NO_RWG, void, env, tr, tr)
 DEF_HELPER_FLAGS_2(ptlb, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_1(ptlbe, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(lpa, TCG_CALL_NO_WG, tr, env, tl)
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 9d8c6a1a16..820049b0c5 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -145,6 +145,7 @@ nop_addrx       000001 ..... ..... -- 01001110 . 00000  @addrx # pdc
 
 probe           000001 b:5 ri:5 sp:2 imm:1 100011 write:1 0 t:5
 
+# pa1.x tlb insert instructions
 ixtlbx          000001 b:5 r:5 sp:2 0100000 addr:1 0 00000      data=1
 ixtlbx          000001 b:5 r:5 ... 000000 addr:1 0 00000        \
                 sp=%assemble_sr3x data=0
@@ -152,6 +153,9 @@ ixtlbx          000001 b:5 r:5 ... 000000 addr:1 0 00000        \
 # pcxl and pcxl2 Fast TLB Insert instructions
 ixtlbxf         000001 00000 r:5 00 0 data:1 01000 addr:1 0 00000
 
+# pa2.0 tlb insert idtlbt and iitlbt instructions
+ixtlbt          000001 r2:5 r1:5 000 data:1 100000 0 00000    # idtlbt
+
 pxtlbx          000001 b:5 x:5 sp:2 0100100 local:1 m:1 -----   data=1
 pxtlbx          000001 b:5 x:5 ... 000100 local:1 m:1 -----     \
                 sp=%assemble_sr3x data=0
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 420b43a0f6..d5d2d62f4a 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -344,7 +344,7 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
 }
 
 /* Insert (Insn/Data) TLB Address.  Note this is PA 1.1 only.  */
-void HELPER(itlba)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
+void HELPER(itlba_pa11)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
 {
     HPPATLBEntry *ent;
 
@@ -365,7 +365,8 @@ void HELPER(itlba)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
     trace_hppa_tlb_itlba(env, ent, ent->itree.start, ent->itree.last, ent->pa);
 }
 
-static void set_access_bits(CPUHPPAState *env, HPPATLBEntry *ent, target_ureg reg)
+static void set_access_bits_pa11(CPUHPPAState *env, HPPATLBEntry *ent,
+                                 target_ureg reg)
 {
     ent->access_id = extract32(reg, 1, 18);
     ent->u = extract32(reg, 19, 1);
@@ -383,20 +384,70 @@ static void set_access_bits(CPUHPPAState *env, HPPATLBEntry *ent, target_ureg re
 }
 
 /* Insert (Insn/Data) TLB Protection.  Note this is PA 1.1 only.  */
-void HELPER(itlbp)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
+void HELPER(itlbp_pa11)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
 {
     HPPATLBEntry *ent = env->tlb_partial;
 
     if (ent) {
         env->tlb_partial = NULL;
         if (ent->itree.start <= addr && addr <= ent->itree.last) {
-            set_access_bits(env, ent, reg);
+            set_access_bits_pa11(env, ent, reg);
             return;
         }
     }
     qemu_log_mask(LOG_GUEST_ERROR, "ITLBP not following ITLBA\n");
 }
 
+static void itlbt_pa20(CPUHPPAState *env, target_ureg r1,
+                       target_ureg r2, vaddr va_b)
+{
+    HPPATLBEntry *ent;
+    vaddr va_e;
+    uint64_t va_size;
+    int mask_shift;
+
+    mask_shift = 2 * (r1 & 0xf);
+    va_size = TARGET_PAGE_SIZE << mask_shift;
+    va_b &= -va_size;
+    va_e = va_b + va_size - 1;
+
+    hppa_flush_tlb_range(env, va_b, va_e);
+    ent = hppa_alloc_tlb_ent(env);
+
+    ent->itree.start = va_b;
+    ent->itree.last = va_e;
+    ent->pa = (r1 << 7) & (TARGET_PAGE_MASK << mask_shift);
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
+    interval_tree_insert(&ent->itree, &env->tlb_root);
+    trace_hppa_tlb_itlba(env, ent, ent->itree.start, ent->itree.last, ent->pa);
+    trace_hppa_tlb_itlbp(env, ent, ent->access_id, ent->u,
+                         ent->ar_pl2, ent->ar_pl1, ent->ar_type,
+                         ent->b, ent->d, ent->t);
+}
+
+void HELPER(idtlbt_pa20)(CPUHPPAState *env, target_ureg r1, target_ureg r2)
+{
+    vaddr va_b = deposit64(env->cr[CR_IOR], 32, 32, env->cr[CR_ISR]);
+    itlbt_pa20(env, r1, r2, va_b);
+}
+
+void HELPER(iitlbt_pa20)(CPUHPPAState *env, target_ureg r1, target_ureg r2)
+{
+    vaddr va_b = deposit64(env->cr[CR_IIAOQ], 32, 32, env->cr[CR_IIASQ]);
+    itlbt_pa20(env, r1, r2, va_b);
+}
+
 /* Purge (Insn/Data) TLB.  This is explicitly page-based, and is
    synchronous across all processors.  */
 static void ptlb_work(CPUState *cpu, run_on_cpu_data data)
@@ -563,7 +614,7 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
             btlb->itree.start = virt_page << TARGET_PAGE_BITS;
             btlb->itree.last = btlb->itree.start + len * TARGET_PAGE_SIZE - 1;
             btlb->pa = phys_page << TARGET_PAGE_BITS;
-            set_access_bits(env, btlb, env->gr[20]);
+            set_access_bits_pa11(env, btlb, env->gr[20]);
             btlb->t = 0;
             btlb->d = 1;
         } else {
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index e16b1c5399..fcea715e7d 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2514,6 +2514,9 @@ static bool trans_probe(DisasContext *ctx, arg_probe *a)
 
 static bool trans_ixtlbx(DisasContext *ctx, arg_ixtlbx *a)
 {
+    if (ctx->is_pa20) {
+        return false;
+    }
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
 #ifndef CONFIG_USER_ONLY
     TCGv_tl addr;
@@ -2524,9 +2527,9 @@ static bool trans_ixtlbx(DisasContext *ctx, arg_ixtlbx *a)
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
@@ -2572,6 +2575,9 @@ static bool trans_pxtlbx(DisasContext *ctx, arg_pxtlbx *a)
  */
 static bool trans_ixtlbxf(DisasContext *ctx, arg_ixtlbxf *a)
 {
+    if (ctx->is_pa20) {
+        return false;
+    }
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
 #ifndef CONFIG_USER_ONLY
     TCGv_tl addr, atl, stl;
@@ -2583,8 +2589,6 @@ static bool trans_ixtlbxf(DisasContext *ctx, arg_ixtlbxf *a)
      * FIXME:
      *  if (not (pcxl or pcxl2))
      *    return gen_illegal(ctx);
-     *
-     * Note for future: these are 32-bit systems; no hppa64.
      */
 
     atl = tcg_temp_new_tl();
@@ -2602,9 +2606,9 @@ static bool trans_ixtlbxf(DisasContext *ctx, arg_ixtlbxf *a)
 
     reg = load_gpr(ctx, a->r);
     if (a->addr) {
-        gen_helper_itlba(tcg_env, addr, reg);
+        gen_helper_itlba_pa11(tcg_env, addr, reg);
     } else {
-        gen_helper_itlbp(tcg_env, addr, reg);
+        gen_helper_itlbp_pa11(tcg_env, addr, reg);
     }
 
     /* Exit TB for TLB change if mmu is enabled.  */
@@ -2615,6 +2619,32 @@ static bool trans_ixtlbxf(DisasContext *ctx, arg_ixtlbxf *a)
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
+    {
+        TCGv_i64 src1 = load_gpr(ctx, a->r1);
+        TCGv_i64 src2 = load_gpr(ctx, a->r2);
+
+        if (a->data) {
+            gen_helper_idtlbt_pa20(tcg_env, src1, src2);
+        } else {
+            gen_helper_iitlbt_pa20(tcg_env, src1, src2);
+        }
+    }
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


