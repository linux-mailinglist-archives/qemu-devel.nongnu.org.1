Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0928077377A
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:16:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTD98-00026U-Jq; Mon, 07 Aug 2023 23:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTD8l-0001LU-F3
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:12:11 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTD8Y-0000Fx-52
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:12:11 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-56cc3453e31so3410284eaf.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 20:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691464316; x=1692069116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gzWqj3MGsLV9R8E01giJK4jPvvtSNzy1Q6wuC0RlJy0=;
 b=iaBPZHwCCJjII0luF2VFInF0s3stMkq78vyinGgfBvld8ys7lxSqYSfoAepgzogzwH
 eF7vcq4yuZMCNRYKN3GbQAzFmqKJ4qMDhQFW5Kyf3o1sBOlUyTaP6xooNV2D9JotLUaZ
 IDdg5bVUL7qeaSGRQPYvFA/vlO9Ef5oFJfZCvDvJGaX7/xabdmnJrqr7J053S/ymary0
 t1IGGkBoGSFsSaV9ooy8/JNzw3BMdbT3ykhzEvxpgYp7BfLMkRJiV/9D4NVCH9gpjq2t
 cbPzZ0pRWj+4djc2VN/aoSwGMaVMS6Uxq5lHH8b3n7puY6zZh9DnP4dbTgFSq0JAvKwm
 TQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691464316; x=1692069116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gzWqj3MGsLV9R8E01giJK4jPvvtSNzy1Q6wuC0RlJy0=;
 b=DiZPZThTOWSwFf6xH0M3Y8hz7d52yOL+fkuogHrR86lUdsrx36C1rdQTwMGvSDNFYc
 FJ4Kqxz/+uiElMoXKbFQ2g0iGOe17/IdtluOslExYsqTzsyfeZtepHsyanU4jLr1PkVe
 qCJfcTQs+KrPWcScx+7U+J8iaOKFA4DRRCM/K1xArDQMooG8GRCWQT4heNQAJ1rvsmE7
 IdFfZO/tP7uPBdutPQig+lkIg66BKH2Lv/7RaRkK/BrxE4VCY6F36rqwkgxpoQw7yGaF
 bgE55HJEqAMfG/vmTqa2VbvjpUm5uM+v55hxSNXMD/iFoLuDBD3u37xGDIK4reU3aeeb
 kfvQ==
X-Gm-Message-State: AOJu0Yx2ILPQl7iu7WNxkk73rHnLC9aSLYiWdbXDMsHMvhAIGKovg1xA
 L3l4DRx87ITQWnjLW9dRPWNJJTu+e6QeDa9I7ng=
X-Google-Smtp-Source: AGHT+IG3nuxQLfzEbRuGOp4NYX4TOiyBpI8WfAtTn3/TdTG7dpBxLYyeEJpydbT/RnD00LVwTfDFVA==
X-Received: by 2002:a05:6358:990e:b0:134:d4c3:c47d with SMTP id
 w14-20020a056358990e00b00134d4c3c47dmr8521568rwa.6.1691464316347; 
 Mon, 07 Aug 2023 20:11:56 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 g64-20020a636b43000000b0055bf96b11d9sm5639087pgc.89.2023.08.07.20.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:11:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PATCH 13/24] tcg/arm: Implement negsetcond_i32
Date: Mon,  7 Aug 2023 20:11:32 -0700
Message-Id: <20230808031143.50925-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808031143.50925-1-richard.henderson@linaro.org>
References: <20230808031143.50925-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Trivial, as we simply need to load a different constant
in the conditional move.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.h     | 2 +-
 tcg/arm/tcg-target.c.inc | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index b076d033a9..b064bbda9f 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -122,7 +122,7 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_div_i32          use_idiv_instructions
 #define TCG_TARGET_HAS_rem_i32          0
-#define TCG_TARGET_HAS_negsetcond_i32   0
+#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 83e286088f..162df38c73 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1975,6 +1975,14 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_dat_imm(s, tcg_cond_to_arm_cond[tcg_invert_cond(args[3])],
                         ARITH_MOV, args[0], 0, 0);
         break;
+    case INDEX_op_negsetcond_i32:
+        tcg_out_dat_rIN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0,
+                        args[1], args[2], const_args[2]);
+        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[args[3]],
+                        ARITH_MVN, args[0], 0, 0);
+        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[tcg_invert_cond(args[3])],
+                        ARITH_MOV, args[0], 0, 0);
+        break;
 
     case INDEX_op_brcond2_i32:
         c = tcg_out_cmp2(s, args, const_args);
@@ -2112,6 +2120,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_add_i32:
     case INDEX_op_sub_i32:
     case INDEX_op_setcond_i32:
+    case INDEX_op_negsetcond_i32:
         return C_O1_I2(r, r, rIN);
 
     case INDEX_op_and_i32:
-- 
2.34.1


