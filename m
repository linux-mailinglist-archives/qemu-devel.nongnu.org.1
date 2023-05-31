Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A3E7174F6
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:13:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D4I-0007d3-T4; Wed, 31 May 2023 00:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D47-0007Uv-W5
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:04:04 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D46-0006J8-3O
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:04:03 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-39a3f26688bso917399b6e.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505841; x=1688097841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jIBJg2lmoN4SFecYrI5sb6VaAgGxZyVvAyGpaJ4I0ws=;
 b=x/918YIX7KsoPChVHYdTP/ZYDuTraQxbCWCsE/rNXdWELsnrkl3qbc1/fqnjCaLI+S
 iU8D/dHR95bmJadc2Y6r9wsTTb4D6AKzoxC7VnaE1VZsgbA5hQs9Dk/CXVGcajuaT28n
 8o/8SAtAB/xiDdhGj6FS8So5tq4vXESWbV/pBfZGWtMb17U9DC6dj3/jShCWyzLrsMOS
 M2HB29vJ+MotpCwJDTS8JlgYqX3KeKKEgF2GeGDPanA1u42bEuGKC2o69Ke5kFifmU9M
 0ns6PYty1z75U0Okg3WEsm2x3o2tnq7lCRQljcFtN9KQcK/0bIk+C1AamRCGfPrAfXWh
 ZqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505841; x=1688097841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jIBJg2lmoN4SFecYrI5sb6VaAgGxZyVvAyGpaJ4I0ws=;
 b=TpyIfFpixNL2HDOYMOWVqLN7zow3P+8errzmjw4tp4ja8gRZrcgzB0+XXsHKPEYzgR
 o3VtXeHDyj7TOoIOVX4oSbrLIam1urDNF7j47O640szirzdvmPf7PuUT9gvORv3IiUS5
 TxfV0PDkoaELZAkuXEHwYrNpvSqG4lzRbInEN4882NH4cOowHUsaLMPrK7w7ejm5P7Bv
 w4df8iDlllQ/fqaS28qR3atWSet5Biw8gSbRycy4MdkF2CKZgdGkduw8HKMMcfHgfdo0
 YpzcOALjbwhOkRjg2iaOVyVyIgY/rxJuZAzUOkdY5GQkOJuazZ4Ku9fKQlfEp3LYlnl8
 BvPw==
X-Gm-Message-State: AC+VfDz9RDx9BjtvJWYsZ5PzYbS+WV+yZBzSr6PTZX6LrBVVnZAxVoHn
 fES1K2IyFrDXH+RqnnUUtVKJAh0qU3QoOMuQpz0=
X-Google-Smtp-Source: ACHHUZ7vdpCoQoRdnAJXvC4jp0c46UuoE479s6qEqj50T22/gKCIn3zyXfRpBSvZLIvDVZZuUm3BkA==
X-Received: by 2002:a05:6808:191f:b0:398:c4ec:63bc with SMTP id
 bf31-20020a056808191f00b00398c4ec63bcmr4247133oib.43.1685505840923; 
 Tue, 30 May 2023 21:04:00 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.04.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:04:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 38/48] target/mips: Tidy helpers for translation
Date: Tue, 30 May 2023 21:03:20 -0700
Message-Id: <20230531040330.8950-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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


