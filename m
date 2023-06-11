Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8562B72B2C5
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 18:05:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8NVg-0006Za-T9; Sun, 11 Jun 2023 12:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUu-00061g-Iw
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:01:00 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUm-0000Xq-Ez
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:56 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-30c55d2b9f3so2247213f8f.2
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 09:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686499247; x=1689091247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N3PW9VYsAGC1K2Fi7FePAHwlou4P1DBl1fvZGT4Ua6o=;
 b=R3EahtEMoyCM0Z+UROplgAYMMPCKNPfbwBnGvJKOfrWp5vOkPJbW8ZK9hJc3ZbUpVI
 5+qqx618f7pY/7FbXgfn8CkyjwBbG0Jzdp/GlPrr618ap7R+HqFv2l9d+9tpFfIo46Xy
 bnfwPL67QDXA/nnDyryiQBW7OhM0OiRnelNdWlsyzgp4g+k230yOKmMb1Sz+rM8H3brs
 T/TRT/Jc6ud0kmsDgRoaPrzfrKiTh1YGVP1syU9xLaC0r2+siCc21hmE10kHn+To0591
 ZoDUT9eeL5GqqdaaDvVkBevbZb+yZn/5K+CW2IXbP/GFL22m+tb+PaBdStjwr96JEAJW
 wv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686499247; x=1689091247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N3PW9VYsAGC1K2Fi7FePAHwlou4P1DBl1fvZGT4Ua6o=;
 b=h8b+kMgGeijlhj3F8xVGOMhhH/hkTQjHZFOx9aLcWAqAxTDZNMKystY7dhgPgYM/Dc
 9Y1h+bVtKSOXLyw+Mm3EIk+TEUFCFodCdVlXDdAkqIV2wqigfaxj2gIV96f1B5IPzN2W
 oFasdfgjQcVIuNQDF5HG5rf1qqrgUTOKDvAYcWobvVG8Qduocn4RiFE3TYxNQfZVZg7R
 uzEXZlN924rKMEN3j8Y3XhWus2DLW3LD8wItB/2iSYoZbZrScLLXUkE3e1qe/WNgNOs3
 1KAPAuHRHpKmxA6Zea7lro0VlVALGYvpiAe+UOaJe2IP5lVuhv4InOcgosh3WI2dPq7N
 mjmw==
X-Gm-Message-State: AC+VfDx7/lb3ySo5Fvit0kv6JcXRHJd34x6A99Tz1rPClen7/+OwvJTF
 qhHK0n01MaHPekdRgJBnGteXEmlmInbctrnf5uY=
X-Google-Smtp-Source: ACHHUZ5pisSMJqRMcubg0WtV4BPnLOVkSKOttbeHmK/73zLaIg878QB4u481/LEi+CRQ/qaXxe/FjA==
X-Received: by 2002:adf:e906:0:b0:30f:be0f:fbf with SMTP id
 f6-20020adfe906000000b0030fbe0f0fbfmr1109970wrm.22.1686499247015; 
 Sun, 11 Jun 2023 09:00:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a056000008900b0030ae499da59sm9923022wrx.111.2023.06.11.09.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 09:00:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 23/23] target/arm: Convert load/store tags insns to
 decodetree
Date: Sun, 11 Jun 2023 17:00:32 +0100
Message-Id: <20230611160032.274823-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230611160032.274823-1-peter.maydell@linaro.org>
References: <20230611160032.274823-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Convert the instructions in the load/store memory tags instruction
group to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230602155223.2040685-21-peter.maydell@linaro.org
---
 target/arm/tcg/a64.decode      |  25 +++
 target/arm/tcg/translate-a64.c | 360 ++++++++++++++++-----------------
 2 files changed, 199 insertions(+), 186 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 4ffdc91865f..ef64a3f9cba 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -528,3 +528,28 @@ LD_single          0 . 001101 . 1 . ..... 10 . 001 ..... .....  @ldst_single_d
 
 # Replicating load case
 LD_single_repl  0 q:1 001101 p:1 1 . rm:5 11 . 0 scale:2 rn:5 rt:5 selem=%ldst_single_selem
