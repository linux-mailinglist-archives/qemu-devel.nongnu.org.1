Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB0E80EBF0
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:36:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD1zo-0002TU-08; Tue, 12 Dec 2023 07:36:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD1zg-0001w1-Mf
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:36:14 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD1zW-0008JK-8j
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:36:07 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a1d2f89ddabso683060566b.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 04:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702384559; x=1702989359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xslJUC3cunhRFccFUTnzrLeqNr8O79apnk92wLCDXQw=;
 b=EN3Ao34P4ki+7vLzwl7xvjTvlEVfVG/ByVbjMnT71aaENKSciRJr5lgUlrVS21BbQg
 puQOsuOrnXig12ZwH7Ph8VJtFKzi1avHlEemsbxskngSTkbK+Bq1mq+1eCAgKnsQ6xXk
 4sqPKQ2ZhHV/bjIfurE3dB8WCJEJ2roUv8MDcuR0C13HoB8R9l3oO2MDh2whofzp8J35
 tQxsqEZ7kotVUFghx5VsMPFkpY0n9GPdrENnKIzWMEPD1lHq16H7wAUTV9MvqkhtzYk0
 K/3iMvm0ymqxoB+bHZ+YBU9jNazTyfbx8P87od2YRFXpxW/RXiD7DbAujku8NBzoBTvu
 kRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702384559; x=1702989359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xslJUC3cunhRFccFUTnzrLeqNr8O79apnk92wLCDXQw=;
 b=qh1GgSKbk0F17IxMAeU0bZttHscOobfHsrwFQnmr/3J5rLleSqBhvFui4B7BC+GvBv
 jf3hGSTeDlQAEPWNmLgmRSWR7LquDE7BfHVI0fZxKjdjyLgKqRQBlPaYskmyArxOtchK
 KsATJNYYtVvqQ05xg+q6jWAurlNAR7SGGJRa4PLrgOVED3B2zv34ch6XqHkHhp9M72Xb
 mxlIXVpwMOqPUoDpMmyqE2ZPVsZgJiMUH3HqoPisRKcAQcU+DTbLZ1Rq37AgJDjbE/F+
 f2AlTt0ghbVGwXEzV1H8WVlqxoD38pDqGrd0WrL+spV/FLXfnJnU0ykXGMJaOw21DXlI
 SS9g==
X-Gm-Message-State: AOJu0YxsL5poWJ6seeParPy0r8DMcsaYoNyPlIeI8nVH8GietlD0LSIN
 Zc6UEeti2hBRClvsIOl3OUVBtvTbtKJsO17MXhv+qg==
X-Google-Smtp-Source: AGHT+IGamzso69xnPwzGKjHX41GnloqCiUmwOG28jEND09G11dW0vVNtrhqK56fjX2WhuNEhH2u0bA==
X-Received: by 2002:a17:906:35cb:b0:a1d:c75c:3d3a with SMTP id
 p11-20020a17090635cb00b00a1dc75c3d3amr3374408ejb.29.1702384559159; 
 Tue, 12 Dec 2023 04:35:59 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 ts4-20020a170907c5c400b00a1cc1be1158sm6202405ejc.165.2023.12.12.04.35.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 04:35:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Claudio Fontana <cfontana@suse.de>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, Brian Cain <bcain@quicinc.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 16/23] exec: Move [b]tswapl() declarations to
 'exec/user/tswap-target.h'
Date: Tue, 12 Dec 2023 13:33:52 +0100
Message-ID: <20231212123401.37493-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212123401.37493-1-philmd@linaro.org>
References: <20231212123401.37493-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

tswapl() and bswaptls() are target-dependent and only used
by user emulation. Move their definitions to a new header:
"exec/user/tswap-target.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 bsd-user/freebsd/target_os_elf.h   |  1 +
 bsd-user/freebsd/target_os_stack.h |  1 +
 bsd-user/netbsd/target_os_elf.h    |  1 +
 bsd-user/openbsd/target_os_elf.h   |  1 +
 include/exec/cpu-all.h             |  8 --------
 include/exec/user/abitypes.h       |  1 +
 include/exec/user/tswap-target.h   | 22 ++++++++++++++++++++++
 bsd-user/signal.c                  |  1 +
 bsd-user/strace.c                  |  1 +
 linux-user/elfload.c               |  1 +
 linux-user/i386/signal.c           |  1 +
 linux-user/ppc/signal.c            |  1 +
 12 files changed, 32 insertions(+), 8 deletions(-)
 create mode 100644 include/exec/user/tswap-target.h

diff --git a/bsd-user/freebsd/target_os_elf.h b/bsd-user/freebsd/target_os_elf.h
index 9df17d56d8..27d8ce036c 100644
--- a/bsd-user/freebsd/target_os_elf.h
+++ b/bsd-user/freebsd/target_os_elf.h
@@ -22,6 +22,7 @@
 
 #include "target_arch_elf.h"
 #include "elf.h"
+#include "exec/user/tswap-target.h"
 
 #define bsd_get_ncpu() 1 /* until we pull in bsd-proc.[hc] */
 
