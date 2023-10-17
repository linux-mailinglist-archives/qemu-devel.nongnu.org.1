Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 017957CBAF6
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:21:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdNk-00035t-Gd; Tue, 17 Oct 2023 02:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNW-0002py-EG
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:31 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNU-0004h5-1y
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:30 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso2370969b3a.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523387; x=1698128187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7OcqfLX0n4HBjR84BTnyOLb2r4IRA7T7l4/GfiNJjcs=;
 b=IDsYJ/g7J0DjqRyXcsMOA5UFMPGBtAzw5jdItKAUfl8yzuIY4uc1xoijqKIvgpdU+y
 M9bDTbXU5D4Dvn93UGSyGFOX/dnZaExck1tfLQrLitQgQDwXcsqvQ06ddNpnqEOQvN0V
 5fj78JJP7R1FwHZKArwjf3Dcmq+uDPrxud14rtv85y0MUGEyYh8WgOfFDG0u3xww3qae
 4gpkNkV/dpPp7sLkRn084ZmEJXEgaO62dxv6JQxz9DcFDElY11QtR6GC5xwKkQi58fAh
 JTVGURb0vZ6w52zOqR0VOuri6ajkPm39cBteermtUN4JFmbsWZTQG4vATVMvEwsXgnS2
 QwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523387; x=1698128187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7OcqfLX0n4HBjR84BTnyOLb2r4IRA7T7l4/GfiNJjcs=;
 b=WWRnQd0OHgEA+DFzSn8Ja1Ge/rv6OoirlKO348CDLG6/Wg1NJXZdhQgQqOxdi3dCeO
 AJV/I41N7q3p6Evbfxx0WLTCjicudqMorEe8oG5efnR9vx6M0yBvH22iDzXk1/CcYSMP
 kkhKQvUV/Co7kZdhzxhYxnhTimet65AM7PJWZDzzQZtABmOf9VuVxWaFgRNlHBh+d/xW
 yjw78kFMq9+Nll8lH61cJLUKLI/TTKvJkpkZrndzS2KocAW+FgFx+ULn/ZF3v7dhf9YL
 oioMC1zzM7nOCdzR46lN4HASeuO84KJ4D2SFc0wFcJwYj4e7JS9XzE+p6B2Z8LZVj/vV
 OdMA==
X-Gm-Message-State: AOJu0YxiRl3hQOD2bZqJu2Uegtc6NlLUPHc8rbhnE7JoqZLy6VQ/V7uC
 AObTENiQjTdmAoJKsCnRIXf2/7ywDvZoX9wbF98=
X-Google-Smtp-Source: AGHT+IHJlHgiJisPJ8gVvVBOtDHtN1MuedwYA7SP6+1uqgexpY1tL24mqDpcIPZoPO8tgWsP2ieRKA==
X-Received: by 2002:a05:6a00:248b:b0:68f:d44c:22f8 with SMTP id
 c11-20020a056a00248b00b0068fd44c22f8mr1467772pfv.1.1697523386656; 
 Mon, 16 Oct 2023 23:16:26 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 49/90] target/sparc: Move asi integer load/store to
 decodetree
Date: Mon, 16 Oct 2023 23:12:03 -0700
Message-Id: <20231017061244.681584-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Move LDDA, LDSBA, LDSHA, LDSWA, LDUBA, LDUHA, LDUWA, LDXA,
STBA, STDA, STHA, STWA, STXA.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  31 +++++++++
 target/sparc/translate.c  | 128 +++++---------------------------------
 2 files changed, 48 insertions(+), 111 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 24c22c6ae3..94f1f5b9c9 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -230,6 +230,9 @@ RETRY       10 00001 111110 00000 0 0000000000000
 
 &r_r_ri_asi rd rs1 rs2_or_imm asi imm:bool
 @r_r_ri_na  .. rd:5  ...... rs1:5 imm:1 rs2_or_imm:s13     &r_r_ri_asi asi=-1
+@r_r_r_asi  .. rd:5  ...... rs1:5 0     asi:8 rs2_or_imm:5 &r_r_ri_asi imm=0
+@r_r_i_asi  .. rd:5  ...... rs1:5 1     rs2_or_imm:s13     \
+            &r_r_ri_asi imm=1 asi=-2
 
 LDUW        11 ..... 000000 ..... . .............          @r_r_ri_na
 LDUB        11 ..... 000001 ..... . .............          @r_r_ri_na
