Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B36EA67ECD
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Mar 2025 22:35:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuea0-0004TV-3s; Tue, 18 Mar 2025 17:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueYC-0001OD-Do
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:40 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY9-0000rW-TZ
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:40 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-225477548e1so109203605ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333557; x=1742938357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qAJhBvKK2tjocHW8D3nM54DyABQcyAL39T963Zv3mLo=;
 b=Kk4KVl6ZemDq3FNHC6cppUeyncPufqCrtJYyZ7ANQtA5+vIYljCGaEiggb4HrlxQGX
 sLY5qtkNO8036gu2jCwEd41XttC0l7+O+qHBl6HWELof0XRL2dU74hfSdgde3Jeerqy9
 8OG0oBcfaXRh/6sp61l0BEyfNOpE2AhiDSWaweNfjbAqWH1MLzvMdoGalERvOKN5KzsB
 GKw0x9jJ85b/ewBMUvJz1twpyJgsI6PdP8iKjZLsPGBQECYZpCR9OT4Nljd8R/ULgq/Y
 SOI1OJw4i7+ylB6f5IkLuDXk3Rq2OtTm1C4qIMs3A+PBjGUxpwCjsLd0or3ok4cPCYp9
 /9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333557; x=1742938357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qAJhBvKK2tjocHW8D3nM54DyABQcyAL39T963Zv3mLo=;
 b=QDoqbLU5fA2/R7vIRd5n4j12LIUuaO5hagVip4wIryEbpc4V2qoQ0A3p29sBxXPyZW
 ckMxJVex8tqOkX/ECZNx/R1ycJxZHZrYIVZomA16gIHQ5s9trIcY5hMwKrNLbtR7Tgpm
 e7LChJYCkRGr5/7XKWX8RYfHj92rXuKB7rcYUTWaH7ihqeHYwf4g0aSNnk6e4E5UuCBf
 6X4qLuzGdqh6K46orONWHN7OnUbHknsyZUsGDx07DraALSy9mkGe3oMXYRZtUp+lOVPI
 JjckxGc4CkKTgPLUooKhrL3ejUURpi880+63dUANKgXYVagOcRoovT4hMhg+bxcEONKy
 eJmg==
X-Gm-Message-State: AOJu0YyxAY9kOH2b+IWbawZRVv8Tsyj7yacSuiQ3OMra14y2Eb4O7fLi
 DVqlL/ascZh0xSspmQOq75ZnAAluGDZ4JR/qJae1+Y0WzKnE/q0TBw09QQadpdnFX0xq01LJXr2
 V
X-Gm-Gg: ASbGnctx5iB7XJsPNIQFgLleXq6SAvUlMI7OC76t7/hw4JCdtxVu/lUFuNmxKqgcQD+
 dOaNT+7UH4FNhNE5hZF04AB+6o3TMBEwo1rZLQ6cEvoBBpmnY6+h8SmYqQ+w2x7WNoPOptcvdI7
 A95+UfrroS3PQDqZaMasas70b9mrNkT/TzJUdlIx/UcIuAwPBdI65CN8uc7V1hoUFMmzltoD0wB
 TOjT/jt654AOkfhJB1GaUdaJvjVgotHqbCrvb9HVRy7wrjDOtEsrgfk0O5qVZx/dkuFp7vwbjRK
 5zOSCiSDGqs3HW/O7L4GQNmsRL8j0zgUCeAkcqT4t0qLyi0e4ch5g/qD91jvknudvDVAg1M2EW7
 I
X-Google-Smtp-Source: AGHT+IFIMQAgBTGofx4WZX3HM3690fDdzNswM0m0mv6GEiqtGEowHTvHYTNv5EFkyk/Sch9ljND9LA==
X-Received: by 2002:a05:6a21:3286:b0:1f5:8678:182a with SMTP id
 adf61e73a8af0-1fbeb7a1da1mr303795637.12.1742333556532; 
 Tue, 18 Mar 2025 14:32:36 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 37/42] include/exec: Split out icount.h
