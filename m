Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D730F7230F8
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:17:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GdB-0002A8-7h; Mon, 05 Jun 2023 16:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gct-0001yW-77
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:28 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcq-0003ri-SS
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:26 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-650c89c7e4fso5357753b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996183; x=1688588183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2IczERNlolD1Q3LBjraMPYKc5d0zVB/raqEwGBfncQs=;
 b=XYprmoZgvFNC/Fl6lFi/PdfD9RZEmieqv0SZ0trzrZO5sLsf35RrNk45boN7mxZ8YO
 PHddfhJoE+/+FVrC+kJokF1HN14fnjGzPpTV4a9WfYpM1+oXAP6nX5ffCOdM6h4YAsJ3
 EmMiJtTehWvcGztwF2pE7Sm2vo8H2D9jNo/1PJy9RdSRJeXGJR8jqEjpPmAnlKSoNVQ3
 FpXaCtI9140E8W7LPQq6zbOUQPrMiN6ohTQRS732FA0TCNqP1OVur6/rSuf3zoy/JqkR
 Ukwkqit1DrCahORDl+CEbVcAneKokzO+Lf8j+8Jzcp+FnM0lvgUlbmh+cC8CUCzjN994
 MBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996183; x=1688588183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2IczERNlolD1Q3LBjraMPYKc5d0zVB/raqEwGBfncQs=;
 b=Bpq+SMPn1q8kwLF093Ts72Uqs4CTB1x3O1VBMfFe/WrE+GiLJRnJs4el4iAvMq+0t2
 w5QcQ9fb62JPZIdzp/SUaqBZUVqD+19+pU6UTx5+OOuCFpFonDU1rwsZnEzYIsBJ2kv8
 AoOzdkhy7JlRk46k7GwAtXE5EnIFG78eS2Iu5oWNrquUP4l4XfsIieR0nkOh7GAajnrA
 g9ta14T6Q/pPEJSYpFbpznQRLOCj7+Y4SRnEXMwLxwZAKV7ajPfs/Ck6fjPhqMvTqID6
 urOQ8oEB6UO3q0OdaSErulGnerz5vCvXRxqg4nfsGM11YGv/AuDoHnfqO5+ClB96fgda
 NC+A==
X-Gm-Message-State: AC+VfDy1fH/XOz64NF6WylzngqQOpkbtwa8RKsSEXxLqqP8CU6cZscU6
 x9W6MP+AllfWjCt8nfFEhK9wExev/lrGr1zn2sQ=
X-Google-Smtp-Source: ACHHUZ4lj1lK21Da18SdyQtnR+hblK52dRaRooS0i99n5b683yNIdr9M7lXg9cLFJScTR1dZWNPhSw==
X-Received: by 2002:a05:6a20:4426:b0:111:97f:6d9d with SMTP id
 ce38-20020a056a20442600b00111097f6d9dmr6710pzb.62.1685996183480; 
 Mon, 05 Jun 2023 13:16:23 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:16:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 39/52] target/arm: Tidy helpers for translation
Date: Mon,  5 Jun 2023 13:15:35 -0700
Message-Id: <20230605201548.1596865-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Move most includes from *translate*.c to translate.h, ensuring
that we get the ordering correct.  Ensure cpu.h is first.
Use disas/disas.h instead of exec/log.h.
Drop otherwise unused includes.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h        |  3 +++
 target/arm/tcg/translate-a64.c    | 17 +++++------------
 target/arm/tcg/translate-m-nocp.c |  2 --
 target/arm/tcg/translate-mve.c    |  3 ---
 target/arm/tcg/translate-neon.c   |  3 ---
 target/arm/tcg/translate-sme.c    |  6 ------
 target/arm/tcg/translate-sve.c    |  9 ---------
 target/arm/tcg/translate-vfp.c    |  3 ---
 target/arm/tcg/translate.c        | 17 +++++------------
 9 files changed, 13 insertions(+), 50 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 868a3abd0d..5b53b6215d 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -1,6 +1,9 @@
 #ifndef TARGET_ARM_TRANSLATE_H
 #define TARGET_ARM_TRANSLATE_H
 
