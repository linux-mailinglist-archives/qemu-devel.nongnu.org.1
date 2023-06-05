Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE929723153
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:27:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GgI-0007Dk-Gt; Mon, 05 Jun 2023 16:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gfo-0006sL-Ks
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:32 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gfm-0005j1-8v
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:27 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1b02085bf8dso23997045ad.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996365; x=1688588365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ho2ebAK9oxZJuEiRPgTWt9rbyluwjwTYfaQBgc6qN/k=;
 b=MZwwXC0GInF8ZLp8bUYQoBVaVBR3lC8Q7adCvQYFLYW2GCoDm3DleEXmutSQfD2tdd
 8LCkKahIu1AwWajSy8Ez/cgSkUb2aek5D3fUGRl4Y8p6L3y1kO44LbDvWJJRNfZDHWhr
 aykyNaOLBjVZgsM5r0kwKsMkbcTEXuA2HJ7T6IljDdYmo1/GdewevxxesKLm783gkheS
 ARB+EWKi6HDTKyrHQRlffo6Pm82lUZQ77DbVbvHP3BWpenxn8xT5S1RrPfvVcTVqE+BS
 um4x6QgI/Px6sBMPyTNCD2V789t/Xw8XGeGnUSJhW9LUIn+c3sKMhdhMtif/o7C+i0CD
 M8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996365; x=1688588365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ho2ebAK9oxZJuEiRPgTWt9rbyluwjwTYfaQBgc6qN/k=;
 b=S0gMLKp3R06VyWkKOtSaDzlH6w5HAJ7Zlvs/W6iuA+jwjKOHqAJcRy8dL9xXZ+WhQR
 vZmzcNqcf7JsF8VxMbH/aqt8/mEmsvm1bFnbCnl4u6sq6Vc4lXVGgOMDdM36wdh5wbCz
 pamuenhvlwTb7HvYb2+FxuiJkWHI3tj6IXFRVIeE9SYZO68FJSqSyrtIPK8EiAiVh65C
 CQNqZjjp1F2LWMJXXxw8R5tir1lVB99IF/WJVhyodLjtlDSJvwFyeRx62XHBIJRq3CIj
 9EQxk8ypARlhiyPgfcmWcY42L8jvZf4IZqBZxhWrp0fVCypINfkaW6m3IBUcj/+RbIdD
 Xm5A==
X-Gm-Message-State: AC+VfDxIpjQn7fu+uwHSFLw7w+oCy3u+Zt+QsmOGeGmC/BAV7P3BX4BI
 YBvImwrcGjXw3S5ZPAo6GJFJkTiScvyczHuN1Wg=
X-Google-Smtp-Source: ACHHUZ4BvC6i0L6RXOjlr+EJbQ8FUNHrTXrwNuuBFJUqowyYENGXYFgh78wouDYeLuqF+ElVo0THlQ==
X-Received: by 2002:a17:903:1250:b0:1b0:4680:3f with SMTP id
 u16-20020a170903125000b001b04680003fmr26696plh.41.1685996364747; 
 Mon, 05 Jun 2023 13:19:24 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 w20-20020a170902c79400b001a980a23802sm7018184pla.111.2023.06.05.13.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:19:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 40/52] target/mips: Tidy helpers for translation
Date: Mon,  5 Jun 2023 13:15:36 -0700
Message-Id: <20230605201548.1596865-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
 target/mips/tcg/translate.h            |  6 ++++--
 target/mips/tcg/msa_translate.c        |  3 ---
 target/mips/tcg/mxu_translate.c        |  2 --
 target/mips/tcg/octeon_translate.c     |  4 +---
 target/mips/tcg/rel6_translate.c       |  2 --
 target/mips/tcg/translate.c            | 18 ++++++------------
 target/mips/tcg/translate_addr_const.c |  1 -
 target/mips/tcg/tx79_translate.c       |  4 +---
 target/mips/tcg/vr54xx_translate.c     |  3 ---
 9 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index fa8bf55209..3b0498a47a 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -8,9 +8,11 @@
 #ifndef TARGET_MIPS_TRANSLATE_H
 #define TARGET_MIPS_TRANSLATE_H
 
-#include "qemu/log.h"
-#include "exec/translator.h"
+#include "cpu.h"
 #include "tcg/tcg-op.h"