diff --git a/bsd-user/freebsd/target_os_stack.h b/bsd-user/freebsd/target_os_stack.h
index d15fc3263f..6125208182 100644
--- a/bsd-user/freebsd/target_os_stack.h
+++ b/bsd-user/freebsd/target_os_stack.h
@@ -23,6 +23,7 @@
 #include <sys/param.h>
 #include "target_arch_sigtramp.h"
 #include "qemu/guest-random.h"
+#include "exec/user/tswap-target.h"
 
 /*
  * The initial FreeBSD stack is as follows:
diff --git a/bsd-user/netbsd/target_os_elf.h b/bsd-user/netbsd/target_os_elf.h
index 2f3cb20871..23b422bfce 100644
--- a/bsd-user/netbsd/target_os_elf.h
+++ b/bsd-user/netbsd/target_os_elf.h
@@ -22,6 +22,7 @@
 
 #include "target_arch_elf.h"
 #include "elf.h"
+#include "exec/user/tswap-target.h"
 
 /* this flag is uneffective under linux too, should be deleted */
 #ifndef MAP_DENYWRITE
diff --git a/bsd-user/openbsd/target_os_elf.h b/bsd-user/openbsd/target_os_elf.h
index 6dca9c5a85..fc1dfa2e49 100644
--- a/bsd-user/openbsd/target_os_elf.h
+++ b/bsd-user/openbsd/target_os_elf.h
@@ -22,6 +22,7 @@
 
 #include "target_arch_elf.h"
 #include "elf.h"
+#include "exec/user/tswap-target.h"
 
 /* this flag is uneffective under linux too, should be deleted */
 #ifndef MAP_DENYWRITE
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index b042d94892..95af418920 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -36,14 +36,6 @@
 #define BSWAP_NEEDED
 #endif
 
-#if TARGET_LONG_SIZE == 4
-#define tswapl(s) tswap32(s)
-#define bswaptls(s) bswap32s(s)
-#else
-#define tswapl(s) tswap64(s)
-#define bswaptls(s) bswap64s(s)
-#endif
-
 /* Target-endianness CPU memory access functions. These fit into the
  * {ld,st}{type}{sign}{size}{endian}_p naming scheme described in bswap.h.
  */
diff --git a/include/exec/user/abitypes.h b/include/exec/user/abitypes.h
index 6178453d94..ed10d5fe7e 100644
--- a/include/exec/user/abitypes.h
+++ b/include/exec/user/abitypes.h
@@ -2,6 +2,7 @@
 #define EXEC_USER_ABITYPES_H
 
 #include "cpu.h"
+#include "exec/user/tswap-target.h"
 
 #ifdef TARGET_ABI32
 #define TARGET_ABI_BITS 32
diff --git a/include/exec/user/tswap-target.h b/include/exec/user/tswap-target.h
new file mode 100644
index 0000000000..ff302436fe
--- /dev/null
+++ b/include/exec/user/tswap-target.h
@@ -0,0 +1,22 @@
+/*
+ * target-specific swap() definitions
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+#ifndef EXEC_USER_TSWAP_H
+#define EXEC_USER_TSWAP_H
+
+#include "exec/cpu-defs.h"
+#include "exec/tswap.h"
+
+#if TARGET_LONG_SIZE == 4
+#define tswapl(s) tswap32(s)
+#define bswaptls(s) bswap32s(s)
+#else
+#define tswapl(s) tswap64(s)
+#define bswaptls(s) bswap64s(s)
+#endif
+
+#endif
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index ca31470772..7b2d25230a 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu.h"
+#include "exec/user/tswap-target.h"
 #include "gdbstub/user.h"
 #include "signal-common.h"
 #include "trace.h"
diff --git a/bsd-user/strace.c b/bsd-user/strace.c
index 96499751eb..a1b738e63c 100644
--- a/bsd-user/strace.c
+++ b/bsd-user/strace.c
@@ -22,6 +22,7 @@
 #include <sys/ioccom.h>
 
 #include "qemu.h"
+#include "exec/user/tswap-target.h"
 
 #include "os-strace.h"  /* OS dependent strace print functions */
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index cf9e74468b..debea5c355 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -6,6 +6,7 @@
 #include <sys/shm.h>
 
 #include "qemu.h"
+#include "exec/user/tswap-target.h"
 #include "user-internals.h"
 #include "signal-common.h"
 #include "loader.h"
diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index bc5d45302e..eea1fa68c9 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -21,6 +21,7 @@
 #include "user-internals.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
+#include "exec/user/tswap-target.h"
 
 /* from the Linux kernel - /arch/x86/include/uapi/asm/sigcontext.h */
 
diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
index 7e7302823b..988b59a916 100644
--- a/linux-user/ppc/signal.c
+++ b/linux-user/ppc/signal.c
@@ -21,6 +21,7 @@
 #include "user-internals.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
+#include "exec/user/tswap-target.h"
 #include "vdso-asmoffset.h"
 
 /* See arch/powerpc/include/asm/ucontext.h.  Only used for 32-bit PPC;
-- 
2.41.0


