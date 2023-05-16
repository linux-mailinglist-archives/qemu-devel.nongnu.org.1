Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 426637057E8
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:50:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Yx-0006nZ-Be; Tue, 16 May 2023 15:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yv-0006nA-Ly
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:21 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yt-0002uI-Nd
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:21 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-64384c6797eso11570566b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266138; x=1686858138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1hA2GUGH30ti8Xg9mqUcD6D2A4Cc3BlkQs5kBCnxI8w=;
 b=zNrNJ8PvJG3zv2inwkyhs3XvNIXnxroA6s+TdPBeZeOZIEoEH5b7EParXxY6fn6MJs
 Bd4VIt7EDBJmRTK4UNLyFfVe3aJui1kQYnEwyom3hyRdNYeUbf79CHzWzCVZVdHJs5O4
 VwStKP6G2hw56CtzKdf6enF+2Z9gmlSxPWpKmHVEtV6HB6eWHQIqO2RMsijiLsz5zI27
 JQM/Gisemi9eNuM+fFLYOMKGhbzbeBF6WUx6/nm06djh77J0Sli1NGTZarWHux/K8jGr
 khsLEZn9hElwt8QUOVq8yl8r/NcPjPM/Q0ZEMjfQMNAoWM3L3jdHd1fudGT6EV+q8auF
 YGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266138; x=1686858138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1hA2GUGH30ti8Xg9mqUcD6D2A4Cc3BlkQs5kBCnxI8w=;
 b=LK0HDRHy9mJdhlkgbm/uiPQGXs7NOaifF/sVyumKkaJ4DbOZYGtBjG7GY4MTpvMZIJ
 BjWnkvRoD9528aPWnU1141fIEKSCRfBKvPs/Cs+kSP4yvTg/Evm/xxGW+sGg0wqqUDbZ
 XKScvLBI/7fvqzdqC5602ab22OqXRbQJNWjRcnWD7YdiTvm6sLfHt52vCEyuGxlTO2Wk
 DlMqEyQOFIiRIC23LnQBmI3am7fEqCNUZzN7mpHCgXzq4Q5jSfKhPcFf2zVdv9E+0Vay
 2CG61j/YbVs04vhigvtrEHGzhnBpEBGcw0BwpKiR4sSCu/5ZeV1yosKyK7S4YlHmFgjQ
 JbLw==
X-Gm-Message-State: AC+VfDx7Vjw/yx7CHssqpNEAThIpWvLka4VC8KL1E53bd97i82Zp02Ws
 /DnJZhz+7POxpRGUjJXyLTgjRTmhV0OlgnQyATE=
X-Google-Smtp-Source: ACHHUZ7or9pTjZk7wchKJTSdjrGdDj0r94CsD5vJXkmKvBeQNvocYrd9J0R/0XvytWRDSi7Q3+7TWA==
X-Received: by 2002:a05:6a00:2194:b0:643:b653:3aa with SMTP id
 h20-20020a056a00219400b00643b65303aamr46908884pfi.32.1684266138546; 
 Tue, 16 May 2023 12:42:18 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:42:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 35/80] tcg: Merge tcg_out_helper_load_regs into caller
Date: Tue, 16 May 2023 12:41:00 -0700
Message-Id: <20230516194145.1749305-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Now that tcg_out_helper_load_regs is not recursive, we can
merge it into its only caller, tcg_out_helper_load_slots.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 89 +++++++++++++++++++++++++------------------------------
 1 file changed, 41 insertions(+), 48 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 5de9380c6b..2b9e032b70 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -5225,12 +5225,50 @@ static int tcg_out_helper_stk_ofs(TCGType type, unsigned slot)
     return ofs;
 }
 
-static void tcg_out_helper_load_regs(TCGContext *s,
-                                     unsigned nmov, TCGMovExtend *mov,
-                                     const TCGLdstHelperParam *parm)
+static void tcg_out_helper_load_slots(TCGContext *s,
+                                      unsigned nmov, TCGMovExtend *mov,
+                                      const TCGLdstHelperParam *parm)
 {
+    unsigned i;
     TCGReg dst3;
 
+    /*
+     * Start from the end, storing to the stack first.
+     * This frees those registers, so we need not consider overlap.
+     */
+    for (i = nmov; i-- > 0; ) {
+        unsigned slot = mov[i].dst;
+
+        if (arg_slot_reg_p(slot)) {
+            goto found_reg;
+        }
+
+        TCGReg src = mov[i].src;
+        TCGType dst_type = mov[i].dst_type;
+        MemOp dst_mo = dst_type == TCG_TYPE_I32 ? MO_32 : MO_64;
+
+        /* The argument is going onto the stack; extend into scratch. */
+        if ((mov[i].src_ext & MO_SIZE) != dst_mo) {
+            tcg_debug_assert(parm->ntmp != 0);
+            mov[i].dst = src = parm->tmp[0];
+            tcg_out_movext1(s, &mov[i]);
+        }
+
+        tcg_out_st(s, dst_type, src, TCG_REG_CALL_STACK,
+                   tcg_out_helper_stk_ofs(dst_type, slot));
+    }
+    return;
+
+ found_reg:
+    /*
+     * The remaining arguments are in registers.
+     * Convert slot numbers to argument registers.
+     */
+    nmov = i + 1;
+    for (i = 0; i < nmov; ++i) {
+        mov[i].dst = tcg_target_call_iarg_regs[mov[i].dst];
+    }
+
     switch (nmov) {
     case 4:
         /* The backend must have provided enough temps for the worst case. */
@@ -5273,51 +5311,6 @@ static void tcg_out_helper_load_regs(TCGContext *s,
     }
 }
 
-static void tcg_out_helper_load_slots(TCGContext *s,
-                                      unsigned nmov, TCGMovExtend *mov,
-                                      const TCGLdstHelperParam *parm)
-{
-    unsigned i;
-
-    /*
-     * Start from the end, storing to the stack first.
-     * This frees those registers, so we need not consider overlap.
-     */
-    for (i = nmov; i-- > 0; ) {
-        unsigned slot = mov[i].dst;
-
-        if (arg_slot_reg_p(slot)) {
-            goto found_reg;
-        }
-
-        TCGReg src = mov[i].src;
-        TCGType dst_type = mov[i].dst_type;
-        MemOp dst_mo = dst_type == TCG_TYPE_I32 ? MO_32 : MO_64;
-
-        /* The argument is going onto the stack; extend into scratch. */
-        if ((mov[i].src_ext & MO_SIZE) != dst_mo) {
-            tcg_debug_assert(parm->ntmp != 0);
-            mov[i].dst = src = parm->tmp[0];
-            tcg_out_movext1(s, &mov[i]);
-        }
-
-        tcg_out_st(s, dst_type, src, TCG_REG_CALL_STACK,
-                   tcg_out_helper_stk_ofs(dst_type, slot));
-    }
-    return;
-
- found_reg:
-    /*
-     * The remaining arguments are in registers.
-     * Convert slot numbers to argument registers.
-     */
-    nmov = i + 1;
-    for (i = 0; i < nmov; ++i) {
-        mov[i].dst = tcg_target_call_iarg_regs[mov[i].dst];
-    }
-    tcg_out_helper_load_regs(s, nmov, mov, parm);
-}
-
 static void tcg_out_helper_load_imm(TCGContext *s, unsigned slot,
                                     TCGType type, tcg_target_long imm,
                                     const TCGLdstHelperParam *parm)
-- 
2.34.1


