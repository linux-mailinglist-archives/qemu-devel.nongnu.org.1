Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 008427D1B13
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:42:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4eQ-0002oA-Nf; Sat, 21 Oct 2023 01:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eE-0002Pw-7A
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:42 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eA-00015T-MF
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:40 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-577fff1cae6so1107558a12.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866537; x=1698471337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DlBy9AJUnYDybp2M77FwFq/pHwaxmpAeSASwG/yFgSM=;
 b=sglDnuPxEyvvj1sNKVPk8uoqy6Eghc9wYqE5tzQzcp2R034wtFm3+xt/ewwmg81iRG
 gPEwP2RU6Z2O93T6//PF29gw6RZruoEywf4keVKDUJJ3qjKIWMju8iS41TzYQuBF9G0x
 SwMfD2NB9MVFMuoxbSO1fzoRhCHtAj6DklqAzPzcmCX+N1CoL6cw0nLoWnj7jYil5Bnr
 XLU3YeEtR74OSUZncidzBRJ71Lr/83er1UJthsIJzzq4u0LRhpanHI5uTEv15tPX/REs
 0a+PJe9MI+z0V4iBeE481H4lM8ZoJKiWWWDa82ayVH3ngOqwXs9oJDHV8yM5V43ShkUF
 JhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866537; x=1698471337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DlBy9AJUnYDybp2M77FwFq/pHwaxmpAeSASwG/yFgSM=;
 b=blZaUap2bSG0g/SSoy7sl1nehLVUFALFtvVdKqmWZEy7SeimCvdU9xT+isSaLRl1pf
 M+nb6QSzknUCnv4AI4ZRddEuqbyyW17aTHB87Ith6JdUHp2DiUQf8L0dJFYgX8BA2sF2
 9ZKRbIoNeVLGCzogp2jFn/pvcoh6luqlwJm5HQ+Eey0m7qetIdAlkfmMbJ31Q8sS75sD
 nDFkf7h/cSelA/09GiHdnL0zRHcpKWfb7itsti04Wlfi0hkkCNoM11b6BdJy4Res8/EM
 Pwb3tNMr8T055RvNsLBRi3zCPhq4VZwPv/Iu0lc+wPeF4zQrOozYzLB5q2k0fcAAmOy+
 SWZQ==
X-Gm-Message-State: AOJu0YxgsCGT+i4AH8oHEG/8rvGnxJk3DaOj80VSIbO1rN8gUwP5Q12p
 VLlUY+PXC5r7TCN4BwYXGcydopVTv7IuBtPjlMw=
X-Google-Smtp-Source: AGHT+IHv9F66ufgjViu2i/FJC18qG8WjkFD7k9577qW0O9RyWnb0GuTR5p2hKcYQdqWKoytdYYAuzA==
X-Received: by 2002:a05:6a20:144c:b0:159:e4ab:15ce with SMTP id
 a12-20020a056a20144c00b00159e4ab15cemr5210624pzi.15.1697866537169; 
 Fri, 20 Oct 2023 22:35:37 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:35:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 45/90] target/sparc: Drop ifdef around get_asi and friends
Date: Fri, 20 Oct 2023 22:31:13 -0700
Message-Id: <20231021053158.278135-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Mark some of the functions as unused, temporarily.
Fix up some tl vs i64 issues revealed in the process.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 187 +++++++++++++++------------------------
 1 file changed, 70 insertions(+), 117 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f71c70a897..23defa0a77 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -58,6 +58,18 @@
 #define gen_helper_retry(E)             qemu_build_not_reached()
 #define gen_helper_udivx(D, E, A, B)    qemu_build_not_reached()
 #define gen_helper_sdivx(D, E, A, B)    qemu_build_not_reached()
+# ifdef CONFIG_USER_ONLY
+static void gen_helper_ld_asi(TCGv_i64 r, TCGv_env e, TCGv a,
+                              TCGv_i32 asi, TCGv_i32 mop)
+{
+    g_assert_not_reached();
+}
+static void gen_helper_st_asi(TCGv_env e, TCGv a, TCGv_i64 r,
+                              TCGv_i32 asi, TCGv_i32 mop)
+{
+    g_assert_not_reached();
+}
+# endif
 #endif
 
 /* Dynamic PC, must exit to main loop. */
@@ -1887,7 +1899,6 @@ static void gen_ldstub(DisasContext *dc, TCGv dst, TCGv addr, int mmu_idx)
 }
 
 /* asi moves */
