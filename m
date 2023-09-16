Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E707A2DBA
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:36:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM0p-0005wB-S4; Fri, 15 Sep 2023 23:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0n-0005vG-Tg
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:25 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0m-00080U-2x
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:25 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-770ef1f4513so177128885a.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835023; x=1695439823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dNQOpsTrKFG/9ytJ4qmB2azFCQyRzH8Z6QT5wfEw7MI=;
 b=oFa8V4vN7PS4gA/7pfUPfPRaUMEPwzJyUSqUKdbUjvUk4RJ7EmAQtXkFFkcddTtoOu
 1HcSE5ID0x0o2l7eAaf49CBHHrLqSqDTJTt9ybD9M9aplfKLGbflM27APeS9/VNHcmNr
 7hGR6mL5n7btbvm0FM79K4AStJnOGeDjofj41Yv/O8MkNtkQE+YJooZ5DeoYfJwJXF4H
 Wt/tL0aSpE0OvDB30t4JVWh6NfdVKQ1KonyZCzSlbXoi3SzCCmw5/DqzeJmDG+c52iQt
 x7GrFYWwvxKYs04tr2vEnA7dfVXWoqQx3IDVlxljfp3stMK6KjghbhGEGPlYy89iDac6
 R1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835023; x=1695439823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dNQOpsTrKFG/9ytJ4qmB2azFCQyRzH8Z6QT5wfEw7MI=;
 b=m77GtZqMREGCSSqunK1JL2QnqctQtL+NSxrYxxjS4Hei13HEpuVOSCjoT4WYKdj40I
 jOLP4onxLf1UuvkCPRDuCSbAoD7Lojo78hNNPdQAWEyA7Js2gI94Sn/xrqlRjoEd0QPM
 sH6ShIjzjtE18jwa9FKcrs7Y6WNRHHmxDk+Bdjp374vPLyFgUkCY/aR3+r8hb7Dh6Oib
 aJ0/gtjrJqG0dfdXdjAFDilRmqmELZ/OTV984W5Lsx1xzKStoEiq8JNWhCYuyIoSZI34
 uplx0CgcKeChElK3VJLFXW910ooMmdA7NC5p2P3da2Su5DWkjDPIRKhPiQf62UT6/QIE
 qnqg==
X-Gm-Message-State: AOJu0YyTEYrYoC5bMXubSRiFlZFW6RvatKerSu0qAmJ5mkfe1LP0NZtV
 7NOVoBBy/OqIwhIBHtSdKmsAZH9USPKlwqJd1as=
X-Google-Smtp-Source: AGHT+IEV/3hgiybQhXl9aFEFKkuy3EQgYUxrjzzWEPIWIQDZmbdJgRECf7dosXiKFCWR+XWJttJD+Q==
X-Received: by 2002:a37:ef01:0:b0:76c:b53b:8702 with SMTP id
 j1-20020a37ef01000000b0076cb53b8702mr2976289qkk.26.1694835023123; 
 Fri, 15 Sep 2023 20:30:23 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>
Subject: [PULL 10/39] tcg/loongarch64: Lower add/sub_vec to vadd/vsub
Date: Fri, 15 Sep 2023 20:29:42 -0700
Message-Id: <20230916033011.479144-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x734.google.com
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

Lower the following ops:

- add_vec
- sub_vec

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230908022302.180442-6-c@jia.je>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target-con-set.h |  1 +
 tcg/loongarch64/tcg-target-con-str.h |  1 +
 tcg/loongarch64/tcg-target.c.inc     | 61 ++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
index 8c8ea5d919..2d5dce75c3 100644
--- a/tcg/loongarch64/tcg-target-con-set.h
+++ b/tcg/loongarch64/tcg-target-con-set.h
@@ -32,4 +32,5 @@ C_O1_I2(r, rZ, ri)
 C_O1_I2(r, rZ, rJ)
 C_O1_I2(r, rZ, rZ)
 C_O1_I2(w, w, wM)
+C_O1_I2(w, w, wA)
 C_O1_I4(r, rZ, rJ, rZ, rZ)
