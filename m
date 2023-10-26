Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DAE7D7A3D
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 03:40:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvpLp-0001us-8b; Wed, 25 Oct 2023 21:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvpLm-0001u2-2u
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 21:39:54 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvpLj-00034O-8f
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 21:39:53 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ca3a54d2c4so2743155ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 18:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698284389; x=1698889189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FoKclLNER0V8XEHrKIXGl1qWfltrfJBKVAYf+F60a9E=;
 b=Jm8ziepP689N0M/Uwee1IybdKnGvVAepVoevyZa9nBWWNZMSvJjVNNV0HWY+6Q5iT7
 zqMzcWuhJnzHhHQBDBB3YLh9AO8HlOJ22Xj5hwWKOTjrLHwro4qV8mX9k4uVanwa7PZg
 aM/WqHrsOAWOeoJ+EIwCIW65v8bhxmyah7fyM89w5IDf3g5NmJ6+rY56n5m8Lz6T5Kpv
 MhYf3TNiCdt5mCDLJAL7FspiQ1tGErGAcxdWPygR7P+z1oqvKo8yAqsFN63CyrsibZ14
 KKkaaWXGhkbbQC+ckYm3HW6XNCly/xhwEUeC7GQOOnfUWEWXUdjJ6hmjIDPXz+eT1Ln3
 C1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698284389; x=1698889189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FoKclLNER0V8XEHrKIXGl1qWfltrfJBKVAYf+F60a9E=;
 b=DSCR/quWBBuBCrszoFgJ7AGLGbnmf3I1XqvhHnGgiXFxTf/S2Y3rYkdrdDDEp3AK9G
 Cs90M3BjpcKRu4joIi8P0cyoDaWmeliXeADyGDu4x0Rio5NxpNGBR3jvYff7TuHXqlVD
 L4TDjat1nu+RvRdNlB5Ri4g3LzW5xL8yA1IuTXsfkU9TLfGRhJYDbE6gS6NrLuKnbExR
 wpWsiY8pRzjlofY6aBUkQxmWSLrViCSJmfkRGD20NicgnDa/F1X7mOBhHjCNzV7EJ7s/
 +5691TP7NuOGEWyCOCU4iTxWojri4S9/U7M1PWVlj/A7JU26/rRdwGSMA2Kp9Q8V5wL1
 iHrQ==
X-Gm-Message-State: AOJu0YzIR7zwP549qZszvkyu7EZD3bj9iDKD71AYX3IT5cFouHoxUicE
 woAwZDH48+4DKV+xT75Ev3DNCPlUIlNN5KIgdvU=
X-Google-Smtp-Source: AGHT+IG8uN4yYSgNoWUitVKdaeAwkToyh+oFl0WphejWPLFeQJbDYkz1S/UopSvPBy1/KjsanJjPvw==
X-Received: by 2002:a17:902:edc2:b0:1c6:2d13:5b77 with SMTP id
 q2-20020a170902edc200b001c62d135b77mr16245109plk.39.1698284389657; 
 Wed, 25 Oct 2023 18:39:49 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 y6-20020a170902864600b001c0c86a5415sm9817032plt.154.2023.10.25.18.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 18:39:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 4/4] NOTFORMERGE tcg/i386: Assert sub of immediate has been
 folded
Date: Wed, 25 Oct 2023 18:39:45 -0700
Message-Id: <20231026013945.1152174-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026013945.1152174-1-richard.henderson@linaro.org>
References: <20231026013945.1152174-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

A release build should simply accept and emit the subtract.
I'm not even sure if this is reasonable to keep for debug.

Not-Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                 | 49 ++++++++++++++++++++++++++-------------
 tcg/i386/tcg-target.c.inc | 13 ++++++++---
 2 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index a507c111cf..408647af7e 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3618,23 +3618,40 @@ liveness_pass_1(TCGContext *s)
         do_addsub2:
             nb_iargs = 4;
             nb_oargs = 2;
-            /* Test if the high part of the operation is dead, but not
-               the low part.  The result can be optimized to a simple
-               add or sub.  This happens often for x86_64 guest when the
-               cpu mode is set to 32 bit.  */
-            if (arg_temp(op->args[1])->state == TS_DEAD) {
-                if (arg_temp(op->args[0])->state == TS_DEAD) {
-                    goto do_remove;
-                }
-                /* Replace the opcode and adjust the args in place,
-                   leaving 3 unused args at the end.  */
-                op->opc = opc = opc_new;
-                op->args[1] = op->args[2];
-                op->args[2] = op->args[4];
-                /* Fall through and mark the single-word operation live.  */
-                nb_iargs = 2;
-                nb_oargs = 1;
+            /*
+             * Test if the high part of the operation is dead, but the low
+             * part is still live.  The result can be optimized to a simple
+             * add or sub.
+             */
+            if (arg_temp(op->args[1])->state != TS_DEAD) {
+                goto do_not_remove;
             }
+            if (arg_temp(op->args[0])->state == TS_DEAD) {
+                goto do_remove;
+            }
+            /*
+             * Replace the opcode and adjust the args in place, leaving 3
+             * unused args at the end.  Canonicalize subi to andi.
+             */
+            op->args[1] = op->args[2];
+            {
+                TCGTemp *src2 = arg_temp(op->args[4]);
+                if (src2->kind == TEMP_CONST) {
+                    if (opc_new == INDEX_op_sub_i32) {
+                        src2 = tcg_constant_internal(TCG_TYPE_I32,
+                                                     (int32_t)-src2->val);
+                        opc_new = INDEX_op_add_i32;
+                    } else if (opc_new == INDEX_op_sub_i64) {
+                        src2 = tcg_constant_internal(TCG_TYPE_I64, -src2->val);
+                        opc_new = INDEX_op_add_i64;
+                    }
+                }
+                op->args[2] = temp_arg(src2);
+            }
+            op->opc = opc = opc_new;
+            /* Mark the single-word operation live.  */
+            nb_iargs = 2;
+            nb_oargs = 1;
             goto do_not_remove;
 
         case INDEX_op_mulu2_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 0d97864174..39d03fa698 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2544,8 +2544,14 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         c = ARITH_ADD;
         goto gen_arith;
     OP_32_64(sub):
-        c = ARITH_SUB;
-        goto gen_arith;
+        /*
+         * Should have canonicalized all constants to add.
+         * Keep the constraint allowing any constant so that we catch this
+         * case without register allocation loading the constant first.
+         */
+        tcg_debug_assert(!const_a2);
+        tgen_arithr(s, ARITH_SUB + rexw, a0, a2);
+        break;
     OP_32_64(and):
         c = ARITH_AND;
         goto gen_arith;
@@ -3325,7 +3331,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I2(r, r, re);
 
     case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
     case INDEX_op_or_i32:
@@ -3333,6 +3338,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
         return C_O1_I2(r, 0, re);
+    case INDEX_op_sub_i64:
+        return C_O1_I2(r, 0, ri);
 
     case INDEX_op_and_i32:
     case INDEX_op_and_i64:
-- 
2.34.1


