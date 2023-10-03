Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 774D67B7027
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:44:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjFI-0000F7-RS; Tue, 03 Oct 2023 13:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjFE-000082-1o
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:41 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjFB-0007ZO-Ox
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:39 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-577fff1cae6so36349a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354296; x=1696959096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V0tvI4PZhpX6YH6fbLPkscWLIqBc7npsRrS6DF5wxrE=;
 b=S0ms7BdaN35G949LvbBwUuBplNZx+YZWFd4ScX9R7s5R2m0t/k+mzDnxS40LKAvVNl
 EVuAkFtYWBWNKvx/dQXHmUgGD+L9MaI8b9hkSu5yrzusYGyl6/Rg5FEtKzbJzHoPwtbr
 /iraBqGQmfIeubJyzrbu1f7IWNEIx+Q0HVP7TXTdTn+UUQ4iXZQJz7DBc1pDkKCVlBMK
 RCAcqIjuBrUZdOp6tpGU+Ekay8QxrdHh2/zuczLHZ23AQJ3VxogCRdRssgCGr9vT4ilZ
 iRfOXmonRVz8OhRLyPFdyIqAypxkW7W8yv2tWT7GBfk9Ti4TpQy6n3nBG2OIn4CpzeeZ
 LKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354296; x=1696959096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V0tvI4PZhpX6YH6fbLPkscWLIqBc7npsRrS6DF5wxrE=;
 b=VYs3jcyo62mGARPlERlm+hlP7z/XIi+k/DkuF4LgAvyn6UbBLPDfk9XrDyZMWHCQXC
 ULuYi+7rAdr4z5SNw6enYMaqZa6tRMtE8gwR8SJVsv68poXN9aM9PoeK8WFae3q7iy1K
 SYzauwy0OSFzAexDePGmz71EIrXU54Q9jLhRBTpvI93fVwlZtOpvR6o+KHjytjKA5jCj
 zV86DtL9F4tQ5Q9pxKz7bETxfnn1gx/DRWDQpBFxUF90VVuCUr9F2v5Xni7HSkk7j3F5
 hGDq0JtAEPE59ej/zRsXlqrL2SYSjBJUlsxkCTIeAvqwR25kioX8zYuXaWkYJxLv++Ov
 W4iQ==
X-Gm-Message-State: AOJu0Yzvpaw79o8naffH0Ft0/DiObCjyldFfdJELvmgDnAgmX6Txs0U1
 1q73s1ITcUlgMSzM3OKKMHjARyV36iHW4Mn6G3E=
X-Google-Smtp-Source: AGHT+IExc/5OWjKjwBZ6k8COF64rqpA0ccb3PrOzZBnOatwUbPB/KTTPU9PQSh1+rJTr/YgJsFdmsA==
X-Received: by 2002:a05:6a20:748c:b0:125:3445:8af0 with SMTP id
 p12-20020a056a20748c00b0012534458af0mr5173027pzd.7.1696354296474; 
 Tue, 03 Oct 2023 10:31:36 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 39/47] accel/tcg: Make monitor.c a target-agnostic unit
Date: Tue,  3 Oct 2023 10:30:44 -0700
Message-Id: <20231003173052.1601813-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move target-agnostic declarations from "internal-target.h"
to a new "internal-common.h" header.
monitor.c now don't include target specific headers and can
be compiled once in system_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230914185718.76241-10-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-common.h | 17 +++++++++++++++++
 accel/tcg/internal-target.h |  5 -----
 accel/tcg/cpu-exec.c        |  1 +
 accel/tcg/monitor.c         |  2 +-
 accel/tcg/translate-all.c   |  1 +
 accel/tcg/meson.build       |  3 +++
 6 files changed, 23 insertions(+), 6 deletions(-)
 create mode 100644 accel/tcg/internal-common.h

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
new file mode 100644
index 0000000000..5d5247442e
--- /dev/null
+++ b/accel/tcg/internal-common.h
@@ -0,0 +1,17 @@
+/*
+ * Internal execution defines for qemu (target agnostic)
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef ACCEL_TCG_INTERNAL_COMMON_H
+#define ACCEL_TCG_INTERNAL_COMMON_H
+
+extern int64_t max_delay;
+extern int64_t max_advance;
+
+void dump_exec_info(GString *buf);
+
+#endif
diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index ed583e0efd..17e3ad7054 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -102,11 +102,6 @@ static inline bool cpu_in_serial_context(CPUState *cs)
     return !(cs->tcg_cflags & CF_PARALLEL) || cpu_in_exclusive_context(cs);
 }
 
-extern int64_t max_delay;
-extern int64_t max_advance;
-
-void dump_exec_info(GString *buf);
-
 extern bool one_insn_per_tb;
 
 /**
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index a4aa9ec9ca..1a5bc90220 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -42,6 +42,7 @@
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
+#include "internal-common.h"
 #include "internal-target.h"
 
 /* -icount align implementation. */
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 30724fdb98..caf1189e0b 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -16,7 +16,7 @@
 #include "sysemu/cpu-timers.h"
 #include "sysemu/tcg.h"
 #include "tcg/tcg.h"
-#include "internal-target.h"
+#include "internal-common.h"
 
 
 static void dump_drift_info(GString *buf)
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 6c09b7f50d..8cb6ad3511 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -61,6 +61,7 @@
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
+#include "internal-common.h"
 #include "internal-target.h"
 #include "perf.h"
 #include "tcg/insn-start-words.h"
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 8ace783707..0fb03bd7d3 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -20,6 +20,9 @@ specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_ss)
 
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
+))
+
+system_ss.add(when: ['CONFIG_TCG'], if_true: files(
   'monitor.c',
 ))
 
-- 
2.34.1


