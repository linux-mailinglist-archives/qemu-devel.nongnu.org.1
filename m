Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 012317174D3
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:08:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D4C-0007ZW-Lw; Wed, 31 May 2023 00:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D46-0007OH-UZ
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:04:02 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D44-0006B7-No
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:04:02 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-33bdab7b4caso1891465ab.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505840; x=1688097840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yWrZGJGhJkGS/jT+aD3SdArCyOPdyMfFotilTaL2dRI=;
 b=r7aq0z98iWOH+Trj3Skrnc4XcgYDOjXn6H1juHyaXel56CV7GXeccpsqIw1aOZBzN+
 XAG+zIodEbJUN4AX/Oxkb6vNVtaQ13VS/A64aKuEaqCdkVevtwvMmc+mfXZ6QApn1LY0
 OSi5CyQi18RwTcZVQNXwMLe8AcVPHnX1hJE1RF57UwThGkl0CvEPOEt36/qQcWoea3Wc
 7Nx9FasXcGzmhofCn5EbTqj4+uxx3xTfP1bGgCBmYk2wmmYR7P0wgCXt9TSE3Q+vjEYz
 rj+BIZkYmvUoA3S0U2oH7NTMFuXB6KZRUzX2qbkDkE7V8nrYAM8RODWHSzwmHQwVzuE0
 aRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505840; x=1688097840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWrZGJGhJkGS/jT+aD3SdArCyOPdyMfFotilTaL2dRI=;
 b=XIs9v+Is8TNC/vWdav0QgUZfNfwE8XJs5MOBP5j3qdREQg0jv9u05ui4xXW9sKHZsG
 xn+E/PSEm9NQvtxN8XAkTWWAvcJVvk6vZf6mUZ8oOZjKp8Sttufu4MRM8HAKnRX71pqc
 yFOE3/VWlUoaGguH4Fam7yPpNIer7fKEXG1cU+8BaURzSxz+OdcNvnjtQHCa6+/JM0cI
 T3t0R2RF7L+rMyON0J/VnRyxx/IZPOrr2IN1U+u3+4P35inT5f/EHOvk09txXpDE9fDj
 Sc+0J/TakR857pTi3y88vQLBan8cN5cXt2BGzx3Iv8YUR3ovRE5P0gCsZ98xayXdMia+
 9ijw==
X-Gm-Message-State: AC+VfDyUyEoYgVxV2w7PSPw9O05vj1HVw06ovMgQupK1n+fUwYdeOzNU
 KEhZjoV2NDtPz+PiXfk2ip0CiemByBZ4jiPv4lY=
X-Google-Smtp-Source: ACHHUZ4JnJo+Dun8ALsIrn6/14L+eeJT3Dgn3Awqio4LIdeIj1cmDPOiMJ2ftqBYFZHsVPyv4c3wIQ==
X-Received: by 2002:a92:d203:0:b0:335:56cb:a3a with SMTP id
 y3-20020a92d203000000b0033556cb0a3amr960291ily.16.1685505839944; 
 Tue, 30 May 2023 21:03:59 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 37/48] target/arm: Tidy helpers for translation
Date: Tue, 30 May 2023 21:03:19 -0700
Message-Id: <20230531040330.8950-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x131.google.com
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