+#include "exec/translator.h"
+#include "exec/helper-gen.h"
+#include "qemu/log.h"
 
 #define MIPS_DEBUG_DISAS 0
 
diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
index 220cd3b048..b5b66fb38a 100644
--- a/target/mips/tcg/msa_translate.c
+++ b/target/mips/tcg/msa_translate.c
@@ -11,11 +11,8 @@
  * SPDX-License-Identifier: LGPL-2.1-or-later
  */
 #include "qemu/osdep.h"
-#include "tcg/tcg-op.h"
-#include "exec/helper-gen.h"
 #include "translate.h"
 #include "fpu_helper.h"
-#include "internal.h"
 
 static int elm_n(DisasContext *ctx, int x);
 static int elm_df(DisasContext *ctx, int x);
diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index be038b5f07..39348b3a91 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -16,8 +16,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "tcg/tcg-op.h"
-#include "exec/helper-gen.h"
 #include "translate.h"
 
 /*
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 103c304d10..e25c4cbaa0 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -7,10 +7,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "tcg/tcg-op.h"
-#include "tcg/tcg-op-gvec.h"
-#include "exec/helper-gen.h"
 #include "translate.h"
+#include "tcg/tcg-op-gvec.h"
 
 /* Include the auto-generated decoder.  */
 #include "decode-octeon.c.inc"
diff --git a/target/mips/tcg/rel6_translate.c b/target/mips/tcg/rel6_translate.c
index d631851258..59f237ba3b 100644
--- a/target/mips/tcg/rel6_translate.c
+++ b/target/mips/tcg/rel6_translate.c
@@ -9,8 +9,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "tcg/tcg-op.h"
-#include "exec/helper-gen.h"
 #include "translate.h"
 
 /* Include the auto-generated decoders.  */
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 312ed66989..f3da05ba3b 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -23,19 +23,13 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
-#include "internal.h"
-#include "tcg/tcg-op.h"
-#include "exec/translator.h"
-#include "exec/helper-proto.h"
-#include "exec/helper-gen.h"
-#include "semihosting/semihost.h"
-
-#include "trace.h"
-#include "exec/log.h"
-#include "qemu/qemu-print.h"
-#include "fpu_helper.h"
 #include "translate.h"
+#include "internal.h"
+#include "exec/helper-proto.h"
+#include "semihosting/semihost.h"
+#include "trace.h"
+#include "disas/disas.h"
+#include "fpu_helper.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
diff --git a/target/mips/tcg/translate_addr_const.c b/target/mips/tcg/translate_addr_const.c
index a510da406c..6f4b39f715 100644
--- a/target/mips/tcg/translate_addr_const.c
+++ b/target/mips/tcg/translate_addr_const.c
@@ -11,7 +11,6 @@
  * SPDX-License-Identifier: LGPL-2.1-or-later
  */
 #include "qemu/osdep.h"
-#include "tcg/tcg-op.h"
 #include "translate.h"
 
 bool gen_lsa(DisasContext *ctx, int rd, int rt, int rs, int sa)
diff --git a/target/mips/tcg/tx79_translate.c b/target/mips/tcg/tx79_translate.c
index 3a45a1bfea..dd6fb8a7bd 100644
--- a/target/mips/tcg/tx79_translate.c
+++ b/target/mips/tcg/tx79_translate.c
@@ -8,10 +8,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "tcg/tcg-op.h"
-#include "tcg/tcg-op-gvec.h"
-#include "exec/helper-gen.h"
 #include "translate.h"
+#include "tcg/tcg-op-gvec.h"
 
 /* Include the auto-generated decoder.  */
 #include "decode-tx79.c.inc"
diff --git a/target/mips/tcg/vr54xx_translate.c b/target/mips/tcg/vr54xx_translate.c
index 804672f84c..2c1f6cc527 100644
--- a/target/mips/tcg/vr54xx_translate.c
+++ b/target/mips/tcg/vr54xx_translate.c
@@ -10,10 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "tcg/tcg-op.h"
-#include "exec/helper-gen.h"
 #include "translate.h"
-#include "internal.h"
 
 /* Include the auto-generated decoder. */
 #include "decode-vr54xx.c.inc"
-- 
2.34.1


