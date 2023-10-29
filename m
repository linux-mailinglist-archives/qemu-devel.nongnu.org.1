Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4957DAE67
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 22:10:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxD1n-0002f5-CH; Sun, 29 Oct 2023 17:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxD1k-0002eB-Dw
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:08:56 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxD1h-0005DT-3O
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:08:56 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6bee11456baso3188598b3a.1
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 14:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698613731; x=1699218531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yIEZ8p0+QQTNAMNRSoKjZTD6g/pQ7cEjDl2k36Rpcsg=;
 b=laKdn6vezn+fYpF1UmRR32gwJCXGPVIkUNsDDJbB8w+pAVZYLLkPUIfgFIV3Ar/lRN
 HCyqiTwNcIhuAgQ7nWbpYB4+ZNFx0qzaHEIDNLGmDTfBU7vefakgicYO1STnB8G5CeF5
 0AB5dX5vb2IWA9FtJ6xTyQZa/H+coG62Dy0P2yneah0T9yb6WE9YcKcFtEH5YcRwqtsL
 sBZhkQO1HO0F5ZSU5nnZ6xFyoQqmsFWayU4UuLvdXUphcx7QH+0vhMJltcCwcxEkCrrk
 ssRzHGbItFoRnA1mcwMRe3jbVjnRqqy4n08jhIi475xMijMNidlFGF73+8/N5Y6wfoTa
 G9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698613731; x=1699218531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yIEZ8p0+QQTNAMNRSoKjZTD6g/pQ7cEjDl2k36Rpcsg=;
 b=VQbkrOZ9XmmW9d1FXsJv8VybxWVN4nSXHzIFSXhTK5g2QZ9Mbtj9dgwuN6DAXxa9C6
 9xEtMBqbs2FWOb64Ww76S/6eQlsV9wTHoiPkIc0FP5VxNXYAuoN4uaflR63PU4lOfCSp
 y5j/OArEIHEK1rVud5cQePqII+7eHyBzoNt1sRpR8OGXpY0eL3YkrxR/Pebp4azIH0Hm
 83wBIX7l/sUufokOXyOCAdtTkmC6JBSGVsDvebT7auLZEFXIuGkxst+gqegDSgGvK4I1
 BQ+EmNBXysFsLfYKWasVv2RbmQctMe16Bkmy1WQ0mihhjF/YPW58UsOiZdVZaLuiyP+7
 p1xA==
X-Gm-Message-State: AOJu0YxBTiQp6hG7Ub60Wm7Ab7P1ZpUqrGA7TlR+35xOueALdikqD8lG
 +RXJOaMODnVUxPQvx+b1BjTZ5p4A+I/SkIgZjNs=
X-Google-Smtp-Source: AGHT+IHo8I+NDkUaw+ByKOZDPlZ8+0AOkQQeDL+yMN75lV8V7elosBQgsGla+g0N+5PNAwDarAOBrg==
X-Received: by 2002:a05:6a00:2296:b0:693:3e55:59b4 with SMTP id
 f22-20020a056a00229600b006933e5559b4mr7569334pfe.8.1698613731512; 
 Sun, 29 Oct 2023 14:08:51 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 z11-20020aa785cb000000b006c0685422e0sm4622847pfn.214.2023.10.29.14.08.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 14:08:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/11] tcg: Mark tcg_gen_op* as noinline
Date: Sun, 29 Oct 2023 14:08:38 -0700
Message-Id: <20231029210848.78234-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231029210848.78234-1-richard.henderson@linaro.org>
References: <20231029210848.78234-1-richard.henderson@linaro.org>
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

Encourage the compiler to tail-call rather than inline
across the dozens of opcode expanders.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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


