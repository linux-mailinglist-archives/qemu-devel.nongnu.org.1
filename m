Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BDD8239C7
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 01:47:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLBsC-0008Oq-PL; Wed, 03 Jan 2024 19:46:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBs5-0008Ku-0y
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:46:05 -0500
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBs1-0007Vm-G0
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:46:04 -0500
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7815c5b69e1so2065985a.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 16:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704329154; x=1704933954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQB2lgwP2js/xSv1GqDmwtPHGzLG+hXjo8NhOEF/18w=;
 b=J85drvvlWAdNrC19ZEnpueJTRZRvry+sMV/hfyfXF0qVy6h4pgumw6GbxA0dIkUJ0g
 oCheB+nvFvR52pQdp3Hhd/K0P43ZksP6pUNwgXRCZyNB55+8cpT0xgCACm+ja/+/vW7p
 xiQNADYJjRuQG3MLgcwzFBotafS9qJue+bSoE/z/oesDu8zIgcKJn56To0XmO7bSzDBA
 0f/SsVve3iFbYJSB37/YtL1C/wjqCCzTXTXDXzJVDFv/s74hu5b9CtLqZUHlxNEQ5gJS
 r0psZbPUjZyLn7FJKbgEF+tyiE6X1nQF4q1EHguA0eXOOqCO6rpPHuByCbpzYrXDR2rL
 XiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704329154; x=1704933954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IQB2lgwP2js/xSv1GqDmwtPHGzLG+hXjo8NhOEF/18w=;
 b=kg+cAiXDdu965RksDEdno8H/Qb6aplaOGz2SFqXBcE4HDYMpTF2FO22uzY39fTUWCa
 Fbm3MIMtd0uowwhUCsRQw0Dcx3CWSMTAnTSwyXmvocS/GhUzxL4TT1hPvVFnMxgwaW2p
 gC3hyqyyNP5r3dIIcUJOmdNlO1sn5AqFY+fEsitVKjEYacOI6MGNqbPgTriGxkKeXrIJ
 4E1C7X905jQ4lt3sSGWhAmI7EWM/b44x+8LBphWl/x2MJZnx615d9cBjrtbkCM/9HJGA
 ZA0xNfLuQ6UHQBfJwxWW5sTAQ1C3hjMf0ZN5GcDW+QO0L74MbUDjfUk1zBrDpD7sZYAY
 +Qzw==
X-Gm-Message-State: AOJu0Yz1fgzZLkuMreadLZ+ABK1GpKF6jW+00bGutrW1q17j/pSdSGyp
 /vKx0QXR+9UftH3De593p96bNWph0tGqtA==
X-Google-Smtp-Source: AGHT+IHMyD2AYF2cyEwAEeLbWfwp3e9TViq+TLNH9nD23lk7H89ByUFaeD5aRaPJ1egaY+ret8AJjg==
X-Received: by 2002:a05:620a:601c:b0:781:daa1:ff74 with SMTP id
 dw28-20020a05620a601c00b00781daa1ff74mr4804751qkb.116.1704329154278; 
 Wed, 03 Jan 2024 16:45:54 -0800 (PST)
Received: from n231-230-216.byted.org ([147.160.184.87])
 by smtp.gmail.com with ESMTPSA id
 x19-20020ae9f813000000b0077d66e5b2e6sm10646087qkh.3.2024.01.03.16.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 16:45:53 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v3 19/20] util/dsa: Add unit test coverage for Intel DSA task
 submission and completion.
Date: Thu,  4 Jan 2024 00:44:51 +0000
Message-Id: <20240104004452.324068-20-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240104004452.324068-1-hao.xiang@bytedance.com>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x72f.google.com
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

* Test DSA start and stop path.
* Test DSA configure and cleanup path.
* Test DSA task submission and completion path.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 tests/unit/meson.build |   6 +
 tests/unit/test-dsa.c  | 475 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 481 insertions(+)
 create mode 100644 tests/unit/test-dsa.c

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index a05d471090..72e22063dc 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -54,6 +54,12 @@ tests = {
   'test-virtio-dmabuf': [meson.project_source_root() / 'hw/display/virtio-dmabuf.c'],
 }
 
