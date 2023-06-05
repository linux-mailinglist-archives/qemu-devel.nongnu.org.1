Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C2A7230F3
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:17:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Gcb-0001rB-Pz; Mon, 05 Jun 2023 16:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcX-0001pg-It
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:05 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcV-0003ri-Hc
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:05 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-650c89c7e4fso5357362b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996162; x=1688588162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ebG/JBGVQUzhkBt/ZqcczxWo6SU1DNkNqSEwarGUTCU=;
 b=VUcR2ytQlFmX9xl9zbseIZXL9gskOt6wYo4EcqPyKesph+tmkR5EYKqiai7hvbqUJV
 ekC0RQ2HzKvBIGK+dRySezM8r7wRhlh9q6v/dNfaMJRVGVmpWBcaSkl41xBtbiSorHZm
 m+jJTvIozLyL706b37s6PvRYqBgknmdiHbBwfQ2x1wazoilUxfBMUXlDP15F57sjG53q
 6c3aKtZPUdJcI/T/y+/uJjW7tKnTjyOmSzIP4o4BfWtsJ1YN9qDGYmnuXbxUJ4LJB9no
 ovul8fn+tVMqQYIqHNH7107LOvmw+/2Wj/f21uUzlwDmG0mEcAoea8AAwVeL5W8aPgwq
 Ig1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996162; x=1688588162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ebG/JBGVQUzhkBt/ZqcczxWo6SU1DNkNqSEwarGUTCU=;
 b=FUqp+IuSPX5FnLeolKMXCx6FyAeh3nF7bHNKLyutgSOdlUS3gTFwRF0vBuMR3hnZZ0
 NopTNW+sTXp4Leq4mGczLFi+ATkqLcvrgkBexWaH4wdW22sdIB8x8nTCA8M2Q86id0m9
 rr7pVU5Fysb7qi/1c3FKZUq5BA34YCto/BXaUTIQSwMHMNXVDPRdBsChlZQ5GibQ7VyI
 3CGb3IJVIWwvYLGqLJ4wQTwdK9VJfUFzgS/ErsAxTSCanRy6rjOQiLYvBFEa2+HKFrsr
 zMoCUOgk5kfiXWlzxUCk/sJCwUlx9mffUhfIGzIwq7M5PmutSCQT04USYt/UATy600U+
 iW6g==
X-Gm-Message-State: AC+VfDwusSbxYpkm7ZnPKFjmcFiGnHPSKEuEJ53Ey8KfNY38HKuHwUOW
 SYLhSowNsF0jANxoc0Sq/8VWHKuLY+vgWYMBQIU=
X-Google-Smtp-Source: ACHHUZ7HzMxFNQjYz+Elj3Y4C1pT/mOBCdo8E5wJ11apCJ2XemJCmF4zgs6C8i5+STzbPl8otr3UAQ==
X-Received: by 2002:aa7:8884:0:b0:64c:4f2f:a235 with SMTP id
 z4-20020aa78884000000b0064c4f2fa235mr910102pfe.30.1685996161899; 
 Mon, 05 Jun 2023 13:16:01 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:16:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/52] tcg: Split out tcg/oversized-guest.h
Date: Mon,  5 Jun 2023 13:15:09 -0700
Message-Id: <20230605201548.1596865-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Move a use of TARGET_LONG_BITS out of tcg/tcg.h.
Include the new file only where required.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h       |  3 +--
 include/tcg/oversized-guest.h | 23 +++++++++++++++++++++++
 include/tcg/tcg.h             |  9 ---------
 accel/tcg/cputlb.c            |  1 +
 accel/tcg/tcg-all.c           |  1 +
 target/arm/ptw.c              |  1 +
 target/riscv/cpu_helper.c     |  1 +
 7 files changed, 28 insertions(+), 11 deletions(-)
 create mode 100644 include/tcg/oversized-guest.h

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index a43b34e46b..896f305ff3 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -326,8 +326,7 @@ static inline void clear_helper_retaddr(void)
 
 #else
 
-/* Needed for TCG_OVERSIZED_GUEST */
-#include "tcg/tcg.h"
+#include "tcg/oversized-guest.h"
 
 static inline target_ulong tlb_read_idx(const CPUTLBEntry *entry,
                                         MMUAccessType access_type)
diff --git a/include/tcg/oversized-guest.h b/include/tcg/oversized-guest.h
new file mode 100644
index 0000000000..641b9749ff
--- /dev/null
+++ b/include/tcg/oversized-guest.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define TCG_OVERSIZED_GUEST
+ * Copyright (c) 2008 Fabrice Bellard
+ */
+
+#ifndef EXEC_TCG_OVERSIZED_GUEST_H
+#define EXEC_TCG_OVERSIZED_GUEST_H
+
+#include "tcg-target-reg-bits.h"
+#include "cpu-param.h"
+
+/*
+ * Oversized TCG guests make things like MTTCG hard
+ * as we can't use atomics for cputlb updates.
+ */
+#if TARGET_LONG_BITS > TCG_TARGET_REG_BITS
+#define TCG_OVERSIZED_GUEST 1
+#else
+#define TCG_OVERSIZED_GUEST 0
+#endif
+
+#endif
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 5fe90cbb42..021fc903ad 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -59,15 +59,6 @@ typedef uint64_t tcg_target_ulong;
 #error unsupported
 #endif
 
-/* Oversized TCG guests make things like MTTCG hard
- * as we can't use atomics for cputlb updates.
- */
-#if TARGET_LONG_BITS > TCG_TARGET_REG_BITS
-#define TCG_OVERSIZED_GUEST 1
-#else
-#define TCG_OVERSIZED_GUEST 0
-#endif
-
 #if TCG_TARGET_NB_REGS <= 32
 typedef uint32_t TCGRegSet;
 #elif TCG_TARGET_NB_REGS <= 64
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6beaeb0a81..32a4817139 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -40,6 +40,7 @@
 #include "qemu/plugin-memory.h"
 #endif
 #include "tcg/tcg-ldst.h"
+#include "tcg/oversized-guest.h"
 #include "exec/helper-proto.h"
 
 /* DEBUG defines, enable DEBUG_TLB_LOG to log to the CPU_LOG_MMU target */
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index a831f8d7c3..02af6a2891 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -28,6 +28,7 @@
 #include "exec/replay-core.h"
 #include "sysemu/cpu-timers.h"
 #include "tcg/tcg.h"
+#include "tcg/oversized-guest.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/accel.h"
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index b0d2a05403..b2dc223525 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -14,6 +14,7 @@
 #include "cpu.h"
 #include "internals.h"
 #include "idau.h"
+#include "tcg/oversized-guest.h"
 
 
 typedef struct S1Translate {
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 57d04385f1..56381aaf26 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -31,6 +31,7 @@
 #include "sysemu/cpu-timers.h"
 #include "cpu_bits.h"
 #include "debug.h"
+#include "tcg/oversized-guest.h"
 
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
 {
-- 
2.34.1


