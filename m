Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 004E572B104
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 11:06:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Gy0-0006RA-KN; Sun, 11 Jun 2023 05:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8GwJ-0003Rr-EM
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 05:00:57 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8Gw9-00048k-QU
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 05:00:42 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-30adc51b65cso2978156f8f.0
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 02:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686474036; x=1689066036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3c5LLgM8zqCm+VTMgGqUz6vtedxBGV45kgOdre73KRM=;
 b=Tv7At1gmt7VmV/BILMQQibm6etqqfIHfsQNL8jOqLkgVeMYpjdHmOqqESbyWFSxie8
 pFV39qhZzQOvE4XdyBAokoIv35DlGiOxl5zraIgLguvKxHKOefeYjwDTNvbJxB29d8IE
 pj9Mhcs2a8ol/JlqzUyUYOg7onC+cRnFub0Io6FN7E27pKD9W+d5uuraWuOyGkj9an5f
 CJPND+lcOMjLsM6AQVDweOsy43w7+9LKyMp1C5g6qFvzQGoJBHL+5+zxkNvxBGCGo+2A
 dhm3+pnZNoGlfU4c0E7trdjHpa74u6rOc1fZRU2hIdFWHDBbTR8UCHKwvpflZRpmFR4Z
 DUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686474036; x=1689066036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3c5LLgM8zqCm+VTMgGqUz6vtedxBGV45kgOdre73KRM=;
 b=aAb7rOhbUZYymFd6PZ5ORirZw6sQVwHBUIL2Q7Ru0FzvQ6vjz0mIoWaKdrEZ8iElT8
 ezzmRmMhqkXWi7lXoMukcMm64xg4KTgpAgzYLV4N3/sBjas4LJPYHHaHgzvwIUa9qZNg
 Vd2SIvBiiHEnY/thZSzyJZuOy4VZiX39fOR3n5orJofZhVH7YfqD3Dx64FzbMxe6VOdG
 u3ZGxibJ7CV6hZZOZzbHT49KpOOwoYppRQnJzdBOKeRvlkWIbM2lAjNOKVPIL6V0HVPI
 U2SlNh9VfFrR4bW5LV2lzoRIOzgmelxejB8zBUmwMXtQkGgWKvtefSs/3nBNTOEbjROp
 OkAw==
X-Gm-Message-State: AC+VfDw795LjjjVeNp5NogUB4mfX3FrCZVTu1U6LahUF0K7MBKf0JO6f
 3qJzCIQmKpRAashYsj+5MxE9nNJudNWWekRKSc4=
X-Google-Smtp-Source: ACHHUZ7pv3NKIvjh/8ZmWtUoMFgNX4PrRJNpueHmXJp3Jz06RCD5wCtmSFcPHWr/f5tJoq+WfVTc1Q==
X-Received: by 2002:a5d:5543:0:b0:304:b967:956f with SMTP id
 g3-20020a5d5543000000b00304b967956fmr2723982wrw.8.1686474036139; 
 Sun, 11 Jun 2023 02:00:36 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 e7-20020a056000120700b0030af8da022dsm9093350wrx.44.2023.06.11.02.00.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jun 2023 02:00:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 25/26] target/arm/tcg: Rename 'helper.h' ->
 'tcg/helper.h.inc'
Date: Sun, 11 Jun 2023 10:58:45 +0200
Message-Id: <20230611085846.21415-26-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230611085846.21415-1-philmd@linaro.org>
References: <20230611085846.21415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Therefore rename 'helper.h' as 'helper.h.inc'. Since this file
is TCG-specific, move it to the tcg/ directory.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/translate.h                | 2 +-
 target/arm/{helper.h => tcg/helper.h.inc} | 0
 target/arm/debug_helper.c                 | 2 +-
 target/arm/helper.c                       | 2 +-
 target/arm/tcg/crypto_helper.c            | 2 +-
 target/arm/tcg/helper-a64.c               | 2 +-
 target/arm/tcg/hflags.c                   | 2 +-
 target/arm/tcg/m_helper.c                 | 2 +-
 target/arm/tcg/op_helper.c                | 2 +-
 target/arm/tcg/psci.c                     | 2 +-
 target/arm/tcg/tlb_helper.c               | 2 +-
 target/arm/tcg/translate.c                | 2 +-
 target/arm/tcg/vec_helper.c               | 2 +-
 target/arm/vfp_helper.c                   | 2 +-
 14 files changed, 13 insertions(+), 13 deletions(-)
 rename target/arm/{helper.h => tcg/helper.h.inc} (100%)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index fc6357eae8..940347b6bd 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -8,7 +8,7 @@
 #include "exec/translator.h"
 #include "internals.h"
 
