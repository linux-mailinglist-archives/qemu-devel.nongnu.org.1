Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0619A735BAC
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:58:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBHFg-00009P-Jb; Mon, 19 Jun 2023 11:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHFM-0008MX-EJ
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:56:53 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHFK-00058r-HW
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:56:52 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51a4044b7a1so4497121a12.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687190209; x=1689782209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O0JFs8J8H69a32Oys+A1HsefMvNV2m2DSa8XIdwXMC4=;
 b=OWII09jZ8lgkTrZJdcilIXzm4CtZlUTWfYzmIv6diKgpV+OioZCMu5fZH/4wEv7J1Z
 AsoKrJLtvnDj9hYdqHzBULoN6Ttm1Lv6rBokyLEvMv6lP1iIuHxNhIzPZzoE77NZL22F
 uGnowk6JPvhuOjfS2pVngBPS0a0WZPAzQlPE4xVAU1u2z0PnVGvFO1Bq05ozh5x3qihY
 WIzJF8TyaRa+XNSZfDxyo7eVUhr7cfjYEH0/+9JeHcg/JuwRrY4yE4GHKzDomyY60ob0
 WynuN8gmxV4TBil7/ZURHj8huvfUNdwIjlcafNGHCGdhbvoXlSvwvVlSWZdVpVfVYi7E
 RnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687190209; x=1689782209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O0JFs8J8H69a32Oys+A1HsefMvNV2m2DSa8XIdwXMC4=;
 b=PaF96FORoqK5M+ykAwCvZ4Gpf9E5bCdPNXDg/Z2NvgQpqzU/2UFjDIUoRXL2TYS1in
 s8brVlxPiCKxKFoXDr3PsNnsyJVhMXh2+hkSn10QlXZ9HOElKHSL5E8A/Zxn/edbQA82
 YoZBBKS1WrI085ApRfQHUio1Tu8s4BVvrCZwed+PCPCOyWEoQA/x56Z0WIWhXi15vq0D
 fxOvMHgWMycrHtIU2AIDSOp67hBmNTuAG3clWQS5LB21F94xbI9MDK95nUqFNa5PG3zq
 zb2+yBOtKe+uDJzX6Xr8ttJWSmxPLynIsLX9VmXwG872RMajy5eipXH6NYhT4+1Uhlle
 NmJw==
X-Gm-Message-State: AC+VfDxujHwLXkSq6MWqiZBCQjj+/qZ1PA79GyVOjd/EyTQEyWPqXIfG
 h9JBWbyIJsCX7/KjaElBtM0yAZZ0qQxuisd99WYZUA==
X-Google-Smtp-Source: ACHHUZ7A/iCjv9yysNdNO+swzq9nd3/G6R01uFoHkk7k+jBut+xnA4DKVkRzqY6vP8ql6dRtYBTKcg==
X-Received: by 2002:aa7:ce01:0:b0:51b:c82a:e10a with SMTP id
 d1-20020aa7ce01000000b0051bc82ae10amr20357edv.33.1687190208869; 
 Mon, 19 Jun 2023 08:56:48 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 i16-20020aa7c9d0000000b0050d83a39e6fsm13235940edt.4.2023.06.19.08.56.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 08:56:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 24/34] target/arm/tcg: Reduce 'helper-sme.h.inc' inclusion
Date: Mon, 19 Jun 2023 17:55:00 +0200
Message-Id: <20230619155510.80991-12-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619155510.80991-1-philmd@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Instead of including helper-sme.h.inc via helper.h which
is included by all TCG files, restrict it to the few files
that require it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.h            | 1 -
 target/arm/tcg/sme_helper.c    | 5 ++++-
 target/arm/tcg/translate-a64.c | 4 ++++
 target/arm/tcg/translate-sme.c | 6 ++++++
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 6ea6384855..159ed9664f 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -113,5 +113,4 @@ DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 
 #ifdef TARGET_AARCH64
 #include "tcg/helper-a64.h.inc"
-#include "tcg/helper-sme.h.inc"
 #endif
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 1e67fcac30..04170ad18d 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -21,7 +21,6 @@
 #include "cpu.h"
 #include "internals.h"
 #include "tcg/tcg-gvec-desc.h"
-#include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
 #include "qemu/int128.h"
@@ -29,6 +28,10 @@
 #include "vec_internal.h"
 #include "sve_ldst_internal.h"
 
+#define HELPER_H "tcg/helper-sme.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 void helper_set_svcr(CPUARMState *env, uint32_t val, uint32_t mask)
 {
     aarch64_set_svcr(env, val, mask);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 46428ef034..f4c9448582 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -42,6 +42,10 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-sme.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 static TCGv_i64 cpu_X[32];
 static TCGv_i64 cpu_pc;
 
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index e63b9883a9..fa0dc20bf2 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -29,6 +29,12 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-sme.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 /*
  * Include the generated decoder.
  */
-- 
2.38.1