Date: Tue, 18 Mar 2025 14:32:02 -0700
Message-ID: <20250318213209.2579218-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Split icount stuff from system/cpu-timers.h.
There are 17 files which only require icount.h, 7 that only
require cpu-timers.h, and 7 that require both.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/icount.h            | 68 ++++++++++++++++++++++++++++++++
 include/system/cpu-timers.h      | 58 ---------------------------
 accel/tcg/cpu-exec.c             |  2 +-
 accel/tcg/icount-common.c        |  2 +-
 accel/tcg/monitor.c              |  1 +
 accel/tcg/tcg-accel-ops-icount.c |  2 +-
 accel/tcg/tcg-accel-ops-mttcg.c  |  2 +-
 accel/tcg/tcg-accel-ops-rr.c     |  2 +-
 accel/tcg/tcg-accel-ops.c        |  2 +-
 accel/tcg/tcg-all.c              |  2 +-
 accel/tcg/translate-all.c        |  2 +-
 hw/core/ptimer.c                 |  2 +-
 replay/replay.c                  |  2 +-
 stubs/icount.c                   |  2 +-
 system/cpu-timers.c              |  1 +
 system/dma-helpers.c             |  2 +-
 system/vl.c                      |  1 +
 target/arm/helper.c              |  1 +
 target/riscv/cpu_helper.c        |  2 +-
 target/riscv/csr.c               |  2 +-
 target/riscv/debug.c             |  1 +
 target/riscv/machine.c           |  2 +-
 target/riscv/pmu.c               |  2 +-
 util/async.c                     |  2 +-
 util/main-loop.c                 |  1 +
 util/qemu-timer.c                |  1 +
 26 files changed, 92 insertions(+), 75 deletions(-)
 create mode 100644 include/exec/icount.h

diff --git a/include/exec/icount.h b/include/exec/icount.h
new file mode 100644
index 0000000000..4964987ae4
--- /dev/null
+++ b/include/exec/icount.h
@@ -0,0 +1,68 @@
+/*
+ * icount - Instruction Counter API
+ * CPU timers state API
+ *
+ * Copyright 2020 SUSE LLC
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef EXEC_ICOUNT_H
+#define EXEC_ICOUNT_H
+
+/**
+ * ICountMode: icount enablement state:
+ *
+ * @ICOUNT_DISABLED: Disabled - Do not count executed instructions.
+ * @ICOUNT_PRECISE: Enabled - Fixed conversion of insn to ns via "shift" option
+ * @ICOUNT_ADAPTATIVE: Enabled - Runtime adaptive algorithm to compute shift
+ */
+typedef enum {
+    ICOUNT_DISABLED = 0,
+    ICOUNT_PRECISE,
+    ICOUNT_ADAPTATIVE,
+} ICountMode;
+
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+extern ICountMode use_icount;
+#define icount_enabled() (use_icount)
+#else
+#define icount_enabled() ICOUNT_DISABLED
+#endif
+
+/*
+ * Update the icount with the executed instructions. Called by
+ * cpus-tcg vCPU thread so the main-loop can see time has moved forward.
+ */
+void icount_update(CPUState *cpu);
+
+/* get raw icount value */
+int64_t icount_get_raw(void);
+
+/* return the virtual CPU time in ns, based on the instruction counter. */
+int64_t icount_get(void);
+/*
+ * convert an instruction counter value to ns, based on the icount shift.
+ * This shift is set as a fixed value with the icount "shift" option
+ * (precise mode), or it is constantly approximated and corrected at
+ * runtime in adaptive mode.
+ */
+int64_t icount_to_ns(int64_t icount);
+
+/**
+ * icount_configure: configure the icount options, including "shift"
+ * @opts: Options to parse
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Return: true on success, else false setting @errp with error
+ */
+bool icount_configure(QemuOpts *opts, Error **errp);
+
+/* used by tcg vcpu thread to calc icount budget */
+int64_t icount_round(int64_t count);
+
+/* if the CPUs are idle, start accounting real time to virtual clock. */
+void icount_start_warp_timer(void);
+void icount_account_warp_timer(void);
+void icount_notify_exit(void);
+
+#endif /* EXEC_ICOUNT_H */
diff --git a/include/system/cpu-timers.h b/include/system/cpu-timers.h
index 64ae54f6d6..a1abed0d7a 100644
--- a/include/system/cpu-timers.h
+++ b/include/system/cpu-timers.h
@@ -15,64 +15,6 @@
 /* init the whole cpu timers API, including icount, ticks, and cpu_throttle */
 void cpu_timers_init(void);
 
