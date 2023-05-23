Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D2F70DF05
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:17:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SVe-0003Cd-LQ; Tue, 23 May 2023 09:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVa-00038z-F9
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:02 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVX-0004BV-8y
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:02 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-64d1e96c082so4214988b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850218; x=1687442218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jIBJg2lmoN4SFecYrI5sb6VaAgGxZyVvAyGpaJ4I0ws=;
 b=o2yABc5bQOXdy8Kx1nSLrZCHG+6VludoGRQFpCX1KoUcG/sjdbUhMFBn3gdGESZYjT
 mX8YWbaG+m3/2Bi1KHMMOrWKGakrXEhLeEoK2knjAci799+vpCQqjw5t2yLS1sQBq+sI
 1VmyHpXlVMxT8yhmD/kXNTMwLgoPzHwyazQ/ADqI2ldnrmLVVvyZI587242dsTMNOU1O
 dOXTdrq0Vn2k0imk8jyKCTl3U0QjnL/cZLjg9vsyaQGmfoYkAgwe5G7sGVnxbMmKTQlK
 tnC20JOyROX4KFtYxU3GeWK2H6B30OYO9DLVBw3IQarg8CsAVcKgJf4T2vIJyyxcEane
 QkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850218; x=1687442218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jIBJg2lmoN4SFecYrI5sb6VaAgGxZyVvAyGpaJ4I0ws=;
 b=Gdu96RDvrXlj8Vfk0xvdBL//34FCCMGm10GN35oxo973upXDKMeXmvOQ/2ep+f6+Nc
 BUODAIPOTGTHmBSfNYOTFQ2q2XL6qJYj/y/ZPJiOjXskMAQOqmNS9cMD+7m3c1MRyqdp
 jRah/GpbAR1uw5tTGhTEIPDBrGw1q0aHswxzXSbNYAAIARXTYgzs5zYX8dY4XK/uqaUk
 lh+e7QHQjCn1tq+FzjQAOKH5uSg8ajwx0d+/11x9VCzpxgLluCSZH2rt7U2yKUdO+2Og
 8lGxiyGx6+WohoEcqaDwAMybTaev+T1m3tYO61Hsy+YKFuhmvObF1wrAhGLrdJMZVW3u
 pboQ==
X-Gm-Message-State: AC+VfDz8TO3A7IZClfyy6LN52Kp1ukFC0gXYcynK/NTVAll0DgrXh5Ji
 ha7HBdaunrD1wZjNgYuIxSguvGWDA/9f+pRJfAM=
X-Google-Smtp-Source: ACHHUZ5plF4ERR373wIaL4fLb8jg7e04iBwdWgt5D/TWDarWXZJQXWiDcWxlRz4PLpThe+vEgKB97g==
X-Received: by 2002:a05:6a00:1486:b0:645:d02d:9a83 with SMTP id
 v6-20020a056a00148600b00645d02d9a83mr20047104pfu.17.1684850217886; 
 Tue, 23 May 2023 06:56:57 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a62a50b000000b0063799398eaesm5805790pfm.51.2023.05.23.06.56.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:56:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 41/52] target/mips: Tidy helpers for translation
Date: Tue, 23 May 2023 06:53:11 -0700
Message-Id: <20230523135322.678948-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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


