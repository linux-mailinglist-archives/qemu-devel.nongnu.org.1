Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A7F7AC22C
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 15:10:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qk2NR-0003hW-Ll; Sat, 23 Sep 2023 09:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qk2NN-0003fj-ET
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 09:08:49 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qk2NL-0004tt-B4
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 09:08:49 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4054496bde3so17512535e9.1
 for <qemu-devel@nongnu.org>; Sat, 23 Sep 2023 06:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695474525; x=1696079325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=al61xmvGriDTU3uPESirCxjFmobzSAR5hJ5kw9PaCFY=;
 b=GV96aseXotPltNaOLeCTlYiiSdRMwAEO7dl0kSqfNh6kFCAIGBu7JMHBHPjXjdTKgc
 aYyhs2rkGGwQTW5LMOE4xnG2koGtdin8F2w0uVABPrOayEa1KrbvsUb+RiOdUz3Eudp5
 8GgSdnd1deoh3O4L+7Adu4n0wOMwmc4+/NdzeKXaJGtMfhj0prRUyZ6mV04+bRCW8wPJ
 9+kdlojNjWTZykl8KDQyc6BRsOmbT+D+gstBkGycHxExCj1lD/Kb1DZ08wuQgcT3Z/Ln
 CKAfiNAeOri9+H5wRnxbxYBydpGgSR9QpuFz8gYLVZ73hQ9xQqMgJ3Dd5hsLmZBsQx9S
 XTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695474525; x=1696079325;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=al61xmvGriDTU3uPESirCxjFmobzSAR5hJ5kw9PaCFY=;
 b=C5Z5BWA9rkOjF8AROitM1hZiT4MwlkYBnCmapWv7YU1pbY/wALHflHLPJVF7lmKWHg
 XBUGAtCHqXjf26RfIxJ1DnHkDkLtaIlWuuZVZGK91z0bGYpDrOFOJDGe9teZoK1dx5Wi
 PNYeJywJIN5XqhfwtwN0fL+Dg4xVoW6boTuxElDGqIcDT8l4SFYo7Xzuj6uirzrJXSVt
 qEp74StJL7ET6ImWBrRb2jwvwJmOAoeeh6Xqo9CumD/wbE2gyrgXS1fUOxNGCBHPiSH9
 v6gU/QDb30LCzONJpOgSDccEjyo2gv3UBptsuo/Pcvu5uzrRn5WEgRvtn+PQin+mt6RW
 aA/A==
X-Gm-Message-State: AOJu0YxyFNI+nRvyV5wzPRJWNBj+zX5QT4Rdfi8hBEF1cK8uEEWUjlsM
 S4/TLEUQrNhitXhuHDaDo3UFSbMC+S/l608PNTw=
X-Google-Smtp-Source: AGHT+IH2l5SJftDfORvRI5Sne8/U1mrjyEDOVDVmz4Bo+V1IJHzbLa2sdwb9CnLw+S8/CRU/Da4CWA==
X-Received: by 2002:a05:600c:2198:b0:404:7659:ba39 with SMTP id
 e24-20020a05600c219800b004047659ba39mr1639794wme.16.1695474525518; 
 Sat, 23 Sep 2023 06:08:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f18-20020a5d58f2000000b00317b0155502sm6904230wrd.8.2023.09.23.06.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 06:08:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] tcg.h: Split out runtime-only functions into tcg/runtime.h
Date: Sat, 23 Sep 2023 14:08:43 +0100
Message-Id: <20230923130843.3708899-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The tcg/tcg.h header is mostly definitions that are needed only
by the translate-time code in the translate/$ARCH frontends
and the plugin infrastructure, or by the TCG code itself in
tcg/ and accel/tcg. However there are a few functions which
need to be called directly by code in linux-user and bsd-user.

