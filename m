Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 215677F637B
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 16:59:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6C4H-00063a-IR; Thu, 23 Nov 2023 10:56:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C4D-00061q-Up
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:37 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C48-0002Ou-ND
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:37 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40b344101f2so6192745e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 07:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700754991; x=1701359791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+yUzGXsIXja0tGFBOZ/gTUt4pii4b19n7jKgHDQET8=;
 b=wDC4egp1xjruGDPXSzgg7g2NckO9uS3qf7WT4WdhG8MJr6LjZb6sje8/yncFfM8/eI
 AAe4A2RdOYDNzJUu369orHQ/mTCyV4U+T4h3Bvi1EmYSPdwcE8eAhL43Cw7k7TCXbpV2
 pMfu5cffAiDAeb2zMz8J3KsJN//7OoqdnONsSpXgFMOrqM6HP4s0ei2YK2mqKSOnm2Sv
 6zEW9Z8kGxL7/bcJzEraEyBCm/em00/JenkYoCOGc1nXt0N3ogtFjSzZjsTc527num3I
 JM3LVUXWU/F652E2qQ3QgzMuw7bWyOna5R/okJCGHWiWzLpfTYwdstm75RhmJMijb/Ql
 5HTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700754991; x=1701359791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s+yUzGXsIXja0tGFBOZ/gTUt4pii4b19n7jKgHDQET8=;
 b=dGwcUX6RnxH2srwaR4aNFrpi6ijh1LvBZPINyx+gyi81LIw24b6j1voMSgPkWQXp76
 2nNgqpXSGCTZ3VVeDWwWeYwdm5hKsUXOhH5cAGEMvWz+F8UQ6boNLohHGdX0HdShAUIr
 BpwojtdNRJIpvGbbaZDV9O2eQFmXd5NSilIPECGZ/cB9fRndjDW0jyo2++vRiUXa4GHe
 RAw1ws+LW7aiPgp0gs9ZvLmpUz3q7abSegjwsmP98kqHCeF7ief7tZTwziqdjUpqDIlU
 6XowtOtSlh5ucCJYayala2Z3UuTJyj+ExaoBH7a86moYBDBwfdLed8zciS5rIlNsCaXl
 asdA==
X-Gm-Message-State: AOJu0YzVgOFT8OvQEqJwt1561kLkmqAeOgYbUaOn0a4l1uehozXhkgs+
 r3nioFUnl1zbTLsBYX/wBBhVTA==
X-Google-Smtp-Source: AGHT+IFdQckx2wfJFq/wfKH7G0VDTzqUZbRwWlKzYen9Fpa+9heeCD8HuKygE0lD5ruZ8/XPn8bakg==
X-Received: by 2002:a05:600c:5124:b0:406:51a0:17ea with SMTP id
 o36-20020a05600c512400b0040651a017eamr2711081wms.10.1700754991329; 
 Thu, 23 Nov 2023 07:56:31 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o15-20020a05600c4fcf00b0040586360a36sm3112417wmq.17.2023.11.23.07.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 07:56:30 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B739064600;
 Thu, 23 Nov 2023 15:56:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 12/14] tests/tcg: enable semiconsole test for Arm
Date: Thu, 23 Nov 2023 15:56:18 +0000
Message-Id: <20231123155620.3042891-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123155620.3042891-1-alex.bennee@linaro.org>
References: <20231123155620.3042891-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

This still remains a MANUAL test due to blocking issues.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231120150833.2552739-13-alex.bennee@linaro.org>

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


