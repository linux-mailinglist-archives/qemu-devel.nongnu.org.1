Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 181F29ABC3A
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Oct 2024 05:36:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3S9Z-0007Pk-6g; Tue, 22 Oct 2024 23:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S98-00070k-QY
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:56 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S92-0008LY-Kc
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:54 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20c693b68f5so68099915ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729654479; x=1730259279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejQ3abjWoK898OKlrmsQMhX9Q7Lzbw38F/N2+EDuzW0=;
 b=m5HoNYxKncTEZlHXIGUwckNf74O0i8EUUljp6kWczv2vC6CmfQXuw9//wlj58yS+WD
 +MTuJVbuesyEHiASRwTg2A5Z7uBDzNOOGkXmnA0kxlucNrK6qshbmsQWhABXHPNWf6ZD
 DiAm+YiJ9Xy3J8srecyuK1KQ6QUnnfpxzuNslvlU3rK/kG4OlJW3W4Fj6axr4b6Et3g0
 KdGkNW/jrn6vQI9nRYQ47U5wa6vrZjYJRUoC1CFODVOe3up16WAsNgFkYHN1wKJVtAgP
 Ed2blZoJtrQf02/r5N5lf0uZ0LoldVAOCUPnoz5Ha3OS22afSbczZYmJBNnwIEJBjIfw
 Otog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729654479; x=1730259279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ejQ3abjWoK898OKlrmsQMhX9Q7Lzbw38F/N2+EDuzW0=;
 b=XdiLtP5K1v/Ws2NFZ1+tjoDH/IOsF2gGWbJljiu2BthCTulkxiOagMLNmgrrKE5L57
 YUEV/Ov+upKNQId1Xr4PsyAt12aylRoZlAvygKx0NErD/YHeS/l5WW/RonaSd0QypA7K
 C588AjXmW794CfM990DAmBhygQa6Q75xdU7FmYxgnDUJzHr6IFEvFGdFex7g76Up73z7
 By6qIAH7ZqBUzOFNg5yAR6MdH4hKKgp92nLsuuwiO34PCXaLp//QzXVF1eow3yIUL6Bw
 UnW4+KDhzoLPFAGlTuiz2AlLeaeJwUFcf4UIn5DZxfyBDceHt/nUFiRI3DPCmkqhCPWV
 ifNQ==
X-Gm-Message-State: AOJu0YwH/5z6zPuxGOBdmUsOlixc7T96oE9Th161OXdib0pX+Llx9zeY
 t1isu62rcMYI2f28Fjw9oHNeBDf7OmBTUGkrtn5FdEpUL90nI4fJ6EyAumdlvv+euVZ0PfVbzRp
 t
X-Google-Smtp-Source: AGHT+IF3bO5UxKMSYJYEcp9JrE7eLGc/wwW+CIIJYMDuf9jq8YeiK3x5KEKDfq7JSHBOxV5JG1JzXQ==
X-Received: by 2002:a05:6a21:2986:b0:1d9:237a:2d55 with SMTP id
 adf61e73a8af0-1d978bae0e5mr1430642637.34.1729654479238; 
 Tue, 22 Oct 2024 20:34:39 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d73b1sm5438338b3a.105.2024.10.22.20.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 20:34:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 07/24] tcg/riscv: Implement vector cmp/cmpsel ops
Date: Tue, 22 Oct 2024 20:34:15 -0700
Message-ID: <20241023033432.1353830-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023033432.1353830-1-richard.henderson@linaro.org>
References: <20241023033432.1353830-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Extend comparison results from mask registers to SEW-width elements,
following recommendations in The RISC-V SPEC Volume I (Version 20240411).
This aligns with TCG's cmp_vec behavior by expanding compare results to
full element width: all 1s for true, all 0s for false.

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241007025700.47259-7-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target-con-set.h |   2 +
 tcg/riscv/tcg-target-con-str.h |   1 +
 tcg/riscv/tcg-target.h         |   2 +-
 tcg/riscv/tcg-target.c.inc     | 255 +++++++++++++++++++++++++--------
 4 files changed, 200 insertions(+), 60 deletions(-)

diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index 6513cebc4c..97e6ecdb0f 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -26,3 +26,5 @@ C_O1_I1(v, r)
 C_O1_I1(v, v)
 C_O1_I2(v, v, v)
 C_O1_I2(v, v, vK)
+C_O1_I2(v, v, vL)
+C_O1_I4(v, v, vL, vK, vK)
diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target-con-str.h
index 0aaad7b753..089efe96ca 100644
--- a/tcg/riscv/tcg-target-con-str.h
+++ b/tcg/riscv/tcg-target-con-str.h
@@ -18,6 +18,7 @@ REGS('v', ALL_VECTOR_REGS)
 CONST('I', TCG_CT_CONST_S12)
 CONST('J', TCG_CT_CONST_J12)
 CONST('K', TCG_CT_CONST_S5)
+CONST('L', TCG_CT_CONST_CMP_VI)
 CONST('N', TCG_CT_CONST_N12)
 CONST('M', TCG_CT_CONST_M12)
 CONST('Z', TCG_CT_CONST_ZERO)
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index acb8dfdf16..94034504b2 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -164,7 +164,7 @@ typedef enum {
 #define TCG_TARGET_HAS_sat_vec          0
 #define TCG_TARGET_HAS_minmax_vec       0
 #define TCG_TARGET_HAS_bitsel_vec       0
-#define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_cmpsel_vec       1
 
 #define TCG_TARGET_HAS_tst_vec          0
 
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index c8540f9a75..1893c419c6 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -106,12 +106,13 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
     return TCG_REG_A0 + slot;
 }
 
-#define TCG_CT_CONST_ZERO  0x100
-#define TCG_CT_CONST_S12   0x200
-#define TCG_CT_CONST_N12   0x400
-#define TCG_CT_CONST_M12   0x800
-#define TCG_CT_CONST_J12  0x1000
-#define TCG_CT_CONST_S5   0x2000
+#define TCG_CT_CONST_ZERO    0x100
+#define TCG_CT_CONST_S12     0x200
+#define TCG_CT_CONST_N12     0x400
+#define TCG_CT_CONST_M12     0x800
+#define TCG_CT_CONST_J12    0x1000
+#define TCG_CT_CONST_S5     0x2000
+#define TCG_CT_CONST_CMP_VI 0x4000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
@@ -120,59 +121,6 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 
 #define sextreg  sextract64
 
-/* test if a constant matches the constraint */
-static bool tcg_target_const_match(int64_t val, int ct,
-                                   TCGType type, TCGCond cond, int vece)
-{
-    if (ct & TCG_CT_CONST) {
-        return 1;
-    }
-    if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
-        return 1;
-    }
-    if (type >= TCG_TYPE_V64) {
-        /* Val is replicated by VECE; extract the highest element. */
-        val >>= (-8 << vece) & 63;
-    }
-    /*
-     * Sign extended from 12 bits: [-0x800, 0x7ff].
-     * Used for most arithmetic, as this is the isa field.
-     */
-    if ((ct & TCG_CT_CONST_S12) && val >= -0x800 && val <= 0x7ff) {
-        return 1;
-    }
-    /*
-     * Sign extended from 12 bits, negated: [-0x7ff, 0x800].
-     * Used for subtraction, where a constant must be handled by ADDI.
-     */
-    if ((ct & TCG_CT_CONST_N12) && val >= -0x7ff && val <= 0x800) {
-        return 1;
-    }
-    /*
-     * Sign extended from 12 bits, +/- matching: [-0x7ff, 0x7ff].
-     * Used by addsub2 and movcond, which may need the negative value,
-     * and requires the modified constant to be representable.
-     */
-    if ((ct & TCG_CT_CONST_M12) && val >= -0x7ff && val <= 0x7ff) {
-        return 1;
-    }
-    /*
-     * Inverse of sign extended from 12 bits: ~[-0x800, 0x7ff].
-     * Used to map ANDN back to ANDI, etc.
-     */
-    if ((ct & TCG_CT_CONST_J12) && ~val >= -0x800 && ~val <= 0x7ff) {
-        return 1;
-    }
-    /*
-     * Sign extended from 5 bits: [-0x10, 0x0f].
-     * Used for vector-immediate.
-     */
-    if ((ct & TCG_CT_CONST_S5) && val >= -0x10 && val <= 0x0f) {
-        return 1;
-    }
-    return 0;
-}
-
 /*
  * RISC-V Base ISA opcodes (IM)
  */
