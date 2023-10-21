Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E11FE7D1B06
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:40:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4eQ-0002pX-Sn; Sat, 21 Oct 2023 01:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eE-0002S9-Ij
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:42 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eC-00015k-2i
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:42 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5a9bf4fbd3fso1094274a12.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866538; x=1698471338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nXY7V3h9raI68oJ0bwO74lPlv1+miZkxPjaYiDiOh6s=;
 b=c9VpH5nP7urcU95yrEJF9dqNL9EJyyAYHc1b75eVfxUdLMC1vMSPdxCO/uu4UNCqnT
 KJsQGlpQ30hRFlJYSSM53er3z7P2cayd4HU5zqZY0wMGG5nm+B7tiOL/KOt99hh/FqdE
 21jMhsJAu4Dgfzz9+JX1P2yWWBlcSegMNsyAwXxJUz+XEAHrR9jWVcMFw/4RSPXpgFxh
 uN25BsygOuvW++VKforoSbxQfEY3kCGf2cb7S0UTee2L3ko1e7eaI5PjGW77R4mk3WKy
 ItI3H7ceEf6zwE0lpmlBG7ZViWV2FYO8br6mjFE4F4HyNlKrVByvw/TTOJjPGeqr7JXQ
 r4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866538; x=1698471338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nXY7V3h9raI68oJ0bwO74lPlv1+miZkxPjaYiDiOh6s=;
 b=uTNLq7BsDbSTT4uvFU0tguUgh99FZDGMIIxgmtwYisim+UfUciF6IeiTHiCbQWGW4l
 Skarnl6Lts39cqSvCwhBIOrcqUHWdpu0nwMfg292xHt0p16tVOf2WaktSH1YgX5ULbKJ
 RpsSlZ/KNsN1fWMpMJh/rjgjZFRjXAeZ6KNN0SKbabpr5UAjqwgjLqgYOQgJZwPXnQZX
 xkepabM0mHe6sA8kKux+B9nU+IOTbJf6PkQY1cY1Qdjsh8GbAvJrAy+zbOjG7oVkF9Dt
 NSnLMsSESHTo6x9GZdfQ4QmjULKMYNqlMcrZ52brhMGsih1uBe3qZY8G3PMQBcTFE+x7
 kFuA==
X-Gm-Message-State: AOJu0Yx4nWBuWusBrlU8If710+85LUubxszBybU+lTWcUprIz+2CoQmE
 8COABf946xzUmXfMuXixJQ505+nKL22vS9UGyeg=
X-Google-Smtp-Source: AGHT+IFnU07Qz9TLETkCHXhY/+CJTzDDP0akegF6rVcSPYxQlieBBoCiKyi6RTbXRJtjngUzSx3xqQ==
X-Received: by 2002:a05:6a20:1451:b0:17d:1337:cfc5 with SMTP id
 a17-20020a056a20145100b0017d1337cfc5mr1663417pzi.29.1697866538222; 
 Fri, 20 Oct 2023 22:35:38 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:35:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 46/90] target/sparc: Split out ldst functions with asi
 pre-computed
Date: Fri, 20 Oct 2023 22:31:14 -0700
Message-Id: <20231021053158.278135-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

As an intermediate step in decodetree conversion, create
new functions passing in DisasASI and not insn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 215 ++++++++++++++++++++++-----------------
 1 file changed, 123 insertions(+), 92 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 23defa0a77..7d834ae8a0 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2147,25 +2147,21 @@ static DisasASI get_asi(DisasContext *dc, int insn, MemOp memop)
     return resolve_asi(dc, asi, memop);
 }
 
