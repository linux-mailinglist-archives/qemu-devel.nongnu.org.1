Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F013C7F1A65
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 18:36:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r58BQ-0005nk-No; Mon, 20 Nov 2023 12:35:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r58Ax-0005bj-JY
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 12:35:11 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r58Au-0002Ra-UE
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 12:35:10 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32deb2809daso3103654f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 09:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700501707; x=1701106507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pxDVMDGr8B4qXH0/pCUMU+JxzeY5WrCdtQLxJO9oIRQ=;
 b=k9m0hQDc3h6Dh4WBqj8tbKIrYhqT3xsJPQdcmlzr3orJ5Ok3bEru3F4wsMpKx7GDEi
 dL1iuYy0MBP4FO3X5DoEMLmjyVxI8F93Ro6evndjmScc6Z1hWHqL/D3eoqWGcP2/ADG+
 T5WSZeCnN3ncDaAJfdptbe5ax38sjlu31X0EYTvdSKU5kNeUlSQ/5AULquf8Ie0Ztf1B
 wD0vSBFxIsdD1VqNzIob8yyhR+HxE8G1U0al9cyi4hL7F9Xt5eXjKRr+qEtUdrsw8D2i
 96YQ1YelWDJyd6lyuZzZ2yVQRsju+f3BKo6nv7rwyg2gOlVEXEgRe9U9LA3giXP6KY0t
 x4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700501707; x=1701106507;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pxDVMDGr8B4qXH0/pCUMU+JxzeY5WrCdtQLxJO9oIRQ=;
 b=UOcGrJPVVLjbdcNGehqueL5P/M278LReggXNEeu5YMYQf3Xg7RF6rFQ5zqHTuaveG1
 nu9mQ6HuIj0FT2kqGbMNj+C9dLlRJKK0DodjTHp3EdsF2zBsXIYjk3VQ8UeElCwEpU4i
 Xtop2OMB9hCvMvbqjPDcKHCXl9+ln8xc0riQkI50uL1myDhMPDV3hRFF4Ai/i2QaQQ4Y
 c90a9WHWU8Sh1nEElHZSeFhM8+qys3HNgyo5WT530c5KPABSNybXRyX/9zQdfrj+pFQD
 sBhEdzKQwY7W/YZ9xo3sRIjz4J94MVLAZk7V/9rVbUXM54zFwVnKrhzESM9gQ1QG5rGY
 9GQg==
X-Gm-Message-State: AOJu0YwCDfJNckgBaEPbNIl5uV36tYpgPP84SLT4eYDPBrmcXpv+T/xZ
 QomWhkKSRZHWs8eslDfqtzSC0w==
X-Google-Smtp-Source: AGHT+IHExRr+cegkf+W+Lwh470/nAIdg6gPffpWZXS/EEXp6XKSx4MPA4sYtw0hOSBAPLNHp3+ZwVg==
X-Received: by 2002:a5d:5f56:0:b0:332:c9ed:cc2c with SMTP id
 cm22-20020a5d5f56000000b00332c9edcc2cmr2339234wrb.3.1700501707346; 
 Mon, 20 Nov 2023 09:35:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d5-20020adfef85000000b0032fb46812c2sm11850633wro.12.2023.11.20.09.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 09:35:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Leonid Komarianskyi <leonid_komarianskyi@epam.com>
Subject: [PATCH for-8.2] target/arm: Handle overflow in calculation of next
 timer tick
Date: Mon, 20 Nov 2023 17:35:06 +0000
Message-Id: <20231120173506.3729884-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

In commit edac4d8a168 back in 2015 when we added support for
the virtual timer offset CNTVOFF_EL2, we didn't correctly update
the timer-recalculation code that figures out when the timer
interrupt is next going to change state. We got it wrong in
two ways:
 * for the 0->1 transition, we didn't notice that gt->cval + offset
   can overflow a uint64_t
 * for the 1->0 transition, we didn't notice that the transition
   might now happen before the count rolls over, if offset > count

In the former case, we end up trying to set the next interrupt
for a time in the past, which results in QEMU hanging as the
timer fires continuously.

In the latter case, we would fail to update the interrupt
status when we are supposed to.

Fix the calculations in both cases.

The test case is Alex Bennée's from the bug report, and tests
the 0->1 transition overflow case.

