Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7305670DE39
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:57:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SVg-0003GY-I2; Tue, 23 May 2023 09:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVY-00036f-P4
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:02 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVW-0004BN-N6
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:00 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-64f47448aeaso363641b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850217; x=1687442217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yWrZGJGhJkGS/jT+aD3SdArCyOPdyMfFotilTaL2dRI=;
 b=LJBXY/2O+DxopgPZNK/s+cO/KW1lufkO6rmnj9ULvao5Gtbg6FMcC7iEoxpkP/ZlM1
 TdP0kNR3MKcFil6j6UmEnQlb8rS9ge+tLWO62ZmF05Ed08x3inAoKW2yz3cXde2H529B
 B8l4Y1joEe8nMWGqweyy/vWYibyU2WJp4BlR2WA7jQx9G1FFC2IQi9jcuP9QVofGHchr
 wS0v0+ADVx7jGVtJ3JwjbS3GaoEd/RDfGLm7hf362xfk4vIrgYAXDjjZI+nVoP5BCaV1
 sQpilPpsv4rlSSbvqX+iCstNz45O/5L8q+BQa/E3xtSeRFiayn32H9/f4BpdTJe9hJ9Z
 C98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850217; x=1687442217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWrZGJGhJkGS/jT+aD3SdArCyOPdyMfFotilTaL2dRI=;
 b=TJnarG0mumr0tez4OWMdOzIkg+8XQJ6kXdNixcR/VeSVRGwCbReWMYP3tKhYNYu/g5
 8F4o6wKOLA3k5YgLYSgBx7ghy58eIg6U5REKxz1cNqfg4AuMKy0sfOBf8tjKDC6/PqLa
 93AEdM+O5D2+IJFz/A38mXVrSEOzgIuFHCdWlgC1MxI5+spOqEbFvQgbl3TL0KKSI6uc
 OJ2o+Yp5azMb/J4J1vxEAeKAke2WNbya/2/j3wzYABYtBBPqWlqJx1FNtdjfrAtEfo2O
 HhyRREZsEnOrOvivxeJOX7P1BGO8/UFtH+nGOo0U5WMsnF8UNQmhmx38jYsbXyGbB0Q3
 4kMg==
X-Gm-Message-State: AC+VfDwYuYXwvIZy6UW/BrwoeAqiE+hN8mDE0RdaVDwYiQ18XQZGrQ1c
 bzUtd75C4gX1txzR7unV77AmhfKhK89aBm4leHg=
X-Google-Smtp-Source: ACHHUZ5XYT9lHmQzZUwwnZ5Ar3ny+ytkrq9vSPE46BQukudVFoQb/OmKCb4DqlZ6W467kmjqbh3HpA==
X-Received: by 2002:a05:6a00:1a15:b0:638:7e00:3737 with SMTP id
 g21-20020a056a001a1500b006387e003737mr16186906pfv.23.1684850217091; 
 Tue, 23 May 2023 06:56:57 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a62a50b000000b0063799398eaesm5805790pfm.51.2023.05.23.06.56.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:56:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 40/52] target/arm: Tidy helpers for translation
Date: Tue, 23 May 2023 06:53:10 -0700
Message-Id: <20230523135322.678948-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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


