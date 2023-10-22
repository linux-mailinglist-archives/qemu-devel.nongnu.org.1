Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1238B7D2740
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:41:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhwm-00053K-4u; Sun, 22 Oct 2023 19:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwh-0004YE-Bx
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:23 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwe-0007XX-10
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:23 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6b1d1099a84so2605499b3a.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017598; x=1698622398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qgtQkV5i55okV8zZRS2KwZx1nRoXD2DEPY5vszOabjU=;
 b=eBS7lHXTR65v6i7pUXd6a07V5q0VZ8hlbyMISDmzofEA6VqC5g0790K9HwBqiLRRtu
 biZX+7EXdMCNjfEaOyUhqBXzwN52F7xKM+XVVqXj/1/ZxhCWui5VU8lJs8+516uRa9y0
 xtjYPLqH9XMKEe0Yg/gNOfzvINCljMscTeR9Flk0tROYpwCdarUn67O/lRw80PVd0p//
 i59DQQi1kptD2iV9YWSetek3XjXSmjxDxvbhXCTIhiUtr0Zz3bX70GVCL4Z6p9fgTM2B
 arndkBr4rpCKdWdR8Ay0r9ltVUg2iR0om3gO99o/ftAd3uMmFB3Gp30mY2wDbwc53Nlh
 X4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017598; x=1698622398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qgtQkV5i55okV8zZRS2KwZx1nRoXD2DEPY5vszOabjU=;
 b=EfP5jPoUGprP7bF1twRq4dd4w347hXAqjo7FjEdK9wrEQyXh9N4ALaW+qf2mv2q1Ev
 kLEYsI7XPo0yZLBo6CR+8r6B/tBYpUuJPXYlXdw//vKDr7v9kazoyO7stEYb+mYZYS/d
 5Qpug5sBbl4U500IA4L06MvXUTbxm5Jn8/iKlaY+Fs1ILSCwku6bThwurIrxWDxHWTWR
 uO6coIBGZiu/8AK+SLekTzdQcOoF7fxQyej8dRauQ1VFXFh9ujarAzXLXpF/AOVnTz6N
 eMt0r2yVPvmYlstW37W19DccT1EO1uel5KrQ99NjjN3+6MnyMwAlzi/AzUOGOjn93uBk
 oenQ==
X-Gm-Message-State: AOJu0YwAVHWoJLNkNuhTlK+trhvINdZ9xRQ7QJlhUqPnHP9o40UaAw8a
 8kTnDUUEXFZ26tyBx0dvEh2bSM+pPIftPCdSDzA=
X-Google-Smtp-Source: AGHT+IE3Z/k9ORyl9uaC8Zog1HogLJBUx+8DDsY0yIMZ8tKHfO3uGaOwVCrS/ITnAj2vHzf1Ra4QBw==
X-Received: by 2002:a05:6a00:134d:b0:6b8:69fa:a11 with SMTP id
 k13-20020a056a00134d00b006b869fa0a11mr9350135pfu.12.1698017598550; 
 Sun, 22 Oct 2023 16:33:18 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 52/94] target/sparc: Move simple integer load/store to
 decodetree
Date: Sun, 22 Oct 2023 16:28:50 -0700
Message-Id: <20231022232932.80507-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Move LDUW, LDUB, LDUH, LDD, LDSW, LDSB, LDSH, LDX,
STW, STB, STH, STD, STX.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  22 +++++
 target/sparc/translate.c  | 196 +++++++++++++++++++++++---------------
 2 files changed, 142 insertions(+), 76 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 137b7eb3c6..6197fbdb03 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -231,6 +231,28 @@ RESTORE     10 ..... 111101 ..... . .............          @r_r_ri
 DONE        10 00000 111110 00000 0 0000000000000
 RETRY       10 00001 111110 00000 0 0000000000000
 
+##
+## Major Opcode 11 -- load and store instructions
+##
+
+&r_r_ri_asi rd rs1 rs2_or_imm asi imm:bool
+@r_r_ri_na  .. rd:5  ...... rs1:5 imm:1 rs2_or_imm:s13     &r_r_ri_asi asi=-1
+
+LDUW        11 ..... 000000 ..... . .............          @r_r_ri_na
+LDUB        11 ..... 000001 ..... . .............          @r_r_ri_na
+LDUH        11 ..... 000010 ..... . .............          @r_r_ri_na
+LDD         11 ..... 000011 ..... . .............          @r_r_ri_na
+LDSW        11 ..... 001000 ..... . .............          @r_r_ri_na
+LDSB        11 ..... 001001 ..... . .............          @r_r_ri_na
+LDSH        11 ..... 001010 ..... . .............          @r_r_ri_na
+LDX         11 ..... 001011 ..... . .............          @r_r_ri_na
+
+STW         11 ..... 000100 ..... . .............          @r_r_ri_na
+STB         11 ..... 000101 ..... . .............          @r_r_ri_na
+STH         11 ..... 000110 ..... . .............          @r_r_ri_na
+STD         11 ..... 000111 ..... . .............          @r_r_ri_na
+STX         11 ..... 001110 ..... . .............          @r_r_ri_na
+
 NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
 NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 83c344365c..8a77c73aa4 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4533,6 +4533,117 @@ static bool do_done_retry(DisasContext *dc, bool done)
 TRANS(DONE, 64, do_done_retry, true)
 TRANS(RETRY, 64, do_done_retry, false)
 