@@ -322,6 +270,9 @@ typedef enum {
     OPC_VS4R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(3),
     OPC_VS8R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(7),
 
+    OPC_VMERGE_VIM = 0x5c000057 | V_OPIVI,
+    OPC_VMERGE_VVM = 0x5c000057 | V_OPIVV,
+
     OPC_VADD_VV = 0x57 | V_OPIVV,
     OPC_VADD_VI = 0x57 | V_OPIVI,
     OPC_VSUB_VV = 0x8000057 | V_OPIVV,
@@ -332,6 +283,29 @@ typedef enum {
     OPC_VXOR_VV = 0x2c000057 | V_OPIVV,
     OPC_VXOR_VI = 0x2c000057 | V_OPIVI,
 
+    OPC_VMSEQ_VV = 0x60000057 | V_OPIVV,
+    OPC_VMSEQ_VI = 0x60000057 | V_OPIVI,
+    OPC_VMSEQ_VX = 0x60000057 | V_OPIVX,
+    OPC_VMSNE_VV = 0x64000057 | V_OPIVV,
+    OPC_VMSNE_VI = 0x64000057 | V_OPIVI,
+    OPC_VMSNE_VX = 0x64000057 | V_OPIVX,
+
+    OPC_VMSLTU_VV = 0x68000057 | V_OPIVV,
+    OPC_VMSLTU_VX = 0x68000057 | V_OPIVX,
+    OPC_VMSLT_VV = 0x6c000057 | V_OPIVV,
+    OPC_VMSLT_VX = 0x6c000057 | V_OPIVX,
+    OPC_VMSLEU_VV = 0x70000057 | V_OPIVV,
+    OPC_VMSLEU_VX = 0x70000057 | V_OPIVX,
+    OPC_VMSLE_VV = 0x74000057 | V_OPIVV,
+    OPC_VMSLE_VX = 0x74000057 | V_OPIVX,
+
+    OPC_VMSLEU_VI = 0x70000057 | V_OPIVI,
+    OPC_VMSLE_VI = 0x74000057 | V_OPIVI,
+    OPC_VMSGTU_VI = 0x78000057 | V_OPIVI,
+    OPC_VMSGTU_VX = 0x78000057 | V_OPIVX,
+    OPC_VMSGT_VI = 0x7c000057 | V_OPIVI,
+    OPC_VMSGT_VX = 0x7c000057 | V_OPIVX,
+
     OPC_VMV_V_V = 0x5e000057 | V_OPIVV,
     OPC_VMV_V_I = 0x5e000057 | V_OPIVI,
     OPC_VMV_V_X = 0x5e000057 | V_OPIVX,
@@ -339,6 +313,101 @@ typedef enum {
     OPC_VMVNR_V = 0x9e000057 | V_OPIVI,
 } RISCVInsn;
 
+static const struct {
+    RISCVInsn op;
+    bool swap;
+} tcg_cmpcond_to_rvv_vv[] = {
+    [TCG_COND_EQ] =  { OPC_VMSEQ_VV,  false },
+    [TCG_COND_NE] =  { OPC_VMSNE_VV,  false },
+    [TCG_COND_LT] =  { OPC_VMSLT_VV,  false },
+    [TCG_COND_GE] =  { OPC_VMSLE_VV,  true  },
+    [TCG_COND_GT] =  { OPC_VMSLT_VV,  true  },
+    [TCG_COND_LE] =  { OPC_VMSLE_VV,  false },
+    [TCG_COND_LTU] = { OPC_VMSLTU_VV, false },
+    [TCG_COND_GEU] = { OPC_VMSLEU_VV, true  },
+    [TCG_COND_GTU] = { OPC_VMSLTU_VV, true  },
+    [TCG_COND_LEU] = { OPC_VMSLEU_VV, false }
+};
+
+static const struct {
+    RISCVInsn op;
+    int min;
+    int max;
+    bool adjust;
+}  tcg_cmpcond_to_rvv_vi[] = {
+    [TCG_COND_EQ]  = { OPC_VMSEQ_VI,  -16, 15, false },
+    [TCG_COND_NE]  = { OPC_VMSNE_VI,  -16, 15, false },
+    [TCG_COND_GT]  = { OPC_VMSGT_VI,  -16, 15, false },
+    [TCG_COND_LE]  = { OPC_VMSLE_VI,  -16, 15, false },
+    [TCG_COND_LT]  = { OPC_VMSLE_VI,  -15, 16, true  },
+    [TCG_COND_GE]  = { OPC_VMSGT_VI,  -15, 16, true  },
+    [TCG_COND_LEU] = { OPC_VMSLEU_VI,   0, 15, false },
+    [TCG_COND_GTU] = { OPC_VMSGTU_VI,   0, 15, false },
+    [TCG_COND_LTU] = { OPC_VMSLEU_VI,   1, 16, true  },
+    [TCG_COND_GEU] = { OPC_VMSGTU_VI,   1, 16, true  },
+};
+
+/* test if a constant matches the constraint */
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
+{
+    if (ct & TCG_CT_CONST) {
+        return 1;
+    }
+    if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
+        return 1;
+    }
+    if (type >= TCG_TYPE_V64) {
+        /* Val is replicated by VECE; extract the highest element. */
+        val >>= (-8 << vece) & 63;
+    }
+    /*
+     * Sign extended from 12 bits: [-0x800, 0x7ff].
+     * Used for most arithmetic, as this is the isa field.
+     */
+    if ((ct & TCG_CT_CONST_S12) && val >= -0x800 && val <= 0x7ff) {
+        return 1;
+    }
+    /*
+     * Sign extended from 12 bits, negated: [-0x7ff, 0x800].
+     * Used for subtraction, where a constant must be handled by ADDI.
+     */
+    if ((ct & TCG_CT_CONST_N12) && val >= -0x7ff && val <= 0x800) {
+        return 1;
+    }
+    /*
+     * Sign extended from 12 bits, +/- matching: [-0x7ff, 0x7ff].
+     * Used by addsub2 and movcond, which may need the negative value,
+     * and requires the modified constant to be representable.
+     */
+    if ((ct & TCG_CT_CONST_M12) && val >= -0x7ff && val <= 0x7ff) {
+        return 1;
+    }
+    /*
+     * Inverse of sign extended from 12 bits: ~[-0x800, 0x7ff].
+     * Used to map ANDN back to ANDI, etc.
+     */
+    if ((ct & TCG_CT_CONST_J12) && ~val >= -0x800 && ~val <= 0x7ff) {
+        return 1;
+    }
+    /*
+     * Sign extended from 5 bits: [-0x10, 0x0f].
+     * Used for vector-immediate.
+     */
+    if ((ct & TCG_CT_CONST_S5) && val >= -0x10 && val <= 0x0f) {
+        return 1;
+    }
+    /*
+     * Used for vector compare OPIVI instructions.
+     */
+    if ((ct & TCG_CT_CONST_CMP_VI) &&
+        val >= tcg_cmpcond_to_rvv_vi[cond].min &&
+        val <= tcg_cmpcond_to_rvv_vi[cond].max) {
+        return true;
+     }
+    return 0;
+}
+
 /*
  * RISC-V immediate and instruction encoders (excludes 16-bit RVC)
  */
@@ -618,6 +687,18 @@ static void tcg_out_opc_vv_vi(TCGContext *s, RISCVInsn o_vv, RISCVInsn o_vi,
     }
 }
 
