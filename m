Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F15777E48E
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 17:03:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWHwK-0006Z5-WF; Wed, 16 Aug 2023 10:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWHwC-0006KQ-28
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:55:56 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWHw9-0002Qd-DW
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:55:55 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-688787570ccso977500b3a.2
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 07:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692197752; x=1692802552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RrBXPCmtxi2l32z22RsMKS01gRHTx3LMYN0oD4z3IA4=;
 b=nhApJmCzCtugFoJs/TdXOIXkF0lzMG1FpvUDbmwxTbzXjmdiWzZu1g071ZIxRw9ZUi
 v2Mav9ccj53+yGStxowiOkvNP3akWWhb0UD7CtRcK5vWfbqROm7V9575QVhVbbG3dr48
 s54nw5PjXFGOj/qnrHoU01WdkJhu6L6RBxpuqwgFzf32mkbYoIVxmUVavOPe+hGewti1
 06sOBwRChn0pmJdNd3PfyLuWgOjiFnLj5k5hI4CpstkRuZh/s1ML/pKQl+k4rHlzP6aS
 9g/+OUDoPqsNZWvuQrIuuLO2JuU4MKbMXOWpFnO6E5+WITMvjxV6FuUunN1RoZWVQhI3
 YUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692197752; x=1692802552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RrBXPCmtxi2l32z22RsMKS01gRHTx3LMYN0oD4z3IA4=;
 b=TzYaqcrRsmfXKMl/MyJCHpUxVfMZxRd0kUP+055hd2lCX7obbO2aA2nYs1wwcwHxIM
 ASC4EM2aUDoWtGIeuP01S90/ThKfDIfBuMQjX2++gCGD6HHovIAew+zI7Q0RV7t2glBv
 An1NCxzCkT7V+SLDnRy5pQ3Ttf6/7HEZYH5UolZwR/gAXvXKw2TU4QOwj45usDz6Es4+
 oitUBprIh/iwwUS3ynYkTa8PJYesSp++K8wDEYqD13K146xYquEezAof9oaqFuVcWTCK
 nv59jyPjUiSf/6hizSJV50jFXRBAhCKP9Ces7CJXdOCAf4Fn2Kq4XP+DhePOkIyJXLrI
 qzSA==
X-Gm-Message-State: AOJu0YzJNb65qQW4rU2ju2LCICoar6Xxg9PqeB2Tco2ayjyBfZ9DaFvP
 cxSJvXCZLeWwPPaKfXHi2NRIDQcmtMNPtcv4QE8=
X-Google-Smtp-Source: AGHT+IHtY6/2kGuwvq1aXM26wfImuh+poA7jijq9alGwwYvMIsYFmjU6+5l2CodEeACWeG+37AuqeA==
X-Received: by 2002:a05:6a20:8421:b0:141:d54e:a908 with SMTP id
 c33-20020a056a20842100b00141d54ea908mr2647503pzd.41.1692197752079; 
 Wed, 16 Aug 2023 07:55:52 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 fe22-20020a056a002f1600b00682a0184742sm11619069pfb.148.2023.08.16.07.55.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 07:55:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] tcg/i386: Allow immediate as input to deposit_*
Date: Wed, 16 Aug 2023 07:55:47 -0700
Message-Id: <20230816145547.477974-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816145547.477974-1-richard.henderson@linaro.org>
References: <20230816145547.477974-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

We can use MOVB and MOVW with an immediate just as easily
as with a register input.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target-con-set.h |  2 +-
 tcg/i386/tcg-target.c.inc     | 26 ++++++++++++++++++++++----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/tcg/i386/tcg-target-con-set.h b/tcg/i386/tcg-target-con-set.h
index 3949d49538..7d00a7dde8 100644
--- a/tcg/i386/tcg-target-con-set.h
+++ b/tcg/i386/tcg-target-con-set.h
@@ -33,7 +33,7 @@ C_O1_I1(r, q)
 C_O1_I1(r, r)
 C_O1_I1(x, r)
 C_O1_I1(x, x)
-C_O1_I2(q, 0, q)
+C_O1_I2(q, 0, qi)
 C_O1_I2(q, r, re)
 C_O1_I2(r, 0, ci)
 C_O1_I2(r, 0, r)
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index ba40dd0f4d..3045b56002 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -276,6 +276,7 @@ static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
 #define OPC_MOVL_GvEv	(0x8b)		/* loads, more or less */
 #define OPC_MOVB_EvIz   (0xc6)
 #define OPC_MOVL_EvIz	(0xc7)
+#define OPC_MOVB_Ib     (0xb0)
 #define OPC_MOVL_Iv     (0xb8)
 #define OPC_MOVBE_GyMy  (0xf0 | P_EXT38)
 #define OPC_MOVBE_MyGy  (0xf1 | P_EXT38)
@@ -2750,13 +2751,30 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     OP_32_64(deposit):
         if (args[3] == 0 && args[4] == 8) {
             /* load bits 0..7 */
-            tcg_out_modrm(s, OPC_MOVB_EvGv | P_REXB_R | P_REXB_RM, a2, a0);
+            if (const_a2) {
+                tcg_out_opc(s, OPC_MOVB_Ib | P_REXB_RM | LOWREGMASK(a0),
+                            0, a0, 0);
+                tcg_out8(s, a2);
+            } else {
+                tcg_out_modrm(s, OPC_MOVB_EvGv | P_REXB_R | P_REXB_RM, a2, a0);
+            }
         } else if (TCG_TARGET_REG_BITS == 32 && args[3] == 8 && args[4] == 8) {
             /* load bits 8..15 */
-            tcg_out_modrm(s, OPC_MOVB_EvGv, a2, a0 + 4);
+            if (const_a2) {
+                tcg_out8(s, OPC_MOVB_Ib + a0 + 4);
+                tcg_out8(s, a2);
+            } else {
+                tcg_out_modrm(s, OPC_MOVB_EvGv, a2, a0 + 4);
+            }
         } else if (args[3] == 0 && args[4] == 16) {
             /* load bits 0..15 */
-            tcg_out_modrm(s, OPC_MOVL_EvGv | P_DATA16, a2, a0);
+            if (const_a2) {
+                tcg_out_opc(s, OPC_MOVL_Iv | P_DATA16 | LOWREGMASK(a0),
+                            0, a0, 0);
+                tcg_out16(s, a2);
+            } else {
+                tcg_out_modrm(s, OPC_MOVL_EvGv | P_DATA16, a2, a0);
+            }
         } else {
             g_assert_not_reached();
         }
@@ -3311,7 +3329,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
-        return C_O1_I2(q, 0, q);
+        return C_O1_I2(q, 0, qi);
 
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
-- 
2.34.1


