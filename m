Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE449A9496
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Oct 2024 02:14:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t32VP-0000B0-8A; Mon, 21 Oct 2024 20:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t32V0-0008Uk-Lz
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 20:11:46 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t32Uw-0005U0-J3
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 20:11:45 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e2bb1efe78so3363687a91.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 17:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729555901; x=1730160701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xhq+IoN6vCvTOOHHSITV2/VutlKjJMMqJDBjbqbk8YI=;
 b=uehZJQ7MpsMCYfZk0Tn95XdkYMxNpeg8joq/6UlAaVsGwqaMOz2DQJvM2lGACOLgI1
 GaCy0Pz9dWst4DjLiUTLSgPGh9Vy6l0Zjemv16QdBxpqfBVtotA9khReOfxDYMNhunvQ
 294dXokZmRBYaY3EGvalxxaLdRLggr9GNzsbloskVBCXB7hgrszjqVU5ik8e9SmHFhZK
 ACMo09JtN66J4Pcn4+kspA+oPBIstLqtWWvDV5kM4CDA7AuszUHaCb75raBU++IxINxT
 vaAGKRa7L2Ss/n0FkooXzASCgwkyLK4Evju6xwf1d6uqr8bS/me42lxfaXXWmmRnEEhU
 SyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729555901; x=1730160701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xhq+IoN6vCvTOOHHSITV2/VutlKjJMMqJDBjbqbk8YI=;
 b=uBXIPkcNN5Ygbck4XoZaaoHIsOqlrLYXbv45SaTYFHXxP6qkBnp26LdHCyOnUErDNo
 gNCE+nyZeNbozQU1syxQb/T55vyTgHryDGIrAFHbc1LA74YkTJStVYuJJcmhZoOlj5Cl
 GcfAyOAhZ6/KGSM0zMpw/dYP/m2rpmiGM/nxozgrA3Yzx3gMWFr5THO6+gVAU2daeC5f
 /AHk0A5YS1amOulmvTHmNZUJGkfXshxbvdWDfYkS32UzfKNhutOJvZ4X9NWbC4RC/3KX
 lu0MOHT+iDD52JW7G2SoGCsIyuqRbUVOdRHY8sacvkOoVYJ/ocMTIW9P7VbjdJ4X/iS/
 KAUw==
X-Gm-Message-State: AOJu0YzMyYOgihCdoQUmz6XPfP8kx3H+PuoEAd/6LLM28nyIR6RP2f4q
 dqrVNPzKIPdS2qHl+cdB0TrbpwnEBXhMuHOSq6q6DxuQ6mHOn2QBV1NWlJpmuF7A+JQWytvE8E3
 c
X-Google-Smtp-Source: AGHT+IE0ImhgmC/ru16hUDyqo5mbRbF/9n99Dl8+rsTvLx7SiXjgKdwXWYImy1HMXXewA+LvnQG5dA==
X-Received: by 2002:a17:90a:ae17:b0:2e2:e086:f5c0 with SMTP id
 98e67ed59e1d1-2e5db93c457mr2112368a91.5.1729555900991; 
 Mon, 21 Oct 2024 17:11:40 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0f6462sm31681145ad.272.2024.10.21.17.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 17:11:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, dbarboza@ventanamicro.com, alistair23@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v7 06/14] tcg/riscv: Add support for basic vector opcodes
Date: Mon, 21 Oct 2024 17:11:26 -0700
Message-ID: <20241022001134.828724-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022001134.828724-1-richard.henderson@linaro.org>
References: <20241022001134.828724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241007025700.47259-6-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target-con-set.h |  3 ++
 tcg/riscv/tcg-target-con-str.h |  1 +
 tcg/riscv/tcg-target.h         |  2 +-
 tcg/riscv/tcg-target.c.inc     | 80 ++++++++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index d73a62b0f2..6513cebc4c 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -23,3 +23,6 @@ C_O1_I4(r, r, rI, rM, rM)
 C_O2_I4(r, r, rZ, rZ, rM, rM)
 C_O0_I2(v, r)
 C_O1_I1(v, r)
+C_O1_I1(v, v)
+C_O1_I2(v, v, v)
+C_O1_I2(v, v, vK)
diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target-con-str.h
index b2b3211bcb..0aaad7b753 100644
--- a/tcg/riscv/tcg-target-con-str.h
+++ b/tcg/riscv/tcg-target-con-str.h
@@ -17,6 +17,7 @@ REGS('v', ALL_VECTOR_REGS)
  */
 CONST('I', TCG_CT_CONST_S12)
 CONST('J', TCG_CT_CONST_J12)
+CONST('K', TCG_CT_CONST_S5)
 CONST('N', TCG_CT_CONST_N12)
 CONST('M', TCG_CT_CONST_M12)
 CONST('Z', TCG_CT_CONST_ZERO)
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 12a7a37aaa..acb8dfdf16 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -151,7 +151,7 @@ typedef enum {
 #define TCG_TARGET_HAS_nand_vec         0
 #define TCG_TARGET_HAS_nor_vec          0
 #define TCG_TARGET_HAS_eqv_vec          0
-#define TCG_TARGET_HAS_not_vec          0
+#define TCG_TARGET_HAS_not_vec          1
 #define TCG_TARGET_HAS_neg_vec          0
 #define TCG_TARGET_HAS_abs_vec          0
 #define TCG_TARGET_HAS_roti_vec         0
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 17fcc21b0e..c8540f9a75 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -111,6 +111,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_N12   0x400
 #define TCG_CT_CONST_M12   0x800
 #define TCG_CT_CONST_J12  0x1000
+#define TCG_CT_CONST_S5   0x2000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
@@ -129,6 +130,10 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
         return 1;
     }
