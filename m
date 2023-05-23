Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D5170DE55
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:59:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SSt-0005F4-1M; Tue, 23 May 2023 09:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSM-0004x2-7J
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:43 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSH-00032p-Ia
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:41 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-64d3fdcadb8so3010681b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850015; x=1687442015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qvUxh0n09hk8B0Pf+La9yLAbiGYU5Hxqjo6tGxJpF+o=;
 b=eEDZ0KMbLWjHP+x4ZzlQcrKYn2PLA66pcUNrSjnieIn/sxASK3zVwstgJ/RIUD+qWt
 LdvVKhRgmLYdA4Xim4wR9JPxEQ7E/ZY9SKQexItuVwxpSiLHpGD3A0KiV9kNTsZ8T+Q+
 SCgTbjatqdKH6Sx7sZmdfEInBybkgUh/HOehJ27Tb4c7Exw8Ng8PeiE+gioZKniNYv0e
 qCxUHnL8nzNEG8xISaDwCRplFkh7gVxccF5zm/0cqmYFkOo6anzgZd9yzCa7is3tjNpP
 2kFh5PKnRVNbtxtQdAMO+AI3EjwrXODLTzpHLCcP5V7fZcnuSwvg5bLc/Lp5IRqAcYni
 B1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850015; x=1687442015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qvUxh0n09hk8B0Pf+La9yLAbiGYU5Hxqjo6tGxJpF+o=;
 b=gs3JslvjWGyx/y2pNML4Eb1sHR7cGz6gh+lJ4KRfekJcTyVOCmV8o7PAGdyxi1YgkH
 3B/ldQ1P3SNAqZJUOcfvoYJXhMH6bmhlCjNxFbXkPbiy4ooI1U5RFzgvcB5L+VyMV3BH
 e6w2mUKVjz7c/X4gJWNiLnYN3i6m2jxDq8DgYrR/bda1z9SyDhhx3z3MiIYQQAboJyCJ
 0PBVfb4uhMr3FpwefFa8ptDKNARnrcppOVc/otlk6R5AOSG9XXYM+SfQ+eeQnxSt04k4
 ckn0mZH6wdYeORIKvsnt7BajmPdg64wJNCuBtCyud4Den4NbXW/afRNQMTkOx9ImoMv/
 cMMA==
X-Gm-Message-State: AC+VfDxanJFlJozxf67p4U5+6R+rgCLOIuWF50cBhnjpcqufYN9HOq8w
 7csA/bEVk2Dd0ieKbbaKiLlWN4yMmh/82LMt8R0=
X-Google-Smtp-Source: ACHHUZ7UsxPCmC/u+LLXrq1gx3cMsSn1JVGpGsXEfTCMMzcou/GCbA5abBlHVrX20qH/Kdw1d9E5kg==
X-Received: by 2002:a05:6a00:b8f:b0:64f:4586:83fc with SMTP id
 g15-20020a056a000b8f00b0064f458683fcmr2286481pfj.31.1684850015611; 
 Tue, 23 May 2023 06:53:35 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/52] tcg: Split out tcg/oversized-guest.h
Date: Tue, 23 May 2023 06:52:44 -0700
Message-Id: <20230523135322.678948-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Move a use of TARGET_LONG_BITS out of tcg/tcg.h.
Include the new file only where required.

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


