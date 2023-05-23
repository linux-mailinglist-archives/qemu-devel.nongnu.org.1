Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 304ED70DDE0
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:49:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SMr-000151-SN; Tue, 23 May 2023 09:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMq-0000zB-1T
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:48:00 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMn-00019t-9g
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:59 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-64d44b198baso2519528b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684849676; x=1687441676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/tTPPnUnjG19dY5X021rmXFRG/giw/axI09dO2DG2Y=;
 b=Cv/xlKbwfHDjFIVEvo52S3jsphYvFbzTMmeei6lnkN1/zTl8n+VjGvVmFw0C3hH0lN
 AAb+m2pmrpT3Tw7By4VlSWWF2g7QUIiAJxbBojtVNjKYNpJHj/zS9U4XyT73gpyod7F5
 p5JET3zAq+U36ZFmbd1sv5kNiSQkSF4pBzCf3ny97KTJNUzNcTRcfVQnao1MM0n6FicC
 FEBKdQ4Oj7fCpzHJjUbnOjSWRsyTyQcFsNr99Fplmk67WtbgTfzvc4Wh5aNYHI1rQuCU
 hp16a50scpkrtRFItQu1a4IXQ/iu52EjAg7c+AnOoBQoH5kOEocZxCdb5XdHeUESmYz2
 xLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849676; x=1687441676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2/tTPPnUnjG19dY5X021rmXFRG/giw/axI09dO2DG2Y=;
 b=AnMYWUqkWybc0X4NNh9fX9KqbbH5EMJYAXhN83S2dZwIpNRptjZUGyD62r1WOTtfth
 2fXaVi93QffDfpIvkv12RDn9Dh3VwFBwntQxmIf/4ksXkCzn/6DM72t1r6S3XaNIOwOg
 2123mtkuf0MW1gvM7H1vRQYMTT6Utqd9RfJOLrF/d+LFkW5zlMm2YBfb5ou/cl5dMF0e
 7xFtDEkLEbP08yj1iPqEMYqvJ7AZk6NEdpLxjE+SMRvxn1fKtIWGTLCCbh3OYoi3JLUJ
 T1YRxIlq+SCfPMlidkkLB2x03iAwF1jvZ4zmLDTbpC6qgKbS/YTjOMxxV1o6sXuVJgTJ
 KcCg==
X-Gm-Message-State: AC+VfDzJFBrnFXZ3KnP+ZjXa7es5/+/ifedxgv4DbsB3kDsRX7BA2vI5
 Uctzn/GA3iaoZEbRtVNPCn0YJERkYc6leo6MSAA=
X-Google-Smtp-Source: ACHHUZ41PZ9Zox5plhEAmRbqkKHWrZpcJ/I4izSzihngHANNAZSbW5d+0u2BLiDO5xrTe7iZ5RsORA==
X-Received: by 2002:a05:6a00:1d1d:b0:64d:5683:1977 with SMTP id
 a29-20020a056a001d1d00b0064d56831977mr8699175pfx.9.1684849675784; 
 Tue, 23 May 2023 06:47:55 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 j4-20020aa79284000000b0064d1349dc31sm5737122pfa.199.2023.05.23.06.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:47:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 24/27] tcg: Split out tcg/debug-assert.h
Date: Tue, 23 May 2023 06:47:30 -0700
Message-Id: <20230523134733.678646-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523134733.678646-1-richard.henderson@linaro.org>
References: <20230523134733.678646-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
index 1b6466496d..a1b99a31df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -157,6 +157,7 @@ F: include/exec/helper*.h
 F: include/sysemu/cpus.h
 F: include/sysemu/tcg.h
 F: include/hw/core/tcg-cpu-ops.h
+F: include/tcg/
 
 FPU emulation
 M: Aurelien Jarno <aurelien@aurel32.net>
-- 
2.34.1


