Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 077677E3330
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:49:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9B-0008Fy-Bc; Mon, 06 Nov 2023 21:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C98-0008EQ-Pr
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:54 -0500
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C96-0005qq-4i
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:54 -0500
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-45ef8c21e8aso832098137.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325331; x=1699930131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rIcivD5Ogd1WlEn9ayO0cPwZ7+K+X3MtPYioN7oPrmc=;
 b=oc99CKZSj4RZOhk1jaouIrMVMEDENov+FjfCDVb95lcrqZXWtYAVhqIsYbU5TCsZCC
 ZTnlpVkSJYnljuS34myqWCkXUy79pkWibLSpF21xqATephnsTuNT6JveaDd65LoDX8Q6
 EKU1VXXDot7tluv0Sb0G35Ir3fZwXikTMz/M8YUgA0fWWPYprHLLc1FrMvHa6PtdZqQ9
 /HdDuVQ2uHJ/BlraR3t4UIFds/TQwSq3NAzRIQlmZnL9YLlwhenImJhbH0VgvAytYbqX
 IFwo6S+LOspWLrYNuiVg/yPxjTgTsAR5zH5ibQo0TBp2R6OCxR7cvL05pWdz6OGruGTl
 4cWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325331; x=1699930131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rIcivD5Ogd1WlEn9ayO0cPwZ7+K+X3MtPYioN7oPrmc=;
 b=Y1YYypb8cVPesFQluukQ4S6T74tEOUJGksKcnneLeyOBbhrvVZP1xmUPI59Y+A6aL/
 TWRllJsjeqfiIbBmFtCP+nRQr+739JBOCGDA6oXeirAaIL8eoXKG9JjdabGI+r+Y44c4
 do5wpCBVjLUM6IBS0+jxRjwJk+G4fWYUZgRW/n7Qz03SX8kyEKPZUmvQG2CaMSNFXoss
 2CpIO6znCXqOLsvxLb+rh+0JeTZIxzGAWaECY2PUqbiF0jnSwJ4UtbvpcuqEuySYQwAs
 bZXKslqICkiKyx7rDZTMrBDbmvndGxkc0VVxzRuwjPoAJ28PQQGyIZu53ei4Y6xTOIBq
 FANA==
X-Gm-Message-State: AOJu0YxhmrIuxJgqIwkUQzurHoiducDOk7JYeMRzx/cL/briv2YzzeB5
 SQQv5XSZnIln1jshJQ4SxrDKel8rbwmadWNEqXM=
X-Google-Smtp-Source: AGHT+IHDGwj8cbrAC95hzA+a6jGlSD6/GGnx0Eg5SOttXEoqagEEH3uBG/MS9iNubPIsLrDtacL0Iw==
X-Received: by 2002:a05:6102:4717:b0:45f:5d1:9c62 with SMTP id
 ei23-20020a056102471700b0045f05d19c62mr5820390vsb.19.1699325330856; 
 Mon, 06 Nov 2023 18:48:50 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.48.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:48:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/35] tcg: Mark tcg_gen_op* as noinline
Date: Mon,  6 Nov 2023 18:48:16 -0800
Message-Id: <20231107024842.7650-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-vs1-xe2f.google.com
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

Encourage the compiler to tail-call rather than inline
across the dozens of opcode expanders.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231029210848.78234-2-richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 828eb9ee46..9aed19e957 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -31,20 +31,26 @@
 #include "tcg-internal.h"
 
 
-void tcg_gen_op1(TCGOpcode opc, TCGArg a1)
+/*
+ * Encourage the compiler to tail-call to a function, rather than inlining.
+ * Minimizes code size across 99 bottles of beer on the wall.
+ */
+#define NI  __attribute__((noinline))
+
+void NI tcg_gen_op1(TCGOpcode opc, TCGArg a1)
 {
     TCGOp *op = tcg_emit_op(opc, 1);
     op->args[0] = a1;
 }
 
-void tcg_gen_op2(TCGOpcode opc, TCGArg a1, TCGArg a2)
+void NI tcg_gen_op2(TCGOpcode opc, TCGArg a1, TCGArg a2)
 {
     TCGOp *op = tcg_emit_op(opc, 2);
     op->args[0] = a1;
     op->args[1] = a2;
 }
 
-void tcg_gen_op3(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3)
+void NI tcg_gen_op3(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3)
 {
     TCGOp *op = tcg_emit_op(opc, 3);
     op->args[0] = a1;
@@ -52,7 +58,7 @@ void tcg_gen_op3(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3)
     op->args[2] = a3;
 }
 
-void tcg_gen_op4(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3, TCGArg a4)
+void NI tcg_gen_op4(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3, TCGArg a4)
 {
     TCGOp *op = tcg_emit_op(opc, 4);
     op->args[0] = a1;
@@ -61,8 +67,8 @@ void tcg_gen_op4(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3, TCGArg a4)
     op->args[3] = a4;
 }
 
-void tcg_gen_op5(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
-                 TCGArg a4, TCGArg a5)
+void NI tcg_gen_op5(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
+                     TCGArg a4, TCGArg a5)
 {
     TCGOp *op = tcg_emit_op(opc, 5);
     op->args[0] = a1;
@@ -72,8 +78,8 @@ void tcg_gen_op5(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
     op->args[4] = a5;
 }
 
-void tcg_gen_op6(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
-                 TCGArg a4, TCGArg a5, TCGArg a6)
+void NI tcg_gen_op6(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
+                     TCGArg a4, TCGArg a5, TCGArg a6)
 {
     TCGOp *op = tcg_emit_op(opc, 6);
     op->args[0] = a1;
-- 
2.34.1