+if config_host_data.get('CONFIG_DSA_OPT')
+  tests += {
+    'test-dsa': [],
+  }
+endif
+
 if have_system or have_tools
   tests += {
     'test-qmp-event': [testqapi],
diff --git a/tests/unit/test-dsa.c b/tests/unit/test-dsa.c
new file mode 100644
index 0000000000..a3eeb4702a
--- /dev/null
+++ b/tests/unit/test-dsa.c
@@ -0,0 +1,475 @@
+/*
+ * Test DSA functions.
+ *
+ * Copyright (c) 2023 Hao Xiang <hao.xiang@bytedance.com>
+ * Copyright (c) 2023 Bryan Zhang <bryan.zhang@bytedance.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "qemu/osdep.h"
+#include "qemu/host-utils.h"
+
+#include "qemu/cutils.h"
+#include "qemu/memalign.h"
+#include "qemu/dsa.h"
+
+/* TODO Make these not-hardcoded. */
+static const char *path1 = "/dev/dsa/wq4.0";
+static const char *path2 = "/dev/dsa/wq4.0 /dev/dsa/wq4.1";
+static const int num_devices = 2;
+
+static struct batch_task task __attribute__((aligned(64)));
+
+/*
+ * TODO Communicate that DSA must be configured to support this batch size.
+ * TODO Alternatively, poke the DSA device to figure out batch size.
+ */
+static int batch_size = 128;
+static int page_size = 4096;
+
+/* A helper for running a single task and checking for correctness. */
+static void do_single_task(void)
+{
+    batch_task_init(&task, batch_size);
+    char buf[page_size];
+    char *ptr = buf;
+
+    buffer_is_zero_dsa_batch_async(&task,
+                                   (const void **)&ptr,
+                                   1,
+                                   page_size);
+    g_assert(task.results[0] == buffer_is_zero(buf, page_size));
+}
+
+static void test_single_zero(void)
+{
+    g_assert(!dsa_init(path1));
+    dsa_start();
+
+    batch_task_init(&task, batch_size);
+
+    char buf[page_size];
+    char *ptr = buf;
+
+    memset(buf, 0x0, page_size);
+    buffer_is_zero_dsa_batch_async(&task,
+                                   (const void **)&ptr,
+                                   1, page_size);
+    g_assert(task.results[0]);
+
+    dsa_cleanup();
+}
+
+static void test_single_zero_async(void)
+{
+    test_single_zero();
+}
+
+static void test_single_nonzero(void)
+{
+    g_assert(!dsa_init(path1));
+    dsa_start();
+
+    batch_task_init(&task, batch_size);
+
+    char buf[page_size];
+    char *ptr = buf;
+
+    memset(buf, 0x1, page_size);
+    buffer_is_zero_dsa_batch_async(&task,
+                                   (const void **)&ptr,
+                                   1, page_size);
+    g_assert(!task.results[0]);
+
+    dsa_cleanup();
+}
+
+static void test_single_nonzero_async(void)
+{
+    test_single_nonzero();
+}
+
+/* count == 0 should return quickly without calling into DSA. */
+static void test_zero_count_async(void)
+{
+    char buf[page_size];
+    buffer_is_zero_dsa_batch_async(&task,
+                             (const void **)&buf,
+                             0,
+                             page_size);
+}
+
+static void test_null_task_async(void)
+{
+    if (g_test_subprocess()) {
+        g_assert(!dsa_init(path1));
+
+        char buf[page_size * batch_size];
+        char *addrs[batch_size];
+        for (int i = 0; i < batch_size; i++) {
+            addrs[i] = buf + (page_size * i);
+        }
+
+        buffer_is_zero_dsa_batch_async(NULL, (const void **)addrs,
+                                      batch_size,
+                                      page_size);
+    } else {
+        g_test_trap_subprocess(NULL, 0, 0);
+        g_test_trap_assert_failed();
+    }
+}
+
+static void test_oversized_batch(void)
+{
+    g_assert(!dsa_init(path1));
+    dsa_start();
+
+    batch_task_init(&task, batch_size);
+
+    int oversized_batch_size = batch_size + 1;
+    char buf[page_size * oversized_batch_size];
+    char *addrs[batch_size];
+    for (int i = 0; i < oversized_batch_size; i++) {
+        addrs[i] = buf + (page_size * i);
+    }
+
+    int ret = buffer_is_zero_dsa_batch_async(&task,
+                                            (const void **)addrs,
+                                            oversized_batch_size,
+                                            page_size);
+    g_assert(ret != 0);
+
+    dsa_cleanup();
+}
+
+static void test_oversized_batch_async(void)
+{
+    test_oversized_batch();
+}
+
+static void test_zero_len_async(void)
+{
+    if (g_test_subprocess()) {
+        g_assert(!dsa_init(path1));
+
+        batch_task_init(&task, batch_size);
+
+        char buf[page_size];
+
+        buffer_is_zero_dsa_batch_async(&task,
+                                       (const void **)&buf,
+                                       1,
+                                       0);
+    } else {
+        g_test_trap_subprocess(NULL, 0, 0);
+        g_test_trap_assert_failed();
+    }
+}
+
+static void test_null_buf_async(void)
+{
+    if (g_test_subprocess()) {
+        g_assert(!dsa_init(path1));
+
+        batch_task_init(&task, batch_size);
+
+        buffer_is_zero_dsa_batch_async(&task, NULL, 1, page_size);
+    } else {
+        g_test_trap_subprocess(NULL, 0, 0);
+        g_test_trap_assert_failed();
+    }
+}
+
+static void test_batch(void)
+{
+    g_assert(!dsa_init(path1));
+    dsa_start();
+
+    batch_task_init(&task, batch_size);
+
+    char buf[page_size * batch_size];
+    char *addrs[batch_size];
+    for (int i = 0; i < batch_size; i++) {
+        addrs[i] = buf + (page_size * i);
+    }
+
+    /*
+     * Using whatever is on the stack is somewhat random.
+     * Manually set some pages to zero and some to nonzero.
+     */
+    memset(buf + 0, 0, page_size * 10);
+    memset(buf + (10 * page_size), 0xff, page_size * 10);
+
+    buffer_is_zero_dsa_batch_async(&task,
+                                   (const void **)addrs,
+                                   batch_size,
+                                   page_size);
+
+    bool is_zero;
+    for (int i = 0; i < batch_size; i++) {
+        is_zero = buffer_is_zero((const void *)&buf[page_size * i], page_size);
+        g_assert(task.results[i] == is_zero);
+    }
+    dsa_cleanup();
+}
+
+static void test_batch_async(void)
+{
+    test_batch();
+}
+
+static void test_page_fault(void)
+{
+    g_assert(!dsa_init(path1));
+    dsa_start();
+
+    char *buf[2];
+    int prot = PROT_READ | PROT_WRITE;
+    int flags = MAP_SHARED | MAP_ANON;
+    buf[0] = (char *)mmap(NULL, page_size * batch_size, prot, flags, -1, 0);
+    assert(buf[0] != MAP_FAILED);
+    buf[1] = (char *)malloc(page_size * batch_size);
+    assert(buf[1] != NULL);
+
+    for (int j = 0; j < 2; j++) {
+        batch_task_init(&task, batch_size);
+
+        char *addrs[batch_size];
+        for (int i = 0; i < batch_size; i++) {
+            addrs[i] = buf[j] + (page_size * i);
+        }
+
+        buffer_is_zero_dsa_batch_async(&task,
+                                       (const void **)addrs,
+                                       batch_size,
+                                       page_size);
+
+        bool is_zero;
+        for (int i = 0; i < batch_size; i++) {
+            is_zero = buffer_is_zero((const void *)&buf[j][page_size * i],
+                                      page_size);
+            g_assert(task.results[i] == is_zero);
+        }
+    }
+
+    assert(!munmap(buf[0], page_size * batch_size));
+    free(buf[1]);
+    dsa_cleanup();
+}
+
+static void test_various_buffer_sizes(void)
+{
+    g_assert(!dsa_init(path1));
+    dsa_start();
+
+    int len = 1 << 4;
+    for (int count = 12; count > 0; count--, len <<= 1) {
+        batch_task_init(&task, batch_size);
+
+        char buf[len * batch_size];
+        char *addrs[batch_size];
+        for (int i = 0; i < batch_size; i++) {
+            addrs[i] = buf + (len * i);
+        }
+
+        buffer_is_zero_dsa_batch_async(&task,
+                                       (const void **)addrs,
+                                       batch_size,
+                                       len);
+
+        bool is_zero;
+        for (int j = 0; j < batch_size; j++) {
+            is_zero = buffer_is_zero((const void *)&buf[len * j], len);
+            g_assert(task.results[j] == is_zero);
+        }
+    }
+
+    dsa_cleanup();
+}
+
+static void test_various_buffer_sizes_async(void)
+{
+    test_various_buffer_sizes();
+}
+
+static void test_double_start_stop(void)
+{
+    g_assert(!dsa_init(path1));
+    /* Double start */
+    dsa_start();
+    dsa_start();
+    g_assert(dsa_is_running());
+    do_single_task();
+
+    /* Double stop */
+    dsa_stop();
+    g_assert(!dsa_is_running());
+    dsa_stop();
+    g_assert(!dsa_is_running());
+
+    /* Restart */
+    dsa_start();
+    g_assert(dsa_is_running());
+    do_single_task();
+    dsa_cleanup();
+}
+
+static void test_is_running(void)
+{
+    g_assert(!dsa_init(path1));
+
+    g_assert(!dsa_is_running());
+    dsa_start();
+    g_assert(dsa_is_running());
+    dsa_stop();
+    g_assert(!dsa_is_running());
+    dsa_cleanup();
+}
+
+static void test_multiple_engines(void)
+{
+    g_assert(!dsa_init(path2));
+    dsa_start();
+
+    struct batch_task tasks[num_devices]
+        __attribute__((aligned(64)));
+    char bufs[num_devices][page_size * batch_size];
+    char *addrs[num_devices][batch_size];
+
+    /*
+     *  This is a somewhat implementation-specific way
+     *  of testing that the tasks have unique engines
+     *  assigned to them.
+     */
+    batch_task_init(&tasks[0], batch_size);
+    batch_task_init(&tasks[1], batch_size);
+    g_assert(tasks[0].dsa_batch->device != tasks[1].dsa_batch->device);
+
+    for (int i = 0; i < num_devices; i++) {
+        for (int j = 0; j < batch_size; j++) {
+            addrs[i][j] = bufs[i] + (page_size * j);
+        }
+
+        buffer_is_zero_dsa_batch_async(&tasks[i],
+                                       (const void **)addrs[i],
+                                       batch_size, page_size);
+
+        bool is_zero;
+        for (int j = 0; j < batch_size; j++) {
+            is_zero = buffer_is_zero((const void *)&bufs[i][page_size * j],
+                                     page_size);
+            g_assert(tasks[i].results[j] == is_zero);
+        }
+    }
+
+    dsa_cleanup();
+}
+
+static void test_configure_dsa_twice(void)
+{
+    g_assert(!dsa_init(path2));
+    g_assert(!dsa_init(path2));
+    dsa_start();
+    do_single_task();
+    dsa_cleanup();
+}
+
+static void test_configure_dsa_bad_path(void)
+{
+    const char *bad_path = "/not/a/real/path";
+    g_assert(dsa_init(bad_path));
+}
+
+static void test_cleanup_before_configure(void)
+{
+    dsa_cleanup();
+    g_assert(!dsa_init(path2));
+}
+
+static void test_configure_dsa_num_devices(void)
+{
+    g_assert(!dsa_init(path1));
+    dsa_start();
+
+    do_single_task();
+    dsa_stop();
+    dsa_cleanup();
+}
+
+static void test_cleanup_twice(void)
+{
+    g_assert(!dsa_init(path2));
+    dsa_cleanup();
+    dsa_cleanup();
+
+    g_assert(!dsa_init(path2));
+    dsa_start();
+    do_single_task();
+    dsa_cleanup();
+}
+
+static int check_test_setup(void)
+{
+    const char *path[2] = {path1, path2};
+    for (int i = 0; i < sizeof(path) / sizeof(char *); i++) {
+        if (dsa_init(path[i])) {
+            return -1;
+        }
+        dsa_cleanup();
+    }
+    return 0;
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    if (check_test_setup() != 0) {
+        /*
+         * This test requires extra setup. The current
+         * setup is not correct. Just skip this test
+         * for now.
+         */
+        exit(0);
+    }
+
+    if (num_devices > 1) {
+        g_test_add_func("/dsa/multiple_engines", test_multiple_engines);
+    }
+
+    g_test_add_func("/dsa/async/batch", test_batch_async);
+    g_test_add_func("/dsa/async/various_buffer_sizes",
+                    test_various_buffer_sizes_async);
+    g_test_add_func("/dsa/async/null_buf", test_null_buf_async);
+    g_test_add_func("/dsa/async/zero_len", test_zero_len_async);
+    g_test_add_func("/dsa/async/oversized_batch", test_oversized_batch_async);
+    g_test_add_func("/dsa/async/zero_count", test_zero_count_async);
+    g_test_add_func("/dsa/async/single_zero", test_single_zero_async);
+    g_test_add_func("/dsa/async/single_nonzero", test_single_nonzero_async);
+    g_test_add_func("/dsa/async/null_task", test_null_task_async);
+    g_test_add_func("/dsa/async/page_fault", test_page_fault);
+
+    g_test_add_func("/dsa/double_start_stop", test_double_start_stop);
+    g_test_add_func("/dsa/is_running", test_is_running);
+
+    g_test_add_func("/dsa/configure_dsa_twice", test_configure_dsa_twice);
+    g_test_add_func("/dsa/configure_dsa_bad_path", test_configure_dsa_bad_path);
+    g_test_add_func("/dsa/cleanup_before_configure",
+                    test_cleanup_before_configure);
+    g_test_add_func("/dsa/configure_dsa_num_devices",
+                    test_configure_dsa_num_devices);
+    g_test_add_func("/dsa/cleanup_twice", test_cleanup_twice);
+
+    return g_test_run();
+}
-- 
2.30.2