+#include "cpu.h"
+#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
 #include "exec/translator.h"
 #include "exec/helper-gen.h"
 #include "internals.h"
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 8d45dbf8fc..d9800337cf 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -18,20 +18,13 @@
  */
 #include "qemu/osdep.h"
 
-#include "cpu.h"
-#include "exec/exec-all.h"
-#include "tcg/tcg-op.h"
-#include "tcg/tcg-op-gvec.h"
-#include "qemu/log.h"
-#include "arm_ldst.h"
 #include "translate.h"
-#include "internals.h"
-#include "qemu/host-utils.h"
-#include "semihosting/semihost.h"
-#include "exec/log.h"
-#include "cpregs.h"
 #include "translate-a64.h"
-#include "qemu/atomic128.h"
+#include "qemu/log.h"
+#include "disas/disas.h"
+#include "arm_ldst.h"
+#include "semihosting/semihost.h"
+#include "cpregs.h"
 
 static TCGv_i64 cpu_X[32];
 static TCGv_i64 cpu_pc;
diff --git a/target/arm/tcg/translate-m-nocp.c b/target/arm/tcg/translate-m-nocp.c
index 9a89aab785..33f6478bb9 100644
--- a/target/arm/tcg/translate-m-nocp.c
+++ b/target/arm/tcg/translate-m-nocp.c
@@ -18,8 +18,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "tcg/tcg-op.h"
-#include "tcg/tcg-op-gvec.h"
 #include "translate.h"
 #include "translate-a32.h"
 
diff --git a/target/arm/tcg/translate-mve.c b/target/arm/tcg/translate-mve.c
index 2ad3c40975..bbc7b3f4ce 100644
--- a/target/arm/tcg/translate-mve.c
+++ b/target/arm/tcg/translate-mve.c
@@ -18,9 +18,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "tcg/tcg-op.h"
-#include "tcg/tcg-op-gvec.h"
-#include "exec/exec-all.h"
 #include "translate.h"
 #include "translate-a32.h"
 
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 6fac577abd..03913de047 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -21,9 +21,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "tcg/tcg-op.h"
-#include "tcg/tcg-op-gvec.h"
-#include "exec/exec-all.h"
 #include "translate.h"
 #include "translate-a32.h"
 
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index b0812d9dd6..d0054e3f77 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -18,14 +18,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
-#include "tcg/tcg-op.h"
-#include "tcg/tcg-op-gvec.h"
-#include "tcg/tcg-gvec-desc.h"
 #include "translate.h"
 #include "translate-a64.h"
-#include "fpu/softfloat.h"
-
 
 /*
  * Include the generated decoder.
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 106baf311f..d9d5810dde 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -18,16 +18,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
-#include "exec/exec-all.h"
-#include "tcg/tcg-op.h"
-#include "tcg/tcg-op-gvec.h"
-#include "tcg/tcg-gvec-desc.h"
-#include "qemu/log.h"
-#include "arm_ldst.h"
 #include "translate.h"
-#include "internals.h"
-#include "exec/log.h"
 #include "translate-a64.h"
 #include "fpu/softfloat.h"
 
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 95ac8d9db3..359b1e3e96 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -21,9 +21,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "tcg/tcg-op.h"
-#include "tcg/tcg-op-gvec.h"
-#include "exec/exec-all.h"
 #include "translate.h"
 #include "translate-a32.h"
 
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 7caf6d802d..a68d3c7f6d 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -20,20 +20,13 @@
  */
 #include "qemu/osdep.h"
 
-#include "cpu.h"
-#include "internals.h"
-#include "disas/disas.h"
-#include "exec/exec-all.h"
-#include "tcg/tcg-op.h"
-#include "tcg/tcg-op-gvec.h"
-#include "qemu/log.h"
-#include "qemu/bitops.h"
-#include "arm_ldst.h"
-#include "semihosting/semihost.h"
-#include "exec/log.h"
-#include "cpregs.h"
 #include "translate.h"
 #include "translate-a32.h"
+#include "qemu/log.h"
+#include "disas/disas.h"
+#include "arm_ldst.h"
+#include "semihosting/semihost.h"
+#include "cpregs.h"
 #include "exec/helper-proto.h"
 
 #define HELPER_H "helper.h"
-- 
2.34.1