+
+%tag_offset     12:s9 !function=scale_by_log2_tag_granule
+&ldst_tag       rn rt imm p w
+@ldst_tag       ........ .. . ......... .. rn:5 rt:5 &ldst_tag imm=%tag_offset
+@ldst_tag_mult  ........ .. . 000000000 .. rn:5 rt:5 &ldst_tag imm=0
+
+STZGM           11011001 00 1 ......... 00 ..... ..... @ldst_tag_mult p=0 w=0
+STG             11011001 00 1 ......... 01 ..... ..... @ldst_tag p=1 w=1
+STG             11011001 00 1 ......... 10 ..... ..... @ldst_tag p=0 w=0
+STG             11011001 00 1 ......... 11 ..... ..... @ldst_tag p=0 w=1
+
+LDG             11011001 01 1 ......... 00 ..... ..... @ldst_tag p=0 w=0
+STZG            11011001 01 1 ......... 01 ..... ..... @ldst_tag p=1 w=1
+STZG            11011001 01 1 ......... 10 ..... ..... @ldst_tag p=0 w=0
+STZG            11011001 01 1 ......... 11 ..... ..... @ldst_tag p=0 w=1
+
+STGM            11011001 10 1 ......... 00 ..... ..... @ldst_tag_mult p=0 w=0
+ST2G            11011001 10 1 ......... 01 ..... ..... @ldst_tag p=1 w=1
+ST2G            11011001 10 1 ......... 10 ..... ..... @ldst_tag p=0 w=0
+ST2G            11011001 10 1 ......... 11 ..... ..... @ldst_tag p=0 w=1
+
+LDGM            11011001 11 1 ......... 00 ..... ..... @ldst_tag_mult p=0 w=0
+STZ2G           11011001 11 1 ......... 01 ..... ..... @ldst_tag p=1 w=1
+STZ2G           11011001 11 1 ......... 10 ..... ..... @ldst_tag p=0 w=0
+STZ2G           11011001 11 1 ......... 11 ..... ..... @ldst_tag p=0 w=1
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 6e7fe1f35cf..43963287a8c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -62,6 +62,12 @@ static int uimm_scaled(DisasContext *s, int x)
     return imm << scale;
 }
 
+/* For load/store memory tags: scale offset by LOG2_TAG_GRANULE */
+static int scale_by_log2_tag_granule(DisasContext *s, int x)
+{
+    return x << LOG2_TAG_GRANULE;
+}
+
 /*
  * Include the generated decoders.
  */
@@ -3712,185 +3718,184 @@ static bool trans_LD_single_repl(DisasContext *s, arg_LD_single_repl *a)
     return true;
 }
 
