Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B84CD72816D
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:34:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Fk1-0001gP-E5; Thu, 08 Jun 2023 09:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Fjm-0001XE-8M
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:31:41 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Fjj-0005pt-SY
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:31:37 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f70fc4682aso4099875e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 06:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686231094; x=1688823094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ftNyyaWMFAqAjN5bg1efHl67xyXCX1hnkKn723kFLZc=;
 b=wlwH4be91XESizOmdkrTMO2Lp95KoO5L9JkPWBq3PbHH16N38mTLfLh/iDxAKUh6Dn
 +w/3dhcGfjeGED+Vuj50Y5WZ71jgxpVfoYiWzfXcI6nb7oxAIaPAY48fmioy5H1M0A0P
 fddpeLTdW9cqLCbw8ZsRlRhi73lpqyJ2SuNgUEJS5Xvkb/WPLVP8QhEZUaWXKWwLxOK4
 eVwlEZbRfqOtve6lXEhqRaKlxXSwPX9lcsndf8rA+AsdYTJUBZpt2phhDAEJPO2NW5L6
 JpkrNAqoEhRgsy8SvytI0GUckndi1qZ4EfCK6tLMKE1kM5bQCnb7uFGtChi89rqhTmMu
 lQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686231094; x=1688823094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ftNyyaWMFAqAjN5bg1efHl67xyXCX1hnkKn723kFLZc=;
 b=hEq8ph5hzr41dYLpCBYrxW3nRRDQQCElpVPY3DY8aLNO+HS19V4xn0slnHC79v2UGS
 sA4vuQZ36HJG4+workzLjo35/9ZuZGNdsV9Si+uPlnufYeP5+WAnMb/0tkb5qL5Vy1qm
 AIqCNFB93Gb21mmPZj5JS4lftVjrLIXEwn8+I2TleErUpwnneuERJ130SozQ/9xMIYzv
 SOzTwSBTSc/jCq2T7eFGrp74sdc9HJb+6p9fWpKjLVB5oOaptbkool2zywUbvBNrSpvb
 yN5uhtK5my1ENMcUOaGnrWr1vJz3viQ+QWwYXtesv1p3DXqSnZGC4I+ztufSTU6Krbf8
 f/Pg==
X-Gm-Message-State: AC+VfDyHYFM6/5d2rPuCD/V4yqNft0IKMtyRf1AEhCNB54gfdZrM7nPG
 m+RBmqL62ugQQMSawPJQXYdc/6z9xuxJaw7ZW9Y=
X-Google-Smtp-Source: ACHHUZ6MXBq4Cj9JoYey7ZzF5N8f32fovh5Xb2A3f2G13khLDFeBEUCr7Hhzz1cr735UmZev9Yo1FQ==
X-Received: by 2002:a7b:c7c2:0:b0:3f4:2452:9669 with SMTP id
 z2-20020a7bc7c2000000b003f424529669mr1469849wmk.0.1686231094400; 
 Thu, 08 Jun 2023 06:31:34 -0700 (PDT)
Received: from localhost.localdomain ([176.176.169.168])
 by smtp.gmail.com with ESMTPSA id
 14-20020a05600c22ce00b003f7dfdf36bbsm5286778wmg.45.2023.06.08.06.31.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Jun 2023 06:31:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/5] target/i386: Rename helper template headers as '.h.inc'
