Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A617B3DBE
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 05:12:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmQO3-0001YP-FJ; Fri, 29 Sep 2023 23:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmQO1-0001RX-8t
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 23:11:21 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmQNz-0000Cy-DZ
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 23:11:21 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2774f6943b1so8347097a91.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 20:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696043478; x=1696648278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=46MVV1VKXABFEFLwfHrZWuJeVOzvro/vOEjTS2Ume1E=;
 b=HbGu894bkZsCiXfdp2OE3ZtkT80zFebaglVquh+2VGBT/qz737WVGCT+y7JGTB7WLp
 q9+FrNxiSpSxPcDoYUnoXZPi9wUFUDGWoe5RiCuo0CuHSVuE0jhdz5dgfcILvEpvAZf2
 dyz4bbrm+5P2YhWoWWjZQOY63QisZ2J5Qj+IxpbqklC9fvPj6ZovmozPzRJ+QIQUJbyP
 01/U5DtkBv+eDkALxjrbqot5fU6Bwkf4gq0mwyHvtEtW8AYFglUic4Us2j6JVJlWcFFt
 NUcTHTb3wBD32AQHj0GJl0NceWL7FNhW8EecW4b0Xm4yhETGMVRuBgwKXECMsEBuLSu4
 HE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696043478; x=1696648278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=46MVV1VKXABFEFLwfHrZWuJeVOzvro/vOEjTS2Ume1E=;
 b=n/V0ot4dCFi9MacvkodcBMoJgfQaUYBto2Q7564cn3x1Wkz4ziagwpWniAl1bYNLwV
 f8tUtCBZX9S0OHZOVfZxGEnao+26kqrjTZVPIbA7fh1Tkr8o/wxF0tth1eLJWEH7t0wN
 wy/OKo1St/8z1dyNPB8h9swc5BhHrnVYrFH4NqmJQKXAm9kIZYd3V10timm57g6DsCV5
 vuEV8ZVtFkt6kZV99eItZZoeOBvEyllJwseoILpGkMEDAvTizMMdK7MZ8812wK2DQX2A
 mqAYe9nxlTmiP5Rja2rCMdCNNAiiQZSJMeMrZ3qlBHNWRJNQ8gh9LciqknCfNRihc05+
 zExA==
X-Gm-Message-State: AOJu0YwBnl6VSBcNAOXlkcgESLhqLKAbmC2Vus+7T2aJb7sJze741C39
 2CNLBWPvjLQbK21TqjLbxY/h1njKOhRy+M9r0UY=
X-Google-Smtp-Source: AGHT+IG2AN5e95CwhiKwGAkMbol31Pr7bFcW1QLUgzarOTksZ1ZVCo5Atl05sgG6ZJEvWe3q5V64mA==
X-Received: by 2002:a17:90a:688a:b0:268:13c4:b800 with SMTP id
 a10-20020a17090a688a00b0026813c4b800mr5923533pjd.21.1696043477874; 
 Fri, 29 Sep 2023 20:11:17 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 gp15-20020a17090adf0f00b002790ded9c6dsm2146821pjb.31.2023.09.29.20.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 20:11:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 2/2] tcg: Split out tcg init functions to tcg/startup.h
Date: Fri, 29 Sep 2023 20:11:14 -0700
Message-Id: <20230930031114.1042913-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930031114.1042913-1-richard.henderson@linaro.org>
References: <20230930031114.1042913-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

The tcg/tcg.h header is a big bucket, containing stuff related to
the translators and the JIT backend.  The places that initialize
tcg or create new threads do not need all of that, so split out
these three functions to a new header.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
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
index 44aced2ddd..3e45ee26fe 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -783,9 +783,6 @@ static inline void *tcg_malloc(int size)
     }
 }
 
-void tcg_init(size_t tb_size, int splitwx, unsigned max_cpus);
-void tcg_register_thread(void);
-void tcg_prologue_init(void);
 void tcg_func_start(TCGContext *s);
 
 int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start);
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 4b0dfb4be7..aed919d10b 100644
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
index 2d523289a8..7c530d3cda 100644
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
index d9d8dde202..a95c0bfe6d 100644
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
index dcdaf059bc..e72beaaa29 100644
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
index 66962e1d4a..b0501996c7 100644
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
index 4ec4f34b93..87006496a9 100644
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