-#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
 typedef enum {
     GET_ASI_HELPER,
     GET_ASI_EXCP,
@@ -2136,8 +2147,8 @@ static DisasASI get_asi(DisasContext *dc, int insn, MemOp memop)
     return resolve_asi(dc, asi, memop);
 }
 
-static void gen_ld_asi(DisasContext *dc, TCGv dst, TCGv addr,
-                       int insn, MemOp memop)
+static void __attribute__((unused))
+gen_ld_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn, MemOp memop)
 {
     DisasASI da = get_asi(dc, insn, memop);
 
@@ -2171,8 +2182,8 @@ static void gen_ld_asi(DisasContext *dc, TCGv dst, TCGv addr,
     }
 }
 
-static void gen_st_asi(DisasContext *dc, TCGv src, TCGv addr,
-                       int insn, MemOp memop)
+static void __attribute__((unused))
+gen_st_asi(DisasContext *dc, TCGv src, TCGv addr, int insn, MemOp memop)
 {
     DisasASI da = get_asi(dc, insn, memop);
 
@@ -2247,8 +2258,8 @@ static void gen_st_asi(DisasContext *dc, TCGv src, TCGv addr,
     }
 }
 
-static void gen_swap_asi(DisasContext *dc, TCGv dst, TCGv src,
-                         TCGv addr, int insn)
+static void __attribute__((unused))
+gen_swap_asi(DisasContext *dc, TCGv dst, TCGv src, TCGv addr, int insn)
 {
     DisasASI da = get_asi(dc, insn, MO_TEUL);
 
@@ -2265,8 +2276,8 @@ static void gen_swap_asi(DisasContext *dc, TCGv dst, TCGv src,
     }
 }
 
-static void gen_cas_asi(DisasContext *dc, TCGv addr, TCGv cmpv,
-                        int insn, int rd)
+static void __attribute__((unused))
+gen_cas_asi(DisasContext *dc, TCGv addr, TCGv cmpv, int insn, int rd)
 {
     DisasASI da = get_asi(dc, insn, MO_TEUL);
     TCGv oldv;
@@ -2287,7 +2298,8 @@ static void gen_cas_asi(DisasContext *dc, TCGv addr, TCGv cmpv,
     }
 }
 
-static void gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
+static void __attribute__((unused))
+gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
 {
     DisasASI da = get_asi(dc, insn, MO_UB);
 
@@ -2322,11 +2334,9 @@ static void gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
         break;
     }
 }
-#endif
 
-#ifdef TARGET_SPARC64
-static void gen_ldf_asi(DisasContext *dc, TCGv addr,
-                        int insn, int size, int rd)
+static void __attribute__((unused))
+gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 {
     DisasASI da = get_asi(dc, insn, (size == 4 ? MO_TEUL : MO_TEUQ));
     TCGv_i32 d32;
@@ -2434,8 +2444,8 @@ static void gen_ldf_asi(DisasContext *dc, TCGv addr,
     }
 }
 
-static void gen_stf_asi(DisasContext *dc, TCGv addr,
-                        int insn, int size, int rd)
+static void __attribute__((unused))
+gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 {
     DisasASI da = get_asi(dc, insn, (size == 4 ? MO_TEUL : MO_TEUQ));
     TCGv_i32 d32;
@@ -2517,21 +2527,23 @@ static void gen_stf_asi(DisasContext *dc, TCGv addr,
     }
 }
 