@@ -246,6 +249,34 @@ STH         11 ..... 000110 ..... . .............          @r_r_ri_na
 STD         11 ..... 000111 ..... . .............          @r_r_ri_na
 STX         11 ..... 001110 ..... . .............          @r_r_ri_na
 
+LDUW        11 ..... 010000 ..... . .............          @r_r_r_asi # LDUWA
+LDUW        11 ..... 010000 ..... . .............          @r_r_i_asi # LDUWA
+LDUB        11 ..... 010001 ..... . .............          @r_r_r_asi # LDUBA
+LDUB        11 ..... 010001 ..... . .............          @r_r_i_asi # LDUBA
+LDUH        11 ..... 010010 ..... . .............          @r_r_r_asi # LDUHA
+LDUH        11 ..... 010010 ..... . .............          @r_r_i_asi # LDUHA
+LDD         11 ..... 010011 ..... . .............          @r_r_r_asi # LDDA
+LDD         11 ..... 010011 ..... . .............          @r_r_i_asi # LDDA
+LDX         11 ..... 011011 ..... . .............          @r_r_r_asi # LDXA
+LDX         11 ..... 011011 ..... . .............          @r_r_i_asi # LDXA
+LDSB        11 ..... 011001 ..... . .............          @r_r_r_asi # LDSBA
+LDSB        11 ..... 011001 ..... . .............          @r_r_i_asi # LDSBA
+LDSH        11 ..... 011010 ..... . .............          @r_r_r_asi # LDSHA
+LDSH        11 ..... 011010 ..... . .............          @r_r_i_asi # LDSHA
+LDSW        11 ..... 011000 ..... . .............          @r_r_r_asi # LDSWA
+LDSW        11 ..... 011000 ..... . .............          @r_r_i_asi # LDSWA
+
+STW         11 ..... 010100 ..... . .............          @r_r_r_asi # STWA
+STW         11 ..... 010100 ..... . .............          @r_r_i_asi # STWA
+STB         11 ..... 010101 ..... . .............          @r_r_r_asi # STBA
+STB         11 ..... 010101 ..... . .............          @r_r_i_asi # STBA
+STH         11 ..... 010110 ..... . .............          @r_r_r_asi # STHA
+STH         11 ..... 010110 ..... . .............          @r_r_i_asi # STHA
+STD         11 ..... 010111 ..... . .............          @r_r_r_asi # STDA
+STD         11 ..... 010111 ..... . .............          @r_r_i_asi # STDA
+STX         11 ..... 011110 ..... . .............          @r_r_r_asi # STXA
+STX         11 ..... 011110 ..... . .............          @r_r_i_asi # STXA
+
 NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
 NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index db577ee963..587eb0ccd5 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2105,7 +2105,7 @@ static DisasASI get_asi(DisasContext *dc, int insn, MemOp memop)
     return resolve_asi(dc, asi, memop);
 }
 
