Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 292F8786186
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:28:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOl-0000SU-L2; Wed, 23 Aug 2023 16:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOV-0008L2-7r
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:59 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOK-0005UE-Tv
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:56 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bba48b0bd2so40993695ad.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822220; x=1693427020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iNRynbj4NWiJ6TTSh4DJmwLcdDkEd+nKNCg+6WFAujM=;
 b=Z810D/YYnhAYsR9gW//kp7mYn5VjaT/c2zQSGKlknSM3Pn/WwRHVrxf4UxEjidyLfo
 JL6WALMG6jfreUQW74DbRmyJhreGLHTBSfIf5cntv17TQoGAv0cUmPPKwu4edkqwBa6y
 3GU/9oI2OLX5cUZ0DiZw0Y6MPN/iRRBpvm2x+GtvBVOMUEk1XNGu3b+MfJaAhlWfDtZ+
 mQhuvs7xXPDzVo1/W4bhYh43e1HJvK1Cpmt8DP8wJz78azdnO/vs9tpz+ZV1jkcuRpT6
 yc/7yM8ErOeI3jo1/7Z/xMxEwxxGzq4Qsdsq287qT9RyQ05Pq7bMl2JVeMQDSleSQ9NB
 UzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822220; x=1693427020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iNRynbj4NWiJ6TTSh4DJmwLcdDkEd+nKNCg+6WFAujM=;
 b=I7jlSMjIwDk3H1iyzM2p+YIHyiXKx53lrva7YXlJWu+A5esz3oKRtDqFqsOggGPq0Q
 Wc4NLKx2WIo/SBIKGxFpvBTnTnQS7kI9TCNTVV/kR102U5Me/VLHrqzhNUPIviX3Rbz0
 V1LKdbDbe4QsvvVaiez+EyixUoa6elzOlzC8sdp5ewRnKxVVWKhaPZOz69/apA8zp1HO
 CbvjtApEXa/hDRLkeD8B0r9ZJOhXHVw1SITry6l6mA1bIsk7UROBnt/Mno6RtNO4+6xv
 HzqLqp2cIT8jp+q7lPZPLnC5USrDV+JoqN17medE8NBkiz7SQv4XHumJT9Z1cpGI1rt3
 9orA==
X-Gm-Message-State: AOJu0Yx3UX70atvytyia0S0Lk5mBjuN4mzY7/pZyA4E056ZCHAfnGUOL
 bl31GqzRvJNw69Cfq1Nssu3zTCiAZGzK4xSS524=
X-Google-Smtp-Source: AGHT+IHJb9kyogWCtIGTtGZAi0NxwqAOzIL9IfW+6M2laqgmwcd9njEJMQWIw5y/aWBrqUD5a88QEA==
X-Received: by 2002:a17:902:da8b:b0:1bf:78d:5cde with SMTP id
 j11-20020a170902da8b00b001bf078d5cdemr12154039plx.59.1692822220220; 
 Wed, 23 Aug 2023 13:23:40 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 13/48] tcg/i386: Allow immediate as input to deposit_*
Date: Wed, 23 Aug 2023 13:22:51 -0700
Message-Id: <20230823202326.1353645-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