Date: Thu,  8 Jun 2023 15:31:07 +0200
Message-Id: <20230608133108.72655-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230608133108.72655-1-philmd@linaro.org>
References: <20230608133108.72655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Since commit 139c1837db ("meson: rename included C source files
to .c.inc"), QEMU standard procedure for included C files is to
use *.c.inc.

Besides, since commit 6a0057aa22 ("docs/devel: make a statement
about includes") this is documented as the Coding Style:

  If you do use template header files they should be named with
  the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
  being included for expansion.

Therefore move the included templates in the tcg/ directory and
rename as '.h.inc'.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/helper.h                                      | 6 +++---
 .../{cc_helper_template.h => cc_helper_template.h.inc}    | 0
 .../i386/{ops_sse_header.h => tcg/ops_sse_header.h.inc}   | 0
 .../shift_helper_template.h.inc}                          | 0
 target/i386/tcg/cc_helper.c                               | 8 ++++----
 target/i386/tcg/int_helper.c                              | 8 ++++----
 6 files changed, 11 insertions(+), 11 deletions(-)
 rename target/i386/tcg/{cc_helper_template.h => cc_helper_template.h.inc} (100%)
 rename target/i386/{ops_sse_header.h => tcg/ops_sse_header.h.inc} (100%)
 rename target/i386/{shift_helper_template.h => tcg/shift_helper_template.h.inc} (100%)

diff --git a/target/i386/helper.h b/target/i386/helper.h
index e627a93107..48609c210b 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -203,11 +203,11 @@ DEF_HELPER_1(enter_mmx, void, env)
 DEF_HELPER_1(emms, void, env)
 
 #define SHIFT 0
-#include "ops_sse_header.h"
+#include "tcg/ops_sse_header.h.inc"
 #define SHIFT 1
-#include "ops_sse_header.h"
+#include "tcg/ops_sse_header.h.inc"
 #define SHIFT 2
-#include "ops_sse_header.h"
+#include "tcg/ops_sse_header.h.inc"
 
 DEF_HELPER_3(rclb, tl, env, tl, tl)
 DEF_HELPER_3(rclw, tl, env, tl, tl)
diff --git a/target/i386/tcg/cc_helper_template.h b/target/i386/tcg/cc_helper_template.h.inc
similarity index 100%
rename from target/i386/tcg/cc_helper_template.h
rename to target/i386/tcg/cc_helper_template.h.inc
diff --git a/target/i386/ops_sse_header.h b/target/i386/tcg/ops_sse_header.h.inc
similarity index 100%
rename from target/i386/ops_sse_header.h
rename to target/i386/tcg/ops_sse_header.h.inc
diff --git a/target/i386/shift_helper_template.h b/target/i386/tcg/shift_helper_template.h.inc
similarity index 100%
rename from target/i386/shift_helper_template.h
rename to target/i386/tcg/shift_helper_template.h.inc
diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
index 6227dbb30b..c310bd842f 100644
--- a/target/i386/tcg/cc_helper.c
+++ b/target/i386/tcg/cc_helper.c
@@ -58,21 +58,21 @@ const uint8_t parity_table[256] = {
 };
 
 #define SHIFT 0
-#include "cc_helper_template.h"
+#include "cc_helper_template.h.inc"
 #undef SHIFT
 
 #define SHIFT 1
-#include "cc_helper_template.h"
+#include "cc_helper_template.h.inc"
 #undef SHIFT
 
 #define SHIFT 2
-#include "cc_helper_template.h"
+#include "cc_helper_template.h.inc"
 #undef SHIFT
 
 #ifdef TARGET_X86_64
 
 #define SHIFT 3
-#include "cc_helper_template.h"
+#include "cc_helper_template.h.inc"
 #undef SHIFT
 
 #endif
diff --git a/target/i386/tcg/int_helper.c b/target/i386/tcg/int_helper.c
index 599ac968b0..05418f181f 100644
--- a/target/i386/tcg/int_helper.c
+++ b/target/i386/tcg/int_helper.c
@@ -448,20 +448,20 @@ target_ulong helper_pext(target_ulong src, target_ulong mask)
 }
 
 #define SHIFT 0
-#include "shift_helper_template.h"
+#include "shift_helper_template.h.inc"
 #undef SHIFT
 
 #define SHIFT 1
-#include "shift_helper_template.h"
+#include "shift_helper_template.h.inc"
 #undef SHIFT
 
 #define SHIFT 2
-#include "shift_helper_template.h"
+#include "shift_helper_template.h.inc"
 #undef SHIFT
 
 #ifdef TARGET_X86_64
 #define SHIFT 3
-#include "shift_helper_template.h"
+#include "shift_helper_template.h.inc"
 #undef SHIFT
 #endif
 
-- 
2.38.1


