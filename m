Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A37B7A2DC1
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:37:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM0v-0005yo-Hk; Fri, 15 Sep 2023 23:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0q-0005wl-SN
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:28 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0p-00081D-6H
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:28 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68fb6fd2836so2583244b3a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835025; x=1695439825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5dphprXiVkWukG2aEdEE9+dyRDyj0wtRjPfPE48D/nE=;
 b=rAwDXOfhTyg+4kCUTzS1L+EKE7lKnVfoFitYjpDi6+8cSPoyHeMJi67U3dtJ/RugEQ
 a5yW++B1PHlmiTPoBcZcWzTjli6SeJzqEAW2NvzBcKwj5F1uYyE4Qzl9MJ/aRS4PB8oq
 u4mjWknhxR+mbdA6Zjkm4EYdsW6z+dZBsfQmlStHqfu04yYBpGCseceIRmyrSf2LZuvG
 xV8b2Fsm8lohAg94kd7rZjJmRexJUHtQ5Y2ZrYmRD8k5uu1S7ckSdimgn7M98GBRJLIr
 lkJk1BTbJey6JSDCahEmINFubd3b/FU8o0gwDUGSl4LanAdVBCqRh0buZyRwo8bCDKAj
 CYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835025; x=1695439825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5dphprXiVkWukG2aEdEE9+dyRDyj0wtRjPfPE48D/nE=;
 b=Fesd3TsBt9t2cOMQM9pHUfYXAQZYPvMnws5y/InodcTl6u6S+bi7Pzaa6HEQvF44mv
 YAM4jyhRD2nJlW21SNbXMaa0utno0tmHPRlri0dHs77QoPXd6Fr6bFxHgULWNpLaP5Mh
 QGG1UfQpmm1FrTqsOWqEF9h6IiI4pX3QesueACXwd5epNYifBBtkMTVUinBbmHnI7cXj
 hcohdH4tcgyBnhisiW2emR8uhRv6UqaS/npGpx9nrydrZjhPJr2EdXzpeEYugQ8pW9o+
 lc35QFC58U+rhtMwkgjR4QirpIlNN2Wf0kCorYTsn0tPWAH1rFYSDb//dg775Sfldby9
 H71Q==
X-Gm-Message-State: AOJu0YwuDp1PFiDqAXA39JgWlvkJXjmfSFJE59V1FO+1KjA1V4deONWN
 DwUwWbv89sZjTv3RLTstYMKis+tiA1ApxUd+4+0=
X-Google-Smtp-Source: AGHT+IFOQjSS5ayXp8Stf2euwb4uisrnLq/8uuVgVCKlGK8FkRO0ntgQwZiVM8s3W9DX1JqS5b6BmA==
X-Received: by 2002:a05:6a00:c96:b0:68f:d864:596 with SMTP id
 a22-20020a056a000c9600b0068fd8640596mr4297267pfv.3.1694835025616; 
 Fri, 15 Sep 2023 20:30:25 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>
Subject: [PULL 13/39] tcg/loongarch64: Lower mul_vec to vmul
Date: Fri, 15 Sep 2023 20:29:45 -0700
Message-Id: <20230916033011.479144-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
Message-Id: <20230908022302.180442-9-c@jia.je>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.h     | 2 +-
 tcg/loongarch64/tcg-target.c.inc | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 64c72d0857..2c2266ed31 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -185,7 +185,7 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_nand_vec         0
 #define TCG_TARGET_HAS_nor_vec          1
 #define TCG_TARGET_HAS_eqv_vec          0
-#define TCG_TARGET_HAS_mul_vec          0
+#define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          0
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index b36b706e39..0814f62905 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1698,6 +1698,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static const LoongArchInsn neg_vec_insn[4] = {
         OPC_VNEG_B, OPC_VNEG_H, OPC_VNEG_W, OPC_VNEG_D
     };
+    static const LoongArchInsn mul_vec_insn[4] = {
+        OPC_VMUL_B, OPC_VMUL_H, OPC_VMUL_W, OPC_VMUL_D
+    };
 
     a0 = args[0];
     a1 = args[1];
@@ -1799,6 +1802,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_neg_vec:
         tcg_out32(s, encode_vdvj_insn(neg_vec_insn[vece], a0, a1));
         break;
+    case INDEX_op_mul_vec:
+        tcg_out32(s, encode_vdvjvk_insn(mul_vec_insn[vece], a0, a1, a2));
+        break;
     case INDEX_op_dupm_vec:
         tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
         break;
@@ -1825,6 +1831,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_nor_vec:
     case INDEX_op_not_vec:
     case INDEX_op_neg_vec:
+    case INDEX_op_mul_vec:
         return 1;
     default:
         return 0;
@@ -1999,6 +2006,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_orc_vec:
     case INDEX_op_xor_vec:
     case INDEX_op_nor_vec:
+    case INDEX_op_mul_vec:
         return C_O1_I2(w, w, w);
 
     case INDEX_op_not_vec:
-- 
2.34.1