-static void gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
+static void __attribute__((unused))
+gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
 {
     DisasASI da = get_asi(dc, insn, MO_TEUQ);
-    TCGv_i64 hi = gen_dest_gpr(dc, rd);
-    TCGv_i64 lo = gen_dest_gpr(dc, rd + 1);
+    TCGv hi = gen_dest_gpr(dc, rd);
+    TCGv lo = gen_dest_gpr(dc, rd + 1);
 
     switch (da.type) {
     case GET_ASI_EXCP:
         return;
 
     case GET_ASI_DTWINX:
+        assert(TARGET_LONG_BITS == 64);
         gen_address_mask(dc, addr);
-        tcg_gen_qemu_ld_i64(hi, addr, da.mem_idx, da.memop | MO_ALIGN_16);
+        tcg_gen_qemu_ld_tl(hi, addr, da.mem_idx, da.memop | MO_ALIGN_16);
         tcg_gen_addi_tl(addr, addr, 8);
-        tcg_gen_qemu_ld_i64(lo, addr, da.mem_idx, da.memop);
+        tcg_gen_qemu_ld_tl(lo, addr, da.mem_idx, da.memop);
         break;
 
     case GET_ASI_DIRECT:
@@ -2545,9 +2557,9 @@ static void gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
                result is byte swapped.  Having just performed one
                64-bit bswap, we need now to swap the writebacks.  */
             if ((da.memop & MO_BSWAP) == MO_TE) {
-                tcg_gen_extr32_i64(lo, hi, tmp);
+                tcg_gen_extr_i64_tl(lo, hi, tmp);
             } else {
-                tcg_gen_extr32_i64(hi, lo, tmp);
+                tcg_gen_extr_i64_tl(hi, lo, tmp);
             }
         }
         break;
@@ -2567,9 +2579,9 @@ static void gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
 
             /* See above.  */
             if ((da.memop & MO_BSWAP) == MO_TE) {
-                tcg_gen_extr32_i64(lo, hi, tmp);
+                tcg_gen_extr_i64_tl(lo, hi, tmp);
             } else {
-                tcg_gen_extr32_i64(hi, lo, tmp);
+                tcg_gen_extr_i64_tl(hi, lo, tmp);
             }
         }
         break;
@@ -2579,8 +2591,8 @@ static void gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
     gen_store_gpr(dc, rd + 1, lo);
 }
 
-static void gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr,
-                         int insn, int rd)
+static void __attribute__((unused))
+gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr, int insn, int rd)
 {
     DisasASI da = get_asi(dc, insn, MO_TEUQ);
     TCGv lo = gen_load_gpr(dc, rd + 1);
@@ -2590,10 +2602,11 @@ static void gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr,
         break;
 
     case GET_ASI_DTWINX:
+        assert(TARGET_LONG_BITS == 64);
         gen_address_mask(dc, addr);
-        tcg_gen_qemu_st_i64(hi, addr, da.mem_idx, da.memop | MO_ALIGN_16);
+        tcg_gen_qemu_st_tl(hi, addr, da.mem_idx, da.memop | MO_ALIGN_16);
         tcg_gen_addi_tl(addr, addr, 8);
-        tcg_gen_qemu_st_i64(lo, addr, da.mem_idx, da.memop);
+        tcg_gen_qemu_st_tl(lo, addr, da.mem_idx, da.memop);
         break;
 
     case GET_ASI_DIRECT:
@@ -2604,15 +2617,37 @@ static void gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr,
                byte swapped.  We will perform one 64-bit LE store, so now
                we must swap the order of the construction.  */
             if ((da.memop & MO_BSWAP) == MO_TE) {
-                tcg_gen_concat32_i64(t64, lo, hi);
+                tcg_gen_concat_tl_i64(t64, lo, hi);
             } else {
-                tcg_gen_concat32_i64(t64, hi, lo);
+                tcg_gen_concat_tl_i64(t64, hi, lo);
             }
             gen_address_mask(dc, addr);
             tcg_gen_qemu_st_i64(t64, addr, da.mem_idx, da.memop | MO_ALIGN);
         }
         break;
 
+    case GET_ASI_BFILL:
+        assert(TARGET_LONG_BITS == 32);
+        /* Store 32 bytes of T64 to ADDR.  */
+        /* ??? The original qemu code suggests 8-byte alignment, dropping
+           the low bits, but the only place I can see this used is in the
+           Linux kernel with 32 byte alignment, which would make more sense
+           as a cacheline-style operation.  */
+        {
+            TCGv_i64 t64 = tcg_temp_new_i64();
+            TCGv d_addr = tcg_temp_new();
+            TCGv eight = tcg_constant_tl(8);
+            int i;
+
+            tcg_gen_concat_tl_i64(t64, lo, hi);
+            tcg_gen_andi_tl(d_addr, addr, -8);
+            for (i = 0; i < 32; i += 8) {
+                tcg_gen_qemu_st_i64(t64, d_addr, da.mem_idx, da.memop);
+                tcg_gen_add_tl(d_addr, d_addr, eight);
+            }
+        }
+        break;
+
     default:
         /* ??? In theory we've handled all of the ASIs that are valid
            for stda, and this should raise DAE_invalid_asi.  */
