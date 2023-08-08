Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A6D77376F
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:14:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTD9D-0002HK-59; Mon, 07 Aug 2023 23:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTD8q-0001a4-F9
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:12:17 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTD8b-0000Iq-BP
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:12:16 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6bcf2fd5d69so1681831a34.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 20:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691464320; x=1692069120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t2qRbN3xywAnflNfFcs6TASp0rwMLR7CT6jzuqfZ0as=;
 b=UZaZfncF6h8HUxbO2l6AZFS7BXPbvv8esr+V2v7tl9U66GRdnGym+X7qBncZI3kMJ6
 tZnCdxeZ5gD4JIipHiblNs+mxCbmxxwXmVeUsIBuQixQeCF37j1QakJoPLlldEJrBM3k
 qtEHKmFRjB1wCHb7SYOeM6/bWicU0jOcX308cc+6L/K68YesziE/+1dWVkK/BGeVdXmi
 imChfZtVpNK8CvCAKIbB4//BcJ1BDQpQ+HvhbSaJm3CYSk1dBqz5hgc5cB/4yoIe675S
 RjE81tCRP4ieT9F3gOibiJf6LznerZ+C2DtROdtSNb0u4UTXdoNAuJTHqAX3dX3ZyTRU
 mhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691464320; x=1692069120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t2qRbN3xywAnflNfFcs6TASp0rwMLR7CT6jzuqfZ0as=;
 b=HhgeUbSSPPNl+I0lcs88yydo8yrBlKzha2bmIvJffTB5w7fmVsw+mrZ0t6uiSN76Ym
 0sJMxFlaEE7ZBpBxw/GB/gLxt/CYTT8y4wmAudXLTFMCMm9m22/W4p74dTnXyKrnSJZQ
 JoRgjAYEt0M51oVO3+/Q5BKt9R/KEoul4FvYBZFn6VQOxBjVcIdH2MO9x+y6VAIZJQ91
 avAnRM0SdXyvisjg+6Lf9NsQOIL1zirC1cEY6pHDbOtBZmANlhHd8m7SkfxxcOAA3x1N
 uyG5tEuv+SoBEN1uNu7KksBJVWL5Y2ta/wgoJMVhGtNAePQxr/FV7E+h8hJAsBOnr8+Q
 EaIw==
X-Gm-Message-State: AOJu0YwU3pv7wSpToO4k5dSi9X4pRgOsdqi09wmWYhyiJaS2IRj/Yw4c
 Ub0++qNMnJ9QRX3x4dliu1+zJERBC79khc+nUbw=
X-Google-Smtp-Source: AGHT+IHFJ+skxB+aj16CpauseX8ohPYnVPELMDQqfa2VK+sw8eVElBCzR2iTz9nkHH2Jn6wNBlUsKQ==
X-Received: by 2002:a05:6358:2607:b0:132:d32d:d929 with SMTP id
 l7-20020a056358260700b00132d32dd929mr13899267rwc.20.1691464319961; 
 Mon, 07 Aug 2023 20:11:59 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 g64-20020a636b43000000b0055bf96b11d9sm5639087pgc.89.2023.08.07.20.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:11:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PATCH 17/24] tcg/i386: Merge tcg_out_brcond{32,64}
Date: Mon,  7 Aug 2023 20:11:36 -0700
Message-Id: <20230808031143.50925-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808031143.50925-1-richard.henderson@linaro.org>
References: <20230808031143.50925-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

Pass a rexw parameter instead of duplicating the functions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 110 +++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 61 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 77482da070..b9673b55bd 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1433,99 +1433,89 @@ static void tcg_out_cmp(TCGContext *s, TCGArg arg1, TCGArg arg2,
     }
 }
 
-static void tcg_out_brcond32(TCGContext *s, TCGCond cond,
-                             TCGArg arg1, TCGArg arg2, int const_arg2,
-                             TCGLabel *label, int small)
+static void tcg_out_brcond(TCGContext *s, int rexw, TCGCond cond,
+                           TCGArg arg1, TCGArg arg2, int const_arg2,
+                           TCGLabel *label, bool small)
 {
-    tcg_out_cmp(s, arg1, arg2, const_arg2, 0);
+    tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
     tcg_out_jxx(s, tcg_cond_to_jcc[cond], label, small);
 }
 
-#if TCG_TARGET_REG_BITS == 64
-static void tcg_out_brcond64(TCGContext *s, TCGCond cond,
-                             TCGArg arg1, TCGArg arg2, int const_arg2,
-                             TCGLabel *label, int small)
-{
-    tcg_out_cmp(s, arg1, arg2, const_arg2, P_REXW);
-    tcg_out_jxx(s, tcg_cond_to_jcc[cond], label, small);
-}
-#else
-/* XXX: we implement it at the target level to avoid having to
-   handle cross basic blocks temporaries */
+#if TCG_TARGET_REG_BITS == 32
 static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
