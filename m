Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0097A2DB4
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:32:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM0q-0005wX-QD; Fri, 15 Sep 2023 23:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0o-0005vn-TN
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:26 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0n-00080g-66
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:26 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1cc87405650so1546657fac.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835024; x=1695439824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zC9LwHupRZOOVIlUKyTywfJngscB13vMEOLvBb7yseM=;
 b=t7vZswWn/MwdMcityVwMkohsxaqOc4IeWDTcgMm9uXAp9WfrpnqABFYK+khzC8PSVH
 lAbFFAyW6Ars+77p9FDHWPDdefTa50TA/k9pwnZIiWBADoiazuwPgEioQe2SfEDjPnWQ
 6BfJeC0AUrKw0tspO78vyiRo4LPyxeETRy0jae6Vm1Gizbah8RovsQqncJ8xiGAMJAKh
 kaGk20gCrFAlmuf3poNSdqB55bWDepVQUiEuGVdFRBdetKs57iP7rMOAp4DRcKxKvXCO
 7Dt/Ux771HyNAG2H4OvSEekZ+gz67RTRAEk7hhah/4aize+iR640qr9ZyZJW2NcTVnZj
 Ww9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835024; x=1695439824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zC9LwHupRZOOVIlUKyTywfJngscB13vMEOLvBb7yseM=;
 b=MeFE9U9FS+wBCvbaig7MtI2unkIuZIYabDHR7cD/ivsoUHORSDpeMIh3HxkoyIhNFU
 56d993FadeNsTBOuC1mi4mJt9e4gdsQ2wn3pRBycYm9/9oxkwMpILqC+HpxOMTJBDoZo
 U9BoBdWDbqFtHxpq/r9hkah/Do7QC5/aMjGBMcZMvULe+jk/wozwGK56hNUvyie3WhRA
 sND2bFt7VxZfswL+XUHiSIdG23+XP8NSXxcwQlTX0Qev0fBk+N5W2UzPPIpChILFyeu/
 YMQ1qFJhwr1U/jJLJq+zrFb2UTRVsCBayQzOscCVjBqwjk7xwU5AXP3z0DsremfclKgO
 wT7A==
X-Gm-Message-State: AOJu0YwRE0BBM+VeaqbXRJnSza8ly/97Az8KboKmhnTyfdRbjdrmepEX
 UkdMLgmrBDfonFpjhmRNhlVhGWc75t0COAx+tdY=
X-Google-Smtp-Source: AGHT+IGlyCmnHEmq2rG/w7SFFkILgpbbW1FbqxrizCVxbXpiO51Myxfp6TUnJR9918WPwDb3MeVZ1Q==
X-Received: by 2002:a05:6871:291:b0:1b0:60ff:b73f with SMTP id
 i17-20020a056871029100b001b060ffb73fmr4226368oae.8.1694835023924; 
 Fri, 15 Sep 2023 20:30:23 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>
Subject: [PULL 11/39] tcg/loongarch64: Lower vector bitwise operations
Date: Fri, 15 Sep 2023 20:29:43 -0700
Message-Id: <20230916033011.479144-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

- and_vec
- andc_vec
- or_vec
- orc_vec
- xor_vec
- nor_vec
- not_vec

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230908022302.180442-7-c@jia.je>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target-con-set.h |  2 ++
 tcg/loongarch64/tcg-target.h         |  8 ++---
 tcg/loongarch64/tcg-target.c.inc     | 44 ++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
index 2d5dce75c3..3f530ad4d8 100644
--- a/tcg/loongarch64/tcg-target-con-set.h
+++ b/tcg/loongarch64/tcg-target-con-set.h
@@ -20,6 +20,7 @@ C_O0_I2(rZ, rZ)
 C_O0_I2(w, r)
 C_O1_I1(r, r)
 C_O1_I1(w, r)
+C_O1_I1(w, w)
 C_O1_I2(r, r, rC)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rI)
@@ -31,6 +32,7 @@ C_O1_I2(r, 0, rZ)
 C_O1_I2(r, rZ, ri)
 C_O1_I2(r, rZ, rJ)
 C_O1_I2(r, rZ, rZ)
+C_O1_I2(w, w, w)
 C_O1_I2(w, w, wM)
 C_O1_I2(w, w, wA)
 C_O1_I4(r, rZ, rJ, rZ, rZ)
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index daaf38ee31..f9c5cb12ca 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -177,13 +177,13 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_v128             use_lsx_instructions
 #define TCG_TARGET_HAS_v256             0
 
-#define TCG_TARGET_HAS_not_vec          0
+#define TCG_TARGET_HAS_not_vec          1
 #define TCG_TARGET_HAS_neg_vec          0
 #define TCG_TARGET_HAS_abs_vec          0
-#define TCG_TARGET_HAS_andc_vec         0
-#define TCG_TARGET_HAS_orc_vec          0
+#define TCG_TARGET_HAS_andc_vec         1
+#define TCG_TARGET_HAS_orc_vec          1
 #define TCG_TARGET_HAS_nand_vec         0
-#define TCG_TARGET_HAS_nor_vec          0
+#define TCG_TARGET_HAS_nor_vec          1
 #define TCG_TARGET_HAS_eqv_vec          0
 #define TCG_TARGET_HAS_mul_vec          0
 #define TCG_TARGET_HAS_shi_vec          0
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 1a369b237c..d569e443dd 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1722,6 +1722,32 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
             tcg_out_opc_vldx(s, a0, a1, temp);
         }
         break;
+    case INDEX_op_and_vec:
+        tcg_out_opc_vand_v(s, a0, a1, a2);
+        break;
+    case INDEX_op_andc_vec:
+        /*
+         * vandn vd, vj, vk: vd = vk & ~vj
+         * andc_vec vd, vj, vk: vd = vj & ~vk
+         * vk and vk are swapped
+         */
+        tcg_out_opc_vandn_v(s, a0, a2, a1);
+        break;
+    case INDEX_op_or_vec:
+        tcg_out_opc_vor_v(s, a0, a1, a2);
+        break;
+    case INDEX_op_orc_vec:
+        tcg_out_opc_vorn_v(s, a0, a1, a2);
+        break;
+    case INDEX_op_xor_vec:
+        tcg_out_opc_vxor_v(s, a0, a1, a2);
+        break;
+    case INDEX_op_nor_vec:
+        tcg_out_opc_vnor_v(s, a0, a1, a2);
+        break;
+    case INDEX_op_not_vec:
+        tcg_out_opc_vnor_v(s, a0, a1, a1);
+        break;
     case INDEX_op_cmp_vec:
         TCGCond cond = args[3];
         if (const_args[2]) {
@@ -1785,6 +1811,13 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_cmp_vec:
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_andc_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_orc_vec:
+    case INDEX_op_xor_vec:
+    case INDEX_op_nor_vec:
+    case INDEX_op_not_vec:
         return 1;
     default:
         return 0;
@@ -1953,6 +1986,17 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sub_vec:
         return C_O1_I2(w, w, wA);
 
+    case INDEX_op_and_vec:
+    case INDEX_op_andc_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_orc_vec:
+    case INDEX_op_xor_vec:
+    case INDEX_op_nor_vec:
+        return C_O1_I2(w, w, w);
+
+    case INDEX_op_not_vec:
+        return C_O1_I1(w, w);
+
     default:
         g_assert_not_reached();
     }
-- 
2.34.1