-static void gen_ld_asi0(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
+static void gen_ld_asi(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
 {
     switch (da->type) {
     case GET_ASI_EXCP:
@@ -2136,16 +2136,7 @@ static void gen_ld_asi0(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
     }
 }
 
-static void __attribute__((unused))
-gen_ld_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn, MemOp memop)
-{
-    DisasASI da = get_asi(dc, insn, memop);
-
-    gen_address_mask(dc, addr);
-    gen_ld_asi0(dc, &da, dst, addr);
-}
-
-static void gen_st_asi0(DisasContext *dc, DisasASI *da, TCGv src, TCGv addr)
+static void gen_st_asi(DisasContext *dc, DisasASI *da, TCGv src, TCGv addr)
 {
     switch (da->type) {
     case GET_ASI_EXCP:
@@ -2217,15 +2208,6 @@ static void gen_st_asi0(DisasContext *dc, DisasASI *da, TCGv src, TCGv addr)
     }
 }
 
-static void __attribute__((unused))
-gen_st_asi(DisasContext *dc, TCGv src, TCGv addr, int insn, MemOp memop)
-{
-    DisasASI da = get_asi(dc, insn, memop);
-
-    gen_address_mask(dc, addr);
-    gen_st_asi0(dc, &da, src, addr);
-}
-
 static void gen_swap_asi0(DisasContext *dc, DisasASI *da,
                           TCGv dst, TCGv src, TCGv addr)
 {
@@ -2527,7 +2509,7 @@ gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
     }
 }
 
-static void gen_ldda_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
+static void gen_ldda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
 {
     TCGv hi = gen_dest_gpr(dc, rd);
     TCGv lo = gen_dest_gpr(dc, rd + 1);
@@ -2603,16 +2585,7 @@ static void gen_ldda_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
     gen_store_gpr(dc, rd + 1, lo);
 }
 
-static void __attribute__((unused))
-gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
-{
-    DisasASI da = get_asi(dc, insn, MO_TEUQ);
-
-    gen_address_mask(dc, addr);
-    gen_ldda_asi0(dc, &da, addr, rd);
-}
-
-static void gen_stda_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
+static void gen_stda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
 {
     TCGv hi = gen_load_gpr(dc, rd);
     TCGv lo = gen_load_gpr(dc, rd + 1);
@@ -2704,15 +2677,6 @@ static void gen_stda_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
     }
 }
 
-static void __attribute__((unused))
-gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr, int insn, int rd)
-{
-    DisasASI da = get_asi(dc, insn, MO_TEUQ);
-
-    gen_address_mask(dc, addr);
-    gen_stda_asi0(dc, &da, addr, rd);
-}
-
 static TCGv get_src1(DisasContext *dc, unsigned int insn)
 {
     unsigned int rs1 = GET_FIELD(insn, 13, 17);
@@ -4658,7 +4622,7 @@ static bool do_ld_gpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
     da = resolve_asi(dc, a->asi, mop);
 
     reg = gen_dest_gpr(dc, a->rd);
-    gen_ld_asi0(dc, &da, reg, addr);
+    gen_ld_asi(dc, &da, reg, addr);
     gen_store_gpr(dc, a->rd, reg);
     return advance_pc(dc);
 }
@@ -4682,7 +4646,7 @@ static bool do_st_gpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
     da = resolve_asi(dc, a->asi, mop);
 
     reg = gen_load_gpr(dc, a->rd);
-    gen_st_asi0(dc, &da, reg, addr);
+    gen_st_asi(dc, &da, reg, addr);
     return advance_pc(dc);
 }
 
@@ -4704,7 +4668,7 @@ static bool trans_LDD(DisasContext *dc, arg_r_r_ri_asi *a)
         return false;
     }
     da = resolve_asi(dc, a->asi, MO_TEUQ);
-    gen_ldda_asi0(dc, &da, addr, a->rd);
+    gen_ldda_asi(dc, &da, addr, a->rd);
     return advance_pc(dc);
 }
 
@@ -4721,7 +4685,7 @@ static bool trans_STD(DisasContext *dc, arg_r_r_ri_asi *a)
         return false;
     }
     da = resolve_asi(dc, a->asi, MO_TEUQ);
-    gen_stda_asi0(dc, &da, addr, a->rd);
+    gen_stda_asi(dc, &da, addr, a->rd);
     return advance_pc(dc);
 }
 
@@ -5553,9 +5517,17 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x3:       /* ldd, load double word */
                 case 0x9:       /* ldsb, load signed byte */
                 case 0xa:       /* ldsh, load signed halfword */
+                case 0x10:      /* lda, V9 lduwa, load word alternate */
+                case 0x11:      /* lduba, load unsigned byte alternate */
+                case 0x12:      /* lduha, load unsigned halfword alternate */
+                case 0x13:      /* ldda, load double word alternate */
+                case 0x19:      /* ldsba, load signed byte alternate */
+                case 0x1a:      /* ldsha, load signed halfword alternate */
                     g_assert_not_reached();  /* in decodetree */
                 case 0x08:      /* V9 ldsw */
                 case 0x0b:      /* V9 ldx */
+                case 0x18:      /* V9 ldswa */
+                case 0x1b:      /* V9 ldxa */
                     goto illegal_insn;  /* in decodetree */
                 case 0xd:       /* ldstub */
                     gen_ldstub(dc, cpu_val, cpu_addr, dc->mem_idx);
