Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A569786188
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:28:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOn-0000cl-Ph; Wed, 23 Aug 2023 16:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOZ-0008PU-3D
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:04 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOU-0005WZ-Uc
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:02 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bbc87ded50so41176585ad.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822237; x=1693427037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kroIFaZ4+sbfT/0fKHygsaF2AQa5pGIMW/+727fk4mY=;
 b=y/Vpa13GYkXqod87/ZXx82j6sRTFUI4tnP2hlrQniNzCubMiJTMnj5dZD9a7vCjy9C
 vycKGNQ88U2fPiaE9V1kbnsRIfbH5TaDvss3Wt94BuPIcSux/Bau63bLyh3mnXk3oTTF
 tqG/GN2j7xkAOisGL/PS0NXyhQCniLe+8xQhIW9PDLrhe1KyNhbsOLJ5nkTkhuMQb9Hz
 dz/SM2X9f29Q3ABRltyZ90Ki59dBLGmmjrnbiAwa/4fdDFSm0HAekRxVYC4okTGAn/L4
 xYkgarAd8w085Vx+qfK41LFbS/o+L/Tsst5pWMXdZhoUL9YS0VqFOYCQh5d9adLO+Jut
 5YOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822237; x=1693427037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kroIFaZ4+sbfT/0fKHygsaF2AQa5pGIMW/+727fk4mY=;
 b=NTD7sYzGT9iEuURduiD/vZCNhZ801MXLVQRz6KOpnNPSWTS3utuCKsnK9JP4H3KW74
 G6RwDPRzPEa7lqB1U78LHD1G/lw9499t7tOB5nJqvI5HqDCTwdNQSu0f/4HQsHkdOGss
 sIh7DwEHARdu0R2NkytF8F76fM7ctyu+rvEKJwu296jgW7R70KN6sTIeslzH1D86DjLN
 cxQerHAXB5ldcqK2mvrFj7uznInhrJpGU60jpO2mRUk838+LU64QsB3OjCOfTEZp8aIw
 UFMVl9FeW16Hbcq+HsGDPKpTyNCjtH4AhOIBpn3NoQPY2LoC7cd4JoFEPVJc154Hs9fQ
 EpOA==
X-Gm-Message-State: AOJu0Yxg1upvcftxynjC7XqVapM9JJFXo766sDK0UzgZ/j/Jn8gJ1Hr1
 QPxqjnsNLRROuOarlM+ULTcjEmI0ZS85HVB/Knk=
X-Google-Smtp-Source: AGHT+IGgOfjvxuQ/PqR8vMxuwR7sNe52uxbey24+DiEPSRBTCXdndJ3UdVC8cr/+XE/u21ozgCIZZQ==
X-Received: by 2002:a17:902:c411:b0:1bf:69af:b4e4 with SMTP id
 k17-20020a170902c41100b001bf69afb4e4mr13322009plk.37.1692822237593; 
 Wed, 23 Aug 2023 13:23:57 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 32/48] tcg/i386: Merge tcg_out_brcond{32,64}
Date: Wed, 23 Aug 2023 13:23:10 -0700
Message-Id: <20230823202326.1353645-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Pass a rexw parameter instead of duplicating the functions.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 110 +++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 61 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 3045b56002..33f66ba204 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1436,99 +1436,89 @@ static void tcg_out_cmp(TCGContext *s, TCGArg arg1, TCGArg arg2,
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
@@ -2574,8 +2564,9 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
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
@@ -2730,9 +2721,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
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


