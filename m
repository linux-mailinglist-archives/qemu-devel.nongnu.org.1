Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C737E333B
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:50:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9H-0008K0-2E; Mon, 06 Nov 2023 21:49:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9E-0008Ht-7R
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:00 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9B-0005rw-AP
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:59 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a7d9d357faso60358557b3.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325336; x=1699930136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WDqry/XgScdXwJwBq8aBX0uqrceQjTsF7uSyvzshoLw=;
 b=KcZZX/IJuUcq2sq62d0W3RXuc0IfnqsT/L22K9pkFuhS6698d6IH/dhvd6WLLcmcar
 jVwKOJEXz6kja0CuGVL4ZqpWDd0YeZzuQ9ci8aXywV8MoSBHYOsYD2vmHtvrnjLnSmAL
 WijpavlYvnwdpztPNkRlBd94I8vrCjGidxsgMzL6IDv3WHpenrPtH/M948OKTg6hqdUC
 djMiq1oba1OGx/rGpQlotRcptkTQpUHXex/Sj0kGxivHVxTcPgpMmgpOhILBdi6WI1qP
 c1Bj1G6at8U2Iv5ag9q6xemxryDCVOyK7siiJM+VHQjoyYRseIm2CENICfZDQEOzleGL
 J0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325336; x=1699930136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WDqry/XgScdXwJwBq8aBX0uqrceQjTsF7uSyvzshoLw=;
 b=ufAkDHw8zLBgO17YZPGJHQ4nrym3VlVM+781h3SdwOEbmUdegintOVWw5oAvgcfOqZ
 Z6SmMvAnH8n3GVlqY62SC+Pllud5pnE41wcB1tj3bAaoQLBeNgkUMoQxxnMfv3h9DjdL
 SS6pokYbJj92uKvof+f1J+Ort9mZAfAJ9c6Y+ckBUdxMc/TYGei0EUjnapjekXo5ZIyB
 QiOYTuDf8u832vC0yf9PUaaxmXjIGSi+goRewTCG3CvhfJ6fiSgC7UygHthRvZzLUWZ/
 CLpte3iLW/S/RrRkMBZqAsJgGjfi8t2vQz3apu7LklufiQJcJwJl012xkRO/LFuAsE3/
 ZUeA==
X-Gm-Message-State: AOJu0YwSrqYw4Kdhu1FEeU834tgg5HzXVSA0Dq9mndfnZjwrBYdkGLOC
 dr9UtKuk+tq3+n9hsbq6WHMATaYNrlKu7BQVkrs=
X-Google-Smtp-Source: AGHT+IHHRV4DzcJzEMqW7loJJrjtYkf5HvsDJaHrzv72JyAWyzqhB0GlPm9/r5HPB5QTojjr3RysXw==
X-Received: by 2002:a25:d80f:0:b0:da0:c581:6663 with SMTP id
 p15-20020a25d80f000000b00da0c5816663mr32065136ybg.28.1699325336293; 
 Mon, 06 Nov 2023 18:48:56 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.48.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:48:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/35] tcg: Unexport tcg_gen_op*_{i32,i64}
Date: Mon,  6 Nov 2023 18:48:23 -0800
Message-Id: <20231107024842.7650-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112e.google.com
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

These functions are no longer used outside tcg-op.c.
There are several that are completely unused, so remove them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231029210848.78234-9-richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h |  47 -------------
 tcg/tcg-op.c                | 131 ++++++++++++++----------------------
 2 files changed, 52 insertions(+), 126 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b922545118..760c67683b 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -12,53 +12,6 @@
 #include "exec/helper-proto-common.h"
 #include "exec/helper-gen-common.h"
 
