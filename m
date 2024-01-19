Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEE08328EB
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:36:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQnAC-00028X-BK; Fri, 19 Jan 2024 06:35:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnAA-00025d-0Y
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:35:54 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnA7-0000f0-25
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:35:53 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33921b95dddso201646f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705664149; x=1706268949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/u3zpIICoMRx+hk0gsj8/1K/WruFMiJJIe2/2+mB0M=;
 b=QhwK7cP5DoX1xzoqiuN9TK6m7HDpFJy6312Tmp8XlpxCNfM28jUO9G07cGF9UZr7jD
 +Sw/s+8zchXnrNeN+joMYVpaZjBht3yr46fM5BuC6/YF/gapLhGEKGwOmDBaVdRmZSBe
 Hthn3CndVy8Wzy6a6zivzA7dkS+ct04rjiR/3XIFfLq/CBtDdpxZ5zFoKJesA9HImcfV
 9XnPXNWPn1gu25VfRsgQ1Ef0c82ybKNDin9PiuWXQyBNaJ1kEzJ28MbAFQnxuohj+J4o
 hWE3HEbZhEgc3NT80EXFRJiequu0iS/u1TgCHHpUN11fPjP1npe4iiUZ89aqe7AAAQRk
 D79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705664149; x=1706268949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/u3zpIICoMRx+hk0gsj8/1K/WruFMiJJIe2/2+mB0M=;
 b=vq1wB7ONCAUjTcFAv8GXmzkYWTYqx7/+HGPJ2nbjCWPm8ZCXclxLNw9A9rm39xCd/l
 PC523TiDVdg7XyJlOInl6dVFYoiQ2WNewyD6mwlAjPJVKoMODs5Mqm5oGpC+894i4Ul1
 PEYR/t2gLSfmLwOVIl/xYkMIU51JEJMIbc9H3/RxmAwXNrF5aTqZDvLZ9XyApAd+2Elb
 uQHhvEhKeJsUL+befwaA4X/BqzgWFKyVAhLv8lRPT1sVc4KgZVPnwC78mDbwxTATiyBI
 amP90QAGmsI3hoChHulzgnBZKL0BU9BzV5aBQW7ndZ7CDY914n0UeSP7fWQFqlXjWAQa
 kFVg==
X-Gm-Message-State: AOJu0YxzHCvBBBfbte5bJZeI1Fn0LAbeK4LQmXDCSGQdIGo5RnWE1lcX
 HzxGyFdZciwcVZPKCzJ+VSQQMJNjEQbbA7yUjw4c1HRbUWxjzDpsoefI+JGlEca/mHaJDQM+Dp/
 Q+ae1BQ==
X-Google-Smtp-Source: AGHT+IFhP5X1Ro226is5N8ltvqS/oUIw2aIaJAtqHtzZAlnM4Udz0apB9vfp8QyYyD9FFLH2ij70dw==
X-Received: by 2002:a05:600c:2291:b0:40e:937f:16d8 with SMTP id
 17-20020a05600c229100b0040e937f16d8mr521040wmf.50.1705664149390; 
 Fri, 19 Jan 2024 03:35:49 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 r19-20020a05600c459300b0040e42391a12sm28532878wmo.13.2024.01.19.03.35.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 03:35:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/36] target/alpha: Extract clk_helper.c from sys_helper.c
Date: Fri, 19 Jan 2024 12:34:38 +0100
Message-ID: <20240119113507.31951-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119113507.31951-1-philmd@linaro.org>
References: <20240119113507.31951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Except helper_load_pcc(), all helpers from sys_helper.c
are system-emulation specific. In preparation of restricting
sys_helper.c to system emulation, extract helper_load_pcc()
to clk_helper.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231207105426.49339-2-philmd@linaro.org>
---
 target/alpha/clk_helper.c | 32 ++++++++++++++++++++++++++++++++
 target/alpha/sys_helper.c | 15 ---------------
 target/alpha/meson.build  |  1 +
 3 files changed, 33 insertions(+), 15 deletions(-)
 create mode 100644 target/alpha/clk_helper.c

diff --git a/target/alpha/clk_helper.c b/target/alpha/clk_helper.c
new file mode 100644
index 0000000000..26ffc231cd
--- /dev/null
+++ b/target/alpha/clk_helper.c
@@ -0,0 +1,32 @@
+/*
+ *  QEMU Alpha clock helpers.
+ *
+ *  Copyright (c) 2007 Jocelyn Mayer
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "exec/helper-proto.h"
+#include "cpu.h"
+
+uint64_t helper_load_pcc(CPUAlphaState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    /*
+     * In system mode we have access to a decent high-resolution clock.
+     * In order to make OS-level time accounting work with the RPCC,
+     * present it with a well-timed clock fixed at 250MHz.
+     */
+    return (((uint64_t)env->pcc_ofs << 32)
+            | (uint32_t)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) >> 2));
+#else
+    /*
+     * In user-mode, QEMU_CLOCK_VIRTUAL doesn't exist.  Just pass through
+     * the host cpu clock ticks.  Also, don't bother taking PCC_OFS into
+     * account.
+     */
+    return (uint32_t)cpu_get_host_ticks();
+#endif
+}
diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
index c83c92dd4c..98d9a0fff7 100644
--- a/target/alpha/sys_helper.c
+++ b/target/alpha/sys_helper.c
@@ -27,21 +27,6 @@
 #include "qemu/timer.h"
 
 
-uint64_t helper_load_pcc(CPUAlphaState *env)
-{
-#ifndef CONFIG_USER_ONLY
-    /* In system mode we have access to a decent high-resolution clock.
-       In order to make OS-level time accounting work with the RPCC,
-       present it with a well-timed clock fixed at 250MHz.  */
-    return (((uint64_t)env->pcc_ofs << 32)
-            | (uint32_t)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) >> 2));
-#else
-    /* In user-mode, QEMU_CLOCK_VIRTUAL doesn't exist.  Just pass through the host cpu
-       clock ticks.  Also, don't bother taking PCC_OFS into account.  */
-    return (uint32_t)cpu_get_host_ticks();
-#endif
-}
-
 /* PALcode support special instructions */
 #ifndef CONFIG_USER_ONLY
 void helper_tbia(CPUAlphaState *env)
diff --git a/target/alpha/meson.build b/target/alpha/meson.build
index d3502dd823..ea252c99a5 100644
--- a/target/alpha/meson.build
+++ b/target/alpha/meson.build
@@ -4,6 +4,7 @@ alpha_ss.add(files(
   'fpu_helper.c',
   'gdbstub.c',
   'helper.c',
+  'clk_helper.c',
   'int_helper.c',
   'mem_helper.c',
   'sys_helper.c',
-- 
2.41.0


