Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6647B7013
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:41:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjJP-0000W8-Rw; Tue, 03 Oct 2023 13:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjIG-0000Aw-MG
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:34:52 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjIA-0007sV-Rl
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:34:48 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c723f1c80fso9115835ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354481; x=1696959281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LhFHtaeZzNwW239DZCUYt9Mt22FPGgmmAFPDcZ1Pe8A=;
 b=phEx+EFfvb5FQNnaJK4e8SuQr9HQjfU1G7RPsIHHBFYH4UBqcAqE1TNQC4D4rJaIOC
 wcO+8rQO1gxtrMSqZvk0JeZh1bo9llCpBiQ6/jikUbWQ4myux47Cg8IS3UdtJ9o+IJOc
 FgvWs6MzR/9OYM1JsjpAT1TK3SqCWGrzudq4Gsoe/MVWeY5asPbWEsadF9kIDOf7Rxe0
 wp8STBS5uAdFbRRM/8yGHshvvjMQGYTwtfBJwy4EpITN1fI9fLWqYjkujrtedpg31g5c
 ZRYwdHxoNXFaoC+igbjnvLi3ssVvG7WD6ZiZmbrdQCJdUwmfHzCNiHM/bnv1L9v2O1hq
 Dv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354481; x=1696959281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LhFHtaeZzNwW239DZCUYt9Mt22FPGgmmAFPDcZ1Pe8A=;
 b=DVxhZk91QZ4AqfjY+sy5MzZ4yzd3ON8FxicDlr4/tAjxb+WgIl3yxdzxeDkk6iom3u
 Iio0vTh+b2FFivY4dkeesZSQr3l2V/JXrUvukbMvnvTTYK5bGL2a+EbJSVsoOAB1RXRq
 BAWevCiYbU60781xkzYFV0UfqxEpEsijEnLtkDlEJaDG5l4mnSLtfNjh73owmxctGQmc
 0g/HsH6hPDLEMw7x8oUIcp9ORx5ZADFZ5cuzm4pPYKLUq3wto6BbvUDYAFTQuPA2k964
 8Pq/ufI0571aVQU9W0K2shlLDo6HOXwC8KruAB8eXDvPdofubjqy1IRCG+P/G9KOOJiA
 pT8w==
X-Gm-Message-State: AOJu0Ywsv0Zz0aNInN/2xTehtnWBmyxQ8WKE7aSIIqG1KwwWjkHBt9k9
 798i4wgxP7A8kCRjaVt5VxkC7sh9GfZoQRQHliI=
X-Google-Smtp-Source: AGHT+IEVhLPX1VizYhC0PqU1Su/EOpdFuecOvD4LrfQNpaEw7QFLtLW1BdUpu3gNhTLSsE5mrQly1Q==
X-Received: by 2002:a17:902:da90:b0:1c6:de7:addd with SMTP id
 j16-20020a170902da9000b001c60de7adddmr270959plx.48.1696354481532; 
 Tue, 03 Oct 2023 10:34:41 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 y9-20020a17090322c900b001bc676df6a9sm1855118plg.132.2023.10.03.10.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:34:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 43/47] tcg: Split out tcg init functions to tcg/startup.h
Date: Tue,  3 Oct 2023 10:30:48 -0700
Message-Id: <20231003173052.1601813-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The tcg/tcg.h header is a big bucket, containing stuff related to
the translators and the JIT backend.  The places that initialize
tcg or create new threads do not need all of that, so split out
these three functions to a new header.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/startup.h           | 58 +++++++++++++++++++++++++++++++++
 include/tcg/tcg.h               |  3 --
 accel/tcg/tcg-accel-ops-mttcg.c |  2 +-
 accel/tcg/tcg-accel-ops-rr.c    |  2 +-
 accel/tcg/tcg-all.c             |  2 +-
 bsd-user/main.c                 |  2 +-
 linux-user/main.c               |  2 +-
 linux-user/syscall.c            |  2 +-
 tcg/tcg.c                       |  1 +
 9 files changed, 65 insertions(+), 9 deletions(-)
 create mode 100644 include/tcg/startup.h