@@ -5567,27 +5539,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                              dc->mem_idx, MO_TEUL);
                     break;
 #if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
-                case 0x10:      /* lda, V9 lduwa, load word alternate */
-                    gen_ld_asi(dc, cpu_val, cpu_addr, insn, MO_TEUL);
-                    break;
-                case 0x11:      /* lduba, load unsigned byte alternate */
-                    gen_ld_asi(dc, cpu_val, cpu_addr, insn, MO_UB);
-                    break;
-                case 0x12:      /* lduha, load unsigned halfword alternate */
-                    gen_ld_asi(dc, cpu_val, cpu_addr, insn, MO_TEUW);
-                    break;
-                case 0x13:      /* ldda, load double word alternate */
-                    if (rd & 1) {
-                        goto illegal_insn;
-                    }
-                    gen_ldda_asi(dc, cpu_addr, insn, rd);
-                    goto skip_move;
-                case 0x19:      /* ldsba, load signed byte alternate */
-                    gen_ld_asi(dc, cpu_val, cpu_addr, insn, MO_SB);
-                    break;
-                case 0x1a:      /* ldsha, load signed halfword alternate */
-                    gen_ld_asi(dc, cpu_val, cpu_addr, insn, MO_TESW);
-                    break;
                 case 0x1d:      /* ldstuba -- XXX: should be atomically */
                     gen_ldstub_asi(dc, cpu_val, cpu_addr, insn);
                     break;
@@ -5598,12 +5549,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     break;
 #endif
 #ifdef TARGET_SPARC64
-                case 0x18: /* V9 ldswa */
-                    gen_ld_asi(dc, cpu_val, cpu_addr, insn, MO_TESL);
-                    break;
-                case 0x1b: /* V9 ldxa */
-                    gen_ld_asi(dc, cpu_val, cpu_addr, insn, MO_TEUQ);
-                    break;
                 case 0x2d: /* V9 prefetch, no effect */
                     goto skip_move;
                 case 0x30: /* V9 ldfa */
@@ -5635,7 +5580,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     goto illegal_insn;
                 }
                 gen_store_gpr(dc, rd, cpu_val);
-#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
+#if defined(TARGET_SPARC64)
             skip_move: ;
 #endif
             } else if (xop >= 0x20 && xop < 0x24) {
@@ -5688,45 +5633,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 default:
                     goto illegal_insn;
                 }
-            } else if (xop < 8 || (xop >= 0x14 && xop < 0x18) ||
-                       xop == 0xe || xop == 0x1e) {
-#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
-                TCGv cpu_val = gen_load_gpr(dc, rd);
-#endif
-
-                switch (xop) {
-                case 0x4: /* st, store word */
-                case 0x5: /* stb, store byte */
-                case 0x6: /* sth, store halfword */
-                case 0x7: /* std, store double word */
-                    g_assert_not_reached();  /* in decodetree */
-                case 0x0e: /* V9 stx */
-                    goto illegal_insn;  /* in decodetree */
-#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
-                case 0x14: /* sta, V9 stwa, store word alternate */
-                    gen_st_asi(dc, cpu_val, cpu_addr, insn, MO_TEUL);
-                    break;
-                case 0x15: /* stba, store byte alternate */
-                    gen_st_asi(dc, cpu_val, cpu_addr, insn, MO_UB);
-                    break;
-                case 0x16: /* stha, store halfword alternate */
-                    gen_st_asi(dc, cpu_val, cpu_addr, insn, MO_TEUW);
-                    break;
-                case 0x17: /* stda, store double word alternate */
-                    if (rd & 1) {
-                        goto illegal_insn;
-                    }
-                    gen_stda_asi(dc, cpu_val, cpu_addr, insn, rd);
-                    break;
-#endif
-#ifdef TARGET_SPARC64
-                case 0x1e: /* V9 stxa */
-                    gen_st_asi(dc, cpu_val, cpu_addr, insn, MO_TEUQ);
-                    break;
-#endif
-                default:
-                    goto illegal_insn;
-                }
             } else if (xop > 0x23 && xop < 0x28) {
                 if (gen_trap_ifnofpu(dc)) {
                     goto jmp_insn;
-- 
2.34.1


