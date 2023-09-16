Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB807A2DCE
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:38:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM10-00061R-6W; Fri, 15 Sep 2023 23:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0u-0005yx-TD
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:32 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0t-00082S-A9
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:32 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3adba6c031dso374728b6e.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835030; x=1695439830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=reSm3C417FMyjux222VAwgN8xaF2NffDq7ii4SeKnfI=;
 b=mtkF3AQ/1YDXa4eidmioQk2idreKvah/47BHl10NXd0tXbVU+TUXoz65lJZJNbBXK/
 N3sFevzbKjQcpnaoiO9LEDFku7zD8KHMcGxYL0dvJXZbIkedDETjmo39vBD6JuLluJzI
 haAO76k9yf0fO1m/KHzYeP3m4w1RAbAUHaIh4HH+DhSV0eeMypbUF30y7GXrYFUOaaQ5
 TiSBa+8Bk7HaMcDcZpbXCX4jP4Xfin/6q4Fgn1B07xIfCwoJM6BO6Y1VeZoUhMsNWoiN
 JxCn2aNz8nr8zM2dv9ThGJVd0Xi1MHwZGnuoVL0t4L4lT7GKycbD9M2ZmFcKNKhBGYak
 B6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835030; x=1695439830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=reSm3C417FMyjux222VAwgN8xaF2NffDq7ii4SeKnfI=;
 b=MW1HdQ3kgFl/ZEoqAbbI2wlPmGFwBmQ1ZA12DqTkiwwAzD3aZKey25tPsjvO3+e1rD
 ZBCI92oZ8NbafKnBv9wJxX2CVhRAfK4llRPK5fXsSARm0tRh5yq5jpkAwDPD9dXqShur
 EgFCycjYwW1sAWtgxbJmbf3FhpIQgXAZ6EOUDPrZUqksCmhVgTgdCS8+jbwMMaVUvuNj
 7vWpIbRvLNhTOIO7tcDg0fX9YhUtcw3Th33P7dIlhwdzpWCU1lsmfA1W+0FvmzzMMM+K
 zrIMTNYHgjoCQ+tnmY1c3Gn9xxljMkqg9DD9tSCFsoDcoq0c3DLmnYVPCEpsnCsGzKOc
 AOJg==
X-Gm-Message-State: AOJu0YwKOeT+2256Pxu/IrURDjeKY2Woz+PBBlR1Qc2jX/2cOSMNCbUr
 0nQvSz4g4g0QMF3EIrpJGhYs4trDPtJKHmtMtSk=
X-Google-Smtp-Source: AGHT+IE9EK3Fx1o5yAqs5GoOthb7i3vYyXKiW2q1PNN9xv3huHWHokszv4cSaG0Le2gkAVtfUFY2Sw==
X-Received: by 2002:a05:6808:7c1:b0:3a7:c13:c8d1 with SMTP id
 f1-20020a05680807c100b003a70c13c8d1mr3982900oij.17.1694835030082; 
 Fri, 15 Sep 2023 20:30:30 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>
Subject: [PULL 18/39] tcg/loongarch64: Lower vector shift integer ops
Date: Fri, 15 Sep 2023 20:29:50 -0700
Message-Id: <20230916033011.479144-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

- shli_vec
- shrv_vec
- sarv_vec

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230908022302.180442-14-c@jia.je>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.h     |  2 +-
 tcg/loongarch64/tcg-target.c.inc | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index bc56939a57..d7b806e252 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -186,7 +186,7 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_nor_vec          1
 #define TCG_TARGET_HAS_eqv_vec          0
 #define TCG_TARGET_HAS_mul_vec          1
-#define TCG_TARGET_HAS_shi_vec          0
+#define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          1
 #define TCG_TARGET_HAS_roti_vec         0
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index a33ec594ee..c21c917083 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1734,6 +1734,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static const LoongArchInsn sarv_vec_insn[4] = {
         OPC_VSRA_B, OPC_VSRA_H, OPC_VSRA_W, OPC_VSRA_D
     };
+    static const LoongArchInsn shli_vec_insn[4] = {
+        OPC_VSLLI_B, OPC_VSLLI_H, OPC_VSLLI_W, OPC_VSLLI_D
+    };
+    static const LoongArchInsn shri_vec_insn[4] = {
+        OPC_VSRLI_B, OPC_VSRLI_H, OPC_VSRLI_W, OPC_VSRLI_D
+    };
+    static const LoongArchInsn sari_vec_insn[4] = {
+        OPC_VSRAI_B, OPC_VSRAI_H, OPC_VSRAI_W, OPC_VSRAI_D
+    };
 
     a0 = args[0];
     a1 = args[1];
@@ -1872,6 +1881,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sarv_vec:
         tcg_out32(s, encode_vdvjvk_insn(sarv_vec_insn[vece], a0, a1, a2));
         break;
+    case INDEX_op_shli_vec:
+        tcg_out32(s, encode_vdvjuk3_insn(shli_vec_insn[vece], a0, a1, a2));
+        break;
+    case INDEX_op_shri_vec:
+        tcg_out32(s, encode_vdvjuk3_insn(shri_vec_insn[vece], a0, a1, a2));
+        break;
+    case INDEX_op_sari_vec:
+        tcg_out32(s, encode_vdvjuk3_insn(sari_vec_insn[vece], a0, a1, a2));
+        break;
     case INDEX_op_bitsel_vec:
         /* vbitsel vd, vj, vk, va = bitsel_vec vd, va, vk, vj */
         tcg_out_opc_vbitsel_v(s, a0, a3, a2, a1);
@@ -2105,6 +2123,9 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_not_vec:
     case INDEX_op_neg_vec:
+    case INDEX_op_shli_vec:
+    case INDEX_op_shri_vec:
+    case INDEX_op_sari_vec:
         return C_O1_I1(w, w);
 
     case INDEX_op_bitsel_vec:
-- 
2.34.1