diff --git a/include/tcg/startup.h b/include/tcg/startup.h
new file mode 100644
index 0000000000..f71305765c
--- /dev/null
+++ b/include/tcg/startup.h
@@ -0,0 +1,58 @@
+/*
+ * Tiny Code Generator for QEMU: definitions used by runtime startup
+ *
+ * Copyright (c) 2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef TCG_STARTUP_H
+#define TCG_STARTUP_H
+
+/**
+ * tcg_init: Initialize the TCG runtime
+ * @tb_size: translation buffer size
+ * @splitwx: use separate rw and rx mappings
+ * @max_cpus: number of vcpus in system mode
+ *
+ * Allocate and initialize TCG resources, especially the JIT buffer.
+ * In user-only mode, @max_cpus is unused.
+ */
+void tcg_init(size_t tb_size, int splitwx, unsigned max_cpus);
+
+/**
+ * tcg_register_thread: Register this thread with the TCG runtime
+ *
+ * All TCG threads except the parent (i.e. the one that called the TCG
+ * accelerator's init_machine() method) must register with this
+ * function before initiating translation.
+ */
+void tcg_register_thread(void);
+
+/**
+ * tcg_prologue_init(): Generate the code for the TCG prologue
+ *
+ * In softmmu this is done automatically as part of the TCG
+ * accelerator's init_machine() method, but for user-mode, the
+ * user-mode code must call this function after it has loaded
+ * the guest binary and the value of guest_base is known.
+ */
+void tcg_prologue_init(void);
+
+#endif
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 2e2d12d421..680ff00722 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -782,9 +782,6 @@ static inline void *tcg_malloc(int size)
     }
 }
 
-void tcg_init(size_t tb_size, int splitwx, unsigned max_cpus);
-void tcg_register_thread(void);
-void tcg_prologue_init(void);
 void tcg_func_start(TCGContext *s);
 
 int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start);
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index ae95ba419e..fac80095bb 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -32,7 +32,7 @@
 #include "qemu/guest-random.h"
 #include "exec/exec-all.h"
 #include "hw/boards.h"
-#include "tcg/tcg.h"
+#include "tcg/startup.h"
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-mttcg.h"
 
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 671a3c4ca0..611932f3c3 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -32,7 +32,7 @@
 #include "qemu/notify.h"
 #include "qemu/guest-random.h"
 #include "exec/exec-all.h"
-#include "tcg/tcg.h"
+#include "tcg/startup.h"
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-rr.h"
 #include "tcg-accel-ops-icount.h"
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index a81400d3ee..c6619f5b98 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -27,7 +27,7 @@
 #include "sysemu/tcg.h"
 #include "exec/replay-core.h"
 #include "sysemu/cpu-timers.h"
-#include "tcg/tcg.h"
+#include "tcg/startup.h"
 #include "tcg/oversized-guest.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 7ad406903a..703f3e2c41 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -36,7 +36,7 @@
 #include "qemu/help_option.h"
 #include "qemu/module.h"
 #include "exec/exec-all.h"
-#include "tcg/tcg.h"
+#include "tcg/startup.h"
 #include "qemu/timer.h"
 #include "qemu/envlist.h"
 #include "qemu/cutils.h"
diff --git a/linux-user/main.c b/linux-user/main.c
index eb66ddec11..0c23584a96 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -41,7 +41,7 @@
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/user.h"
-#include "tcg/tcg.h"
+#include "tcg/startup.h"
 #include "qemu/timer.h"
 #include "qemu/envlist.h"
 #include "qemu/guest-random.h"
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3521a2d70b..c6ffadd082 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -23,6 +23,7 @@
 #include "qemu/memfd.h"
 #include "qemu/queue.h"
 #include "qemu/plugin.h"
+#include "tcg/startup.h"
 #include "target_mman.h"
 #include <elf.h>
 #include <endian.h>
@@ -141,7 +142,6 @@
 #include "special-errno.h"
 #include "qapi/error.h"
 #include "fd-trans.h"
-#include "tcg/tcg.h"
 #include "cpu_loop-common.h"
 
 #ifndef CLONE_IO
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e37e5a3b5d..f664cf1484 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -36,6 +36,7 @@
 #include "qemu/timer.h"
 #include "exec/translation-block.h"
 #include "exec/tlb-common.h"
+#include "tcg/startup.h"
 #include "tcg/tcg-op-common.h"
 
 #if UINTPTR_MAX == UINT32_MAX
-- 
2.34.1