+    if (type >= TCG_TYPE_V64) {
+        /* Val is replicated by VECE; extract the highest element. */
+        val >>= (-8 << vece) & 63;
+    }
     /*
      * Sign extended from 12 bits: [-0x800, 0x7ff].
      * Used for most arithmetic, as this is the isa field.
@@ -158,6 +163,13 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_J12) && ~val >= -0x800 && ~val <= 0x7ff) {
         return 1;
     }
+    /*
+     * Sign extended from 5 bits: [-0x10, 0x0f].
+     * Used for vector-immediate.
+     */
+    if ((ct & TCG_CT_CONST_S5) && val >= -0x10 && val <= 0x0f) {
+        return 1;
+    }
     return 0;
 }
 
@@ -310,6 +322,16 @@ typedef enum {
     OPC_VS4R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(3),
     OPC_VS8R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(7),
 
+    OPC_VADD_VV = 0x57 | V_OPIVV,
+    OPC_VADD_VI = 0x57 | V_OPIVI,
+    OPC_VSUB_VV = 0x8000057 | V_OPIVV,
+    OPC_VAND_VV = 0x24000057 | V_OPIVV,
+    OPC_VAND_VI = 0x24000057 | V_OPIVI,
+    OPC_VOR_VV = 0x28000057 | V_OPIVV,
+    OPC_VOR_VI = 0x28000057 | V_OPIVI,
+    OPC_VXOR_VV = 0x2c000057 | V_OPIVV,
+    OPC_VXOR_VI = 0x2c000057 | V_OPIVI,
+
     OPC_VMV_V_V = 0x5e000057 | V_OPIVV,
     OPC_VMV_V_I = 0x5e000057 | V_OPIVI,
     OPC_VMV_V_X = 0x5e000057 | V_OPIVX,
@@ -568,6 +590,12 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
  * With RVV 1.0, vs2 is the first operand, while rs1/imm is the
  * second operand.
  */
+static void tcg_out_opc_vv(TCGContext *s, RISCVInsn opc,
+                           TCGReg vd, TCGReg vs2, TCGReg vs1)
+{
+    tcg_out32(s, encode_v(opc, vd, vs1, vs2, true));
+}
+
 static void tcg_out_opc_vx(TCGContext *s, RISCVInsn opc,
                            TCGReg vd, TCGReg vs2, TCGReg rs1)
 {
@@ -580,6 +608,16 @@ static void tcg_out_opc_vi(TCGContext *s, RISCVInsn opc,
     tcg_out32(s, encode_vi(opc, vd, imm, vs2, true));
 }
 
+static void tcg_out_opc_vv_vi(TCGContext *s, RISCVInsn o_vv, RISCVInsn o_vi,
+                              TCGReg vd, TCGReg vs2, TCGArg vi1, int c_vi1)
+{
+    if (c_vi1) {
+        tcg_out_opc_vi(s, o_vi, vd, vs2, vi1);
+    } else {
+        tcg_out_opc_vv(s, o_vv, vd, vs2, vi1);
+    }
+}
+
 typedef struct VsetCache {
     uint32_t movi_insn;
     uint32_t vset_insn;
@@ -2165,10 +2203,12 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
 {
     TCGType type = vecl + TCG_TYPE_V64;
     TCGArg a0, a1, a2;
+    int c2;
 
     a0 = args[0];
     a1 = args[1];
     a2 = args[2];
+    c2 = const_args[2];
 
     switch (opc) {
     case INDEX_op_dupm_vec:
@@ -2180,6 +2220,30 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_st_vec:
         tcg_out_st(s, type, a0, a1, a2);
         break;
+    case INDEX_op_add_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv_vi(s, OPC_VADD_VV, OPC_VADD_VI, a0, a1, a2, c2);
+        break;
+    case INDEX_op_sub_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VSUB_VV, a0, a1, a2);
+        break;
+    case INDEX_op_and_vec:
+        set_vtype_len(s, type);
+        tcg_out_opc_vv_vi(s, OPC_VAND_VV, OPC_VAND_VI, a0, a1, a2, c2);
+        break;
+    case INDEX_op_or_vec:
+        set_vtype_len(s, type);
+        tcg_out_opc_vv_vi(s, OPC_VOR_VV, OPC_VOR_VI, a0, a1, a2, c2);
+        break;
+    case INDEX_op_xor_vec:
+        set_vtype_len(s, type);
+        tcg_out_opc_vv_vi(s, OPC_VXOR_VV, OPC_VXOR_VI, a0, a1, a2, c2);
+        break;
+    case INDEX_op_not_vec:
+        set_vtype_len(s, type);
+        tcg_out_opc_vi(s, OPC_VXOR_VI, a0, a1, -1);
+        break;
     case INDEX_op_mov_vec: /* Always emitted via tcg_out_mov.  */
     case INDEX_op_dup_vec: /* Always emitted via tcg_out_dup_vec.  */
     default:
@@ -2196,6 +2260,13 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
 int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
 {
     switch (opc) {
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_xor_vec:
+    case INDEX_op_not_vec:
+        return 1;
     default:
         return 0;
     }
@@ -2346,6 +2417,15 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_dupm_vec:
     case INDEX_op_ld_vec:
         return C_O1_I1(v, r);
+    case INDEX_op_not_vec:
+        return C_O1_I1(v, v);
+    case INDEX_op_add_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_xor_vec:
+        return C_O1_I2(v, v, vK);
+    case INDEX_op_sub_vec:
+        return C_O1_I2(v, v, v);
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


