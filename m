Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F06197FA7B4
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 18:11:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7f6B-0007UG-2J; Mon, 27 Nov 2023 12:08:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f5z-0007QH-2n
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:31 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f5v-0004cZ-On
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:30 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40b2ddab817so31258545e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 09:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701104906; x=1701709706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uLt/J0Ekf4tgAJYBqplW3Dr2IyBfScT1SQCm++J6lI4=;
 b=FWPtGN+pb4zP0LpUcu8m9G2ih80Y30110LIvXt1ywNq2v8M50KIIyXrfh6megmc8hg
 7qanZfa8GhC08CVD5f3H7Vh6l8WlfbRLxyxBc2HZSQ0Qcu1kbF+KLjLfP6NB/4e1+bFS
 xEV3qA5S6lSEbo98cRb6qgFez6kBVudI7W83bGl8BAV35yEGAnkTt+QKFhRLKOjz8DlY
 bxfSvyLkzkTKPI/WiCui7vSXCU2x1an8Y2+o+XPzZPue2G3VpR+8yNO9iXXCAer8IwTV
 ccYPaxM8b3tAjrIVPoD0+Fs48+36gJGBmu9tn7tI5F9bZcltRGn7dn2kA7sczWRyrsaw
 /9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701104906; x=1701709706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uLt/J0Ekf4tgAJYBqplW3Dr2IyBfScT1SQCm++J6lI4=;
 b=XUJW1V0E0pJSbk+cOKbH6rnhQc757eNmnEo3hHAp5M9Jk8os74gqPYjWarTSG2lFdc
 T+y7iwsGAiAJzEW8RUYWRVQZmRCuQBjflk2NCHPsE63beW2nRuh41g3w8hh1rKjt1cHY
 RXUcPTzDXQi0XTq69uhfdHAYx4tdbogCs5NqpscAGnBe2JCNSNdAaJxabr6mogvuVyRV
 c+G4r923IwkDqNJm9ptTdilE92R5YmhXQATkoTyi1xd7i6TubiceJb/Km1nBBLb0dDbJ
 AVeFdjhr2GJ16jx+d1LIG6PAFxXtMMJ0rSOlP7VeUBdbSsl4mKTpdj8MMLJcO1whVdvS
 JN1Q==
X-Gm-Message-State: AOJu0YxxI0a1jGfnzpsSBgmNK4/uRZ4mOu/ZxQr9y9A+zOsmMlgbn+ZN
 ZYBPE7h6HeoUX9jdfHijRF3BP3ySYH1ADUPzVBs=
X-Google-Smtp-Source: AGHT+IHcgrmjIEXdC5J2hQ3icXSPQEWbEWIR1hli3JpXcwoXiq0pqKfGHUTun0s4NmCQtPCFXLbXgA==
X-Received: by 2002:a05:600c:3ca0:b0:40a:48af:4820 with SMTP id
 bg32-20020a05600c3ca000b0040a48af4820mr5690786wmb.30.1701104906387; 
 Mon, 27 Nov 2023 09:08:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 fl8-20020a05600c0b8800b004030e8ff964sm15353216wmb.34.2023.11.27.09.08.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 09:08:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/13] target/arm: Handle overflow in calculation of next timer
 tick
Date: Mon, 27 Nov 2023 17:08:12 +0000
Message-Id: <20231127170823.589863-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127170823.589863-1-peter.maydell@linaro.org>
References: <20231127170823.589863-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231120173506.3729884-1-peter.maydell@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c                       | 25 ++++++++++--
 tests/tcg/aarch64/system/vtimer.c         | 48 +++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.softmmu-target |  7 +++-
 3 files changed, 75 insertions(+), 5 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/vtimer.c

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ff1970981ee..2746d3fdac8 100644
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
+             * if offset <= count then this is when count == offset + 2^64
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
index 77c5018e02a..4b03ef602ea 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -45,7 +45,8 @@ TESTS+=memory-sve
 
 # Running
 QEMU_BASE_MACHINE=-M virt -cpu max -display none
-QEMU_OPTS+=$(QEMU_BASE_MACHINE) -semihosting-config enable=on,target=native,chardev=output -kernel
+QEMU_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output
+QEMU_OPTS+=$(QEMU_BASE_MACHINE) $(QEMU_BASE_ARGS) -kernel
 
 # console test is manual only
 QEMU_SEMIHOST=-serial none -chardev stdio,mux=on,id=stdio0 -semihosting-config enable=on,chardev=stdio0 -mon chardev=stdio0,mode=readline
@@ -56,6 +57,10 @@ run-semiconsole: semiconsole
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


