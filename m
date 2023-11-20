Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DE17F16E0
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 16:12:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55tl-0006SD-2S; Mon, 20 Nov 2023 10:09:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tU-0005vD-So
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:09:02 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tG-0001Im-Nc
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:09:00 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c5071165d5so55854991fa.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 07:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700492924; x=1701097724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gyb1IbDacWS+M0sLJpuM3eBiDXIMLrNrMXya8IYdc1k=;
 b=YDrUotk2GqBTeKyBVfDfKYhW2+uvDVEcLj54dmHdwuBlQ7hFoRvMRG+yLoFwYvm66u
 2L+zcbLfOySVXLLQf73fdXEmYAtIMNKsJOYn2uBqat62RHAWYbcfzLqBNgX2qxIbxRTT
 LYhe8uZDgCq/ngdkOr8iSZOWG5JRVSHqK6uNEYlO8EQDPn+tE73YMpXY6rXHiEnkwApB
 pucR+xZCRN2kPAi2KF56uRc+UyuFqimrMJy2lXFKLQXa4z95JnIGC9/6FUslf37irUe/
 loE3iFlUadrKKareSf8sy3yfJ8CQcNjMmVyDJdLoRcUkm8JnJcVwXw9fjl4UhBUZV4Nu
 RtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700492924; x=1701097724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gyb1IbDacWS+M0sLJpuM3eBiDXIMLrNrMXya8IYdc1k=;
 b=IB57HMTfqAIMXOf56DAv4Z2GRR9y6lmbxNO5Nkuvgs2FxLWsYUZJsQwNd8SgCKMXIu
 gfYKgSjyCb6O+riSPA+de3t9JmeodS3qB8etAUeiFuWLhwSqzfn26yHUObtnHSgzVk2D
 njOONIly7HEeZbmuOvVh3ehqqyF95W9ge+Wh/YREGIaz7t1SUo8J+GoSCeAiTSOptfPf
 7zBkLNPWdYL2CAJryflgz2CsbFsm/pVMfihIuYOC8WhegJZcf9/ahZRfzZidqJYKYIo/
 n9WsZfCUo2BcKe08aISmHcx6x1p61tXAqonTZhkYrl21x8C8JnB+qUZ8nAKAnFW4TnUI
 ItRg==
X-Gm-Message-State: AOJu0Yzxmu/KvprNYCcQXcgRAe5Z7xSBWZkHQN6kemu2hrFHdrzP+J3y
 7q1J6/yCStnIRxw3SngrJrH7Hg==
X-Google-Smtp-Source: AGHT+IHLyAsKb5DQBFBdNKB3pZIZItQt081kS32+KzZw9ZLhVLlEXwDuZXcYASZYowaxzLW/3EEuMQ==
X-Received: by 2002:a2e:8ec2:0:b0:2c5:3139:2d04 with SMTP id
 e2-20020a2e8ec2000000b002c531392d04mr5312124ljl.47.1700492924291; 
 Mon, 20 Nov 2023 07:08:44 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fb11-20020a05600c520b00b004076f522058sm18057174wmb.0.2023.11.20.07.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 07:08:42 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 185C965779;
 Mon, 20 Nov 2023 15:08:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Marek Vasut <marex@denx.de>,
 Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 12/14] tests/tcg: enable semiconsole test for Arm
Date: Mon, 20 Nov 2023 15:08:31 +0000
Message-Id: <20231120150833.2552739-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120150833.2552739-1-alex.bennee@linaro.org>
References: <20231120150833.2552739-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22e.google.com
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


