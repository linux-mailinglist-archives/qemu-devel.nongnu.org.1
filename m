Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0173C7ED429
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 21:57:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Mvk-0004xx-JL; Wed, 15 Nov 2023 15:56:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r3Mvi-0004xO-7v
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 15:56:10 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r3MvQ-0008CA-QG
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 15:56:10 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40790b0a224so504215e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 12:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700081751; x=1700686551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gyb1IbDacWS+M0sLJpuM3eBiDXIMLrNrMXya8IYdc1k=;
 b=WJRB7X0EoSv9DuzEjzFBKwvmfPW4jXYmMXfkF6Fx4s85QsSvkBwsDr4eceaI1oHc5r
 5mv13Ta0oL6rgPKwuJ62l+0ptSmsnHhjRHXQ+x0ZxN5Jh/3JKkmwRaf7rWvOttGbt/Lx
 nVNNtokNlMWjq1R4DuQMkQXWBwRn7oIjQBsjXh0VJTssMYUQaw+7qrHdf05+dvYZVZ2k
 t8sZiGd07flfnRx9BAC0EC43F+VE2vSlDFsLJc8Km/lf5WPJCzNyWtL0b1Zi/Ef6mXjC
 aBDZ6kVeiP45i1YZJ2r5vg+z8QkYmKI20/KuTilA9zDYbt2rgV4k7fgFIRiqnHpYLQPm
 6V6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700081751; x=1700686551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gyb1IbDacWS+M0sLJpuM3eBiDXIMLrNrMXya8IYdc1k=;
 b=SYRmBxJ6M3yZ3HrCal4vHT3Hc5N6sVTAGo2yUfKgfdPa7+QgkfK3AnDjOR4Ot7GOfP
 44cgjeV6vPOlRDMQ8KCBTY1jcmHJP2LK48dH856lNG/gtTqlYFiFKeJhS6PiypOP27gW
 XFJd2CYpRCZo08QMg9oJdcUkb9ukDvQCfOTrZ7slQwhvACOrckf+NriiNeZCse8h2AgV
 8VX6MDA7EgoXa0IXW5mV4tZpXibYD2dHvNlMPMmMITveBSx9X4bfRDvQzf87x9ssEQSL
 Q4v43ACXvhVwoOGxoahCNq1vtUnpZHjq66/4XYNptGldcE2cNhkJkfBCji6vGqGfHAYg
 rZbQ==
X-Gm-Message-State: AOJu0Ywf5KqlwgYnQe1Td2sqo7FPcxNsDu3fjuEg8FEzbn2d0Lmalpcx
 sjTKc43aG7cvEqe+R+zGP2AXkw==
X-Google-Smtp-Source: AGHT+IHwdwqYIKKLBmm3Mimv7EMxq41QltSW7JdqpbWZl0arue0D4KI8OIXlm+BwxHWi/7vcCv3HTQ==
X-Received: by 2002:adf:ebca:0:b0:32c:ea14:89e5 with SMTP id
 v10-20020adfebca000000b0032cea1489e5mr9227991wrn.39.1700081751329; 
 Wed, 15 Nov 2023 12:55:51 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 e3-20020adffd03000000b003142e438e8csm11534869wrr.26.2023.11.15.12.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 12:55:46 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A7EC95F7B9;
 Wed, 15 Nov 2023 20:55:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 10/10] tests/tcg: enable semiconsole test for Arm
Date: Wed, 15 Nov 2023 20:55:42 +0000
Message-Id: <20231115205542.3092038-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231115205542.3092038-1-alex.bennee@linaro.org>
References: <20231115205542.3092038-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

This still remains a MANUAL test due to blocking issues.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/arm/system/semiconsole.c    | 42 +++++++++++++++++++++++++++
 tests/tcg/arm/Makefile.softmmu-target |  9 ++++++
 2 files changed, 51 insertions(+)
 create mode 100644 tests/tcg/arm/system/semiconsole.c

diff --git a/tests/tcg/arm/system/semiconsole.c b/tests/tcg/arm/system/semiconsole.c
new file mode 100644
index 0000000000..206dd60eed
--- /dev/null
+++ b/tests/tcg/arm/system/semiconsole.c
@@ -0,0 +1,42 @@
+/*
+ * Semihosting Console Test
+ *
+ * Copyright (c) 2019 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+#include <minilib.h>
+
+#define SYS_READC 0x7
+
+uintptr_t __semi_call(uintptr_t type, uintptr_t arg0)
+{
+    register uintptr_t t asm("r0") = type;
+    register uintptr_t a0 asm("r1") = arg0;
+#ifdef __thumb__
+#  define SVC  "svc 0xab"
+#else
+#  define SVC  "svc 0x123456"
+#endif
+    asm(SVC : "=r" (t)
+        : "r" (t), "r" (a0));
+
+    return t;
+}
+
+int main(void)
+{
+    char c;
+
+    ml_printf("Semihosting Console Test\n");
+    ml_printf("hit X to exit:");
+
+    do {
+        c = __semi_call(SYS_READC, 0);
+        __sys_outc(c);
+    } while (c != 'X');
+
+    return 0;
+}
diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index aadc12767e..4c9264057f 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -48,6 +48,15 @@ memory: CFLAGS+=-DCHECK_UNALIGNED=0
 QEMU_BASE_MACHINE=-M virt -cpu max -display none
 QEMU_OPTS+=$(QEMU_BASE_MACHINE) -semihosting-config enable=on,target=native,chardev=output -kernel
 
+# console test is manual only
+QEMU_SEMIHOST=-serial none -chardev stdio,mux=on,id=stdio0 -semihosting-config enable=on,chardev=stdio0 -mon chardev=stdio0,mode=readline
+run-semiconsole: QEMU_OPTS=$(QEMU_BASE_MACHINE) $(QEMU_SEMIHOST)  -kernel
+run-semiconsole: semiconsole
+	$(call skip-test, $<, "MANUAL ONLY")
+	$(if $(V),@printf "  %-7s %s %s\n" "TO RUN" $(notdir $(QEMU)) "$(QEMU_OPTS) $<")
+run-plugin-semiconsole-with-%: semiconsole
+	$(call skip-test, $<, "MANUAL ONLY")
+
 # Simple Record/Replay Test
 .PHONY: memory-record
 run-memory-record: memory-record memory
-- 
2.39.2


