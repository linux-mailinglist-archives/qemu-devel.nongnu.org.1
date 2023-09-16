Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B197A2DBE
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:37:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM12-00062Z-5L; Fri, 15 Sep 2023 23:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0w-0005zf-UY
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:35 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0v-00082v-A4
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:34 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3a9b41ffe12so1765951b6e.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835032; x=1695439832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J5eCTTbGKug1UNNDIbUgVVHxENMXa5Ibqy6ai76Xrb8=;
 b=blJfa8jyOBEJ+y40zMDMXAXuMAXs7ezHdsenmF4RnTHDzu5HmvYsG7VWOHkuYW8qZ+
 qcmNfePXNayFxDg9o9eNfuRwD9SAsyH7ULuPc0C6f8Td2oQHRrYp/AOIULLG2dhpYw+8
 9sccMjE78vFd9B/E0zqFXXDEJd6KWU/PbHkzzcVmmBMPhnyOUoTAggaibpsdvhAzYzCM
 sAYUpnDKZCytTExvFHx5Fm5mPg5/hxAAcd2khalt7XBpepbsp69uBNF3oxNHCo8qDxOg
 Td+F+UNXL7FzzK8WkJy/QmigeOYVwUWn/pVC8XS0sAGD2y8YYcFpoTEyZ+PKYZ7s3lRi
 Kazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835032; x=1695439832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J5eCTTbGKug1UNNDIbUgVVHxENMXa5Ibqy6ai76Xrb8=;
 b=Ni60L7642DOZ5Tr260bDrn2V3sgYzuMODa8SvrYZLPwrcjKjtOm+Ri0+4AGTtVDh/B
 zSciuz9sD8vbrjU2QjMauOyTnTwAAYdzUYcoWGazqbE5NlYe1oO6yus/FjhnYzjtvtyF
 xq3m6h+a9ZN70LtgZ18OnllrghQc4O40af0RfBknGuCKSvMLsjGW4a9pxAf6zcwZ2MrY
 XeMEaYW1HMRK7mz6ZFDi7oLjJ482rNmNxMxAi9DpuTBOL/EBT+BzhFBMUCnc2Cdfy3xw
 sUxosCa7iqna6vZuTTnTaZdVvj2KCLkv9VFCEraySpA89EXydXjAKqFitTs4Y1hQbsDB
 Hkhw==
X-Gm-Message-State: AOJu0Yy4DZPcTrXa3l6tDbYUDNMO9M89bzuoggnao3qjEh57Ij9XqbVS
 x8F0jxq8XBHM6NXeNq4DKp6/cgZKjuzBHh3k0qw=
X-Google-Smtp-Source: AGHT+IEAxgsKQoaj2CrgbWovgMaKOXBTIZY5U2xmbUZfDq7bA0QHmjP7ED7QywW0VlmPy7Qsyyny+g==
X-Received: by 2002:a05:6808:2349:b0:3ac:b12b:9acc with SMTP id
 ef9-20020a056808234900b003acb12b9accmr3215347oib.43.1694835031932; 
 Fri, 15 Sep 2023 20:30:31 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>
Subject: [PULL 20/39] tcg/loongarch64: Lower rotli_vec to vrotri
Date: Fri, 15 Sep 2023 20:29:52 -0700
Message-Id: <20230916033011.479144-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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
Message-Id: <20230908022302.180442-16-c@jia.je>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.h     |  2 +-
 tcg/loongarch64/tcg-target.c.inc | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index d5c69bc192..67b0a95532 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -189,7 +189,7 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          1
-#define TCG_TARGET_HAS_roti_vec         0
+#define TCG_TARGET_HAS_roti_vec         1
 #define TCG_TARGET_HAS_rots_vec         0
 #define TCG_TARGET_HAS_rotv_vec         1
 #define TCG_TARGET_HAS_sat_vec          1
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 8f448823b0..82901d678a 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1902,6 +1902,26 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out32(s, encode_vdvjvk_insn(rotrv_vec_insn[vece], a0, a1,
                                         temp_vec));
         break;
+    case INDEX_op_rotli_vec:
+        /* rotli_vec a1, a2 = rotri_vec a1, -a2 */
+        a2 = extract32(-a2, 0, 3 + vece);
+        switch (vece) {
+        case MO_8:
+            tcg_out_opc_vrotri_b(s, a0, a1, a2);
+            break;
+        case MO_16:
+            tcg_out_opc_vrotri_h(s, a0, a1, a2);
+            break;
+        case MO_32:
+            tcg_out_opc_vrotri_w(s, a0, a1, a2);
+            break;
+        case MO_64:
+            tcg_out_opc_vrotri_d(s, a0, a1, a2);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        break;
     case INDEX_op_bitsel_vec:
         /* vbitsel vd, vj, vk, va = bitsel_vec vd, va, vk, vj */
         tcg_out_opc_vbitsel_v(s, a0, a3, a2, a1);
@@ -2140,6 +2160,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
+    case INDEX_op_rotli_vec:
         return C_O1_I1(w, w);
 
     case INDEX_op_bitsel_vec:
-- 
2.34.1


