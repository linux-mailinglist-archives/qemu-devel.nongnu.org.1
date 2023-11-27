Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F357F98A1
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 06:23:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7U4U-0004T2-Bv; Mon, 27 Nov 2023 00:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1r7U4Q-0004So-6V
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 00:22:10 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1r7U4N-0008BT-7C
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 00:22:09 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6cbda959062so3186424b3a.1
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 21:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701062525; x=1701667325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/qrtP7sSfrEUApSD9rVL4Ayre6N/0rnGZosMCQPlDJ4=;
 b=ys4ZIn6sU9h8vUIG4Dg+b1+Xd7BQI3LIMFQkDdL78BpP6AAGqny0tCztuS4m3A8Otb
 zwF2lLd3gcXIEHZOfkbQMQfH+AolN8IgpyB2aMreHBl5PTc+H2giLGp2xNIpdpu5EDZP
 TVKXHsLTPiDk6/1wFJaFoO2lxA917y7YDw1fFYQTjH5z+2CVpn2kJ+R2tL0iPPLYVwtR
 EplK6SQIJoQJWcYiao+GI+RXF5p9O0C6UFTSfAK/cs1joUo/Api54uNpH7hxPN2BBDk1
 xIolke+od981fngQInSznVdVKGK6ZL9cP4feq5iJfReCkV9Q/hEiFCPtag/U14wOH9A4
 YzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701062525; x=1701667325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/qrtP7sSfrEUApSD9rVL4Ayre6N/0rnGZosMCQPlDJ4=;
 b=w2OdXiE6tVpuTYgUIkpf5uQ96BKncdKYMzc+qlKzsJMQL+LMXoQuvFajN+0T2i1HbT
 jmbIwalJWShOQEQEqhFC3WLnzjnKqBgyY9ThpfowrhW5JkPgj2vbfyAUeYLfE5Yd8RI4
 zAZM6xoyAn1V8f2137jGwMVstS3odil9KPgr9YVJdODvuCBmmM5pHxNidJoewboh8cXU
 eq4dlqQ2fgOeG/2uT8CJ7Kb7uQwYOdm5elFEcgiJcJgdR3Q2qmYfEyJY4oFl4/H9aVkk
 zRNW24s/6uGO0aoHTpbry1JA2t4Y9MJ1l7lyKKZptkrH5DI8H8MuJzc9x40ppmayLLw5
 kJiw==
X-Gm-Message-State: AOJu0YwzNBFF7ix4Se2E+1uamdaj2Zmh4x9/m0O94XUgmyyeVsSFArK7
 TFh7WQdJfINGzY3zuP51ugxe8mNNLRnXeZcvu5Lic3MU
X-Google-Smtp-Source: AGHT+IEG61OU1PAzpK47lBZ3EsdKXPYIO2Ty4+TEtxXX12gpkvEBAVK5PivvUQO/NpcksWKNCoywHw==
X-Received: by 2002:a05:6a00:1483:b0:6cb:6c9b:8892 with SMTP id
 v3-20020a056a00148300b006cb6c9b8892mr12541721pfu.29.1701062525527; 
 Sun, 26 Nov 2023 21:22:05 -0800 (PST)
