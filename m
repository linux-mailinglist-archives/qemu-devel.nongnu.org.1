Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B4072B107
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 11:06:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Gw7-00034H-MT; Sun, 11 Jun 2023 05:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8GvV-0002XY-Kz
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 05:00:00 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8GvP-0003l3-RQ
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 04:59:54 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-307d20548adso2161121f8f.0
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 01:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686473989; x=1689065989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5nz4UOUVBnov9YujuZ44MJvqxjEXrGs664hSVxA4MoM=;
 b=iZsCcQAIsiry4BtQd/wddHuRkOXcU0t2ZsyUrWSsGAytswR/cATk70HNp/12c3LfEc
 Tmt70EiFy7AWJ8KQJpP3RbyeNHAurOTb2dR612VCLjtYnQsCpZ1Gx4ryQWRrg+y2hfbi
 qrau9WJJdDw0ZMS4tWSZrZEqVLHmUsfsKzcbxNrzg441dSwJm7KhlnnfqMl52u7lTAGS
 p91fr0TZzT0Y249PA2EkPWbgUbTTyp5YH5DGfM8zzRO2XL/GEDooQIUIn05ZBWbL7hd/
 0JhBjNFir+uU7X8xvV7kc4NmOqreVr0wFTPNCmiJe2Z9aFGYic8A/rdGEE6YNRMPweKF
 MIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686473989; x=1689065989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5nz4UOUVBnov9YujuZ44MJvqxjEXrGs664hSVxA4MoM=;
 b=eklHBgBBzjpxjWCeRcqh7pQ4EErW0+ZsC7oJo6jiA0xQ1dW/5AWl30kSYCpN2tOh7P
 2uIAefx0Qg0nCGsR2eFx+tf+0YtM4ObrUCeTeQwtG0GFpEricyZufdoGxwk0L6/88D0R
 DW3Be0KnyEJQY8pi4vsuCpDxlSJSUSXrESSewb38eDLjrrK7KQoPux2Fg7xNraHEsOE7
 wAwGDtCgujUbqYriPx8muXputvNgnzI2y6ZUqLAOEHPKx0L5LAaNIW6uns6JHzpETEdu
 5x4Gu35pjx5Dke9fU2wCqBoh9K8nksv0vPo9n1AcwJx8gYSLuZ3wUOSr/RpZb/hiCId3
 FTNg==
X-Gm-Message-State: AC+VfDyfratYXaPMx+UQKY3hKIB5XxzN2zhV4rwBv5Xi5C9hwa4bTYTA
 WaZvmCsVIhfWSQHJrRA97Kq0TPe1O9b4MXOqFvU=
X-Google-Smtp-Source: ACHHUZ4niy0G1FGC0sF8damYThS0ASNWJYbE5zyIq+y6lkw8GBxqsVmKvjwYNiSZh0+rkxoNmzNLvw==
X-Received: by 2002:adf:f983:0:b0:307:8c47:a266 with SMTP id
 f3-20020adff983000000b003078c47a266mr2401236wrr.61.1686473989020; 
 Sun, 11 Jun 2023 01:59:49 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 o7-20020adfeac7000000b002fed865c55esm9139039wrn.56.2023.06.11.01.59.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jun 2023 01:59:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 14/26] target/arm/tcg: Reduce 'helper-neon.h.inc' inclusion
Date: Sun, 11 Jun 2023 10:58:34 +0200
Message-Id: <20230611085846.21415-15-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230611085846.21415-1-philmd@linaro.org>
References: <20230611085846.21415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Instead of including helper-neon.h.inc via helper.h which
is included by all TCG files, restrict it to the few files
that require it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.h             | 1 -
 target/arm/tcg/neon_helper.c    | 5 ++++-
 target/arm/tcg/translate-a64.c  | 4 ++++
 target/arm/tcg/translate-neon.c | 6 ++++++
 target/arm/tcg/translate-sme.c  | 4 ++++
 target/arm/tcg/translate.c      | 4 ++++
 target/arm/tcg/vec_helper.c     | 4 ++++
 7 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 97d97dc9d8..eb8ac68dc8 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -589,5 +589,4 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
 #include "tcg/helper-sme.h.inc"
 #endif
 
-#include "tcg/helper-neon.h.inc"
 #include "tcg/helper-mve.h.inc"
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index 0a4ab3e42c..0432a6e771 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -9,10 +9,13 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 #include "vec_internal.h"
 
+#define HELPER_H "tcg/helper-neon.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 #define SIGNBIT (uint32_t)0x80000000
 #define SIGNBIT64 ((uint64_t)1 << 63)
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c0727c900f..22caf89bb0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -30,6 +30,10 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-neon.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 static TCGv_i64 cpu_X[32];
 static TCGv_i64 cpu_pc;
 
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 497aba2e39..9a1831f849 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -28,6 +28,12 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-neon.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 /* Include the generated Neon decoder */
 #include "decode-neon-dp.c.inc"
 #include "decode-neon-ls.c.inc"
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index d0054e3f77..24796e5d9e 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -21,6 +21,10 @@
 #include "translate.h"
 #include "translate-a64.h"
 
+#define HELPER_H "tcg/helper-neon.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 /*
  * Include the generated decoder.
  */
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index a352fced6e..2b3951cece 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -29,6 +29,10 @@
 #include "cpregs.h"
 #include "exec/helper-proto.h"
 
+#define HELPER_H "tcg/helper-neon.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 013ca1b05f..af325577f0 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -29,6 +29,10 @@
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-neon.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 /*
  * Data for expanding active predicate bits to bytes, for byte elements.
  *
-- 
2.38.1


