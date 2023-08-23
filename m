Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC1D786182
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:28:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOl-0000Qk-CT; Wed, 23 Aug 2023 16:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOb-0008RA-84
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:05 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOW-0005Vk-Sq
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:04 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bd9b4f8e0eso40226145ad.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822233; x=1693427033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D7NIoRhXITmVWSRN6hbMfoA30tKZp5gKe/MKfIU5oaA=;
 b=vNpyvuQCKkCNwxgHHz1aVZz56q4+lzC6GSnOpRx2Wu/SFkI26j4+3jW0AIqTZthd0F
 +oC1IIpzn19jk41D+3Pu0pt7Q/dLlNBAHMsSl0+7AslJIzVS+T4aUkJpz4I1qYVe7UwS
 TXPrVgsD0G8KQnobmpXXIzB2kG6TQgeh0q48Uez2926PC0DR3dtJFaNgGFOwbIDrDG/x
 mO+ivJR9rZiisdKWV+JcgX6507TZhjOv/itjPzaf5FOFNOza9hxEszt8X1iM2IEEBW59
 P60g8hp2hoimEvCQpYXynRPXZtEGYHmgpsCndZ34aDma08hA3jbFg+Gz7SyVyE5HoxyF
 0RFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822233; x=1693427033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D7NIoRhXITmVWSRN6hbMfoA30tKZp5gKe/MKfIU5oaA=;
 b=j7GyquiYYUwv6gFP5n3DYX7AITiXYyCmUhUDfUDgJdv6ovJn1sLH95tjfwwzwxOg+o
 Wz0/mgDl1fGeZ8hm90Di6gA+dmqi9pT2abGGNt9dcyVrOIdt1KsFiPBuvQGzLC+Zsr5U
 oGvXuMkgNxddQYpXKnZlDpJwZmCqD1dY+hiO4OsGqxz8IojA9PEy8EkzypMYSCBrtWrn
 MeCn5p3xpnYa+ck36LYz9Dyqw3V40sDBckse+Eae4/KDEd5OoAmDyobhMUcaP1SU7hTv
 wAS+u/sMK1xLXXf2RGVcOqCgN8WiF3U5tjF6OPo0MFCdjirSP4TFpQJECnnLqIzCprls
 ujJA==
X-Gm-Message-State: AOJu0YwjnqgMBY403Z9RO9N4b1p+H+scI4Ib9GuL8zrOsPhWEvUnrI0S
 PPYU3JLWblwqKJlR72bZGbTI7cqdZ0NTHOAbX6o=
X-Google-Smtp-Source: AGHT+IGLAXplrlwjDLFu4untaKBl/4TWDm9507lqVkVdo/GbETiJIfj6AIoQPPZtKq2NLtQR38P1UA==
X-Received: by 2002:a17:902:f54f:b0:1bd:f1ae:309d with SMTP id
 h15-20020a170902f54f00b001bdf1ae309dmr12547544plf.9.1692822232680; 
 Wed, 23 Aug 2023 13:23:52 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 27/48] tcg/aarch64: Implement negsetcond_*
Date: Wed, 23 Aug 2023 13:23:05 -0700
Message-Id: <20230823202326.1353645-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Trivial, as aarch64 has an instruction for this: CSETM.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     |  4 ++--
 tcg/aarch64/tcg-target.c.inc | 12 ++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index bfa3e5aae9..98727ea53b 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -86,7 +86,7 @@ typedef enum {
 #define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_movcond_i32      1
-#define TCG_TARGET_HAS_negsetcond_i32   0
+#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_mulu2_i32        0
@@ -123,7 +123,7 @@ typedef enum {
 #define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_movcond_i64      1
-#define TCG_TARGET_HAS_negsetcond_i64   0
+#define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_mulu2_i64        0
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 35ca80cd56..7d8d114c9e 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2262,6 +2262,16 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
                      TCG_REG_XZR, tcg_invert_cond(args[3]));
         break;
 
+    case INDEX_op_negsetcond_i32:
+        a2 = (int32_t)a2;
+        /* FALLTHRU */
+    case INDEX_op_negsetcond_i64:
+        tcg_out_cmp(s, ext, a1, a2, c2);
+        /* Use CSETM alias of CSINV Wd, WZR, WZR, invert(cond).  */
+        tcg_out_insn(s, 3506, CSINV, ext, a0, TCG_REG_XZR,
+                     TCG_REG_XZR, tcg_invert_cond(args[3]));
+        break;
+
     case INDEX_op_movcond_i32:
         a2 = (int32_t)a2;
         /* FALLTHRU */
@@ -2868,6 +2878,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sub_i64:
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rA);
 
     case INDEX_op_mul_i32:
-- 
2.34.1