Received: from amd.. ([2804:7f0:b402:7782:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 v13-20020aa7808d000000b006cb9f436232sm6392316pff.114.2023.11.26.21.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Nov 2023 21:22:05 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: thuth@redhat.com,
	gustavo.romero@linaro.org
Subject: [PATCH 3/4] tests/qtest: Add ivshmem-flat test
Date: Mon, 27 Nov 2023 05:20:23 +0000
Message-Id: <20231127052024.435743-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127052024.435743-1-gustavo.romero@linaro.org>
References: <20231127052024.435743-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x431.google.com
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

Add qtest for the ivshmem-flat device.

Based-on: <20231113230149.321304-1-gustavo.romero@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/qtest/ivshmem-flat-test.c | 319 ++++++++++++++++++++++++++++++++
 tests/qtest/meson.build         |   2 +
 2 files changed, 321 insertions(+)
 create mode 100644 tests/qtest/ivshmem-flat-test.c

diff --git a/tests/qtest/ivshmem-flat-test.c b/tests/qtest/ivshmem-flat-test.c
new file mode 100644
index 0000000000..7a4547637c
--- /dev/null
+++ b/tests/qtest/ivshmem-flat-test.c
@@ -0,0 +1,319 @@
+/*
+ * Inter-VM Shared Memory Flat Device qtests
+ *
+ * SPDX-FileCopyrightText: 2023 Linaro Ltd.
+ * SPDX-FileContributor: Gustavo Romero <gustavo.romero@linaro.org>
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "ivshmem-utils.h"
+
+#define IVSHMEM_FLAT_MMR_ADDR 0x400FF000
+#define IVSHMEM_FLAT_SHM_ADDR 0x40100000
+#define SHM_SIZE 131072 /* 128k */
+
+static ServerThread thread;
+
+uint32_t *shm_ptr;
+char *shm_rel_path;
+char *server_socket_path;
+
+static void cleanup(void)
+{
+    if (shm_ptr) {
+        munmap(shm_ptr, SHM_SIZE);
+        shm_ptr = NULL;
+    }
+
+    if (shm_rel_path) {
+        shm_unlink(shm_rel_path);
+        shm_rel_path = NULL;
+    }
+
+    if (server_socket_path) {
+        unlink(server_socket_path);
+        server_socket_path = NULL;
+    }
+}
+
+static void abort_handler(void *data)
+{
+    test_ivshmem_server_stop(&thread);
+    cleanup();
+}
+
+/*
+ * Check if exactly 1 positive pulse (low->high->low) on 'irq' IRQ line happens
+ * in 'timeout' second(s). 'irq' must be intercepted using qtest_irq_intercept_*
+ * before this function can be used on it. It returns 0 when pulse is detected,
+ * otherwise 1.
+ */
+static int test_ivshmem_flat_irq_positive_pulse(QTestState *qts, int irq,
+                                                int timeout)
+{
+    uint64_t num_raises = 0;
+    uint64_t num_lows = 0;
+    uint64_t end_time;
+
+    end_time = g_get_monotonic_time() + timeout * G_TIME_SPAN_SECOND;
+    do {
+        if ((num_raises = qtest_get_irq_raised_counter(qts, 0))) {
+            num_lows = qtest_get_irq_lowered_counter(qts, 0);
+            /* Check for 1 raise and 1 low IRQ event. */
+            if (num_raises == num_lows && num_lows == 1) {
+                return 0;
+            } else {
+                g_message("%s: Timeout expired", __func__);
+                return 1;
+            }
+        }
+        qtest_clock_step(qts, 10000);
+    } while (g_get_monotonic_time() < end_time);
+
+    return 1;
+}
+
+static inline uint32_t read_reg(QTestState *qts, enum Reg reg)
+{
+    uint32_t v;
+
+    qtest_memread(qts, IVSHMEM_FLAT_MMR_ADDR + reg, &v, sizeof(v));
+
+    return v;
+}
+
+static inline void write_reg(QTestState *qts, enum Reg reg, uint32_t v)
+{
+    qtest_memwrite(qts, IVSHMEM_FLAT_MMR_ADDR + reg, &v, sizeof(v));
+}
+
+/*
+ * Setup a test VM with ivshmem-flat device attached, IRQ properly set, and
+ * connected to the ivshmem-server.
+ */
+static QTestState *setup_vm(void)
+{
+    QTestState *qts;
+    const char *cmd_line;
+
+    cmd_line = g_strdup_printf("-machine lm3s6965evb "
+                               "-chardev socket,path=%s,id=ivshm "
+                               "-device ivshmem-flat,chardev=ivshm,"
+                               "x-irq-qompath='/machine/unattached/device[1]/nvic/unnamed-gpio-in[0]',"
+                               "x-bus-qompath='/sysbus',shmem-size=%d",
+                               server_socket_path, SHM_SIZE);
+    qts = qtest_init(cmd_line);
+
+    return qts;
+}
+
+static void test_ivshmem_flat_irq(void)
+{
+    QTestState *vm_state;
+    uint16_t own_id;
+
+    vm_state = setup_vm();
+
+    qtest_irq_intercept_out_named(vm_state,
+                                  "/machine/peripheral-anon/device[0]",
+                                  "irq-output");
+
+    /* IVPOSTION has the device's own ID distributed by the ivshmem-server. */
+    own_id = read_reg(vm_state, IVPOSITION);
+
+    /* Make device notify itself. */
+    write_reg(vm_state, DOORBELL, (own_id << 16) | 0 /* vector 0 */);
+
+    /*
+     * Check intercepted device's IRQ output line. Named IRQ line 'irq-output'
+     * was associated to qtest IRQ 0 and after self notification qtest IRQ 0
+     * must be toggled by the device. The test fails if no toggling is detected
+     * in 2 seconds.
+     */
+    g_assert(test_ivshmem_flat_irq_positive_pulse(vm_state, 0, 2) == 0);
+
+    qtest_quit(vm_state);
+}
+
+static void test_ivshmem_flat_shm_write(void)
+{
+    QTestState *vm_state;
+    int num_elements, i;
+    uint32_t  *data;
+
+    vm_state = setup_vm();
+
+    /* Prepare test data with random values. */
+    data = g_malloc(SHM_SIZE);
+    num_elements = SHM_SIZE/sizeof(*data);
+    for (i = 0; i < num_elements; i++) {
+        data[i] = g_test_rand_int();
+    }
+
+    /*
+     * Write test data to VM address IVSHMEM_FLAT_SHM_ADDR, where the shared
+     * memory region is located.
+     */
+    qtest_memwrite(vm_state, IVSHMEM_FLAT_SHM_ADDR, data, SHM_SIZE);
+
+    /*
+     * Since the shared memory fd is mmapped into this test process VMA at
+     * shm_ptr, every byte written by the VM in its shared memory region should
+     * also be available in the test process via shm_ptr. Thus, data in shm_ptr
+     * is compared back against the original test data.
+     */
+    for (i = 0; i < num_elements; i++) {
+        g_assert_cmpint(shm_ptr[i], ==, data[i]);
+    }
+
+    qtest_quit(vm_state);
+}
+
+static void test_ivshmem_flat_shm_read(void)
+{
+    QTestState *vm_state;
+    int num_elements, i;
+    uint32_t  *data;
+    uint32_t v;
+
+    vm_state = setup_vm();
+
+    /* Prepare test data with random values. */
+    data = g_malloc(SHM_SIZE);
+    num_elements = SHM_SIZE/sizeof(*data);
+    for (i = 0; i < num_elements; i++) {
+        data[i] = g_test_rand_int();
+    }
+
+    /*
+     * Copy test data to the shared memory region so it can be read from the VM
+     * (IVSHMEM_FLAT_SHM_ADDR location).
+     */
+    memcpy(shm_ptr, data, SHM_SIZE);
+
+    /* Check data */
+    for (i = 0; i < num_elements; i++) {
+        qtest_memread(vm_state, IVSHMEM_FLAT_SHM_ADDR + i * sizeof(v), &v,
+                      sizeof(v));
+        g_assert_cmpint(v, ==, data[i]);
+    }
+
+    qtest_quit(vm_state);
+}
+
+static void test_ivshmem_flat_shm_pair(void)
+{
+    QTestState *vm0_state, *vm1_state;
+    uint16_t vm0_peer_id, vm1_peer_id;
+    int num_elements, i;
+    uint32_t  *data;
+    uint32_t v;
+
+    vm0_state = setup_vm();
+    vm1_state = setup_vm();
+
+    /* Get peer ID for the VM so it can be used for one notify each other. */
+    vm0_peer_id = read_reg(vm0_state, IVPOSITION);
+    vm1_peer_id = read_reg(vm1_state, IVPOSITION);
+
+    /* Observe vm1 IRQ output line first. */
+    qtest_irq_intercept_out_named(vm1_state,
+                                  "/machine/peripheral-anon/device[0]",
+                                  "irq-output");
+
+    /* Notify (interrupt) VM1 from VM0. */
+    write_reg(vm0_state, DOORBELL, (vm1_peer_id << 16) | 0 /* vector 0 */);
+
+    /* Check if VM1 IRQ output line is toggled after notification from VM0. */
+    g_assert(test_ivshmem_flat_irq_positive_pulse(vm1_state, 0, 2) == 0);
+
+    /* Secondly, observe VM0 IRQ output line first. */
+    qtest_irq_intercept_out_named(vm0_state,
+                                  "/machine/peripheral-anon/device[0]",
+                                  "irq-output");
+
+    /* ... and do the opposite: notify (interrupt) VM0 from VM1. */
+    write_reg(vm1_state, DOORBELL, (vm0_peer_id << 16) | 0 /* vector 0 */);
+
+    /* Check if VM0 IRQ output line is toggled after notification from VM0. */
+    g_assert(test_ivshmem_flat_irq_positive_pulse(vm0_state, 0, 2) == 0);
+
+    /* Prepare test data with random values. */
+    data = g_malloc(SHM_SIZE);
+    num_elements = SHM_SIZE/sizeof(*data);
+    for (i = 0; i < num_elements; i++) {
+        data[i] = g_test_rand_int();
+    }
+
+    /* Write test data on VM0. */
+    qtest_memwrite(vm0_state, IVSHMEM_FLAT_SHM_ADDR, data, SHM_SIZE);
+
+    /* Check test data on VM1. */
+    for (i = 0; i < num_elements; i++) {
+        qtest_memread(vm1_state, IVSHMEM_FLAT_SHM_ADDR + i * sizeof(v), &v,
+                      sizeof(v));
+        g_assert_cmpint(v, ==, data[i]);
+    }
+
+    /* Prepare new test data with random values. */
+    for (i = 0; i < num_elements; i++) {
+        data[i] = g_test_rand_int();
+    }
+
+    /* Write test data on VM1. */
+    qtest_memwrite(vm1_state, IVSHMEM_FLAT_SHM_ADDR, data, SHM_SIZE);
+
+    /* Check test data on VM0. */
+    for (i = 0; i < num_elements; i++) {
+        qtest_memread(vm0_state, IVSHMEM_FLAT_SHM_ADDR + i * sizeof(v), &v,
+                      sizeof(v));
+        g_assert_cmpint(v, ==, data[i]);
+    }
+
+    qtest_quit(vm0_state);
+    qtest_quit(vm1_state);
+}
+
+int main(int argc, char *argv[])
+{
+    int shm_fd, r;
+
+    g_test_init(&argc, &argv, NULL);
+
+    /* If test fails, stop server, cleanup socket and shm files. */
+    qtest_add_abrt_handler(abort_handler, NULL);
+
+    shm_rel_path = mktempshm(SHM_SIZE, &shm_fd);
+    g_assert(shm_rel_path);
+
+    /*
+     * Map shm to this test's VMA so it's possible to read/write from/to it. For
+     * VMs with the ivhsmem-flat device attached, this region will also be
+     * mapped in their own memory layout, at IVSHMEM_FLAT_SHM_ADDR (default).
+     */
+    shm_ptr = mmap(0, SHM_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, shm_fd, 0);
+    g_assert(shm_ptr != MAP_FAILED);
+
+    server_socket_path = mktempsocket();
+    /* It never fails, so no assert(). */
+
+    /*
+     * Currently, ivshmem-flat device only supports notification via 1 vector,
+     * i.e. vector 0.
+     */
+    test_ivshmem_server_start(&thread, server_socket_path, shm_rel_path, 1);
+
+    /* Register tests. */
+    qtest_add_func("/ivshmem-flat/irq", test_ivshmem_flat_irq);
+    qtest_add_func("/ivshmem-flat/shm-write", test_ivshmem_flat_shm_write);
+    qtest_add_func("/ivshmem-flat/shm-read", test_ivshmem_flat_shm_read);
+    qtest_add_func("/ivshmem-flat/pair", test_ivshmem_flat_shm_pair);
+
+    r = g_test_run();
+
+    test_ivshmem_server_stop(&thread);
+    cleanup();
+
+    return r;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index b6c4ca937c..e7475c7e23 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -195,6 +195,7 @@ qtests_aspeed = \
    'aspeed_smc-test',
    'aspeed_gpio-test']
 qtests_arm = \
+  (config_all_devices.has_key('CONFIG_IVSHMEM_FLAT_DEVICE') ? ['ivshmem-flat-test'] : []) + \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-dualtimer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_TIMER') ? ['cmsdk-apb-timer-test'] : []) + \
@@ -306,6 +307,7 @@ qtests = {
   'dbus-vmstate-test': files('migration-helpers.c') + dbus_vmstate1,
   'erst-test': files('erst-test.c'),
   'ivshmem-test': ['ivshmem-utils.c', '../../contrib/ivshmem-server/ivshmem-server.c'],
+  'ivshmem-flat-test': ['ivshmem-utils.c', '../../contrib/ivshmem-server/ivshmem-server.c'],
   'migration-test': migration_files,
   'pxe-test': files('boot-sector.c'),
   'qos-test': [chardev, io, qos_test_ss.apply(config_host, strict: false).sources()],
-- 
2.34.1