-/*
- * Load/Store memory tags
- *
- *  31 30 29         24     22  21     12    10      5      0
- * +-----+-------------+-----+---+------+-----+------+------+
- * | 1 1 | 0 1 1 0 0 1 | op1 | 1 | imm9 | op2 |  Rn  |  Rt  |
- * +-----+-------------+-----+---+------+-----+------+------+
- */
-static void disas_ldst_tag(DisasContext *s, uint32_t insn)
+static bool trans_STZGM(DisasContext *s, arg_ldst_tag *a)
 {
-    int rt = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    uint64_t offset = sextract64(insn, 12, 9) << LOG2_TAG_GRANULE;
-    int op2 = extract32(insn, 10, 2);
-    int op1 = extract32(insn, 22, 2);
-    bool is_load = false, is_pair = false, is_zero = false, is_mult = false;
-    int index = 0;
     TCGv_i64 addr, clean_addr, tcg_rt;
+    int size = 4 << s->dcz_blocksize;
 
-    /* We checked insn bits [29:24,21] in the caller.  */
-    if (extract32(insn, 30, 2) != 3) {
-        goto do_unallocated;
+    if (!dc_isar_feature(aa64_mte, s)) {
+        return false;
+    }
+    if (s->current_el == 0) {
+        return false;
     }
 
-    /*
-     * @index is a tri-state variable which has 3 states:
-     * < 0 : post-index, writeback
-     * = 0 : signed offset
-     * > 0 : pre-index, writeback
-     */
-    switch (op1) {
-    case 0:
-        if (op2 != 0) {
-            /* STG */
-            index = op2 - 2;
-        } else {
-            /* STZGM */
-            if (s->current_el == 0 || offset != 0) {
-                goto do_unallocated;
-            }
-            is_mult = is_zero = true;
-        }
-        break;
-    case 1:
-        if (op2 != 0) {
-            /* STZG */
-            is_zero = true;
-            index = op2 - 2;
-        } else {
-            /* LDG */
-            is_load = true;
-        }
-        break;
-    case 2:
-        if (op2 != 0) {
-            /* ST2G */
-            is_pair = true;
-            index = op2 - 2;
-        } else {
-            /* STGM */
-            if (s->current_el == 0 || offset != 0) {
-                goto do_unallocated;
-            }
-            is_mult = true;
-        }
-        break;
-    case 3:
-        if (op2 != 0) {
-            /* STZ2G */
-            is_pair = is_zero = true;
-            index = op2 - 2;
-        } else {
-            /* LDGM */
-            if (s->current_el == 0 || offset != 0) {
-                goto do_unallocated;
-            }
-            is_mult = is_load = true;
-        }
-        break;
-
-    default:
-    do_unallocated:
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (is_mult
-        ? !dc_isar_feature(aa64_mte, s)
-        : !dc_isar_feature(aa64_mte_insn_reg, s)) {
-        goto do_unallocated;
-    }
-
-    if (rn == 31) {
+    if (a->rn == 31) {
         gen_check_sp_alignment(s);
     }
 
-    addr = read_cpu_reg_sp(s, rn, true);
-    if (index >= 0) {
+    addr = read_cpu_reg_sp(s, a->rn, true);
+    tcg_gen_addi_i64(addr, addr, a->imm);
+    tcg_rt = cpu_reg(s, a->rt);
+
+    if (s->ata) {
+        gen_helper_stzgm_tags(cpu_env, addr, tcg_rt);
+    }
+    /*
+     * The non-tags portion of STZGM is mostly like DC_ZVA,
+     * except the alignment happens before the access.
+     */
+    clean_addr = clean_data_tbi(s, addr);
+    tcg_gen_andi_i64(clean_addr, clean_addr, -size);
+    gen_helper_dc_zva(cpu_env, clean_addr);
+    return true;
+}
+
+static bool trans_STGM(DisasContext *s, arg_ldst_tag *a)
+{
+    TCGv_i64 addr, clean_addr, tcg_rt;
+
+    if (!dc_isar_feature(aa64_mte, s)) {
+        return false;
+    }
+    if (s->current_el == 0) {
+        return false;
+    }
+
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+
+    addr = read_cpu_reg_sp(s, a->rn, true);
+    tcg_gen_addi_i64(addr, addr, a->imm);
+    tcg_rt = cpu_reg(s, a->rt);
+
+    if (s->ata) {
+        gen_helper_stgm(cpu_env, addr, tcg_rt);
+    } else {
+        MMUAccessType acc = MMU_DATA_STORE;
+        int size = 4 << GMID_EL1_BS;
+
+        clean_addr = clean_data_tbi(s, addr);
+        tcg_gen_andi_i64(clean_addr, clean_addr, -size);
+        gen_probe_access(s, clean_addr, acc, size);
+    }
+    return true;
+}
+
+static bool trans_LDGM(DisasContext *s, arg_ldst_tag *a)
+{
+    TCGv_i64 addr, clean_addr, tcg_rt;
+
+    if (!dc_isar_feature(aa64_mte, s)) {
+        return false;
+    }
+    if (s->current_el == 0) {
+        return false;
+    }
+
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+
+    addr = read_cpu_reg_sp(s, a->rn, true);
+    tcg_gen_addi_i64(addr, addr, a->imm);
+    tcg_rt = cpu_reg(s, a->rt);
+
+    if (s->ata) {
+        gen_helper_ldgm(tcg_rt, cpu_env, addr);
+    } else {
+        MMUAccessType acc = MMU_DATA_LOAD;
+        int size = 4 << GMID_EL1_BS;
+
+        clean_addr = clean_data_tbi(s, addr);
+        tcg_gen_andi_i64(clean_addr, clean_addr, -size);
+        gen_probe_access(s, clean_addr, acc, size);
+        /* The result tags are zeros.  */
+        tcg_gen_movi_i64(tcg_rt, 0);
+    }
+    return true;
+}
+
+static bool trans_LDG(DisasContext *s, arg_ldst_tag *a)
+{
+    TCGv_i64 addr, clean_addr, tcg_rt;
+
+    if (!dc_isar_feature(aa64_mte_insn_reg, s)) {
+        return false;
+    }
+
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+
+    addr = read_cpu_reg_sp(s, a->rn, true);
+    if (!a->p) {
         /* pre-index or signed offset */
-        tcg_gen_addi_i64(addr, addr, offset);
+        tcg_gen_addi_i64(addr, addr, a->imm);
     }
 
-    if (is_mult) {
-        tcg_rt = cpu_reg(s, rt);
+    tcg_gen_andi_i64(addr, addr, -TAG_GRANULE);
+    tcg_rt = cpu_reg(s, a->rt);
+    if (s->ata) {
+        gen_helper_ldg(tcg_rt, cpu_env, addr, tcg_rt);
+    } else {
+        /*
+         * Tag access disabled: we must check for aborts on the load
+         * load from [rn+offset], and then insert a 0 tag into rt.
+         */
+        clean_addr = clean_data_tbi(s, addr);
+        gen_probe_access(s, clean_addr, MMU_DATA_LOAD, MO_8);
+        gen_address_with_allocation_tag0(tcg_rt, tcg_rt);
+    }
 
-        if (is_zero) {
-            int size = 4 << s->dcz_blocksize;
-
-            if (s->ata) {
-                gen_helper_stzgm_tags(cpu_env, addr, tcg_rt);
-            }
-            /*
-             * The non-tags portion of STZGM is mostly like DC_ZVA,
-             * except the alignment happens before the access.
-             */
-            clean_addr = clean_data_tbi(s, addr);
-            tcg_gen_andi_i64(clean_addr, clean_addr, -size);
-            gen_helper_dc_zva(cpu_env, clean_addr);
-        } else if (s->ata) {
-            if (is_load) {
-                gen_helper_ldgm(tcg_rt, cpu_env, addr);
-            } else {
-                gen_helper_stgm(cpu_env, addr, tcg_rt);
-            }
-        } else {
-            MMUAccessType acc = is_load ? MMU_DATA_LOAD : MMU_DATA_STORE;
-            int size = 4 << GMID_EL1_BS;
-
-            clean_addr = clean_data_tbi(s, addr);
-            tcg_gen_andi_i64(clean_addr, clean_addr, -size);
-            gen_probe_access(s, clean_addr, acc, size);
-
-            if (is_load) {
-                /* The result tags are zeros.  */
-                tcg_gen_movi_i64(tcg_rt, 0);
-            }
+    if (a->w) {
+        /* pre-index or post-index */
+        if (a->p) {
+            /* post-index */
+            tcg_gen_addi_i64(addr, addr, a->imm);
         }
-        return;
+        tcg_gen_mov_i64(cpu_reg_sp(s, a->rn), addr);
+    }
+    return true;
+}
+
+static bool do_STG(DisasContext *s, arg_ldst_tag *a, bool is_zero, bool is_pair)
+{
+    TCGv_i64 addr, tcg_rt;
+
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
     }
 
-    if (is_load) {
-        tcg_gen_andi_i64(addr, addr, -TAG_GRANULE);
-        tcg_rt = cpu_reg(s, rt);
-        if (s->ata) {
-            gen_helper_ldg(tcg_rt, cpu_env, addr, tcg_rt);
+    addr = read_cpu_reg_sp(s, a->rn, true);
+    if (!a->p) {
+        /* pre-index or signed offset */
+        tcg_gen_addi_i64(addr, addr, a->imm);
+    }
+    tcg_rt = cpu_reg_sp(s, a->rt);
+    if (!s->ata) {
+        /*
+         * For STG and ST2G, we need to check alignment and probe memory.
+         * TODO: For STZG and STZ2G, we could rely on the stores below,
+         * at least for system mode; user-only won't enforce alignment.
+         */
+        if (is_pair) {
+            gen_helper_st2g_stub(cpu_env, addr);
         } else {
-            /*
-             * Tag access disabled: we must check for aborts on the load
-             * load from [rn+offset], and then insert a 0 tag into rt.
-             */
-            clean_addr = clean_data_tbi(s, addr);
-            gen_probe_access(s, clean_addr, MMU_DATA_LOAD, MO_8);
-            gen_address_with_allocation_tag0(tcg_rt, tcg_rt);
+            gen_helper_stg_stub(cpu_env, addr);
+        }
+    } else if (tb_cflags(s->base.tb) & CF_PARALLEL) {
+        if (is_pair) {
+            gen_helper_st2g_parallel(cpu_env, addr, tcg_rt);
+        } else {
+            gen_helper_stg_parallel(cpu_env, addr, tcg_rt);
         }
     } else {
-        tcg_rt = cpu_reg_sp(s, rt);
-        if (!s->ata) {
-            /*
-             * For STG and ST2G, we need to check alignment and probe memory.
-             * TODO: For STZG and STZ2G, we could rely on the stores below,
-             * at least for system mode; user-only won't enforce alignment.
-             */
-            if (is_pair) {
-                gen_helper_st2g_stub(cpu_env, addr);
-            } else {
-                gen_helper_stg_stub(cpu_env, addr);
-            }
-        } else if (tb_cflags(s->base.tb) & CF_PARALLEL) {
-            if (is_pair) {
-                gen_helper_st2g_parallel(cpu_env, addr, tcg_rt);
-            } else {
-                gen_helper_stg_parallel(cpu_env, addr, tcg_rt);
-            }
+        if (is_pair) {
+            gen_helper_st2g(cpu_env, addr, tcg_rt);
         } else {
-            if (is_pair) {
-                gen_helper_st2g(cpu_env, addr, tcg_rt);
-            } else {
-                gen_helper_stg(cpu_env, addr, tcg_rt);
-            }
+            gen_helper_stg(cpu_env, addr, tcg_rt);
         }
     }
 
@@ -3911,32 +3916,21 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
         }
     }
 
-    if (index != 0) {
+    if (a->w) {
         /* pre-index or post-index */
-        if (index < 0) {
+        if (a->p) {
             /* post-index */
-            tcg_gen_addi_i64(addr, addr, offset);
+            tcg_gen_addi_i64(addr, addr, a->imm);
         }
-        tcg_gen_mov_i64(cpu_reg_sp(s, rn), addr);
+        tcg_gen_mov_i64(cpu_reg_sp(s, a->rn), addr);
     }
+    return true;
 }
 
-/* Loads and stores */
-static void disas_ldst(DisasContext *s, uint32_t insn)
-{
-    switch (extract32(insn, 24, 6)) {
-    case 0x19:
-        if (extract32(insn, 21, 1) != 0) {
-            disas_ldst_tag(s, insn);
-        } else {
-            unallocated_encoding(s);
-        }
-        break;
-    default:
-        unallocated_encoding(s);
-        break;
-    }
-}
+TRANS_FEAT(STG, aa64_mte_insn_reg, do_STG, a, false, false)
+TRANS_FEAT(STZG, aa64_mte_insn_reg, do_STG, a, true, false)
+TRANS_FEAT(ST2G, aa64_mte_insn_reg, do_STG, a, false, true)
+TRANS_FEAT(STZ2G, aa64_mte_insn_reg, do_STG, a, true, true)
 
 typedef void ArithTwoOp(TCGv_i64, TCGv_i64, TCGv_i64);
 
@@ -13832,12 +13826,6 @@ static bool btype_destination_ok(uint32_t insn, bool bt, int btype)
 static void disas_a64_legacy(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 25, 4)) {
-    case 0x4:
-    case 0x6:
-    case 0xc:
-    case 0xe:      /* Loads and stores */
-        disas_ldst(s, insn);
-        break;
     case 0x5:
     case 0xd:      /* Data processing - register */
         disas_data_proc_reg(s, insn);
-- 
2.34.1


