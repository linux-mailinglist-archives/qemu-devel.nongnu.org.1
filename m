Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3597CBAEB
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:21:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdNm-0003HB-Hf; Tue, 17 Oct 2023 02:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNY-0002rL-1O
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:33 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNV-0004hZ-TS
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:31 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6b20577ef7bso2962177b3a.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523388; x=1698128188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oynuqxebIh5u+8YIx7roHVDtnKQBfZX9HSGTH2xmAUw=;
 b=jyRjiuJsNDV9FgsLHRSq5plgDC6McePKwxYh8WlDaCumaS6UtwV7zAqzLgMf6wTw//
 2sInmwX2f6HIUhSCqateCXfBx659BF/v0GnXXdRjY2G2u0pelgUMAz8dHHNz7TmyBemV
 Bz5CYy7mppE/MoI0d7hEUwzMfHkjpCTopO7G9knTAvPZzD46V2mb0hHtZnwIlB7xKHhs
 cpGPJJvInWHE9CSU0KRbODzGUuJ59M7u6iKdqV6nksTTNelk+97fJwLb6hkmWmcXWUlK
 Te9nCqJfa3SO81fzpMsnbonkhFxfRz5ms1Xnt7e0NvXmhDRGGjPke2aXggy53i4tFvxz
 PcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523388; x=1698128188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oynuqxebIh5u+8YIx7roHVDtnKQBfZX9HSGTH2xmAUw=;
 b=tRrhoJSiXV+hn7oSp+pkb8UJL42eKNYrzQJXOcjC4aHHKJpWKfLB0ixB+5UKTmRF4h
 0xozqSi9oygsgVvjDhDz9FlE29v2CLhLpEnUPiGyqxULxKfQFFwSFYVHnQvGDyEyKxzK
 XHMaBhGyGFaxLO3XXEwmERjI/g0IthEleJ5Mfzk8I1qekdzNBaPPyWU0ZwB5iWJ7hNia
 T3oo3lrL/9PQCSmQ23knDFO+zgtfuP8mu7bDgNMOhjINEI0wBak3+ER959wWS1c+v3uo
 HkHsnzze0oKTZOfFFIb3mUTbFnJ14H0SKV7K/9UHjqigek2TFlZc9joQ97v9fqmVMELj
 jayg==
X-Gm-Message-State: AOJu0YxUWJnVJrbYjooD2eW8YgAXp9QgZBWY3fuM8dIeFov+Bg8L29tV
 MotzqWEZqSs23u6WY3bbwZqxaCPhQoGgpBeHr4o=
X-Google-Smtp-Source: AGHT+IFjphuUDhOyIMzUYfKWKMtMe7xYqdomnEvm737jDRs0oXEXkLjV1MiUxAQ6xqo4zCcFjQVoxw==
X-Received: by 2002:a05:6a00:1a86:b0:6b5:92d9:ef44 with SMTP id
 e6-20020a056a001a8600b006b592d9ef44mr1236088pfv.7.1697523388278; 
 Mon, 16 Oct 2023 23:16:28 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 51/90] target/sparc: Move SWAP, SWAPA to decodetree
Date: Mon, 16 Oct 2023 23:12:05 -0700
Message-Id: <20231017061244.681584-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
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

Remove gen_swap_asi.
Rename gen_swap_asi0 to gen_swap_asi.
Merge gen_swap into gen_swap_asi.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  4 +++
 target/sparc/translate.c  | 58 +++++++++++++++++----------------------
 2 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 3233528b08..32ac9cdbf7 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -281,6 +281,10 @@ LDSTUB      11 ..... 001101 ..... . .............          @r_r_ri_na
 LDSTUB      11 ..... 011101 ..... . .............          @r_r_r_asi # LDSTUBA
 LDSTUB      11 ..... 011101 ..... . .............          @r_r_i_asi # LDSTUBA
 
+SWAP        11 ..... 001111 ..... . .............          @r_r_ri_na
+SWAP        11 ..... 011111 ..... . .............          @r_r_r_asi # SWAPA
+SWAP        11 ..... 011111 ..... . .............          @r_r_i_asi # SWAPA
+
 NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
 NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index c2ea027fe1..e1b8cdd798 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1842,13 +1842,6 @@ static void gen_ne_fop_QD(DisasContext *dc, int rd, int rs,
     gen_update_fprs_dirty(dc, QFPREG(rd));
 }
 