Fixes: edac4d8a168 ("target-arm: Add CNTVOFF_EL2")
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/60
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Thanks to Leonid for his recent patch which prodded me
into looking at this again. I preferred to fix both halves
of the if(), rather than just one, and I have thrown in
Alex's test case since it was conveniently to hand.
---
 target/arm/helper.c                       | 25 ++++++++++--
 tests/tcg/aarch64/system/vtimer.c         | 48 +++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.softmmu-target |  7 +++-
 3 files changed, 75 insertions(+), 5 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/vtimer.c

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ff1970981ee..0430ae55edf 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2646,11 +2646,28 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
         gt->ctl = deposit32(gt->ctl, 2, 1, istatus);
 
         if (istatus) {
-            /* Next transition is when count rolls back over to zero */
-            nexttick = UINT64_MAX;
+            /*
+             * Next transition is when (count - offset) rolls back over to 0.
+             * If offset > count then this is when count == offset;
+             * if offset <= count then this is when count == offset + UINT64_MAX
+             * For the latter case we set nexttick to an "as far in future
+             * as possible" value and let the code below handle it.
+             */
+            if (offset > count) {
+                nexttick = offset;
+            } else {
+                nexttick = UINT64_MAX;
+            }
         } else {
-            /* Next transition is when we hit cval */
-            nexttick = gt->cval + offset;
+            /*
+             * Next transition is when (count - offset) == cval, i.e.
+             * when count == (cval + offset).
+             * If that would overflow, then again we set up the next interrupt
+             * for "as far in the future as possible" for the code below.
+             */
+            if (uadd64_overflow(gt->cval, offset, &nexttick)) {
+                nexttick = UINT64_MAX;
+            }
         }
         /*
          * Note that the desired next expiry time might be beyond the
diff --git a/tests/tcg/aarch64/system/vtimer.c b/tests/tcg/aarch64/system/vtimer.c
new file mode 100644
index 00000000000..42f2f7796c7
--- /dev/null
+++ b/tests/tcg/aarch64/system/vtimer.c
@@ -0,0 +1,48 @@
+/*
+ * Simple Virtual Timer Test
+ *
+ * Copyright (c) 2020 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <inttypes.h>
+#include <minilib.h>
+
+/* grabbed from Linux */
+#define __stringify_1(x...) #x
+#define __stringify(x...)   __stringify_1(x)
+
+#define read_sysreg(r) ({                                           \
+            uint64_t __val;                                         \
+            asm volatile("mrs %0, " __stringify(r) : "=r" (__val)); \
+            __val;                                                  \
+})
+
+#define write_sysreg(r, v) do {                     \
+        uint64_t __val = (uint64_t)(v);             \
+        asm volatile("msr " __stringify(r) ", %x0"  \
+                 : : "rZ" (__val));                 \
+} while (0)
+
+int main(void)
+{
+    int i;
+
+    ml_printf("VTimer Test\n");
+
+    write_sysreg(cntvoff_el2, 1);
+    write_sysreg(cntv_cval_el0, -1);
+    write_sysreg(cntv_ctl_el0, 1);
+
+    ml_printf("cntvoff_el2=%lx\n", read_sysreg(cntvoff_el2));
+    ml_printf("cntv_cval_el0=%lx\n", read_sysreg(cntv_cval_el0));
+    ml_printf("cntv_ctl_el0=%lx\n", read_sysreg(cntv_ctl_el0));
+
+    /* Now read cval a few times */
+    for (i = 0; i < 10; i++) {
+        ml_printf("%d: cntv_cval_el0=%lx\n", i, read_sysreg(cntv_cval_el0));
+    }
+
+    return 0;
+}
diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index b74a2534e38..d71659cc226 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -45,7 +45,8 @@ TESTS+=memory-sve
 
 # Running
 QEMU_BASE_MACHINE=-M virt -cpu max -display none
-QEMU_OPTS+=$(QEMU_BASE_MACHINE) -semihosting-config enable=on,target=native,chardev=output -kernel
+QEMU_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output
+QEMU_OPTS+=$(QEMU_BASE_MACHINE) $(QEMU_BASE_ARGS) -kernel
 
 # console test is manual only
 QEMU_SEMIHOST=-chardev stdio,mux=on,id=stdio0 -semihosting-config enable=on,chardev=stdio0 -mon chardev=stdio0,mode=readline
@@ -55,6 +56,10 @@ run-semiconsole: semiconsole
 run-plugin-semiconsole-with-%: semiconsole
 	$(call skip-test, $<, "MANUAL ONLY")
 
+# vtimer test needs EL2
+QEMU_EL2_MACHINE=-machine virt,virtualization=on,gic-version=2 -cpu cortex-a57 -smp 4
+run-vtimer: QEMU_OPTS=$(QEMU_EL2_MACHINE) $(QEMU_BASE_ARGS) -kernel
+
 # Simple Record/Replay Test
 .PHONY: memory-record
 run-memory-record: memory-record memory
-- 
2.34.1