-/* Basic output routines.  Not for general consumption.  */
-
-void tcg_gen_op1_i32(TCGOpcode, TCGv_i32);
-void tcg_gen_op1_i64(TCGOpcode, TCGv_i64);
-void tcg_gen_op1i(TCGOpcode, TCGArg);
-void tcg_gen_op2_i32(TCGOpcode, TCGv_i32, TCGv_i32);
-void tcg_gen_op2_i64(TCGOpcode, TCGv_i64, TCGv_i64);
-void tcg_gen_op2i_i32(TCGOpcode, TCGv_i32, TCGArg);
-void tcg_gen_op2i_i64(TCGOpcode, TCGv_i64, TCGArg);
-void tcg_gen_op2ii(TCGOpcode, TCGArg, TCGArg);
-void tcg_gen_op3_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32);
-void tcg_gen_op3_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64);
-void tcg_gen_op3i_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGArg);
-void tcg_gen_op3i_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGArg);
-void tcg_gen_ldst_op_i32(TCGOpcode, TCGv_i32, TCGv_ptr, TCGArg);
-void tcg_gen_ldst_op_i64(TCGOpcode, TCGv_i64, TCGv_ptr, TCGArg);
-void tcg_gen_op4_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32);
-void tcg_gen_op4_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64);
-void tcg_gen_op4i_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32, TCGArg);
-void tcg_gen_op4i_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64, TCGArg);
-void tcg_gen_op4ii_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGArg, TCGArg);
-void tcg_gen_op4ii_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGArg, TCGArg);
-void tcg_gen_op5_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32,
-                     TCGv_i32, TCGv_i32);
-void tcg_gen_op5_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64,
-                     TCGv_i64, TCGv_i64);
-void tcg_gen_op5i_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32,
-                      TCGv_i32, TCGArg);
-void tcg_gen_op5i_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64,
-                      TCGv_i64, TCGArg);
-void tcg_gen_op5ii_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32,
-                       TCGArg, TCGArg);
-void tcg_gen_op5ii_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64,
-                       TCGArg, TCGArg);
-void tcg_gen_op6_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32,
-                     TCGv_i32, TCGv_i32, TCGv_i32);
-void tcg_gen_op6_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64,
-                     TCGv_i64, TCGv_i64, TCGv_i64);
-void tcg_gen_op6i_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32,
-                      TCGv_i32, TCGv_i32, TCGArg);
-void tcg_gen_op6i_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64,
-                      TCGv_i64, TCGv_i64, TCGArg);
-void tcg_gen_op6ii_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32,
-                       TCGv_i32, TCGArg, TCGArg);
-void tcg_gen_op6ii_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64,
-                       TCGv_i64, TCGArg, TCGArg);
-
 /* Generic ops.  */
 
 void gen_set_label(TCGLabel *l);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 579a2aab15..9aba103590 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -100,204 +100,177 @@ void NI tcg_gen_op6(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
 # define DNI
 #endif
 
-void DNI tcg_gen_op1_i32(TCGOpcode opc, TCGv_i32 a1)
+static void DNI tcg_gen_op1_i32(TCGOpcode opc, TCGv_i32 a1)
 {
     tcg_gen_op1(opc, tcgv_i32_arg(a1));
 }
 
-void DNI tcg_gen_op1_i64(TCGOpcode opc, TCGv_i64 a1)
+static void DNI tcg_gen_op1_i64(TCGOpcode opc, TCGv_i64 a1)
 {
     tcg_gen_op1(opc, tcgv_i64_arg(a1));
 }
 
-void DNI tcg_gen_op1i(TCGOpcode opc, TCGArg a1)
+static void DNI tcg_gen_op1i(TCGOpcode opc, TCGArg a1)
 {
     tcg_gen_op1(opc, a1);
 }
 
-void DNI tcg_gen_op2_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2)
+static void DNI tcg_gen_op2_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2)
 {
     tcg_gen_op2(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2));
 }
 
-void DNI tcg_gen_op2_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2)
+static void DNI tcg_gen_op2_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2)
 {
     tcg_gen_op2(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2));
 }
 
