Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8C67C8F51
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:36:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPlu-00089O-UT; Fri, 13 Oct 2023 17:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPlp-0007jL-Uu
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:34 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPlm-0001Lk-3X
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:33 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b6f4c118b7so507025b3a.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232749; x=1697837549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KUmwueb7S1DMx35feLpQHLxy/jk7oJXlQISdfgxN4F0=;
 b=PS7fBfgPmuNZPO05jXLtvakMNAoqckfrtFnPNxLFrRtVd2oKB33vBmD9vdDQSnsMge
 3a99lawtG3dwD5oRDZT/1rgTpIKKcBROXTcVFT4ilft3FTgkS2CWTwUKzd02/SIz/M9W
 yv+ksf9pqqhVNbeykjxyvR2KwNaBbOlVv0qqEeuVks+gxFrBF3fVhIxyJRbQtw2JD5xi
 YurwITUPfvf/LH+eEPi2yXvy/mKMCwAmOHjp2Etx2a6BxL3d2LVqkvxX/pIsg/OaDrKZ
 RckxfvPY4rLPTk9HZOv0VTi9D/Jb4itDnEGqvoAbzmscNFxKgil9H04jaqSGn61AqdcQ
 cOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232749; x=1697837549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KUmwueb7S1DMx35feLpQHLxy/jk7oJXlQISdfgxN4F0=;
 b=baBLmtWYsqt28xKyMyjIBHlz6gVt3zJb37MEV5tqaEAFergQUTZz7ZpOHT1BAsuoyh
 u5atFbxiKnyFUxXJz1cNmJtn8hHAhhwsNy7gfpVJh94OunN9+qFbboZRN5J983cy8N0d
 kxv/m8VRPd9VkjJMC8vKewZSzdbEk/HA5XD0QWlKmYTOVxFVHkC5MXt+LAEpVphr95Lr
 YFIhhlHOZKzPKDq3Jzfgn3jv4zP+Dj8kQiqXOu3HO3QYUBPE5WYBsXroyZ2EDjjZHJhf
 ZPiblc1K8J7ZwLa7zuXcVkG/DRt/PP9XbJho16JliWQpn9VnhaQrX8eL9Mers0/IWltK
 11xA==
X-Gm-Message-State: AOJu0Yzmhow/8c5OdLe0/zKMg3j/WA9lGnl+NGln7LCoXTsVcu9b0kQu
 oiro5IqBhP186GztJfh7RFMDglWY4p8+USIxvAk=
X-Google-Smtp-Source: AGHT+IHm+IS7m5S09b5mslKXYiBDIBZz90GZ56+Cal+B0hDmX6GytciH08SFPk4Q48xjGDWkdr8DtQ==
X-Received: by 2002:a05:6a00:2e8f:b0:690:d4f5:c664 with SMTP id
 fd15-20020a056a002e8f00b00690d4f5c664mr30554679pfb.11.1697232748463; 
 Fri, 13 Oct 2023 14:32:28 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 43/85] target/sparc: Move simple integer load/store to
 decodetree
Date: Fri, 13 Oct 2023 14:28:04 -0700
Message-Id: <20231013212846.165724-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  22 +++++
 target/sparc/translate.c  | 196 +++++++++++++++++++++++---------------
 2 files changed, 142 insertions(+), 76 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 9f17a11dd0..41fbda4eb8 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -225,6 +225,28 @@ RESTORE     10 ..... 111101 ..... . .............          @r_r_ri
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
index 1b993d3c4f..7b7437dbd8 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4548,6 +4548,117 @@ static bool trans_RETRY(DisasContext *dc, arg_RETRY *a)
     return true;
 }
 
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
@@ -5371,47 +5482,15 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 
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
@@ -5453,16 +5532,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5555,38 +5624,18 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5605,11 +5654,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


