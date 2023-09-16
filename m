Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 011DB7A2DB7
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:33:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM0r-0005wp-Kw; Fri, 15 Sep 2023 23:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0n-0005uy-B1
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:25 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0l-00080H-9J
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:25 -0400
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-76dc77fd024so179721385a.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835022; x=1695439822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pv+L2Y6wQzG+8Jbcm5tEtwONQWwTMgFDuUJNKMtcQJo=;
 b=tCr6qUKjKNHA+KrO2RmajoTL7R70LYSc56QTz14eqNBcMaYZxsWbVGMd/5aX1kOfmE
 J0L/3ludP3RckjETJy2yBwng4fapJ0vRErKICyDICN6pCAj13fodg3qRft+OZIVnbPjh
 apv8Xfy1YshEOD6vl0wBNIm7atH7097oG5E/NTb/zO0Jr9FoanlkFV+5EEGXrx76yA36
 lSoY0C7Fbc8y8OXjpMNUCnVGyBOJSm0L7odotk5rB7ADqgIeKx6CGK4+hOVZKXVynybP
 51slGh97iFG0BH18c8qWk3zQpwvzyxtwKasi7ZfIIjN75D+nHQxRZvUuzjoOoB1P8FuJ
 tVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835022; x=1695439822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pv+L2Y6wQzG+8Jbcm5tEtwONQWwTMgFDuUJNKMtcQJo=;
 b=F7fn7eocWbmSNnCwQ+j0R2RQeJN9jcO2K2RXeTwThR5rY95StwkZ6g+hV7t333hcuo
 4IwYs7/9HPPoZOwNywGt2HuzBpyidJnB/AOeSomKhJNCNcBU4ZlRNCLzKGRxLu0Nq4Uj
 NFZwmJUjIHZf0Lk0G6gZ6ClikOQbd/AROlDTTVbkrPO5c9r1ABmc+Q6vXKuD8LvRrcmf
 vY2WbpQIBK0qBPu793SPViSavbIyVGzNaTeOfWkC3dQwsCsg7xjjz1S6nrvMpO23Jlef
 Nj/PLFI8n3gMbxbC9WkdoXdzbPF1BlqbbxI2qpGojNnOLjPPWqkHykyaqpWu0hVGScRU
 H6OA==
X-Gm-Message-State: AOJu0YxVR9VCFMqnTbklb6kHQnyD5RuF8uxEWpd0Iv1TBv7WJEUMUQGt
 R8SvL1vZ6yYD3SwKpGX1PBfjazGZWKN4HI5KsoU=
X-Google-Smtp-Source: AGHT+IF7M9ozVwKlEjgFv1JUmn2hkYuHtxlHIHNwj18DxelQKnhbsNnTd1+8jit8GFvU9P5PIM5MMA==
X-Received: by 2002:a05:620a:25c9:b0:76d:95d0:c80a with SMTP id
 y9-20020a05620a25c900b0076d95d0c80amr4127555qko.3.1694835022102; 
 Fri, 15 Sep 2023 20:30:22 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>
Subject: [PULL 09/39] tcg/loongarch64: Lower cmp_vec to vseq/vsle/vslt
Date: Fri, 15 Sep 2023 20:29:41 -0700
Message-Id: <20230916033011.479144-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x729.google.com
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

From: Jiajie Chen <c@jia.je>

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230908022302.180442-5-c@jia.je>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target-con-set.h |  1 +
 tcg/loongarch64/tcg-target-con-str.h |  1 +
 tcg/loongarch64/tcg-target.c.inc     | 65 ++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
index 37b3f80bf9..8c8ea5d919 100644
--- a/tcg/loongarch64/tcg-target-con-set.h
+++ b/tcg/loongarch64/tcg-target-con-set.h
@@ -31,4 +31,5 @@ C_O1_I2(r, 0, rZ)
 C_O1_I2(r, rZ, ri)
 C_O1_I2(r, rZ, rJ)
 C_O1_I2(r, rZ, rZ)
+C_O1_I2(w, w, wM)
 C_O1_I4(r, rZ, rJ, rZ, rZ)
diff --git a/tcg/loongarch64/tcg-target-con-str.h b/tcg/loongarch64/tcg-target-con-str.h
index 81b8d40278..a8a1c44014 100644
--- a/tcg/loongarch64/tcg-target-con-str.h
+++ b/tcg/loongarch64/tcg-target-con-str.h
@@ -26,3 +26,4 @@ CONST('U', TCG_CT_CONST_U12)
 CONST('Z', TCG_CT_CONST_ZERO)
 CONST('C', TCG_CT_CONST_C12)
 CONST('W', TCG_CT_CONST_WSZ)
+CONST('M', TCG_CT_CONST_VCMP)
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 07a0326e5d..129dd92910 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -176,6 +176,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_U12   0x800
 #define TCG_CT_CONST_C12   0x1000
 #define TCG_CT_CONST_WSZ   0x2000