-void DNI tcg_gen_op2i_i32(TCGOpcode opc, TCGv_i32 a1, TCGArg a2)
-{
-    tcg_gen_op2(opc, tcgv_i32_arg(a1), a2);
-}
-
-void DNI tcg_gen_op2i_i64(TCGOpcode opc, TCGv_i64 a1, TCGArg a2)
-{
-    tcg_gen_op2(opc, tcgv_i64_arg(a1), a2);
-}
-
-void DNI tcg_gen_op2ii(TCGOpcode opc, TCGArg a1, TCGArg a2)
-{
-    tcg_gen_op2(opc, a1, a2);
-}
-
-void DNI tcg_gen_op3_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2, TCGv_i32 a3)
+static void DNI tcg_gen_op3_i32(TCGOpcode opc, TCGv_i32 a1,
+                                TCGv_i32 a2, TCGv_i32 a3)
 {
     tcg_gen_op3(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), tcgv_i32_arg(a3));
 }
 
-void DNI tcg_gen_op3_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2, TCGv_i64 a3)
+static void DNI tcg_gen_op3_i64(TCGOpcode opc, TCGv_i64 a1,
+                                TCGv_i64 a2, TCGv_i64 a3)
 {
     tcg_gen_op3(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), tcgv_i64_arg(a3));
 }
 
-void DNI tcg_gen_op3i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2, TCGArg a3)
+static void DNI tcg_gen_op3i_i32(TCGOpcode opc, TCGv_i32 a1,
+                                 TCGv_i32 a2, TCGArg a3)
 {
     tcg_gen_op3(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3);
 }
 
-void DNI tcg_gen_op3i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2, TCGArg a3)
+static void DNI tcg_gen_op3i_i64(TCGOpcode opc, TCGv_i64 a1,
+                                 TCGv_i64 a2, TCGArg a3)
 {
     tcg_gen_op3(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3);
 }
 
-void DNI tcg_gen_ldst_op_i32(TCGOpcode opc, TCGv_i32 val,
-                             TCGv_ptr base, TCGArg offset)
+static void DNI tcg_gen_ldst_op_i32(TCGOpcode opc, TCGv_i32 val,
+                                    TCGv_ptr base, TCGArg offset)
 {
     tcg_gen_op3(opc, tcgv_i32_arg(val), tcgv_ptr_arg(base), offset);
 }
 
-void DNI tcg_gen_ldst_op_i64(TCGOpcode opc, TCGv_i64 val,
-                             TCGv_ptr base, TCGArg offset)
+static void DNI tcg_gen_ldst_op_i64(TCGOpcode opc, TCGv_i64 val,
+                                    TCGv_ptr base, TCGArg offset)
 {
     tcg_gen_op3(opc, tcgv_i64_arg(val), tcgv_ptr_arg(base), offset);
 }
 
-void DNI tcg_gen_op4_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                         TCGv_i32 a3, TCGv_i32 a4)
+static void DNI tcg_gen_op4_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                                TCGv_i32 a3, TCGv_i32 a4)
 {
     tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), tcgv_i32_arg(a4));
 }
 
-void DNI tcg_gen_op4_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                         TCGv_i64 a3, TCGv_i64 a4)
+static void DNI tcg_gen_op4_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
+                                TCGv_i64 a3, TCGv_i64 a4)
 {
     tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
                 tcgv_i64_arg(a3), tcgv_i64_arg(a4));
 }
 
-void DNI tcg_gen_op4i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                          TCGv_i32 a3, TCGArg a4)
+static void DNI tcg_gen_op4i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                                 TCGv_i32 a3, TCGArg a4)
 {
     tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), a4);
 }
 
-void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                          TCGv_i64 a3, TCGArg a4)
+static void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
+                                 TCGv_i64 a3, TCGArg a4)
 {
     tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
                 tcgv_i64_arg(a3), a4);
 }
 
-void DNI tcg_gen_op4ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                           TCGArg a3, TCGArg a4)
+static void DNI tcg_gen_op4ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                                  TCGArg a3, TCGArg a4)
 {
     tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3, a4);
 }
 
-void DNI tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                           TCGArg a3, TCGArg a4)
+static void DNI tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
+                                  TCGArg a3, TCGArg a4)
 {
     tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3, a4);
 }
 