-static void gen_swap(DisasContext *dc, TCGv dst, TCGv src,
-                     TCGv addr, int mmu_idx, MemOp memop)
-{
-    gen_address_mask(dc, addr);
-    tcg_gen_atomic_xchg_tl(dst, addr, src, mmu_idx, memop | MO_ALIGN);
-}
-
 /* asi moves */
 typedef enum {
     GET_ASI_HELPER,
@@ -2201,14 +2194,15 @@ static void gen_st_asi(DisasContext *dc, DisasASI *da, TCGv src, TCGv addr)
     }
 }
 
-static void gen_swap_asi0(DisasContext *dc, DisasASI *da,
-                          TCGv dst, TCGv src, TCGv addr)
+static void gen_swap_asi(DisasContext *dc, DisasASI *da,
+                         TCGv dst, TCGv src, TCGv addr)
 {
     switch (da->type) {
     case GET_ASI_EXCP:
         break;
     case GET_ASI_DIRECT:
-        gen_swap(dc, dst, src, addr, da->mem_idx, da->memop);
+        tcg_gen_atomic_xchg_tl(dst, addr, src,
+                               da->mem_idx, da->memop | MO_ALIGN);
         break;
     default:
         /* ??? Should be DAE_invalid_asi.  */
@@ -2217,15 +2211,6 @@ static void gen_swap_asi0(DisasContext *dc, DisasASI *da,
     }
 }
 
-static void __attribute__((unused))
-gen_swap_asi(DisasContext *dc, TCGv dst, TCGv src, TCGv addr, int insn)
-{
-    DisasASI da = get_asi(dc, insn, MO_TEUL);
-
-    gen_address_mask(dc, addr);
-    gen_swap_asi0(dc, &da, dst, src, addr);
-}
-
 static void gen_cas_asi0(DisasContext *dc, DisasASI *da,
                          TCGv oldv, TCGv newv, TCGv cmpv, TCGv addr)
 {
@@ -4691,6 +4676,24 @@ static bool trans_LDSTUB(DisasContext *dc, arg_r_r_ri_asi *a)
     return advance_pc(dc);
 }
 
+static bool trans_SWAP(DisasContext *dc, arg_r_r_ri_asi *a)
+{
+    TCGv addr, dst, src;
+    DisasASI da;
+
+    addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+    if (addr == NULL) {
+        return false;
+    }
+    da = resolve_asi(dc, a->asi, MO_TEUL);
+
+    dst = gen_dest_gpr(dc, a->rd);
+    src = gen_load_gpr(dc, a->rd);
+    gen_swap_asi(dc, &da, dst, src, addr);
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4702,7 +4705,7 @@ static bool trans_LDSTUB(DisasContext *dc, arg_r_r_ri_asi *a)
 static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 {
     unsigned int opc, rs1, rs2, rd;
-    TCGv cpu_src1;
+    TCGv cpu_src1 __attribute__((unused));
     TCGv cpu_src2 __attribute__((unused));
     TCGv_i32 cpu_src1_32, cpu_src2_32, cpu_dst_32;
     TCGv_i64 cpu_src1_64, cpu_src2_64, cpu_dst_64;
@@ -5520,6 +5523,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x9:       /* ldsb, load signed byte */
                 case 0xa:       /* ldsh, load signed halfword */
                 case 0xd:       /* ldstub */
+                case 0x0f:      /* swap */
                 case 0x10:      /* lda, V9 lduwa, load word alternate */
                 case 0x11:      /* lduba, load unsigned byte alternate */
                 case 0x12:      /* lduha, load unsigned halfword alternate */
@@ -5527,25 +5531,13 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x19:      /* ldsba, load signed byte alternate */
                 case 0x1a:      /* ldsha, load signed halfword alternate */
                 case 0x1d:      /* ldstuba */
+                case 0x1f:      /* swapa */
                     g_assert_not_reached();  /* in decodetree */
                 case 0x08:      /* V9 ldsw */
                 case 0x0b:      /* V9 ldx */
                 case 0x18:      /* V9 ldswa */
                 case 0x1b:      /* V9 ldxa */
                     goto illegal_insn;  /* in decodetree */
-                case 0x0f:
-                    /* swap, swap register with memory. Also atomically */
-                    cpu_src1 = gen_load_gpr(dc, rd);
-                    gen_swap(dc, cpu_val, cpu_src1, cpu_addr,
-                             dc->mem_idx, MO_TEUL);
-                    break;
-#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
-                case 0x1f:      /* swapa, swap reg with alt. memory. Also
-                                   atomically */
-                    cpu_src1 = gen_load_gpr(dc, rd);
-                    gen_swap_asi(dc, cpu_val, cpu_src1, cpu_addr, insn);
-                    break;
-#endif
 #ifdef TARGET_SPARC64
                 case 0x2d: /* V9 prefetch, no effect */
                     goto skip_move;
-- 
2.34.1