@@ -2623,9 +2658,9 @@ static void gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr,
 
             /* See above.  */
             if ((da.memop & MO_BSWAP) == MO_TE) {
-                tcg_gen_concat32_i64(t64, lo, hi);
+                tcg_gen_concat_tl_i64(t64, lo, hi);
             } else {
-                tcg_gen_concat32_i64(t64, hi, lo);
+                tcg_gen_concat_tl_i64(t64, hi, lo);
             }
 
             save_state(dc);
@@ -2635,8 +2670,8 @@ static void gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr,
     }
 }
 
-static void gen_casx_asi(DisasContext *dc, TCGv addr, TCGv cmpv,
-                         int insn, int rd)
+static void __attribute__((unused))
+gen_casx_asi(DisasContext *dc, TCGv addr, TCGv cmpv, int insn, int rd)
 {
     DisasASI da = get_asi(dc, insn, MO_TEUQ);
     TCGv oldv;
@@ -2657,88 +2692,6 @@ static void gen_casx_asi(DisasContext *dc, TCGv addr, TCGv cmpv,
     }
 }
 
-#elif !defined(CONFIG_USER_ONLY)
-static void gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
-{
-    /* ??? Work around an apparent bug in Ubuntu gcc 4.8.2-10ubuntu2+12,
-       whereby "rd + 1" elicits "error: array subscript is above array".
-       Since we have already asserted that rd is even, the semantics
-       are unchanged.  */
-    TCGv lo = gen_dest_gpr(dc, rd | 1);
-    TCGv hi = gen_dest_gpr(dc, rd);
-    TCGv_i64 t64 = tcg_temp_new_i64();
-    DisasASI da = get_asi(dc, insn, MO_TEUQ);
-
-    switch (da.type) {
-    case GET_ASI_EXCP:
-        return;
-    case GET_ASI_DIRECT:
-        gen_address_mask(dc, addr);
-        tcg_gen_qemu_ld_i64(t64, addr, da.mem_idx, da.memop | MO_ALIGN);
-        break;
-    default:
-        {
-            TCGv_i32 r_asi = tcg_constant_i32(da.asi);
-            TCGv_i32 r_mop = tcg_constant_i32(MO_UQ);
-
-            save_state(dc);
-            gen_helper_ld_asi(t64, tcg_env, addr, r_asi, r_mop);
-        }
-        break;
-    }
-
-    tcg_gen_extr_i64_i32(lo, hi, t64);
-    gen_store_gpr(dc, rd | 1, lo);
-    gen_store_gpr(dc, rd, hi);
-}
-
-static void gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr,
-                         int insn, int rd)
-{
-    DisasASI da = get_asi(dc, insn, MO_TEUQ);
-    TCGv lo = gen_load_gpr(dc, rd + 1);
-    TCGv_i64 t64 = tcg_temp_new_i64();
-
-    tcg_gen_concat_tl_i64(t64, lo, hi);
-
-    switch (da.type) {
-    case GET_ASI_EXCP:
-        break;
-    case GET_ASI_DIRECT:
-        gen_address_mask(dc, addr);
-        tcg_gen_qemu_st_i64(t64, addr, da.mem_idx, da.memop | MO_ALIGN);
-        break;
-    case GET_ASI_BFILL:
-        /* Store 32 bytes of T64 to ADDR.  */
-        /* ??? The original qemu code suggests 8-byte alignment, dropping
-           the low bits, but the only place I can see this used is in the
-           Linux kernel with 32 byte alignment, which would make more sense
-           as a cacheline-style operation.  */
-        {
-            TCGv d_addr = tcg_temp_new();
-            TCGv eight = tcg_constant_tl(8);
-            int i;
-
-            tcg_gen_andi_tl(d_addr, addr, -8);
-            for (i = 0; i < 32; i += 8) {
-                tcg_gen_qemu_st_i64(t64, d_addr, da.mem_idx, da.memop);
-                tcg_gen_add_tl(d_addr, d_addr, eight);
-            }
-        }
-        break;
-    default:
-        {
-            TCGv_i32 r_asi = tcg_constant_i32(da.asi);
-            TCGv_i32 r_mop = tcg_constant_i32(MO_UQ);
-
-            save_state(dc);
-            gen_helper_st_asi(tcg_env, addr, t64, r_asi, r_mop);
-        }
-        break;
-    }
-}
-#endif
-
 static TCGv get_src1(DisasContext *dc, unsigned int insn)
 {
     unsigned int rs1 = GET_FIELD(insn, 13, 17);
-- 
2.34.1