-#define HELPER_H "helper.h"
+#define HELPER_H "tcg/helper.h.inc"
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
diff --git a/target/arm/helper.h b/target/arm/tcg/helper.h.inc
similarity index 100%
rename from target/arm/helper.h
rename to target/arm/tcg/helper.h.inc
diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 31165b92a5..b32852e947 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -15,7 +15,7 @@
 
 #ifdef CONFIG_TCG
 
-#define HELPER_H "helper.h"
+#define HELPER_H "tcg/helper.h.inc"
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 523f7b7765..2bdf7b0d4e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -26,7 +26,7 @@
 #include "qemu/guest-random.h"
 #ifdef CONFIG_TCG
 
-#define HELPER_H "helper.h"
+#define HELPER_H "tcg/helper.h.inc"
 #include "exec/helper-proto.h.inc"
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index 1b6b105527..15faa7455e 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -17,7 +17,7 @@
 #include "crypto/sm4.h"
 #include "vec_internal.h"
 
-#define HELPER_H "helper.h"
+#define HELPER_H "tcg/helper.h.inc"
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 56c2f01532..b8ee45074f 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -34,7 +34,7 @@
 #include "fpu/softfloat.h"
 #include <zlib.h> /* For crc32 */
 
-#define HELPER_H "helper.h"
+#define HELPER_H "tcg/helper.h.inc"
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 83a1aa08e4..e75cb0100e 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -10,7 +10,7 @@
 #include "internals.h"
 #include "cpregs.h"
 
-#define HELPER_H "helper.h"
+#define HELPER_H "tcg/helper.h.inc"
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 1991eafe05..4100161775 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -24,7 +24,7 @@
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
-#define HELPER_H "helper.h"
+#define HELPER_H "tcg/helper.h.inc"
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 24205074cc..e1aadd63f0 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -24,7 +24,7 @@
 #include "exec/cpu_ldst.h"
 #include "cpregs.h"
 
-#define HELPER_H "helper.h"
+#define HELPER_H "tcg/helper.h.inc"
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
index 2822a6b96a..e00b9b1493 100644
--- a/target/arm/tcg/psci.c
+++ b/target/arm/tcg/psci.c
@@ -24,7 +24,7 @@
 #include "internals.h"
 #include "arm-powerctl.h"
 
-#define HELPER_H "helper.h"
+#define HELPER_H "tcg/helper.h.inc"
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index e663aef2fd..3f8cb358a6 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -10,7 +10,7 @@
 #include "internals.h"
 #include "exec/exec-all.h"
 
-#define HELPER_H "helper.h"
+#define HELPER_H "tcg/helper.h.inc"
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index fc7a2804f7..f44b9415ec 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -41,7 +41,7 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
-#define HELPER_H "helper.h"
+#define HELPER_H "tcg/helper.h.inc"
 #include "exec/helper-proto.h.inc"
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 325a231de9..46f347a8c3 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -24,7 +24,7 @@
 #include "qemu/int128.h"
 #include "vec_internal.h"
 
-#define HELPER_H "helper.h"
+#define HELPER_H "tcg/helper.h.inc"
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 51f8e92ff7..38faf99073 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -31,7 +31,7 @@
 
 #ifdef CONFIG_TCG
 
-#define HELPER_H "helper.h"
+#define HELPER_H "tcg/helper.h.inc"
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
-- 
2.38.1


