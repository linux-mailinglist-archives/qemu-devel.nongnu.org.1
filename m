Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C51723E3E
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:50:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TJ1-0007s9-SX; Tue, 06 Jun 2023 05:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIu-0007ng-Pm
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:40 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIq-0004mT-Hl
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:40 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-30ae5f2ac94so5882792f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044916; x=1688636916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xj/f+gH5uKmAixTu4UKEotEF3ZRZ6S/5RBdB+cJJN84=;
 b=bv0snAPDb8OAQUfPFCNaWIFM0G2bzAACs3uSnyp8afzDU1e82Lpp4lpCu9vTxnI6zL
 uG4WHn+i3++ZDA+iK+vIjLsixwZ/nOL7dUmJ1UIy8BIrRsw17oJjyjmmTcgQHEHt/z/C
 yIiF8Y7acwppXWv5k18BZBnl5ks0+zUpJ/5A94p3W+PKhWeyyCf6d5zMnMrJktPLCvPh
 RXnn6MavNJKsciVbbMDDYSXCl1Qpf7Lwnp9z+Te3lENgR4q66mNkhyjVAiZe412oZKyC
 RWax6ZL/yJsnyjkmOV1p30T5f6H6jIPikb5O/gOePAYCx7L3cep1hE2wJ/YI5kbytuEy
 oDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044916; x=1688636916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xj/f+gH5uKmAixTu4UKEotEF3ZRZ6S/5RBdB+cJJN84=;
 b=aKQiiozPX8emwXrhgehy2zwrlMKEbstERGOfq1OTLXJCN5aiL03FHy3ngfnBxUKlMA
 7zDDLeK9dKioQG9bevwpOsC/dxnZsq9tCO7Y79Lv3phZGGU6QAOnMQspsw5G+s4I25WF
 wxQCmOnfccoKCIk2yCBqWqo9kOq7Kr8fFUgvTkCRTe+el2QukZAInekfC1By+RoQY0r7
 JeIJBVwongh9tsTywVKVs+R2yGYIQ6cg0NtKN4T+lpZztiCQBOSqdDWIfpclnUpkkDqx
 bZKwMqS91mrdJxhiiFOf9zeq5EYtDFZ7I1oQdCdVHd2735IjaCg4iN59cOypwc7WFWtq
 dLVA==
X-Gm-Message-State: AC+VfDxxI/jceDr0OCxNwJcsumS0MdmfSWBxUUQwl/Fzz2P99RQk8O7P
 tmiQhq2z9ZJqKDq9MPJvsxBwn6vYZqw1rrDtXM0=
X-Google-Smtp-Source: ACHHUZ5V6EpZcHybEhD6Lsz1cIPMBuQO4typkhRlItz28iaLf3gWxtgtKlnnrQqteliaEYKqPmZXJw==
X-Received: by 2002:a5d:698f:0:b0:30a:f17e:e02e with SMTP id
 g15-20020a5d698f000000b0030af17ee02emr1523145wru.12.1686044915837; 
 Tue, 06 Jun 2023 02:48:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/42] tests/tcg/aarch64: add DC CVA[D]P tests
Date: Tue,  6 Jun 2023 10:48:13 +0100
Message-Id: <20230606094814.3581397-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Zhuojia Shen <chaosdefinition@hotmail.com>

Test execution of DC CVAP and DC CVADP instructions under user mode
emulation.

Signed-off-by: Zhuojia Shen <chaosdefinition@hotmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/dcpodp.c        | 63 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/dcpop.c         | 63 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target | 11 ++++++
 3 files changed, 137 insertions(+)
 create mode 100644 tests/tcg/aarch64/dcpodp.c
 create mode 100644 tests/tcg/aarch64/dcpop.c