+#define TCG_CT_CONST_VCMP  0x4000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
@@ -209,6 +210,10 @@ static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
     if ((ct & TCG_CT_CONST_WSZ) && val == (type == TCG_TYPE_I32 ? 32 : 64)) {
         return true;
     }
+    int64_t vec_val = sextract64(val, 0, 8 << vece);
+    if ((ct & TCG_CT_CONST_VCMP) && -0x10 <= vec_val && vec_val <= 0x1f) {
+        return true;
+    }
     return false;
 }
 
@@ -1624,6 +1629,23 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     TCGType type = vecl + TCG_TYPE_V64;
     TCGArg a0, a1, a2;
     TCGReg temp = TCG_REG_TMP0;
+    TCGReg temp_vec = TCG_VEC_TMP0;
+
+    static const LoongArchInsn cmp_vec_insn[16][4] = {
+        [TCG_COND_EQ] = {OPC_VSEQ_B, OPC_VSEQ_H, OPC_VSEQ_W, OPC_VSEQ_D},
+        [TCG_COND_LE] = {OPC_VSLE_B, OPC_VSLE_H, OPC_VSLE_W, OPC_VSLE_D},
+        [TCG_COND_LEU] = {OPC_VSLE_BU, OPC_VSLE_HU, OPC_VSLE_WU, OPC_VSLE_DU},
+        [TCG_COND_LT] = {OPC_VSLT_B, OPC_VSLT_H, OPC_VSLT_W, OPC_VSLT_D},
+        [TCG_COND_LTU] = {OPC_VSLT_BU, OPC_VSLT_HU, OPC_VSLT_WU, OPC_VSLT_DU},
+    };
+    static const LoongArchInsn cmp_vec_imm_insn[16][4] = {
+        [TCG_COND_EQ] = {OPC_VSEQI_B, OPC_VSEQI_H, OPC_VSEQI_W, OPC_VSEQI_D},
+        [TCG_COND_LE] = {OPC_VSLEI_B, OPC_VSLEI_H, OPC_VSLEI_W, OPC_VSLEI_D},
+        [TCG_COND_LEU] = {OPC_VSLEI_BU, OPC_VSLEI_HU, OPC_VSLEI_WU, OPC_VSLEI_DU},
+        [TCG_COND_LT] = {OPC_VSLTI_B, OPC_VSLTI_H, OPC_VSLTI_W, OPC_VSLTI_D},
+        [TCG_COND_LTU] = {OPC_VSLTI_BU, OPC_VSLTI_HU, OPC_VSLTI_WU, OPC_VSLTI_DU},
+    };
+    LoongArchInsn insn;
 
     a0 = args[0];
     a1 = args[1];
@@ -1651,6 +1673,45 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
             tcg_out_opc_vldx(s, a0, a1, temp);
         }
         break;
+    case INDEX_op_cmp_vec:
+        TCGCond cond = args[3];
+        if (const_args[2]) {
+            /*
+             * cmp_vec dest, src, value
+             * Try vseqi/vslei/vslti
+             */
+            int64_t value = sextract64(a2, 0, 8 << vece);
+            if ((cond == TCG_COND_EQ || cond == TCG_COND_LE || \
+                 cond == TCG_COND_LT) && (-0x10 <= value && value <= 0x0f)) {
+                tcg_out32(s, encode_vdvjsk5_insn(cmp_vec_imm_insn[cond][vece], \
+                                                 a0, a1, value));
+                break;
+            } else if ((cond == TCG_COND_LEU || cond == TCG_COND_LTU) &&
+                (0x00 <= value && value <= 0x1f)) {
+                tcg_out32(s, encode_vdvjuk5_insn(cmp_vec_imm_insn[cond][vece], \
+                                                 a0, a1, value));
+                break;
+            }
+
+            /*
+             * Fallback to:
+             * dupi_vec temp, a2
+             * cmp_vec a0, a1, temp, cond
+             */
+            tcg_out_dupi_vec(s, type, vece, temp_vec, a2);
+            a2 = temp_vec;
+        }
+
+        insn = cmp_vec_insn[cond][vece];
+        if (insn == 0) {
+            TCGArg t;
+            t = a1, a1 = a2, a2 = t;
+            cond = tcg_swap_cond(cond);
+            insn = cmp_vec_insn[cond][vece];
+            tcg_debug_assert(insn != 0);
+        }
+        tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
+        break;
     case INDEX_op_dupm_vec:
         tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
         break;
@@ -1666,6 +1727,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_st_vec:
     case INDEX_op_dup_vec:
     case INDEX_op_dupm_vec:
+    case INDEX_op_cmp_vec:
         return 1;
     default:
         return 0;
@@ -1827,6 +1889,9 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_st_vec:
         return C_O0_I2(w, r);
 
+    case INDEX_op_cmp_vec:
+        return C_O1_I2(w, w, wM);
+
     default:
         g_assert_not_reached();
     }
-- 
2.34.1