Split those functions out into a separate header, so that
linux-user and bsd-user don't need to include this large
header which is mostly useless to them and which includes
some awkward things like a 'cpu_env' global that will be
shadowed if that name is used in runtime functions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 (1) I haven't tested that bsd-user compiles with this change
 (2) Suggestions for better naming welcome. I picked 'runtime.h'
     with a vague idea of splitting out the parts that are
     only of interest to the runtime framework from the parts
     that are translate-time or TCG-internal. We could perhaps
     move a few more functions and then be able to use only
     this header and not tcg/tcg.h in some or all of accel/tcg.
     Alternatively we could say it was purely for the benefit
     of the user-mode code and give it a suitable name.
---
 include/tcg/runtime.h | 51 +++++++++++++++++++++++++++++++++++++++++++
 include/tcg/tcg.h     |  6 +----
 bsd-user/main.c       |  2 +-
 linux-user/main.c     |  2 +-
 linux-user/syscall.c  |  2 +-
 5 files changed, 55 insertions(+), 8 deletions(-)
 create mode 100644 include/tcg/runtime.h

diff --git a/include/tcg/runtime.h b/include/tcg/runtime.h
new file mode 100644
index 00000000000..0170a871a53
--- /dev/null
+++ b/include/tcg/runtime.h
@@ -0,0 +1,51 @@
+/*
+ * Tiny Code Generator for QEMU: definitions used by runtime
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
+#ifndef TCG_RUNTIME_H
+#define TCG_RUNTIME_H
+
+typedef struct TCGContext TCGContext;
+
+extern __thread TCGContext *tcg_ctx;
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
+ * tcg_prologue_init(): generate the code for the TCG prologue
+ *
+ * In softmmu this is done automatically as part of the TCG
+ * accelerator's init_machine() method, but for user-mode, the
+ * user-mode code must call this function after it has loaded
+ * the guest binary and the value of guest_base is known.
+ */
+void tcg_prologue_init(TCGContext *s);
+
+#endif
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index c9c6d770d05..d2e9795ade0 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -35,6 +35,7 @@
 #include "tcg-target.h"
 #include "tcg/tcg-cond.h"
 #include "tcg/debug-assert.h"
+#include "tcg/runtime.h"
 
 /* XXX: make safe guess about sizes */
 #define MAX_OP_PER_INSTR 266
@@ -428,8 +429,6 @@ typedef struct TCGTemp {
     void *state_ptr;
 } TCGTemp;
 
-typedef struct TCGContext TCGContext;
-
 typedef struct TCGTempSet {
     unsigned long l[BITS_TO_LONGS(TCG_MAX_TEMPS)];
 } TCGTempSet;
@@ -574,7 +573,6 @@ static inline bool temp_readonly(TCGTemp *ts)
     return ts->kind >= TEMP_FIXED;
 }
 
-extern __thread TCGContext *tcg_ctx;
 extern const void *tcg_code_gen_epilogue;
 extern uintptr_t tcg_splitwx_diff;
 extern TCGv_env cpu_env;
@@ -784,8 +782,6 @@ static inline void *tcg_malloc(int size)
 }
 
 void tcg_init(size_t tb_size, int splitwx, unsigned max_cpus);
-void tcg_register_thread(void);
-void tcg_prologue_init(TCGContext *s);
 void tcg_func_start(TCGContext *s);
 
 int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start);
diff --git a/bsd-user/main.c b/bsd-user/main.c
index f913cb55a72..062870c131c 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -36,7 +36,7 @@
 #include "qemu/help_option.h"
 #include "qemu/module.h"
 #include "exec/exec-all.h"
-#include "tcg/tcg.h"
+#include "tcg/runtime.h"
 #include "qemu/timer.h"
 #include "qemu/envlist.h"
 #include "qemu/cutils.h"
diff --git a/linux-user/main.c b/linux-user/main.c
index 96be354897d..dc9b580b24b 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -41,7 +41,7 @@
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/user.h"
-#include "tcg/tcg.h"
+#include "tcg/runtime.h"
 #include "qemu/timer.h"
 #include "qemu/envlist.h"
 #include "qemu/guest-random.h"
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3521a2d70b0..8fd7f961459 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -23,6 +23,7 @@
 #include "qemu/memfd.h"
 #include "qemu/queue.h"
 #include "qemu/plugin.h"
+#include "tcg/runtime.h"
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
-- 
2.34.1


