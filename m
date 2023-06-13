Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D6B72E1D0
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:40:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90UZ-0005Yn-PT; Tue, 13 Jun 2023 05:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90UX-0005YP-PD
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:39:09 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90UV-0005aw-7s
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:39:09 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5169f920a9dso10849915a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686649145; x=1689241145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rHrcXRiCbN+BH2DRfEnwQXK6yfm4A30MJfpoXN1BebI=;
 b=Uxl4dn5ovOJmJAUv6ODkGAf4umvAEAxumdIhkeAYQVquTw7yrUatHJyPKojN3GsBRi
 Balc1lXqfTyeKEp9S+D1z2eDKkqRKv7zXpleP6C5ZGyU/aBEdUdW0LabCig+J9fYxugt
 58BJMN//atHclN/VpDgDCdZJ/Krjq+FQxzf6mzlPczJdWKHG7HHq6fffXx8XSzZm3R4H
 vrk2JrJ+wzov4eKVwivn34nE/TpgyyIzB4JUCL3d/af9INfAE++tzFSES8mCbmWDHMb5
 yRI++YXpvf27wack8fMH+9pA23nLGHPvasgzVimf1ahAlPIFNp9M2LjmebOLYvVf8jX4
 Rngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686649145; x=1689241145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rHrcXRiCbN+BH2DRfEnwQXK6yfm4A30MJfpoXN1BebI=;
 b=jUEUFAFVhFFsOipE4wCId6XZk5MGee9R9h+56piiyAxjdjfZrqE0IBt8D/QjX1BBBG
 mJupzEc8hik57yWLSX9MhxOYDZpAz3P/RBNYhzZ2R1JAskg0k1emLrhbVvKSytaXSg/k
 KbsIpajJYyItKF0t1ubDzKP58BfMharZ09nhNSKVi/cHV9dqLpXZVrgZ3JI1/Xs5yEK0
 bpWVNGYN/Vbp8AF3Mvm/N8qxGF4ddRY03xyIj/B7jY3RRJL8pIalLJCJIqhhMMbjo8zl
 UPa2ZTdibSRPucjsaAtcekZiTBgAFyXnToTj7tCDkdX4gjLtAAQpuzSEaGwTZUnDPqti
 wY9w==
X-Gm-Message-State: AC+VfDzOP38Fa/Syy5MnQZGj1WlN1rQvyCTFqRbUkaQ7P0VIeYyrIqVT
 6HWI34AA8xQWyAgEymMYkGoQhAJiPR8/olvCGgQVYg==
X-Google-Smtp-Source: ACHHUZ5xN/Sz4P86Y4Acc1+K4h3MpySnSoa+xRfMzEisvEQo0Fk3+xo2rU3ntNWrSiP/W3nNfsjwnA==
X-Received: by 2002:a05:6402:35d1:b0:514:94be:323c with SMTP id
 z17-20020a05640235d100b0051494be323cmr8704889edc.10.1686649145606; 
 Tue, 13 Jun 2023 02:39:05 -0700 (PDT)
Received: from localhost.localdomain ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 v4-20020a056402184400b00515c8024cb9sm6307552edy.55.2023.06.13.02.39.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jun 2023 02:39:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/17] target/i386: Rename helper template headers as '.h.inc'
Date: Tue, 13 Jun 2023 11:38:14 +0200
Message-Id: <20230613093822.63750-10-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613093822.63750-1-philmd@linaro.org>
References: <20230613093822.63750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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
Message-Id: <20230608133108.72655-5-philmd@linaro.org>
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