-static void __attribute__((unused))
-gen_ld_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn, MemOp memop)
+static void gen_ld_asi0(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
 {
-    DisasASI da = get_asi(dc, insn, memop);
-
-    switch (da.type) {
+    switch (da->type) {
     case GET_ASI_EXCP:
         break;
     case GET_ASI_DTWINX: /* Reserved for ldda.  */
         gen_exception(dc, TT_ILL_INSN);
         break;
     case GET_ASI_DIRECT:
-        gen_address_mask(dc, addr);
-        tcg_gen_qemu_ld_tl(dst, addr, da.mem_idx, da.memop | MO_ALIGN);
+        tcg_gen_qemu_ld_tl(dst, addr, da->mem_idx, da->memop | MO_ALIGN);
         break;
     default:
         {
-            TCGv_i32 r_asi = tcg_constant_i32(da.asi);
-            TCGv_i32 r_mop = tcg_constant_i32(memop | MO_ALIGN);
+            TCGv_i32 r_asi = tcg_constant_i32(da->asi);
+            TCGv_i32 r_mop = tcg_constant_i32(da->memop | MO_ALIGN);
 
             save_state(dc);
 #ifdef TARGET_SPARC64
@@ -2183,33 +2179,38 @@ gen_ld_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn, MemOp memop)
 }
 
 static void __attribute__((unused))
-gen_st_asi(DisasContext *dc, TCGv src, TCGv addr, int insn, MemOp memop)
+gen_ld_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn, MemOp memop)
 {
     DisasASI da = get_asi(dc, insn, memop);
 
-    switch (da.type) {
+    gen_address_mask(dc, addr);
+    gen_ld_asi0(dc, &da, dst, addr);
+}
+
+static void gen_st_asi0(DisasContext *dc, DisasASI *da, TCGv src, TCGv addr)
+{
+    switch (da->type) {
     case GET_ASI_EXCP:
         break;
+
     case GET_ASI_DTWINX: /* Reserved for stda.  */
-#ifndef TARGET_SPARC64
-        gen_exception(dc, TT_ILL_INSN);
-        break;
-#else
-        if (!(dc->def->features & CPU_FEATURE_HYPV)) {
+        if (TARGET_LONG_BITS == 32) {
+            gen_exception(dc, TT_ILL_INSN);
+            break;
+        } else if (!(dc->def->features & CPU_FEATURE_HYPV)) {
             /* Pre OpenSPARC CPUs don't have these */
             gen_exception(dc, TT_ILL_INSN);
-            return;
+            break;
         }
-        /* in OpenSPARC T1+ CPUs TWINX ASIs in store instructions
-         * are ST_BLKINIT_ ASIs */
-#endif
+        /* In OpenSPARC T1+ CPUs TWINX ASIs in store are ST_BLKINIT_ ASIs */
         /* fall through */
+
     case GET_ASI_DIRECT:
-        gen_address_mask(dc, addr);
-        tcg_gen_qemu_st_tl(src, addr, da.mem_idx, da.memop | MO_ALIGN);
+        tcg_gen_qemu_st_tl(src, addr, da->mem_idx, da->memop | MO_ALIGN);
         break;
-#if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
+
     case GET_ASI_BCOPY:
+        assert(TARGET_LONG_BITS == 32);
         /* Copy 32 bytes from the address in SRC to ADDR.  */
         /* ??? The original qemu code suggests 4-byte alignment, dropping
            the low bits, but the only place I can see this used is in the
@@ -2227,18 +2228,18 @@ gen_st_asi(DisasContext *dc, TCGv src, TCGv addr, int insn, MemOp memop)
             for (i = 0; i < 32; i += 4) {
                 /* Since the loads and stores are paired, allow the
                    copy to happen in the host endianness.  */
-                tcg_gen_qemu_ld_i32(tmp, saddr, da.mem_idx, MO_UL);
-                tcg_gen_qemu_st_i32(tmp, daddr, da.mem_idx, MO_UL);
+                tcg_gen_qemu_ld_i32(tmp, saddr, da->mem_idx, MO_UL);
+                tcg_gen_qemu_st_i32(tmp, daddr, da->mem_idx, MO_UL);
                 tcg_gen_add_tl(saddr, saddr, four);
                 tcg_gen_add_tl(daddr, daddr, four);
             }
         }
         break;
-#endif
+
     default:
         {
-            TCGv_i32 r_asi = tcg_constant_i32(da.asi);
-            TCGv_i32 r_mop = tcg_constant_i32(memop | MO_ALIGN);
+            TCGv_i32 r_asi = tcg_constant_i32(da->asi);
+            TCGv_i32 r_mop = tcg_constant_i32(da->memop | MO_ALIGN);
 
             save_state(dc);
 #ifdef TARGET_SPARC64
@@ -2258,16 +2259,49 @@ gen_st_asi(DisasContext *dc, TCGv src, TCGv addr, int insn, MemOp memop)
     }
 }
 
+static void __attribute__((unused))
+gen_st_asi(DisasContext *dc, TCGv src, TCGv addr, int insn, MemOp memop)
+{
+    DisasASI da = get_asi(dc, insn, memop);
+
+    gen_address_mask(dc, addr);
+    gen_st_asi0(dc, &da, src, addr);
+}
+
+static void gen_swap_asi0(DisasContext *dc, DisasASI *da,
+                          TCGv dst, TCGv src, TCGv addr)
+{
+    switch (da->type) {
+    case GET_ASI_EXCP:
+        break;
+    case GET_ASI_DIRECT:
+        gen_swap(dc, dst, src, addr, da->mem_idx, da->memop);
+        break;
+    default:
+        /* ??? Should be DAE_invalid_asi.  */
+        gen_exception(dc, TT_DATA_ACCESS);
+        break;
+    }
+}
+
 static void __attribute__((unused))
 gen_swap_asi(DisasContext *dc, TCGv dst, TCGv src, TCGv addr, int insn)
 {
     DisasASI da = get_asi(dc, insn, MO_TEUL);
 
-    switch (da.type) {
+    gen_address_mask(dc, addr);
+    gen_swap_asi0(dc, &da, dst, src, addr);
+}
+
+static void gen_cas_asi0(DisasContext *dc, DisasASI *da,
+                         TCGv oldv, TCGv newv, TCGv cmpv, TCGv addr)
+{
+    switch (da->type) {
     case GET_ASI_EXCP:
-        break;
+        return;
     case GET_ASI_DIRECT:
-        gen_swap(dc, dst, src, addr, da.mem_idx, da.memop);
+        tcg_gen_atomic_cmpxchg_tl(oldv, addr, cmpv, newv,
+                                  da->mem_idx, da->memop | MO_ALIGN);
         break;
     default:
         /* ??? Should be DAE_invalid_asi.  */
@@ -2280,34 +2314,33 @@ static void __attribute__((unused))
 gen_cas_asi(DisasContext *dc, TCGv addr, TCGv cmpv, int insn, int rd)
 {
     DisasASI da = get_asi(dc, insn, MO_TEUL);
-    TCGv oldv;
+    TCGv oldv = gen_dest_gpr(dc, rd);
+    TCGv newv = gen_load_gpr(dc, rd);
 
-    switch (da.type) {
-    case GET_ASI_EXCP:
-        return;
-    case GET_ASI_DIRECT:
-        oldv = tcg_temp_new();
-        tcg_gen_atomic_cmpxchg_tl(oldv, addr, cmpv, gen_load_gpr(dc, rd),
-                                  da.mem_idx, da.memop | MO_ALIGN);
-        gen_store_gpr(dc, rd, oldv);
-        break;
-    default:
-        /* ??? Should be DAE_invalid_asi.  */
-        gen_exception(dc, TT_DATA_ACCESS);
-        break;
-    }
+    gen_address_mask(dc, addr);
+    gen_cas_asi0(dc, &da, oldv, newv, cmpv, addr);
+    gen_store_gpr(dc, rd, oldv);
 }
 
 static void __attribute__((unused))
-gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
+gen_casx_asi(DisasContext *dc, TCGv addr, TCGv cmpv, int insn, int rd)
 {
-    DisasASI da = get_asi(dc, insn, MO_UB);
+    DisasASI da = get_asi(dc, insn, MO_TEUQ);
+    TCGv oldv = gen_dest_gpr(dc, rd);
+    TCGv newv = gen_load_gpr(dc, rd);
 
-    switch (da.type) {
+    gen_address_mask(dc, addr);
+    gen_cas_asi0(dc, &da, oldv, newv, cmpv, addr);
+    gen_store_gpr(dc, rd, oldv);
+}
+
+static void gen_ldstub_asi0(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
+{
+    switch (da->type) {
     case GET_ASI_EXCP:
         break;
     case GET_ASI_DIRECT:
-        gen_ldstub(dc, dst, addr, da.mem_idx);
+        gen_ldstub(dc, dst, addr, da->mem_idx);
         break;
     default:
         /* ??? In theory, this should be raise DAE_invalid_asi.
@@ -2315,7 +2348,7 @@ gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
         if (tb_cflags(dc->base.tb) & CF_PARALLEL) {
             gen_helper_exit_atomic(tcg_env);
         } else {
-            TCGv_i32 r_asi = tcg_constant_i32(da.asi);
+            TCGv_i32 r_asi = tcg_constant_i32(da->asi);
             TCGv_i32 r_mop = tcg_constant_i32(MO_UB);
             TCGv_i64 s64, t64;
 
@@ -2335,6 +2368,15 @@ gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
     }
 }
 
+static void __attribute__((unused))
+gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
+{
+    DisasASI da = get_asi(dc, insn, MO_UB);
+
+    gen_address_mask(dc, addr);
+    gen_ldstub_asi0(dc, &da, dst, addr);
+}
+
 static void __attribute__((unused))
 gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 {
@@ -2527,36 +2569,32 @@ gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
     }
 }
 
-static void __attribute__((unused))
-gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
+static void gen_ldda_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
 {
-    DisasASI da = get_asi(dc, insn, MO_TEUQ);
     TCGv hi = gen_dest_gpr(dc, rd);
     TCGv lo = gen_dest_gpr(dc, rd + 1);
 
-    switch (da.type) {
+    switch (da->type) {
     case GET_ASI_EXCP:
         return;
 
     case GET_ASI_DTWINX:
         assert(TARGET_LONG_BITS == 64);
-        gen_address_mask(dc, addr);
-        tcg_gen_qemu_ld_tl(hi, addr, da.mem_idx, da.memop | MO_ALIGN_16);
+        tcg_gen_qemu_ld_tl(hi, addr, da->mem_idx, da->memop | MO_ALIGN_16);
         tcg_gen_addi_tl(addr, addr, 8);
-        tcg_gen_qemu_ld_tl(lo, addr, da.mem_idx, da.memop);
+        tcg_gen_qemu_ld_tl(lo, addr, da->mem_idx, da->memop);
         break;
 
     case GET_ASI_DIRECT:
         {
             TCGv_i64 tmp = tcg_temp_new_i64();
 
-            gen_address_mask(dc, addr);
-            tcg_gen_qemu_ld_i64(tmp, addr, da.mem_idx, da.memop | MO_ALIGN);
+            tcg_gen_qemu_ld_i64(tmp, addr, da->mem_idx, da->memop | MO_ALIGN);
 
             /* Note that LE ldda acts as if each 32-bit register
                result is byte swapped.  Having just performed one
                64-bit bswap, we need now to swap the writebacks.  */
-            if ((da.memop & MO_BSWAP) == MO_TE) {
+            if ((da->memop & MO_BSWAP) == MO_TE) {
                 tcg_gen_extr_i64_tl(lo, hi, tmp);
             } else {
                 tcg_gen_extr_i64_tl(hi, lo, tmp);
@@ -2570,15 +2608,15 @@ gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
            real hardware allows others.  This can be seen with e.g.
            FreeBSD 10.3 wrt ASI_IC_TAG.  */
         {
-            TCGv_i32 r_asi = tcg_constant_i32(da.asi);
-            TCGv_i32 r_mop = tcg_constant_i32(da.memop);
+            TCGv_i32 r_asi = tcg_constant_i32(da->asi);
+            TCGv_i32 r_mop = tcg_constant_i32(da->memop);
             TCGv_i64 tmp = tcg_temp_new_i64();
 
             save_state(dc);
             gen_helper_ld_asi(tmp, tcg_env, addr, r_asi, r_mop);
 
             /* See above.  */
-            if ((da.memop & MO_BSWAP) == MO_TE) {
+            if ((da->memop & MO_BSWAP) == MO_TE) {
                 tcg_gen_extr_i64_tl(lo, hi, tmp);
             } else {
                 tcg_gen_extr_i64_tl(hi, lo, tmp);
@@ -2592,21 +2630,28 @@ gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
 }
 
 static void __attribute__((unused))
-gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr, int insn, int rd)
+gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
 {
     DisasASI da = get_asi(dc, insn, MO_TEUQ);
+
+    gen_address_mask(dc, addr);
+    gen_ldda_asi0(dc, &da, addr, rd);
+}
+
+static void gen_stda_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
+{
+    TCGv hi = gen_load_gpr(dc, rd);
     TCGv lo = gen_load_gpr(dc, rd + 1);
 
-    switch (da.type) {
+    switch (da->type) {
     case GET_ASI_EXCP:
         break;
 
     case GET_ASI_DTWINX:
         assert(TARGET_LONG_BITS == 64);
-        gen_address_mask(dc, addr);
-        tcg_gen_qemu_st_tl(hi, addr, da.mem_idx, da.memop | MO_ALIGN_16);
+        tcg_gen_qemu_st_tl(hi, addr, da->mem_idx, da->memop | MO_ALIGN_16);
         tcg_gen_addi_tl(addr, addr, 8);
-        tcg_gen_qemu_st_tl(lo, addr, da.mem_idx, da.memop);
+        tcg_gen_qemu_st_tl(lo, addr, da->mem_idx, da->memop);
         break;
 
     case GET_ASI_DIRECT:
@@ -2616,13 +2661,12 @@ gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr, int insn, int rd)
             /* Note that LE stda acts as if each 32-bit register result is
                byte swapped.  We will perform one 64-bit LE store, so now
                we must swap the order of the construction.  */
-            if ((da.memop & MO_BSWAP) == MO_TE) {
+            if ((da->memop & MO_BSWAP) == MO_TE) {
                 tcg_gen_concat_tl_i64(t64, lo, hi);
             } else {
                 tcg_gen_concat_tl_i64(t64, hi, lo);
             }
-            gen_address_mask(dc, addr);
-            tcg_gen_qemu_st_i64(t64, addr, da.mem_idx, da.memop | MO_ALIGN);
+            tcg_gen_qemu_st_i64(t64, addr, da->mem_idx, da->memop | MO_ALIGN);
         }
         break;
 
@@ -2642,7 +2686,7 @@ gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr, int insn, int rd)
             tcg_gen_concat_tl_i64(t64, lo, hi);
             tcg_gen_andi_tl(d_addr, addr, -8);
             for (i = 0; i < 32; i += 8) {
-                tcg_gen_qemu_st_i64(t64, d_addr, da.mem_idx, da.memop);
+                tcg_gen_qemu_st_i64(t64, d_addr, da->mem_idx, da->memop);
                 tcg_gen_add_tl(d_addr, d_addr, eight);
             }
         }
@@ -2652,12 +2696,12 @@ gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr, int insn, int rd)
         /* ??? In theory we've handled all of the ASIs that are valid
            for stda, and this should raise DAE_invalid_asi.  */
         {
-            TCGv_i32 r_asi = tcg_constant_i32(da.asi);
-            TCGv_i32 r_mop = tcg_constant_i32(da.memop);
+            TCGv_i32 r_asi = tcg_constant_i32(da->asi);
+            TCGv_i32 r_mop = tcg_constant_i32(da->memop);
             TCGv_i64 t64 = tcg_temp_new_i64();
 
             /* See above.  */
-            if ((da.memop & MO_BSWAP) == MO_TE) {
+            if ((da->memop & MO_BSWAP) == MO_TE) {
                 tcg_gen_concat_tl_i64(t64, lo, hi);
             } else {
                 tcg_gen_concat_tl_i64(t64, hi, lo);
@@ -2671,25 +2715,12 @@ gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr, int insn, int rd)
 }
 
 static void __attribute__((unused))
-gen_casx_asi(DisasContext *dc, TCGv addr, TCGv cmpv, int insn, int rd)
+gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr, int insn, int rd)
 {
     DisasASI da = get_asi(dc, insn, MO_TEUQ);
-    TCGv oldv;
 
-    switch (da.type) {
-    case GET_ASI_EXCP:
-        return;
-    case GET_ASI_DIRECT:
-        oldv = tcg_temp_new();
-        tcg_gen_atomic_cmpxchg_tl(oldv, addr, cmpv, gen_load_gpr(dc, rd),
-                                  da.mem_idx, da.memop | MO_ALIGN);
-        gen_store_gpr(dc, rd, oldv);
-        break;
-    default:
-        /* ??? Should be DAE_invalid_asi.  */
-        gen_exception(dc, TT_DATA_ACCESS);
-        break;
-    }
+    gen_address_mask(dc, addr);
+    gen_stda_asi0(dc, &da, addr, rd);
 }
 
 static TCGv get_src1(DisasContext *dc, unsigned int insn)
-- 
2.34.1


