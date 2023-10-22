Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD17D7D2744
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:42:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhwl-00051i-Fp; Sun, 22 Oct 2023 19:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwh-0004c2-Qw
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:23 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwc-0007X6-Az
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:23 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3b2e22a4004so2072839b6e.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017597; x=1698622397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U+aoeg+tALNSXnabfV9V4u//DbSOfzXT4El3MI56364=;
 b=Eg2rSD6umVxytEfZ++JRMzEBKm5pyeJ27GEl8ikJnJ2Qw6z1/Vo6Ax97bQ9oB33hQ2
 6YBpu0bp3Db11ip+Jw8YyTFGnVbyFpfbHursTD2ijTkbCIhaoH7Xhefh9eTDR4eJ3gO5
 NFuxd76k+EN65a1AlJkeP6wxQOqj8x9nbAPR6qKMr59XczoSRqQM6cDrY6R7Y3d7BOEO
 /cqJJQh4OwsxNDHyDxku6H+N6GdQZ2FvpklKIbtQQ6C7TNCyQsxjkYGo0qkE91TakfKQ
 lPw9pIUnXBvRxuDYxLH/7vvvvsTqQD3soB6thAyBvKtvmnmxWQf+XZ6OytejZ0FSBVlW
 obng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017597; x=1698622397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U+aoeg+tALNSXnabfV9V4u//DbSOfzXT4El3MI56364=;
 b=KtnBqTfA0hPGSKMc/nSryPTHbKfCMZhEOOczHSkYC+uLkxvYr4TF4QnPt9FVErxOVL
 ZT0p00WFgIlh3vKLenLt12FGehqvs3teqh4ncjl8YlEjcV8nLK99Af3gwDTxxZWgXOlR
 I2OmU/iy40t5fj0c4Fb9hgKg1xC4p6CIAFEEJcn7DjmrkYQDlJDw3dC7ALbg8Jcoddal
 zNw9atoCRNBGrGPfVGWOnr+oOMlf0JtPFfkrRRr/5Jgo2Jh0UktI8h+ql0pSdGZo/Sfn
 cJ11v82M1XNTrQaFjlp8HPyb8q63WgHrVuTtnv6eyjvnoYEo4YZg9bZoRx4rM8USLEuh
 2Aag==
X-Gm-Message-State: AOJu0YwA9Y6sy1EKZsKkGbI2IPtjj9MHQLZ05Y4hIHHzhLeXULtbXf7o
 2YJEJUGHuqAK6Hlax8d+MngKqbaH4aX4HRnSuDQ=
X-Google-Smtp-Source: AGHT+IFX3SSQV43rV6p9zD2bpbDG1nJtKZHfRawAsD39+ohzH2smzYCireU0ZIoFtvbhfdJ+lIGXvw==
X-Received: by 2002:aca:2817:0:b0:3b2:e9ae:5d4f with SMTP id
 23-20020aca2817000000b003b2e9ae5d4fmr9125999oix.24.1698017596921; 
 Sun, 22 Oct 2023 16:33:16 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 50/94] target/sparc: Split out ldst functions with asi
 pre-computed
Date: Sun, 22 Oct 2023 16:28:48 -0700
Message-Id: <20231022232932.80507-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 215 ++++++++++++++++++++++-----------------
 1 file changed, 123 insertions(+), 92 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index c2a2ee4621..f4dde20ff8 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2162,25 +2162,21 @@ static void gen_helper_st_asi(TCGv_env e, TCGv a, TCGv_i64 r,
 }
 #endif
 
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
@@ -2198,33 +2194,38 @@ gen_ld_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn, MemOp memop)
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
@@ -2242,18 +2243,18 @@ gen_st_asi(DisasContext *dc, TCGv src, TCGv addr, int insn, MemOp memop)
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
@@ -2273,16 +2274,49 @@ gen_st_asi(DisasContext *dc, TCGv src, TCGv addr, int insn, MemOp memop)
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
@@ -2295,34 +2329,33 @@ static void __attribute__((unused))
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
@@ -2330,7 +2363,7 @@ gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
         if (tb_cflags(dc->base.tb) & CF_PARALLEL) {
             gen_helper_exit_atomic(tcg_env);
         } else {
-            TCGv_i32 r_asi = tcg_constant_i32(da.asi);
+            TCGv_i32 r_asi = tcg_constant_i32(da->asi);
             TCGv_i32 r_mop = tcg_constant_i32(MO_UB);
             TCGv_i64 s64, t64;
 
@@ -2350,6 +2383,15 @@ gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
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
@@ -2542,36 +2584,32 @@ gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
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
@@ -2585,15 +2623,15 @@ gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
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
@@ -2607,21 +2645,28 @@ gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
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
@@ -2631,13 +2676,12 @@ gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr, int insn, int rd)
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
 
@@ -2657,7 +2701,7 @@ gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr, int insn, int rd)
             tcg_gen_concat_tl_i64(t64, lo, hi);
             tcg_gen_andi_tl(d_addr, addr, -8);
             for (i = 0; i < 32; i += 8) {
-                tcg_gen_qemu_st_i64(t64, d_addr, da.mem_idx, da.memop);
+                tcg_gen_qemu_st_i64(t64, d_addr, da->mem_idx, da->memop);
                 tcg_gen_add_tl(d_addr, d_addr, eight);
             }
         }
@@ -2667,12 +2711,12 @@ gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr, int insn, int rd)
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
@@ -2686,25 +2730,12 @@ gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr, int insn, int rd)
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