diff --git a/tcg/loongarch64/tcg-target-con-str.h b/tcg/loongarch64/tcg-target-con-str.h
index a8a1c44014..2ba9c135ac 100644
--- a/tcg/loongarch64/tcg-target-con-str.h
+++ b/tcg/loongarch64/tcg-target-con-str.h
@@ -27,3 +27,4 @@ CONST('Z', TCG_CT_CONST_ZERO)
 CONST('C', TCG_CT_CONST_C12)
 CONST('W', TCG_CT_CONST_WSZ)
 CONST('M', TCG_CT_CONST_VCMP)
+CONST('A', TCG_CT_CONST_VADD)
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 129dd92910..1a369b237c 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -177,6 +177,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_C12   0x1000
 #define TCG_CT_CONST_WSZ   0x2000
 #define TCG_CT_CONST_VCMP  0x4000
+#define TCG_CT_CONST_VADD  0x8000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
@@ -214,6 +215,9 @@ static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
     if ((ct & TCG_CT_CONST_VCMP) && -0x10 <= vec_val && vec_val <= 0x1f) {
         return true;
     }
+    if ((ct & TCG_CT_CONST_VADD) && -0x1f <= vec_val && vec_val <= 0x1f) {
+        return true;
+    }
     return false;
 }
 
@@ -1621,6 +1625,51 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
     }
 }
 
+static void tcg_out_addsub_vec(TCGContext *s, unsigned vece, const TCGArg a0,
+                               const TCGArg a1, const TCGArg a2,
+                               bool a2_is_const, bool is_add)
+{
+    static const LoongArchInsn add_vec_insn[4] = {
+        OPC_VADD_B, OPC_VADD_H, OPC_VADD_W, OPC_VADD_D
+    };
+    static const LoongArchInsn add_vec_imm_insn[4] = {
+        OPC_VADDI_BU, OPC_VADDI_HU, OPC_VADDI_WU, OPC_VADDI_DU
+    };
+    static const LoongArchInsn sub_vec_insn[4] = {
+        OPC_VSUB_B, OPC_VSUB_H, OPC_VSUB_W, OPC_VSUB_D
+    };
+    static const LoongArchInsn sub_vec_imm_insn[4] = {
+        OPC_VSUBI_BU, OPC_VSUBI_HU, OPC_VSUBI_WU, OPC_VSUBI_DU
+    };
+
+    if (a2_is_const) {
+        int64_t value = sextract64(a2, 0, 8 << vece);
+        if (!is_add) {
+            value = -value;
+        }
+
+        /* Try vaddi/vsubi */
+        if (0 <= value && value <= 0x1f) {
+            tcg_out32(s, encode_vdvjuk5_insn(add_vec_imm_insn[vece], a0, \
+                                             a1, value));
+            return;
+        } else if (-0x1f <= value && value < 0) {
+            tcg_out32(s, encode_vdvjuk5_insn(sub_vec_imm_insn[vece], a0, \
+                                             a1, -value));
+            return;
+        }
+
+        /* constraint TCG_CT_CONST_VADD ensures unreachable */
+        g_assert_not_reached();
+    }
+
+    if (is_add) {
+        tcg_out32(s, encode_vdvjvk_insn(add_vec_insn[vece], a0, a1, a2));
+    } else {
+        tcg_out32(s, encode_vdvjvk_insn(sub_vec_insn[vece], a0, a1, a2));
+    }
+}
+
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            unsigned vecl, unsigned vece,
                            const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1712,6 +1761,12 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         }
         tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
         break;
+    case INDEX_op_add_vec:
+        tcg_out_addsub_vec(s, vece, a0, a1, a2, const_args[2], true);
+        break;
+    case INDEX_op_sub_vec:
+        tcg_out_addsub_vec(s, vece, a0, a1, a2, const_args[2], false);
+        break;
     case INDEX_op_dupm_vec:
         tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
         break;
@@ -1728,6 +1783,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_dup_vec:
     case INDEX_op_dupm_vec:
     case INDEX_op_cmp_vec:
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
         return 1;
     default:
         return 0;
@@ -1892,6 +1949,10 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_cmp_vec:
         return C_O1_I2(w, w, wM);
 
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
+        return C_O1_I2(w, w, wA);
+
     default:
         g_assert_not_reached();
     }
-- 
2.34.1