-                            const int *const_args, int small)
+                            const int *const_args, bool small)
 {
     TCGLabel *label_next = gen_new_label();
     TCGLabel *label_this = arg_label(args[5]);
 
     switch(args[4]) {
     case TCG_COND_EQ:
-        tcg_out_brcond32(s, TCG_COND_NE, args[0], args[2], const_args[2],
-                         label_next, 1);
-        tcg_out_brcond32(s, TCG_COND_EQ, args[1], args[3], const_args[3],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_NE, args[0], args[2], const_args[2],
+                       label_next, 1);
+        tcg_out_brcond(s, 0, TCG_COND_EQ, args[1], args[3], const_args[3],
+                       label_this, small);
         break;
     case TCG_COND_NE:
-        tcg_out_brcond32(s, TCG_COND_NE, args[0], args[2], const_args[2],
-                         label_this, small);
-        tcg_out_brcond32(s, TCG_COND_NE, args[1], args[3], const_args[3],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_NE, args[0], args[2], const_args[2],
+                       label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_NE, args[1], args[3], const_args[3],
+                       label_this, small);
         break;
     case TCG_COND_LT:
-        tcg_out_brcond32(s, TCG_COND_LT, args[1], args[3], const_args[3],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_LT, args[1], args[3], const_args[3],
+                       label_this, small);
         tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond32(s, TCG_COND_LTU, args[0], args[2], const_args[2],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_LTU, args[0], args[2], const_args[2],
+                       label_this, small);
         break;
     case TCG_COND_LE:
-        tcg_out_brcond32(s, TCG_COND_LT, args[1], args[3], const_args[3],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_LT, args[1], args[3], const_args[3],
+                       label_this, small);
         tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond32(s, TCG_COND_LEU, args[0], args[2], const_args[2],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_LEU, args[0], args[2], const_args[2],
+                       label_this, small);
         break;
     case TCG_COND_GT:
-        tcg_out_brcond32(s, TCG_COND_GT, args[1], args[3], const_args[3],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_GT, args[1], args[3], const_args[3],
+                       label_this, small);
         tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond32(s, TCG_COND_GTU, args[0], args[2], const_args[2],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_GTU, args[0], args[2], const_args[2],
+                       label_this, small);
         break;
     case TCG_COND_GE:
-        tcg_out_brcond32(s, TCG_COND_GT, args[1], args[3], const_args[3],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_GT, args[1], args[3], const_args[3],
+                       label_this, small);
         tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond32(s, TCG_COND_GEU, args[0], args[2], const_args[2],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_GEU, args[0], args[2], const_args[2],
+                       label_this, small);
         break;
     case TCG_COND_LTU:
-        tcg_out_brcond32(s, TCG_COND_LTU, args[1], args[3], const_args[3],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_LTU, args[1], args[3], const_args[3],
+                       label_this, small);
         tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond32(s, TCG_COND_LTU, args[0], args[2], const_args[2],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_LTU, args[0], args[2], const_args[2],
+                       label_this, small);
         break;
     case TCG_COND_LEU:
-        tcg_out_brcond32(s, TCG_COND_LTU, args[1], args[3], const_args[3],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_LTU, args[1], args[3], const_args[3],
+                       label_this, small);
         tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond32(s, TCG_COND_LEU, args[0], args[2], const_args[2],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_LEU, args[0], args[2], const_args[2],
+                       label_this, small);
         break;
     case TCG_COND_GTU:
-        tcg_out_brcond32(s, TCG_COND_GTU, args[1], args[3], const_args[3],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_GTU, args[1], args[3], const_args[3],
+                       label_this, small);
         tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond32(s, TCG_COND_GTU, args[0], args[2], const_args[2],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_GTU, args[0], args[2], const_args[2],
+                       label_this, small);
         break;
     case TCG_COND_GEU:
-        tcg_out_brcond32(s, TCG_COND_GTU, args[1], args[3], const_args[3],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_GTU, args[1], args[3], const_args[3],
+                       label_this, small);
         tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond32(s, TCG_COND_GEU, args[0], args[2], const_args[2],
-                         label_this, small);
+        tcg_out_brcond(s, 0, TCG_COND_GEU, args[0], args[2], const_args[2],
+                       label_this, small);
         break;
     default:
         g_assert_not_reached();
@@ -2571,8 +2561,9 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_modrm(s, OPC_POPCNT + rexw, a0, a1);
         break;
 
-    case INDEX_op_brcond_i32:
-        tcg_out_brcond32(s, a2, a0, a1, const_args[1], arg_label(args[3]), 0);
+    OP_32_64(brcond):
+        tcg_out_brcond(s, rexw, a2, a0, a1, const_args[1],
+                       arg_label(args[3]), 0);
         break;
     case INDEX_op_setcond_i32:
         tcg_out_setcond32(s, args[3], a0, a1, a2, const_a2);
@@ -2727,9 +2718,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
-    case INDEX_op_brcond_i64:
-        tcg_out_brcond64(s, a2, a0, a1, const_args[1], arg_label(args[3]), 0);
-        break;
     case INDEX_op_setcond_i64:
         tcg_out_setcond64(s, args[3], a0, a1, a2, const_a2);
         break;
-- 
2.34.1


