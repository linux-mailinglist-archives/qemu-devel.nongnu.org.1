Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D835D7A2DAB
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:31:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM0s-0005xS-8U; Fri, 15 Sep 2023 23:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0p-0005wT-Ru
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:27 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0o-00080v-5b
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:27 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68cbbff84f6so2777426b3a.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835025; x=1695439825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfBRrxx77NvM2gONPN+r7Oxv4+eOWyWr5yF2/BMEzhk=;
 b=xBXtvXlWFdKnj++OWDhF3a9txGNLDNRWohlnhABUPN/jxIrA6ypGx011qwQ4uPEPds
 EWKWcDMbj0BXDFhtAlX8aK4CVmYbK/dwAnhj4N4ZzqffcTh371LebTMu+pje0D5u9PaD
 u0g/UCE3FKISgQMGAzOUNTIACZv4fMCYrtTNTZQ3JNJG4w38VdvqSocRLg35VVSpxiIV
 NrIiYRVPBj218XhgKIhOTRMsCluceBGN/tqlrAqYjGTqRhXvjw7X34rUyjGsJQYqOeFf
 +WoRWMdBhtJVAoxrmZR+8Dbn/LeTjzRqkzIJdXkEsAhc+NL8X2HYZShDWE2Z6R0mI6UL
 gBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835025; x=1695439825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gfBRrxx77NvM2gONPN+r7Oxv4+eOWyWr5yF2/BMEzhk=;
 b=gIv4o/tXenhIIRVpKgWdQvYrmg+TN2aSeutYX1p/KLIaf2VeyPxerBoFYWEwpUIxGm
 2ivLPxxvprJIQOBLDx9jN2VfF7PWwL/unuiEi64TgJamFB01QgFbw4FzCmlcry2sCESK
 r12CTX9xAs0BqQuD08Y2j+LrzEaS+f8S1jJsqz02PSLyx01fHChlZThKOOxnLLZKvXvq
 2EAD6RjSEN72oR6/nR2cBudYpQ4mOdRd0qhb0SJswl1dTJE3cr+AgL9YtT+h86JTFqEQ
 WcU8Nw35AN0ZSbCh4Gy9TkDdudrIlEHZUxkI5UZf57XgVh8LUjuyu20mhwCnc7Obv2jd
 euNQ==
X-Gm-Message-State: AOJu0Yxg3LeB3o+g6MEPzjh0VoSYZYBbxeFcfk89DhqZ0t+IHzo3wCUi
 ANoy5UTqbXPRXBvWLaqDJ71Y/3YDDtFFH/bbIts=
X-Google-Smtp-Source: AGHT+IFuLaG/jYlBKrhTAGV/pEnRgINJnrnGB11PXiLbZxBU3KgqI6eYSSNa3/B5QncLpiFUANA6JQ==
X-Received: by 2002:a05:6a21:3299:b0:159:c07d:66f0 with SMTP id
 yt25-20020a056a21329900b00159c07d66f0mr4447856pzb.6.1694835024734; 
 Fri, 15 Sep 2023 20:30:24 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>
Subject: [PULL 12/39] tcg/loongarch64: Lower neg_vec to vneg
Date: Fri, 15 Sep 2023 20:29:44 -0700
Message-Id: <20230916033011.479144-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
Message-Id: <20230908022302.180442-8-c@jia.je>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.h     | 2 +-
 tcg/loongarch64/tcg-target.c.inc | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index f9c5cb12ca..64c72d0857 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -178,7 +178,7 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_v256             0
 
 #define TCG_TARGET_HAS_not_vec          1
-#define TCG_TARGET_HAS_neg_vec          0
+#define TCG_TARGET_HAS_neg_vec          1
 #define TCG_TARGET_HAS_abs_vec          0
 #define TCG_TARGET_HAS_andc_vec         1
 #define TCG_TARGET_HAS_orc_vec          1
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index d569e443dd..b36b706e39 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1695,6 +1695,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         [TCG_COND_LTU] = {OPC_VSLTI_BU, OPC_VSLTI_HU, OPC_VSLTI_WU, OPC_VSLTI_DU},
     };
     LoongArchInsn insn;
+    static const LoongArchInsn neg_vec_insn[4] = {
+        OPC_VNEG_B, OPC_VNEG_H, OPC_VNEG_W, OPC_VNEG_D
+    };
 
     a0 = args[0];
     a1 = args[1];
@@ -1793,6 +1796,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sub_vec:
         tcg_out_addsub_vec(s, vece, a0, a1, a2, const_args[2], false);
         break;
+    case INDEX_op_neg_vec:
+        tcg_out32(s, encode_vdvj_insn(neg_vec_insn[vece], a0, a1));
+        break;
     case INDEX_op_dupm_vec:
         tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
         break;
@@ -1818,6 +1824,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_xor_vec:
     case INDEX_op_nor_vec:
     case INDEX_op_not_vec:
+    case INDEX_op_neg_vec:
         return 1;
     default:
         return 0;
@@ -1995,6 +2002,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I2(w, w, w);
 
     case INDEX_op_not_vec:
+    case INDEX_op_neg_vec:
         return C_O1_I1(w, w);
 
     default:
-- 
2.34.1