+static void tcg_out_opc_vim_mask(TCGContext *s, RISCVInsn opc, TCGReg vd,
+                                 TCGReg vs2, int32_t imm)
+{
+    tcg_out32(s, encode_vi(opc, vd, imm, vs2, false));
+}
+
+static void tcg_out_opc_vvm_mask(TCGContext *s, RISCVInsn opc, TCGReg vd,
+                                 TCGReg vs2, TCGReg vs1)
+{
+    tcg_out32(s, encode_v(opc, vd, vs1, vs2, false));
+}
+
 typedef struct VsetCache {
     uint32_t movi_insn;
     uint32_t vset_insn;
@@ -1408,6 +1489,48 @@ static void tcg_out_cltz(TCGContext *s, TCGType type, RISCVInsn insn,
     }
 }
 
+static void tcg_out_cmpsel(TCGContext *s, TCGType type, unsigned vece,
+                           TCGCond cond, TCGReg ret,
+                           TCGReg cmp1, TCGReg cmp2, bool c_cmp2,
+                           TCGReg val1, bool c_val1,
+                           TCGReg val2, bool c_val2)
+{
+    set_vtype_len_sew(s, type, vece);
+
+    /* Use only vmerge_vim if possible, by inverting the test. */
+    if (c_val2 && !c_val1) {
+        TCGArg temp = val1;
+        cond = tcg_invert_cond(cond);
+        val1 = val2;
+        val2 = temp;
+        c_val1 = true;
+        c_val2 = false;
+    }
+
+    /* Perform the comparison into V0 mask. */
+    if (c_cmp2) {
+        tcg_out_opc_vi(s, tcg_cmpcond_to_rvv_vi[cond].op, TCG_REG_V0, cmp1,
+                       cmp2 - tcg_cmpcond_to_rvv_vi[cond].adjust);
+    } else if (tcg_cmpcond_to_rvv_vv[cond].swap) {
+        tcg_out_opc_vv(s, tcg_cmpcond_to_rvv_vv[cond].op,
+                       TCG_REG_V0, cmp2, cmp1);
+    } else {
+        tcg_out_opc_vv(s, tcg_cmpcond_to_rvv_vv[cond].op,
+                       TCG_REG_V0, cmp1, cmp2);
+    }
+    if (c_val1) {
+        if (c_val2) {
+            tcg_out_opc_vi(s, OPC_VMV_V_I, ret, 0, val2);
+            val2 = ret;
+        }
+        /* vd[i] == v0.mask[i] ? imm : vs2[i] */
+        tcg_out_opc_vim_mask(s, OPC_VMERGE_VIM, ret, val2, val1);
+    } else {
+        /* vd[i] == v0.mask[i] ? vs1[i] : vs2[i] */
+        tcg_out_opc_vvm_mask(s, OPC_VMERGE_VVM, ret, val2, val1);
+    }
+}
+
 static void init_setting_vtype(TCGContext *s)
 {
     s->riscv_cur_type = TCG_TYPE_COUNT;
@@ -2244,6 +2367,14 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         set_vtype_len(s, type);
         tcg_out_opc_vi(s, OPC_VXOR_VI, a0, a1, -1);
         break;
+    case INDEX_op_cmp_vec:
+        tcg_out_cmpsel(s, type, vece, args[3], a0, a1, a2, c2,
+                       -1, true, 0, true);
+        break;
+    case INDEX_op_cmpsel_vec:
+        tcg_out_cmpsel(s, type, vece, args[5], a0, a1, a2, c2,
+                       args[3], const_args[3], args[4], const_args[4]);
+        break;
     case INDEX_op_mov_vec: /* Always emitted via tcg_out_mov.  */
     case INDEX_op_dup_vec: /* Always emitted via tcg_out_dup_vec.  */
     default:
@@ -2266,6 +2397,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
     case INDEX_op_not_vec:
+    case INDEX_op_cmp_vec:
+    case INDEX_op_cmpsel_vec:
         return 1;
     default:
         return 0;
@@ -2426,6 +2559,10 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I2(v, v, vK);
     case INDEX_op_sub_vec:
         return C_O1_I2(v, v, v);
+    case INDEX_op_cmp_vec:
+        return C_O1_I2(v, v, vL);
+    case INDEX_op_cmpsel_vec:
+        return C_O1_I4(v, v, vL, vK, vK);
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