-void DNI tcg_gen_op5_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                         TCGv_i32 a3, TCGv_i32 a4, TCGv_i32 a5)
+static void DNI tcg_gen_op5_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                                TCGv_i32 a3, TCGv_i32 a4, TCGv_i32 a5)
 {
     tcg_gen_op5(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5));
 }
 
-void DNI tcg_gen_op5_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                         TCGv_i64 a3, TCGv_i64 a4, TCGv_i64 a5)
+static void DNI tcg_gen_op5_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
+                                TCGv_i64 a3, TCGv_i64 a4, TCGv_i64 a5)
 {
     tcg_gen_op5(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
                 tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5));
 }
 
-void DNI tcg_gen_op5i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                          TCGv_i32 a3, TCGv_i32 a4, TCGArg a5)
-{
-    tcg_gen_op5(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), tcgv_i32_arg(a4), a5);
-}
-
-void DNI tcg_gen_op5i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                          TCGv_i64 a3, TCGv_i64 a4, TCGArg a5)
-{
-    tcg_gen_op5(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), tcgv_i64_arg(a4), a5);
-}
-
-void DNI tcg_gen_op5ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                           TCGv_i32 a3, TCGArg a4, TCGArg a5)
+static void DNI tcg_gen_op5ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                                  TCGv_i32 a3, TCGArg a4, TCGArg a5)
 {
     tcg_gen_op5(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), a4, a5);
 }
 
-void DNI tcg_gen_op5ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                           TCGv_i64 a3, TCGArg a4, TCGArg a5)
+static void DNI tcg_gen_op5ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
+                                  TCGv_i64 a3, TCGArg a4, TCGArg a5)
 {
     tcg_gen_op5(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
                 tcgv_i64_arg(a3), a4, a5);
 }
 
-void DNI tcg_gen_op6_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2, TCGv_i32 a3,
-                         TCGv_i32 a4, TCGv_i32 a5, TCGv_i32 a6)
+static void DNI tcg_gen_op6_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                                TCGv_i32 a3, TCGv_i32 a4,
+                                TCGv_i32 a5, TCGv_i32 a6)
 {
     tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5),
                 tcgv_i32_arg(a6));
 }
 
-void DNI tcg_gen_op6_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2, TCGv_i64 a3,
-                         TCGv_i64 a4, TCGv_i64 a5, TCGv_i64 a6)
+static void DNI tcg_gen_op6_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
+                                TCGv_i64 a3, TCGv_i64 a4,
+                                TCGv_i64 a5, TCGv_i64 a6)
 {
     tcg_gen_op6(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
                 tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5),
                 tcgv_i64_arg(a6));
 }
 
-void DNI tcg_gen_op6i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2, TCGv_i32 a3,
-                          TCGv_i32 a4, TCGv_i32 a5, TCGArg a6)
+static void DNI tcg_gen_op6i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                                 TCGv_i32 a3, TCGv_i32 a4,
+                                 TCGv_i32 a5, TCGArg a6)
 {
     tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5), a6);
 }
 
-void DNI tcg_gen_op6i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2, TCGv_i64 a3,
-                          TCGv_i64 a4, TCGv_i64 a5, TCGArg a6)
+static void DNI tcg_gen_op6i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
+                                 TCGv_i64 a3, TCGv_i64 a4,
+                                 TCGv_i64 a5, TCGArg a6)
 {
     tcg_gen_op6(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
                 tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5), a6);
 }
 
-void DNI tcg_gen_op6ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                           TCGv_i32 a3, TCGv_i32 a4, TCGArg a5, TCGArg a6)
+static void DNI tcg_gen_op6ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                                  TCGv_i32 a3, TCGv_i32 a4,
+                                  TCGArg a5, TCGArg a6)
 {
     tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), tcgv_i32_arg(a4), a5, a6);
 }
 
-void DNI tcg_gen_op6ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                           TCGv_i64 a3, TCGv_i64 a4, TCGArg a5, TCGArg a6)
-{
-    tcg_gen_op6(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), tcgv_i64_arg(a4), a5, a6);
-}
-
 /* Generic ops.  */
 
 void gen_set_label(TCGLabel *l)
-- 
2.34.1