-/* icount - Instruction Counter API */
-
-/**
- * ICountMode: icount enablement state:
- *
- * @ICOUNT_DISABLED: Disabled - Do not count executed instructions.
- * @ICOUNT_PRECISE: Enabled - Fixed conversion of insn to ns via "shift" option
- * @ICOUNT_ADAPTATIVE: Enabled - Runtime adaptive algorithm to compute shift
- */
-typedef enum {
-    ICOUNT_DISABLED = 0,
-    ICOUNT_PRECISE,
-    ICOUNT_ADAPTATIVE,
-} ICountMode;
-
-#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
-extern ICountMode use_icount;
-#define icount_enabled() (use_icount)
-#else
-#define icount_enabled() ICOUNT_DISABLED
-#endif
-
-/*
- * Update the icount with the executed instructions. Called by
- * cpus-tcg vCPU thread so the main-loop can see time has moved forward.
- */
-void icount_update(CPUState *cpu);
-
-/* get raw icount value */
-int64_t icount_get_raw(void);
-
-/* return the virtual CPU time in ns, based on the instruction counter. */
-int64_t icount_get(void);
-/*
- * convert an instruction counter value to ns, based on the icount shift.
- * This shift is set as a fixed value with the icount "shift" option
- * (precise mode), or it is constantly approximated and corrected at
- * runtime in adaptive mode.
- */
-int64_t icount_to_ns(int64_t icount);
-
-/**
- * icount_configure: configure the icount options, including "shift"
- * @opts: Options to parse
- * @errp: pointer to a NULL-initialized error object
- *
- * Return: true on success, else false setting @errp with error
- */
-bool icount_configure(QemuOpts *opts, Error **errp);
-
-/* used by tcg vcpu thread to calc icount budget */
-int64_t icount_round(int64_t count);
-
-/* if the CPUs are idle, start accounting real time to virtual clock. */
-void icount_start_warp_timer(void);
-void icount_account_warp_timer(void);
-void icount_notify_exit(void);
-
 /*
  * CPU Ticks and Clock
  */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 372b876604..034c2ded6b 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -35,7 +35,7 @@
 #include "exec/log.h"
 #include "qemu/main-loop.h"
 #include "exec/cpu-all.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "exec/replay-core.h"
 #include "system/tcg.h"
 #include "exec/helper-proto-common.h"
diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
index 402d3e3f4e..d6471174a3 100644
--- a/accel/tcg/icount-common.c
+++ b/accel/tcg/icount-common.c
@@ -35,7 +35,7 @@
 #include "system/replay.h"
 #include "system/runstate.h"
 #include "hw/core/cpu.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "system/cpu-timers-internal.h"
 
 /*
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index eeb38a4d9c..1c182b6bfb 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -14,6 +14,7 @@
 #include "qapi/qapi-commands-machine.h"
 #include "monitor/monitor.h"
 #include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "system/tcg.h"
 #include "tcg/tcg.h"
 #include "internal-common.h"
diff --git a/accel/tcg/tcg-accel-ops-icount.c b/accel/tcg/tcg-accel-ops-icount.c
index 27cf1044c7..d0f7b410fa 100644
--- a/accel/tcg/tcg-accel-ops-icount.c
+++ b/accel/tcg/tcg-accel-ops-icount.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "system/replay.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "qemu/main-loop.h"
 #include "qemu/guest-random.h"
 #include "hw/core/cpu.h"
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index bdcc385ae9..dfcee30947 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "system/tcg.h"
 #include "system/replay.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "qemu/main-loop.h"
 #include "qemu/notify.h"
 #include "qemu/guest-random.h"
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index f62cf24e1d..6eec5c9eee 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -27,7 +27,7 @@
 #include "qemu/lockable.h"
 #include "system/tcg.h"
 #include "system/replay.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "qemu/main-loop.h"
 #include "qemu/notify.h"
 #include "qemu/guest-random.h"
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 5c88056157..ccdb781eef 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -29,7 +29,7 @@
 #include "system/accel-ops.h"
 #include "system/tcg.h"
 #include "system/replay.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "qemu/main-loop.h"
 #include "qemu/guest-random.h"
 #include "qemu/timer.h"
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index c1a30b0121..7a5b810b88 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "system/tcg.h"
 #include "exec/replay-core.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "tcg/startup.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 167535bcb1..bb161ae61a 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -55,7 +55,7 @@
 #include "qemu/cacheinfo.h"
 #include "qemu/timer.h"
 #include "exec/log.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "system/tcg.h"
 #include "qapi/error.h"
 #include "accel/tcg/cpu-ops.h"
diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index 7f63d17ca1..0aeb10fb53 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -11,7 +11,7 @@
 #include "migration/vmstate.h"
 #include "qemu/host-utils.h"
 #include "exec/replay-core.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "system/qtest.h"
 #include "block/aio.h"
 #include "hw/clock.h"
diff --git a/replay/replay.c b/replay/replay.c
index 3adc387b3d..a3e24c967a 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "system/replay.h"
 #include "system/runstate.h"
 #include "replay-internal.h"
diff --git a/stubs/icount.c b/stubs/icount.c
index edbf60cbfa..ceb73b4fc2 100644
--- a/stubs/icount.c
+++ b/stubs/icount.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 
 /* icount - Instruction Counter API */
 