diff --git a/tests/tcg/aarch64/dcpodp.c b/tests/tcg/aarch64/dcpodp.c
new file mode 100644
index 00000000000..2cf7df2e073
--- /dev/null
+++ b/tests/tcg/aarch64/dcpodp.c
@@ -0,0 +1,63 @@
+/*
+ * Test execution of DC CVADP instruction.
+ *
+ * Copyright (c) 2023 Zhuojia Shen <chaosdefinition@hotmail.com>
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <asm/hwcap.h>
+#include <sys/auxv.h>
+
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#ifndef HWCAP2_DCPODP
+#define HWCAP2_DCPODP (1 << 0)
+#endif
+
+bool should_fail = false;
+
+static void signal_handler(int sig, siginfo_t *si, void *data)
+{
+    ucontext_t *uc = (ucontext_t *)data;
+
+    if (should_fail) {
+        uc->uc_mcontext.pc += 4;
+    } else {
+        exit(EXIT_FAILURE);
+    }
+}
+
+static int do_dc_cvadp(void)
+{
+    struct sigaction sa = {
+        .sa_flags = SA_SIGINFO,
+        .sa_sigaction = signal_handler,
+    };
+
+    sigemptyset(&sa.sa_mask);
+    if (sigaction(SIGSEGV, &sa, NULL) < 0) {
+        perror("sigaction");
+        return EXIT_FAILURE;
+    }
+
+    asm volatile("dc cvadp, %0\n\t" :: "r"(&sa));
+
+    should_fail = true;
+    asm volatile("dc cvadp, %0\n\t" :: "r"(NULL));
+    should_fail = false;
+
+    return EXIT_SUCCESS;
+}
+
+int main(void)
+{
+    if (getauxval(AT_HWCAP2) & HWCAP2_DCPODP) {
+        return do_dc_cvadp();
+    } else {
+        printf("SKIP: no HWCAP2_DCPODP on this system\n");
+        return EXIT_SUCCESS;
+    }
+}
diff --git a/tests/tcg/aarch64/dcpop.c b/tests/tcg/aarch64/dcpop.c
new file mode 100644
index 00000000000..a332a804a41
--- /dev/null
+++ b/tests/tcg/aarch64/dcpop.c
@@ -0,0 +1,63 @@
+/*
+ * Test execution of DC CVAP instruction.
+ *
+ * Copyright (c) 2023 Zhuojia Shen <chaosdefinition@hotmail.com>
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <asm/hwcap.h>
+#include <sys/auxv.h>
+
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#ifndef HWCAP_DCPOP
+#define HWCAP_DCPOP (1 << 16)
+#endif
+
+bool should_fail = false;
+
+static void signal_handler(int sig, siginfo_t *si, void *data)
+{
+    ucontext_t *uc = (ucontext_t *)data;
+
+    if (should_fail) {
+        uc->uc_mcontext.pc += 4;
+    } else {
+        exit(EXIT_FAILURE);
+    }
+}
+
+static int do_dc_cvap(void)
+{
+    struct sigaction sa = {
+        .sa_flags = SA_SIGINFO,
+        .sa_sigaction = signal_handler,
+    };
+
+    sigemptyset(&sa.sa_mask);
+    if (sigaction(SIGSEGV, &sa, NULL) < 0) {
+        perror("sigaction");
+        return EXIT_FAILURE;
+    }
+
+    asm volatile("dc cvap, %0\n\t" :: "r"(&sa));
+
+    should_fail = true;
+    asm volatile("dc cvap, %0\n\t" :: "r"(NULL));
+    should_fail = false;
+
+    return EXIT_SUCCESS;
+}
+
+int main(void)
+{
+    if (getauxval(AT_HWCAP) & HWCAP_DCPOP) {
+        return do_dc_cvap();
+    } else {
+        printf("SKIP: no HWCAP_DCPOP on this system\n");
+        return EXIT_SUCCESS;
+    }
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 03157954871..3430fd3cd80 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -21,12 +21,23 @@ config-cc.mak: Makefile
 	$(quiet-@)( \
 	    $(call cc-option,-march=armv8.1-a+sve,          CROSS_CC_HAS_SVE); \
 	    $(call cc-option,-march=armv8.1-a+sve2,         CROSS_CC_HAS_SVE2); \
+	    $(call cc-option,-march=armv8.2-a,              CROSS_CC_HAS_ARMV8_2); \
 	    $(call cc-option,-march=armv8.3-a,              CROSS_CC_HAS_ARMV8_3); \
+	    $(call cc-option,-march=armv8.5-a,              CROSS_CC_HAS_ARMV8_5); \
 	    $(call cc-option,-mbranch-protection=standard,  CROSS_CC_HAS_ARMV8_BTI); \
 	    $(call cc-option,-march=armv8.5-a+memtag,       CROSS_CC_HAS_ARMV8_MTE); \
 	    $(call cc-option,-march=armv9-a+sme,            CROSS_CC_HAS_ARMV9_SME)) 3> config-cc.mak
 -include config-cc.mak
 
+ifneq ($(CROSS_CC_HAS_ARMV8_2),)
+AARCH64_TESTS += dcpop
+dcpop: CFLAGS += -march=armv8.2-a
+endif
+ifneq ($(CROSS_CC_HAS_ARMV8_5),)
+AARCH64_TESTS += dcpodp
+dcpodp: CFLAGS += -march=armv8.5-a
+endif
+
 # Pauth Tests
 ifneq ($(CROSS_CC_HAS_ARMV8_3),)
 AARCH64_TESTS += pauth-1 pauth-2 pauth-4 pauth-5
-- 
2.34.1


