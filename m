Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 439F57174BC
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:05:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D3v-00076h-Tp; Wed, 31 May 2023 00:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3q-0006wr-Bl
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:47 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3n-0006B7-LS
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:46 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-33bdab7b4caso1891035ab.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505821; x=1688097821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ebG/JBGVQUzhkBt/ZqcczxWo6SU1DNkNqSEwarGUTCU=;
 b=vjsJrWaJVVqJBMPVoMZvP7TU5vCbhGX52ahQOAe87IuS5ZuZMKeQIAkZAxifzejYtI
 HaMVbpQK6tqSfdoy51S4QnQlGQFoAaRw0t9f//liDUO3Y1Z2fTS9C2wROgfsnjb8B6Mn
 i1dILwqsnnKXie3FNrlcjeiMDDUTLYpGaCUQo8fGBEgsnqP369Qnz1W5bNs84yYzVnCI
 OX8wxXSYzA5UtUot3xxHQGdNSNiXAAQaCt02mJVs1IFTQqRqci9LtVs37a7om0h5Xbhh
 /CF3r9UVMUaYFE4xvZI8hY6WH+IBjzLJo1goVYF7j/of38mc+SPxtSxqedwhetlDsJu5
 VSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505821; x=1688097821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ebG/JBGVQUzhkBt/ZqcczxWo6SU1DNkNqSEwarGUTCU=;
 b=dNBmWaeXQsO3Cs4OikisMLQHvH9wCGLAUW1rmIRY1kun+Vdvhq70Rhkv0opNnKSy7U
 FFievf+qfz3BuN1h5JWPG2VkkurDllIHeDgMcf5M6b5XN7pYozPgHKs3gh0+SInro8y4
 ifhD7vXxWpqnmv18/DNmBupHG9rW7ckYEE0GMFR9SeXEBWUFuDamlvB76G1Vei+kZ8Wt
 Ev1x+Q8au+mVbMOhO8jovYaCcoz0XBAJHhwrjpDal+y979zoU++m2xY2h7399U2IoSVg
 rHuXdNkXdoVO4WMyoUiwM+uemQDwhTZ8y5FOqwJifyWMKv3hTv0iOret4bnzQnGVJzr3
 Bqtg==
X-Gm-Message-State: AC+VfDzN00FfmQ0LYhLW9XkP71H80uKiixtUC0Xfcm2DKmDzRwYSrxAV
 HIpIjnO4PPEgGQLjCeTwhgUCYYkeWbWxuoNzGnw=
X-Google-Smtp-Source: ACHHUZ4XbC/SG+mBV8NqDfkV7LoQF0tLDp4kpPu6eiii6hOeoKSsLf41V/4Tzs77ZwTdW5VdJ5ynAw==
X-Received: by 2002:a92:d581:0:b0:33b:ad59:a8a9 with SMTP id
 a1-20020a92d581000000b0033bad59a8a9mr968457iln.9.1685505821397; 
 Tue, 30 May 2023 21:03:41 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 13/48] tcg: Split out tcg/oversized-guest.h
Date: Tue, 30 May 2023 21:02:55 -0700
Message-Id: <20230531040330.8950-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x131.google.com
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