+/*
+ * Major opcode 11 -- load and store instructions
+ */
+
+static TCGv gen_ldst_addr(DisasContext *dc, int rs1, bool imm, int rs2_or_imm)
+{
+    TCGv addr, tmp = NULL;
+
+    /* For simplicity, we under-decoded the rs2 form. */
+    if (!imm && rs2_or_imm & ~0x1f) {
+        return NULL;
+    }
+
+    addr = gen_load_gpr(dc, rs1);
+    if (rs2_or_imm) {
+        tmp = tcg_temp_new();
+        if (imm) {
+            tcg_gen_addi_tl(tmp, addr, rs2_or_imm);
+        } else {
+            tcg_gen_add_tl(tmp, addr, cpu_regs[rs2_or_imm]);
+        }
+        addr = tmp;
+    }
+    if (AM_CHECK(dc)) {
+        if (!tmp) {
+            tmp = tcg_temp_new();
+        }
+        tcg_gen_ext32u_tl(tmp, addr);
+        addr = tmp;
+    }
+    return addr;
+}
+
+static bool do_ld_gpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
+{
+    TCGv reg, addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+    DisasASI da;
+
+    if (addr == NULL) {
+        return false;
+    }
+    da = resolve_asi(dc, a->asi, mop);
+
+    reg = gen_dest_gpr(dc, a->rd);
+    gen_ld_asi0(dc, &da, reg, addr);
+    gen_store_gpr(dc, a->rd, reg);
+    return advance_pc(dc);
+}
+
+TRANS(LDUW, ALL, do_ld_gpr, a, MO_TEUL)
+TRANS(LDUB, ALL, do_ld_gpr, a, MO_UB)
+TRANS(LDUH, ALL, do_ld_gpr, a, MO_TEUW)
+TRANS(LDSB, ALL, do_ld_gpr, a, MO_SB)
+TRANS(LDSH, ALL, do_ld_gpr, a, MO_TESW)
+TRANS(LDSW, 64, do_ld_gpr, a, MO_TESL)
+TRANS(LDX, 64, do_ld_gpr, a, MO_TEUQ)
+
+static bool do_st_gpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
+{
+    TCGv reg, addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+    DisasASI da;
+
+    if (addr == NULL) {
+        return false;
+    }
+    da = resolve_asi(dc, a->asi, mop);
+
+    reg = gen_load_gpr(dc, a->rd);
+    gen_st_asi0(dc, &da, reg, addr);
+    return advance_pc(dc);
+}
+
+TRANS(STW, ALL, do_st_gpr, a, MO_TEUL)
+TRANS(STB, ALL, do_st_gpr, a, MO_UB)
+TRANS(STH, ALL, do_st_gpr, a, MO_TEUW)
+TRANS(STX, 64, do_st_gpr, a, MO_TEUQ)
+
+static bool trans_LDD(DisasContext *dc, arg_r_r_ri_asi *a)
+{
+    TCGv addr;
+    DisasASI da;
+
+    if (a->rd & 1) {
+        return false;
+    }
+    addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+    if (addr == NULL) {
+        return false;
+    }
+    da = resolve_asi(dc, a->asi, MO_TEUQ);
+    gen_ldda_asi0(dc, &da, addr, a->rd);
+    return advance_pc(dc);
+}
+
+static bool trans_STD(DisasContext *dc, arg_r_r_ri_asi *a)
+{
+    TCGv addr;
+    DisasASI da;
+
+    if (a->rd & 1) {
+        return false;
+    }
+    addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+    if (addr == NULL) {
+        return false;
+    }
+    da = resolve_asi(dc, a->asi, MO_TEUQ);
+    gen_stda_asi0(dc, &da, addr, a->rd);
+    return advance_pc(dc);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -5356,47 +5467,15 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 
                 switch (xop) {
                 case 0x0:       /* ld, V9 lduw, load unsigned word */
-                    gen_address_mask(dc, cpu_addr);
-                    tcg_gen_qemu_ld_tl(cpu_val, cpu_addr,
-                                       dc->mem_idx, MO_TEUL | MO_ALIGN);
-                    break;
                 case 0x1:       /* ldub, load unsigned byte */
-                    gen_address_mask(dc, cpu_addr);
-                    tcg_gen_qemu_ld_tl(cpu_val, cpu_addr,
-                                       dc->mem_idx, MO_UB);
-                    break;
                 case 0x2:       /* lduh, load unsigned halfword */
-                    gen_address_mask(dc, cpu_addr);
-                    tcg_gen_qemu_ld_tl(cpu_val, cpu_addr,
-                                       dc->mem_idx, MO_TEUW | MO_ALIGN);
-                    break;
                 case 0x3:       /* ldd, load double word */
-                    if (rd & 1)
-                        goto illegal_insn;
-                    else {
-                        TCGv_i64 t64;
-
-                        gen_address_mask(dc, cpu_addr);
-                        t64 = tcg_temp_new_i64();
-                        tcg_gen_qemu_ld_i64(t64, cpu_addr,
-                                            dc->mem_idx, MO_TEUQ | MO_ALIGN);
-                        tcg_gen_trunc_i64_tl(cpu_val, t64);
-                        tcg_gen_ext32u_tl(cpu_val, cpu_val);
-                        gen_store_gpr(dc, rd + 1, cpu_val);
-                        tcg_gen_shri_i64(t64, t64, 32);
-                        tcg_gen_trunc_i64_tl(cpu_val, t64);
-                        tcg_gen_ext32u_tl(cpu_val, cpu_val);
-                    }
-                    break;
                 case 0x9:       /* ldsb, load signed byte */
-                    gen_address_mask(dc, cpu_addr);
-                    tcg_gen_qemu_ld_tl(cpu_val, cpu_addr, dc->mem_idx, MO_SB);
-                    break;
                 case 0xa:       /* ldsh, load signed halfword */
-                    gen_address_mask(dc, cpu_addr);
-                    tcg_gen_qemu_ld_tl(cpu_val, cpu_addr,
-                                       dc->mem_idx, MO_TESW | MO_ALIGN);
-                    break;
+                    g_assert_not_reached();  /* in decodetree */
+                case 0x08:      /* V9 ldsw */
+                case 0x0b:      /* V9 ldx */
+                    goto illegal_insn;  /* in decodetree */
                 case 0xd:       /* ldstub */
                     gen_ldstub(dc, cpu_val, cpu_addr, dc->mem_idx);
                     break;
@@ -5438,16 +5517,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     break;
 #endif
 #ifdef TARGET_SPARC64
-                case 0x08: /* V9 ldsw */
-                    gen_address_mask(dc, cpu_addr);
-                    tcg_gen_qemu_ld_tl(cpu_val, cpu_addr,
-                                       dc->mem_idx, MO_TESL | MO_ALIGN);
-                    break;
-                case 0x0b: /* V9 ldx */
-                    gen_address_mask(dc, cpu_addr);
-                    tcg_gen_qemu_ld_tl(cpu_val, cpu_addr,
-                                       dc->mem_idx, MO_TEUQ | MO_ALIGN);
-                    break;
                 case 0x18: /* V9 ldswa */
                     gen_ld_asi(dc, cpu_val, cpu_addr, insn, MO_TESL);
                     break;
@@ -5540,38 +5609,18 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 }
             } else if (xop < 8 || (xop >= 0x14 && xop < 0x18) ||
                        xop == 0xe || xop == 0x1e) {
+#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
                 TCGv cpu_val = gen_load_gpr(dc, rd);
+#endif
 
                 switch (xop) {
                 case 0x4: /* st, store word */
-                    gen_address_mask(dc, cpu_addr);
-                    tcg_gen_qemu_st_tl(cpu_val, cpu_addr,
-                                       dc->mem_idx, MO_TEUL | MO_ALIGN);
-                    break;
                 case 0x5: /* stb, store byte */
-                    gen_address_mask(dc, cpu_addr);
-                    tcg_gen_qemu_st_tl(cpu_val, cpu_addr, dc->mem_idx, MO_UB);
-                    break;
                 case 0x6: /* sth, store halfword */
-                    gen_address_mask(dc, cpu_addr);
-                    tcg_gen_qemu_st_tl(cpu_val, cpu_addr,
-                                       dc->mem_idx, MO_TEUW | MO_ALIGN);
-                    break;
                 case 0x7: /* std, store double word */
-                    if (rd & 1)
-                        goto illegal_insn;
-                    else {
-                        TCGv_i64 t64;
-                        TCGv lo;
-
-                        gen_address_mask(dc, cpu_addr);
-                        lo = gen_load_gpr(dc, rd + 1);
-                        t64 = tcg_temp_new_i64();
-                        tcg_gen_concat_tl_i64(t64, lo, cpu_val);
-                        tcg_gen_qemu_st_i64(t64, cpu_addr,
-                                            dc->mem_idx, MO_TEUQ | MO_ALIGN);
-                    }
-                    break;
+                    g_assert_not_reached();  /* in decodetree */
+                case 0x0e: /* V9 stx */
+                    goto illegal_insn;  /* in decodetree */
 #if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
                 case 0x14: /* sta, V9 stwa, store word alternate */
                     gen_st_asi(dc, cpu_val, cpu_addr, insn, MO_TEUL);
@@ -5590,11 +5639,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     break;
 #endif
 #ifdef TARGET_SPARC64
-                case 0x0e: /* V9 stx */
-                    gen_address_mask(dc, cpu_addr);
-                    tcg_gen_qemu_st_tl(cpu_val, cpu_addr,
-                                       dc->mem_idx, MO_TEUQ | MO_ALIGN);
-                    break;
                 case 0x1e: /* V9 stxa */
                     gen_st_asi(dc, cpu_val, cpu_addr, insn, MO_TEUQ);
                     break;
-- 
2.34.1


