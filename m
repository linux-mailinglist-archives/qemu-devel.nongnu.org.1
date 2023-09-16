Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DB47A2DC3
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:37:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM0x-0005zW-94; Fri, 15 Sep 2023 23:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0s-0005xU-37
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:30 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0q-00081O-Cc
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:29 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-69002ef0104so2341746b3a.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835026; x=1695439826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2de48uTbbzZLTdNLRXaaMxYnIH3bKWLRjpewcWvUdMk=;
 b=cJdRh88ybDNs6aF9yA56491pfqiK/qSiwXXktAAVW7QP/LgG6UVrm1IRQFdT9D5E/P
 JXSxc33lyKGRxzMiDqG+y6otRPSAAABOd2YeGpXgOW2eEzuY1H1R7Jp6b7NYEwYW6U57
 YoPgxigVWpR26IxYrs4uf9QP5h1dYfMDS7z5gTd2lxOnc4e3nVxAvp+xIjIkSiXyTDCA
 yxdObufEcyyEIHzH+9v8KwjvN1a+4SeHFOZBc9FAjShgN4rSfcFbnPLcVv6u8FcNsTIh
 MO3sNBLL1hSHVbK7sNeHwczKwoTl9Q1p8KdFHDeYrtM4HpYzh8HVumAOCFPtWQlTn79s
 GSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835026; x=1695439826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2de48uTbbzZLTdNLRXaaMxYnIH3bKWLRjpewcWvUdMk=;
 b=D3fDp2m2pjcTeXlZmwCMmT/T1zwQ/rjJmY6isJxIoFy38rtWo8WM63fpC3zFfrdm9u
 FDC1hNnOvR5K5kEXCMi8NLdIe0TEPZkVEPCvYworiAl0lFo5mTwllOwkCmIk+ugpsZTq
 9/Q1EKYSCzHwm4BdPL/GjV459f5ejvQVonZqohAqbai++sTP/v4KfOR3Zn6KDdr10ure
 PTtm7rhFXtskA9A2ZSdKrYvBjsqcmMmU2FtZ3599ftgjaEbe5WOJEGl9ruAOtKQjTsPU
 IwIz8kxDOLVrI+t2yrm1NZLBk0VdX7EJ8Xqs0ZrjxHLH9sSDAP6XjYKd/pUFKQzpJ8pI
 Gjfg==
X-Gm-Message-State: AOJu0Yys82yrPuEGJ+iJljHljBH2pBTJN9CX8Ps/rcNMtRxzr5kEABMo
 C+xuVQspGGPypkOLdnq3cme1LnDC65unwqPVznE=
X-Google-Smtp-Source: AGHT+IEAahN/9jrQewoThg2dmaAdh8NTSbQ5GxerlxGLp8wbR+c0zIirG7s7+SlFbZ18wLSo7ZLuwQ==
X-Received: by 2002:a05:6a00:80c:b0:68f:efc2:ba51 with SMTP id
 m12-20020a056a00080c00b0068fefc2ba51mr3945556pfk.21.1694835026577; 
 Fri, 15 Sep 2023 20:30:26 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>
Subject: [PULL 14/39] tcg/loongarch64: Lower vector min max ops
Date: Fri, 15 Sep 2023 20:29:46 -0700
Message-Id: <20230916033011.479144-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

- smin_vec
- smax_vec
- umin_vec
- umax_vec

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230908022302.180442-10-c@jia.je>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.h     |  2 +-
 tcg/loongarch64/tcg-target.c.inc | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 2c2266ed31..ec725aaeaa 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -193,7 +193,7 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_rots_vec         0
 #define TCG_TARGET_HAS_rotv_vec         0
 #define TCG_TARGET_HAS_sat_vec          0
-#define TCG_TARGET_HAS_minmax_vec       0
+#define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       0
 #define TCG_TARGET_HAS_cmpsel_vec       0
 
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 0814f62905..bdf22d8807 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1701,6 +1701,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static const LoongArchInsn mul_vec_insn[4] = {
         OPC_VMUL_B, OPC_VMUL_H, OPC_VMUL_W, OPC_VMUL_D
     };
+    static const LoongArchInsn smin_vec_insn[4] = {
+        OPC_VMIN_B, OPC_VMIN_H, OPC_VMIN_W, OPC_VMIN_D
+    };
+    static const LoongArchInsn umin_vec_insn[4] = {
+        OPC_VMIN_BU, OPC_VMIN_HU, OPC_VMIN_WU, OPC_VMIN_DU
+    };
+    static const LoongArchInsn smax_vec_insn[4] = {
+        OPC_VMAX_B, OPC_VMAX_H, OPC_VMAX_W, OPC_VMAX_D
+    };
+    static const LoongArchInsn umax_vec_insn[4] = {
+        OPC_VMAX_BU, OPC_VMAX_HU, OPC_VMAX_WU, OPC_VMAX_DU
+    };
 
     a0 = args[0];
     a1 = args[1];
@@ -1805,6 +1817,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_mul_vec:
         tcg_out32(s, encode_vdvjvk_insn(mul_vec_insn[vece], a0, a1, a2));
         break;
+    case INDEX_op_smin_vec:
+        tcg_out32(s, encode_vdvjvk_insn(smin_vec_insn[vece], a0, a1, a2));
+        break;
+    case INDEX_op_smax_vec:
+        tcg_out32(s, encode_vdvjvk_insn(smax_vec_insn[vece], a0, a1, a2));
+        break;
+    case INDEX_op_umin_vec:
+        tcg_out32(s, encode_vdvjvk_insn(umin_vec_insn[vece], a0, a1, a2));
+        break;
+    case INDEX_op_umax_vec:
+        tcg_out32(s, encode_vdvjvk_insn(umax_vec_insn[vece], a0, a1, a2));
+        break;
     case INDEX_op_dupm_vec:
         tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
         break;
@@ -1832,6 +1856,10 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_not_vec:
     case INDEX_op_neg_vec:
     case INDEX_op_mul_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_umin_vec:
+    case INDEX_op_umax_vec:
         return 1;
     default:
         return 0;
@@ -2007,6 +2035,10 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_xor_vec:
     case INDEX_op_nor_vec:
     case INDEX_op_mul_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_umin_vec:
+    case INDEX_op_umax_vec:
         return C_O1_I2(w, w, w);
 
     case INDEX_op_not_vec:
-- 
2.34.1