diff --git a/system/cpu-timers.c b/system/cpu-timers.c
index 23dd82b465..cb35fa62b8 100644
--- a/system/cpu-timers.c
+++ b/system/cpu-timers.c
@@ -36,6 +36,7 @@
 #include "hw/core/cpu.h"
 #include "system/cpu-timers.h"
 #include "system/cpu-timers-internal.h"
+#include "exec/icount.h"
 
 /* clock and ticks */
 
diff --git a/system/dma-helpers.c b/system/dma-helpers.c
index 6bad75876f..0d592f6468 100644
--- a/system/dma-helpers.c
+++ b/system/dma-helpers.c
@@ -13,7 +13,7 @@
 #include "trace.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "qemu/range.h"
 
 /* #define DEBUG_IOMMU */
diff --git a/system/vl.c b/system/vl.c
index ec93988a03..c17945c493 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -89,6 +89,7 @@
 #include "audio/audio.h"
 #include "system/cpus.h"
 #include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "migration/colo.h"
 #include "migration/postcopy-ram.h"
 #include "system/kvm.h"
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0454b06a6c..becbbbd0d8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -24,6 +24,7 @@
 #include "exec/translation-block.h"
 #include "hw/irq.h"
 #include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
 #include "qapi/error.h"
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 6c4391d96b..0dd8645994 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -31,7 +31,7 @@
 #include "accel/tcg/cpu-ops.h"
 #include "trace.h"
 #include "semihosting/common-semi.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "cpu_bits.h"
 #include "debug.h"
 #include "pmp.h"
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 49566d3c08..be4aebb9b2 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -27,7 +27,7 @@
 #include "exec/exec-all.h"
 #include "exec/cputlb.h"
 #include "exec/tb-flush.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
 #include <stdbool.h>
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index fea989afe9..7fc9e121e1 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -32,6 +32,7 @@
 #include "exec/helper-proto.h"
 #include "exec/watchpoint.h"
 #include "system/cpu-timers.h"
+#include "exec/icount.h"
 
 /*
  * The following M-mode trigger CSRs are implemented:
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 889e2b6570..a1f70cc955 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -21,7 +21,7 @@
 #include "qemu/error-report.h"
 #include "system/kvm.h"
 #include "migration/cpu.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "debug.h"
 
 static bool pmp_needed(void *opaque)
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 0408f96e6a..a68809eef3 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -22,7 +22,7 @@
 #include "qemu/timer.h"
 #include "cpu.h"
 #include "pmu.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "system/device_tree.h"
 
 #define RISCV_TIMEBASE_FREQ 1000000000 /* 1Ghz */
diff --git a/util/async.c b/util/async.c
index 863416dee9..2719c629ae 100644
--- a/util/async.c
+++ b/util/async.c
@@ -35,7 +35,7 @@
 #include "block/raw-aio.h"
 #include "qemu/coroutine_int.h"
 #include "qemu/coroutine-tls.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "trace.h"
 
 /***********************************************************/
diff --git a/util/main-loop.c b/util/main-loop.c
index acad8c2e6c..42bd75c193 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -27,6 +27,7 @@
 #include "qemu/cutils.h"
 #include "qemu/timer.h"
 #include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "system/replay.h"
 #include "qemu/main-loop.h"
 #include "block/aio.h"
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 788466fe22..1fb48be281 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -27,6 +27,7 @@
 #include "qemu/timer.h"
 #include "qemu/lockable.h"
 #include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "system/replay.h"
 #include "system/cpus.h"
 
-- 
2.43.0


