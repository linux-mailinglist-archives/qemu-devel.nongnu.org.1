Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DD978153F
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 00:15:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7j4-000540-G5; Fri, 18 Aug 2023 18:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7j1-00052I-TT
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:47 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7iz-0004Pk-FA
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:47 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bf078d5fb7so11106385ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 15:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692396824; x=1693001624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91TkpjxjjXOf7l8ASqNz9Rj6LlbJ7npX0PFpYQ3x9X0=;
 b=Xwq0iK1dnmE1ZVOxe1cz4i9puIrJv4P3zhWhRYJJxNYOEECT0U25AX0ScL8vEDD1Pc
 I6yhB7iVnDr9AAVsNi2wxSq2WnL92tWxMfjLeGV6uwC7SgTu+HuyrlvQj7HPqCWDDLzC
 3LcWm8qZae0hvg/F99v3yGnARuWgHoQnptt9cXsQbnzbIHFgZ+tgko5JP4wl0hFA1cLr
 7RSU4u668lk/BPRKokNms1WLW0LAHjIiMMz9BGOBnI0a0S2+GMZh2r8Kq3Eh5+MdXK/p
 O74dCHcJ9l7WOgclcdi6+dh/QVitCojXSeVkDrjegI8f18SETcHVgxYg/nqZrdCpuMAJ
 6PAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692396824; x=1693001624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=91TkpjxjjXOf7l8ASqNz9Rj6LlbJ7npX0PFpYQ3x9X0=;
 b=I6y/EcHXZUs8LlvrX6xEVc9aP8DB8QH7Dx3kDuGV0nAfHixEPd6HEoklXhTPOPRtAv
 oZVNrT68OYzePVc9SokT/DrXyLw9jIioFURMfu0EP59MpnC8rYGCkxoGMNrtT3gXSgX8
 dUeVnPNp9gGDVKvXF5pH2SNj9/G9Trdg1WewqWd9+g1EzOWU4oPERkFu55kAYngnKi40
 MEoKyiDzB+R96KI7Yh02AAV8t8pyS6N6r483dCreJf3W2ZeTJ1evRizZWf+2V6nKPBU/
 jNIEeCCutVv1xqiWgtyHH9C8bxSsRktfjAajVTFnXlpbeVooY+zjSkuM3cok7uqcSlfH
 kfXA==
X-Gm-Message-State: AOJu0YwpNRRu7OacxenCGY6x/3dvepDo3Bk8cC3DeJHNyPO2rvp9Imh6
 8IBevfpD6xrLK73gcG4EetTFnAepbLiKzXLsh5A=
X-Google-Smtp-Source: AGHT+IFetJItQe7xVFLAjSwmPDM1AwOdhuWvF/BVlTAyx1XbDe60gSCwq9ZTyIVCJXRolWatkeYvDw==
X-Received: by 2002:a17:903:32ce:b0:1bc:56c3:ebb7 with SMTP id
 i14-20020a17090332ce00b001bc56c3ebb7mr661392plr.20.1692396824247; 
 Fri, 18 Aug 2023 15:13:44 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001bdb85291casm2231417plg.208.2023.08.18.15.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 15:13:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 18/23] tcg/i386: Merge tcg_out_setcond{32,64}
Date: Fri, 18 Aug 2023 15:13:22 -0700
Message-Id: <20230818221327.150194-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818221327.150194-1-richard.henderson@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 33f66ba204..010432d3a9 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1527,23 +1527,16 @@ static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
 }
 #endif
 
-static void tcg_out_setcond32(TCGContext *s, TCGCond cond, TCGArg dest,
-                              TCGArg arg1, TCGArg arg2, int const_arg2)
+static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
+                            TCGArg dest, TCGArg arg1, TCGArg arg2,
+                            int const_arg2)
 {
-    tcg_out_cmp(s, arg1, arg2, const_arg2, 0);
+    tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
     tcg_out_modrm(s, OPC_SETCC | tcg_cond_to_jcc[cond], 0, dest);
     tcg_out_ext8u(s, dest, dest);
 }
 
-#if TCG_TARGET_REG_BITS == 64
-static void tcg_out_setcond64(TCGContext *s, TCGCond cond, TCGArg dest,
-                              TCGArg arg1, TCGArg arg2, int const_arg2)
-{
-    tcg_out_cmp(s, arg1, arg2, const_arg2, P_REXW);
-    tcg_out_modrm(s, OPC_SETCC | tcg_cond_to_jcc[cond], 0, dest);
-    tcg_out_ext8u(s, dest, dest);
-}
-#else
+#if TCG_TARGET_REG_BITS == 32
 static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
                              const int *const_args)
 {
@@ -2568,8 +2561,8 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_brcond(s, rexw, a2, a0, a1, const_args[1],
                        arg_label(args[3]), 0);
         break;
-    case INDEX_op_setcond_i32:
-        tcg_out_setcond32(s, args[3], a0, a1, a2, const_a2);
+    OP_32_64(setcond):
+        tcg_out_setcond(s, rexw, args[3], a0, a1, a2, const_a2);
         break;
     case INDEX_op_movcond_i32:
         tcg_out_movcond32(s, args[5], a0, a1, a2, const_a2, args[3]);
@@ -2721,9 +2714,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
-    case INDEX_op_setcond_i64:
-        tcg_out_setcond64(s, args[3], a0, a1, a2, const_a2);
-        break;
     case INDEX_op_movcond_i64:
         tcg_out_movcond64(s, args[5], a0, a1, a2, const_a2, args[3]);
         break;
-- 
2.34.1


