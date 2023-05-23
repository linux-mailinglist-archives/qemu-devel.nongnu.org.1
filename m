Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D674070E9DD
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 01:59:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1bu1-0004Mb-2V; Tue, 23 May 2023 19:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btl-0004J4-Cv
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:37 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btb-0001ng-5j
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:37 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-64d426e63baso168733b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684886306; x=1687478306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r5f4Ylw8IiZ84PTvuG5q1Iu6daSgx3AqNPjCHwsi6/0=;
 b=qPwjaFS0qgy3Ro2PjaQ0cezPAsMbPyAi2tZlsGpAbg27vZHmH9vJ9SaN7N2RSnkehn
 LLo1+XEBB1zeQI1eunjmXKa1+xBupSc7m/NXto82qk8hUd/G8mdgqvFuqA0X4HGZ590y
 wn6OMbm4F+VbQSTxHrjKjs27OyPcvicsDN5ZEdiQK5+CKeqMwMyNTloStmRPoeH5UbnY
 66dv5kl50BrLL63YhptlJr/ggjuUpw0/AvIw6DNr+jPjPlQ0PDDIrw8HWzBxsHrrlPES
 8j472ZFNSHazRRgetQK++On+OUoj2RoGvYLmOKHaIXDFV/E2JxoMs3bL16FmEo0PFIhp
 jNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684886306; x=1687478306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r5f4Ylw8IiZ84PTvuG5q1Iu6daSgx3AqNPjCHwsi6/0=;
 b=CjsZmw4MlMNFCSpRScP+IYHcELibgm1DxsqR77Vm4ZKr3mSVW15xvPO/nohWGIRb7H
 HZPS8Y/4KF5wrmwJ5lZEgGq69hUULU/U27w8CFg8dSP15V68+GEmx2UxxJQZ6y21sihO
 aW0ufGQtujEAB1G4NQNZBY2Wj0VIKCzCH1Yo2roDQKF/sUQPTT/6y3zNvDjMNd7ZpJ/F
 b+dtgmZcopc3flEnLZbNoHPPjKq754FkIB6yyuKPPOh7hVsBbzild4is2V1xw0pwhEYI
 KC4mDJSTuMzSjZi5tSy52lrOTozbt7J2gk84XCiWDbm5iQqqlAgQh9mR0FfBkQ+pfQKe
 /PqQ==
X-Gm-Message-State: AC+VfDwE4HQFssaWkWLcXtOAbqjaV1sH1Y/GqHXYvACxIE3C1ImowApl
 aqeIX93vj+zb7UnFYjF5+iNoqTzoYcsGuLTRkHk=
X-Google-Smtp-Source: ACHHUZ4hm+LPHOV1j9oR5ZQzBc1fLJnHa02uzPaM/ZpOXF2qdjZR/SMA4LWLMIp/ps8FcznfKv0jiA==
X-Received: by 2002:a05:6a21:3293:b0:10b:7b64:706 with SMTP id
 yt19-20020a056a21329300b0010b7b640706mr10352933pzb.13.1684886306417; 
 Tue, 23 May 2023 16:58:26 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b0063b7c42a070sm6285041pfn.68.2023.05.23.16.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 16:58:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/28] tcg: Split out tcg/debug-assert.h
Date: Tue, 23 May 2023 16:58:00 -0700
Message-Id: <20230523235804.747803-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523235804.747803-1-richard.henderson@linaro.org>
References: <20230523235804.747803-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/debug-assert.h | 17 +++++++++++++++++
 include/tcg/tcg.h          |  9 +--------
 MAINTAINERS                |  1 +
 3 files changed, 19 insertions(+), 8 deletions(-)
 create mode 100644 include/tcg/debug-assert.h

diff --git a/include/tcg/debug-assert.h b/include/tcg/debug-assert.h
new file mode 100644
index 0000000000..596765a3d2
--- /dev/null
+++ b/include/tcg/debug-assert.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define tcg_debug_assert
+ * Copyright (c) 2008 Fabrice Bellard
+ */
+
+#ifndef TCG_DEBUG_ASSERT_H
+#define TCG_DEBUG_ASSERT_H
+
+#if defined CONFIG_DEBUG_TCG || defined QEMU_STATIC_ANALYSIS
+# define tcg_debug_assert(X) do { assert(X); } while (0)
+#else
+# define tcg_debug_assert(X) \
+    do { if (!(X)) { __builtin_unreachable(); } } while (0)
+#endif
+
+#endif
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index cd6327b175..072c35f7f5 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -34,6 +34,7 @@
 #include "tcg/tcg-mo.h"
 #include "tcg-target.h"
 #include "tcg/tcg-cond.h"
+#include "tcg/debug-assert.h"
 
 /* XXX: make safe guess about sizes */
 #define MAX_OP_PER_INSTR 266
@@ -222,14 +223,6 @@ typedef uint64_t tcg_insn_unit;
 /* The port better have done this.  */
 #endif
 
-
-#if defined CONFIG_DEBUG_TCG || defined QEMU_STATIC_ANALYSIS
-# define tcg_debug_assert(X) do { assert(X); } while (0)
-#else
-# define tcg_debug_assert(X) \
-    do { if (!(X)) { __builtin_unreachable(); } } while (0)
-#endif
-
 typedef struct TCGRelocation TCGRelocation;
 struct TCGRelocation {
     QSIMPLEQ_ENTRY(TCGRelocation) next;
diff --git a/MAINTAINERS b/MAINTAINERS
index 1a32066231..1c93ab0ee5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -159,6 +159,7 @@ F: include/sysemu/tcg.h
 F: include/hw/core/tcg-cpu-ops.h
 F: host/include/*/host/cpuinfo.h
 F: util/cpuinfo-*.c
+F: include/tcg/
 
 FPU emulation
 M: Aurelien Jarno <aurelien@aurel32.net>
-- 
2.34.1


