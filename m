Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 356407DC516
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 05:02:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxfwB-0001RG-AW; Tue, 31 Oct 2023 00:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qxfw3-0001Q6-2t
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 00:01:00 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qxfvy-0005He-OW
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 00:00:58 -0400
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-1cc0d0a0355so34141165ad.3
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 21:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698724850; x=1699329650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cFBKtoEcKUMOYHSMLFAIsLL4AHCBFnIuRPcTZq6xV4M=;
 b=OxXOLYNApl99vbHeBp9wxYNfdSXpzJKZi+TV3vyOEwzpSlv/PEkh9IQCv2GuiZGUOl
 6eJefeEDcrQPXi3hHovnuJG6lmE8/+AtKqPzGOGWfnSU+/uDIUFATQL23ogAy+OeA5cE
 xX6v89fbHxgxcuxWuf+5hKYORJsIGQ8DhsZb5m+Va1g3uNCEE6zi0hlvkfVYaIcTFE6j
 xRMmG00Pdehymq33/pZCrEdOMmWFWf0EVuHqZKXc3sGSVdCFl51EkrXpnXtONDb0lApO
 awzovpoeCefuk2wMrpycPUkXEkSja7PYc8XoISMkpwBQrw6Qu0rnSfTHRWnrSpGYJlia
 2wxA==
X-Gm-Message-State: AOJu0YwJGPd1YpyOVRCmk8yUI0nIhN5YqwFEeOd2v7bI02QRwoWC2R9R
 ieRRmu6JwizZmn6pmhFFmryjueKskaAYWA==
X-Google-Smtp-Source: AGHT+IGRQZTBDzn/apmol3vw8Ufj4MDMgNZw0k4apmxjD5C8e5wQiMrf2PmrSO//CB9bRZxCtP4wKw==
X-Received: by 2002:a17:903:30d4:b0:1c4:4462:f1bd with SMTP id
 s20-20020a17090330d400b001c44462f1bdmr7309242plc.35.1698724849715; 
 Mon, 30 Oct 2023 21:00:49 -0700 (PDT)
Received: from localhost.localdomain ([2601:642:4c02:7b37:49a8:6e6e:cee6:cee7])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a170902f54400b001bbfa86ca3bsm257975plf.78.2023.10.30.21.00.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Oct 2023 21:00:49 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v4 14/14] tests: add TPM-CRB sysbus tests for aarch64
Date: Mon, 30 Oct 2023 21:00:17 -0700
Message-ID: <20231031040021.65582-15-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031040021.65582-1-j@getutm.app>
References: <20231031040021.65582-1-j@getutm.app>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.173; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f173.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

- Factor out common test code from tpm-crb-test.c -> tpm-tests.c
- Store device addr in `tpm_device_base_addr` (unify with TIS tests)
- Add new tests for aarch64

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 tests/qtest/tpm-tests.h                 |   2 +
 tests/qtest/tpm-util.h                  |   4 +-
 tests/qtest/bios-tables-test.c          |   4 +-
 tests/qtest/tpm-crb-device-swtpm-test.c |  72 ++++++++++++++
 tests/qtest/tpm-crb-device-test.c       |  71 ++++++++++++++
 tests/qtest/tpm-crb-swtpm-test.c        |   2 +
 tests/qtest/tpm-crb-test.c              | 121 +-----------------------
 tests/qtest/tpm-tests.c                 | 121 ++++++++++++++++++++++++
 tests/qtest/tpm-tis-device-swtpm-test.c |   2 +-
 tests/qtest/tpm-tis-device-test.c       |   2 +-
 tests/qtest/tpm-tis-i2c-test.c          |   3 +
 tests/qtest/tpm-tis-swtpm-test.c        |   2 +-
 tests/qtest/tpm-tis-test.c              |   2 +-
 tests/qtest/tpm-util.c                  |  16 ++--
 tests/qtest/meson.build                 |   4 +
 15 files changed, 295 insertions(+), 133 deletions(-)
 create mode 100644 tests/qtest/tpm-crb-device-swtpm-test.c
 create mode 100644 tests/qtest/tpm-crb-device-test.c

diff --git a/tests/qtest/tpm-tests.h b/tests/qtest/tpm-tests.h
index 07ba60d26e..c1bfb2f914 100644
--- a/tests/qtest/tpm-tests.h
+++ b/tests/qtest/tpm-tests.h
@@ -24,4 +24,6 @@ void tpm_test_swtpm_migration_test(const char *src_tpm_path,
                                    const char *ifmodel,
                                    const char *machine_options);
 
+void tpm_test_crb(const void *data);
+
 #endif /* TESTS_TPM_TESTS_H */
diff --git a/tests/qtest/tpm-util.h b/tests/qtest/tpm-util.h
index 0cb28dd6e5..c99380684e 100644
--- a/tests/qtest/tpm-util.h
+++ b/tests/qtest/tpm-util.h
@@ -15,10 +15,10 @@
 
 #include "io/channel-socket.h"
 
-extern uint64_t tpm_tis_base_addr;
+extern uint64_t tpm_device_base_addr;
 
 #define TIS_REG(LOCTY, REG) \
-    (tpm_tis_base_addr + ((LOCTY) << 12) + REG)
+    (tpm_device_base_addr + ((LOCTY) << 12) + REG)
 
 typedef void (tx_func)(QTestState *s,
                        const unsigned char *req, size_t req_size,
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index c63bad0205..dea2a18158 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1343,7 +1343,7 @@ static void test_acpi_piix4_tcg_numamem(void)
     free_test_data(&data);
 }
 
-uint64_t tpm_tis_base_addr;
+uint64_t tpm_device_base_addr;
 
 static test_data tcg_tpm_test_data(const char *machine)
 {
@@ -1379,7 +1379,7 @@ static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
     const char *suffix = tpm_version == TPM_VERSION_2_0 ? "tpm2" : "tpm12";
     char *args, *variant = g_strdup_printf(".%s.%s", tpm_if, suffix);
 
-    tpm_tis_base_addr = base;
+    tpm_device_base_addr = base;
 
     module_call_init(MODULE_INIT_QOM);
 
diff --git a/tests/qtest/tpm-crb-device-swtpm-test.c b/tests/qtest/tpm-crb-device-swtpm-test.c
new file mode 100644
index 0000000000..332add5ca6
--- /dev/null
+++ b/tests/qtest/tpm-crb-device-swtpm-test.c
@@ -0,0 +1,72 @@
+/*
+ * QTest testcase for TPM CRB talking to external swtpm and swtpm migration
+ *
+ * Copyright (c) 2018 IBM Corporation
+ *  with parts borrowed from migration-test.c that is:
+ *     Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
+ *
+ * Authors:
+ *   Stefan Berger <stefanb@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "libqtest.h"
+#include "qemu/module.h"
+#include "tpm-tests.h"
+#include "hw/acpi/tpm.h"
+
+uint64_t tpm_device_base_addr = 0xc000000;
+#define MACHINE_OPTIONS "-machine virt,gic-version=max -accel tcg"
+
+typedef struct TestState {
+    char *src_tpm_path;
+    char *dst_tpm_path;
+    char *uri;
+} TestState;
+
+static void tpm_crb_swtpm_test(const void *data)
+{
+    const TestState *ts = data;
+
+    tpm_test_swtpm_test(ts->src_tpm_path, tpm_util_crb_transfer,
+                        "tpm-crb-device", MACHINE_OPTIONS);
+}
+
+static void tpm_crb_swtpm_migration_test(const void *data)
+{
+    const TestState *ts = data;
+
+    tpm_test_swtpm_migration_test(ts->src_tpm_path, ts->dst_tpm_path, ts->uri,
+                                  tpm_util_crb_transfer, "tpm-crb-device",
+                                  MACHINE_OPTIONS);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+    TestState ts = { 0 };
+
+    ts.src_tpm_path = g_dir_make_tmp("qemu-tpm-crb-swtpm-test.XXXXXX", NULL);
+    ts.dst_tpm_path = g_dir_make_tmp("qemu-tpm-crb-swtpm-test.XXXXXX", NULL);
+    ts.uri = g_strdup_printf("unix:%s/migsocket", ts.src_tpm_path);
+
+    module_call_init(MODULE_INIT_QOM);
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_data_func("/tpm/crb-swtpm/test", &ts, tpm_crb_swtpm_test);
+    qtest_add_data_func("/tpm/crb-swtpm-migration/test", &ts,
+                        tpm_crb_swtpm_migration_test);
+    ret = g_test_run();
+
+    tpm_util_rmdir(ts.dst_tpm_path);
+    g_free(ts.dst_tpm_path);
+    tpm_util_rmdir(ts.src_tpm_path);
+    g_free(ts.src_tpm_path);
+    g_free(ts.uri);
+
+    return ret;
+}
diff --git a/tests/qtest/tpm-crb-device-test.c b/tests/qtest/tpm-crb-device-test.c
new file mode 100644
index 0000000000..17d09a57fd
--- /dev/null
+++ b/tests/qtest/tpm-crb-device-test.c
@@ -0,0 +1,71 @@
+/*
+ * QTest testcase for TPM CRB
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * Authors:
+ *   Marc-André Lureau <marcandre.lureau@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <glib/gstdio.h>
+
+#include "hw/acpi/tpm.h"
+#include "io/channel-socket.h"
+#include "libqtest-single.h"
+#include "qemu/module.h"
+#include "tpm-emu.h"
+#include "tpm-tests.h"
+
+/*
+ * As the Sysbus tpm-crb-device is instantiated on the ARM virt
+ * platform bus and it is the only sysbus device dynamically
+ * instantiated, it gets plugged at its base address
+ */
+uint64_t tpm_device_base_addr = 0xc000000;
+
+int main(int argc, char **argv)
+{
+    int ret;
+    char *args, *tmp_path = g_dir_make_tmp("qemu-tpm-crb-test.XXXXXX", NULL);
+    GThread *thread;
+    TPMTestState test;
+
+    module_call_init(MODULE_INIT_QOM);
+    g_test_init(&argc, &argv, NULL);
+
+    test.addr = g_new0(SocketAddress, 1);
+    test.addr->type = SOCKET_ADDRESS_TYPE_UNIX;
+    test.addr->u.q_unix.path = g_build_filename(tmp_path, "sock", NULL);
+    g_mutex_init(&test.data_mutex);
+    g_cond_init(&test.data_cond);
+    test.data_cond_signal = false;
+    test.tpm_version = TPM_VERSION_2_0;
+
+    thread = g_thread_new(NULL, tpm_emu_ctrl_thread, &test);
+    tpm_emu_test_wait_cond(&test);
+
+    args = g_strdup_printf(
+        "-machine virt,gic-version=max -accel tcg "
+        "-chardev socket,id=chr,path=%s "
+        "-tpmdev emulator,id=dev,chardev=chr "
+        "-device tpm-crb-device,tpmdev=dev",
+        test.addr->u.q_unix.path);
+    qtest_start(args);
+
+    qtest_add_data_func("/tpm-crb/test", &test, tpm_test_crb);
+    ret = g_test_run();
+
+    qtest_end();
+
+    g_thread_join(thread);
+    g_unlink(test.addr->u.q_unix.path);
+    qapi_free_SocketAddress(test.addr);
+    g_rmdir(tmp_path);
+    g_free(tmp_path);
+    g_free(args);
+    return ret;
+}
diff --git a/tests/qtest/tpm-crb-swtpm-test.c b/tests/qtest/tpm-crb-swtpm-test.c
index ffeb1c396b..08862210a4 100644
--- a/tests/qtest/tpm-crb-swtpm-test.c
+++ b/tests/qtest/tpm-crb-swtpm-test.c
@@ -19,6 +19,8 @@
 #include "tpm-tests.h"
 #include "hw/acpi/tpm.h"
 
+uint64_t tpm_device_base_addr = TPM_CRB_ADDR_BASE;
+
 typedef struct TestState {
     char *src_tpm_path;
     char *dst_tpm_path;
diff --git a/tests/qtest/tpm-crb-test.c b/tests/qtest/tpm-crb-test.c
index 9d30fe8293..51614abc70 100644
--- a/tests/qtest/tpm-crb-test.c
+++ b/tests/qtest/tpm-crb-test.c
@@ -18,124 +18,9 @@
 #include "libqtest-single.h"
 #include "qemu/module.h"
 #include "tpm-emu.h"
+#include "tpm-tests.h"
 
-#define TPM_CMD "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00"
-
-static void tpm_crb_test(const void *data)
-{
-    const TPMTestState *s = data;
-    uint32_t intfid = readl(TPM_CRB_ADDR_BASE + A_CRB_INTF_ID);
-    uint32_t csize = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_SIZE);
-    uint64_t caddr = readq(TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_LADDR);
-    uint32_t rsize = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_SIZE);
-    uint64_t raddr = readq(TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_LADDR);
-    uint8_t locstate = readb(TPM_CRB_ADDR_BASE + A_CRB_LOC_STATE);
-    uint32_t locctrl = readl(TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL);
-    uint32_t locsts = readl(TPM_CRB_ADDR_BASE + A_CRB_LOC_STS);
-    uint32_t sts = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
-
-    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, InterfaceType), ==, 1);
-    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, InterfaceVersion), ==, 1);
-    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapLocality), ==, 0);
-    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapCRBIdleBypass), ==, 0);
-    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapDataXferSizeSupport),
-                    ==, 3);
-    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapFIFO), ==, 0);
-    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapCRB), ==, 1);
-    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, InterfaceSelector), ==, 1);
-    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, RID), ==, 0);
-
-    g_assert_cmpint(csize, >=, 128);
-    g_assert_cmpint(rsize, >=, 128);
-    g_assert_cmpint(caddr, >, TPM_CRB_ADDR_BASE);
-    g_assert_cmpint(raddr, >, TPM_CRB_ADDR_BASE);
-
-    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmEstablished), ==, 1);
-    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, locAssigned), ==, 0);
-    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, activeLocality), ==, 0);
-    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, reserved), ==, 0);
-    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmRegValidSts), ==, 1);
-
-    g_assert_cmpint(locctrl, ==, 0);
-
-    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, Granted), ==, 0);
-    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, beenSeized), ==, 0);
-
-    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), ==, 1);
-    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), ==, 0);
-
-    /* request access to locality 0 */
-    writeb(TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 1);
-
-    /* granted bit must be set now */
-    locsts = readl(TPM_CRB_ADDR_BASE + A_CRB_LOC_STS);
-    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, Granted), ==, 1);
-    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, beenSeized), ==, 0);
-
-    /* we must have an assigned locality */
-    locstate = readb(TPM_CRB_ADDR_BASE + A_CRB_LOC_STATE);
-    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmEstablished), ==, 1);
-    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, locAssigned), ==, 1);
-    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, activeLocality), ==, 0);
-    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, reserved), ==, 0);
-    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmRegValidSts), ==, 1);
-
-    /* set into ready state */
-    writel(TPM_CRB_ADDR_BASE + A_CRB_CTRL_REQ, 1);
-
-    /* TPM must not be in the idle state */
-    sts = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
-    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), ==, 0);
-    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), ==, 0);
-
-    memwrite(caddr, TPM_CMD, sizeof(TPM_CMD));
-
-    uint32_t start = 1;
-    uint64_t end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
-    writel(TPM_CRB_ADDR_BASE + A_CRB_CTRL_START, start);
-    do {
-        start = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
-        if ((start & 1) == 0) {
-            break;
-        }
-    } while (g_get_monotonic_time() < end_time);
-    start = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
-    g_assert_cmpint(start & 1, ==, 0);
-
-    /* TPM must still not be in the idle state */
-    sts = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
-    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), ==, 0);
-    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), ==, 0);
-
-    struct tpm_hdr tpm_msg;
-    memread(raddr, &tpm_msg, sizeof(tpm_msg));
-    g_assert_cmpmem(&tpm_msg, sizeof(tpm_msg), s->tpm_msg, sizeof(*s->tpm_msg));
-
-    /* set TPM into idle state */
-    writel(TPM_CRB_ADDR_BASE + A_CRB_CTRL_REQ, 2);
-
-    /* idle state must be indicated now */
-    sts = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
-    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), ==, 1);
-    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), ==, 0);
-
-    /* relinquish locality */
-    writel(TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 2);
-
-    /* Granted flag must be cleared */
-    sts = readl(TPM_CRB_ADDR_BASE + A_CRB_LOC_STS);
-    g_assert_cmpint(FIELD_EX32(sts, CRB_LOC_STS, Granted), ==, 0);
-    g_assert_cmpint(FIELD_EX32(sts, CRB_LOC_STS, beenSeized), ==, 0);
-
-    /* no locality may be assigned */
-    locstate = readb(TPM_CRB_ADDR_BASE + A_CRB_LOC_STATE);
-    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmEstablished), ==, 1);
-    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, locAssigned), ==, 0);
-    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, activeLocality), ==, 0);
-    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, reserved), ==, 0);
-    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmRegValidSts), ==, 1);
-
-}
+uint64_t tpm_device_base_addr = TPM_CRB_ADDR_BASE;
 
 int main(int argc, char **argv)
 {
@@ -165,7 +50,7 @@ int main(int argc, char **argv)
         test.addr->u.q_unix.path);
     qtest_start(args);
 
-    qtest_add_data_func("/tpm-crb/test", &test, tpm_crb_test);
+    qtest_add_data_func("/tpm-crb/test", &test, tpm_test_crb);
     ret = g_test_run();
 
     qtest_end();
diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
index fb94496bbd..83c5536136 100644
--- a/tests/qtest/tpm-tests.c
+++ b/tests/qtest/tpm-tests.c
@@ -15,7 +15,10 @@
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
 
+#include "hw/registerfields.h"
+#include "hw/acpi/tpm.h"
 #include "libqtest-single.h"
+#include "tpm-emu.h"
 #include "tpm-tests.h"
 
 static bool
@@ -130,3 +133,121 @@ void tpm_test_swtpm_migration_test(const char *src_tpm_path,
     g_unlink(src_tpm_addr->u.q_unix.path);
     qapi_free_SocketAddress(src_tpm_addr);
 }
+
+#define TPM_CMD "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00"
+
+void tpm_test_crb(const void *data)
+{
+    const TPMTestState *s = data;
+    uint32_t intfid = readl(tpm_device_base_addr + A_CRB_INTF_ID);
+    uint32_t csize = readl(tpm_device_base_addr + A_CRB_CTRL_CMD_SIZE);
+    uint64_t caddr = readq(tpm_device_base_addr + A_CRB_CTRL_CMD_LADDR);
+    uint32_t rsize = readl(tpm_device_base_addr + A_CRB_CTRL_RSP_SIZE);
+    uint64_t raddr = readq(tpm_device_base_addr + A_CRB_CTRL_RSP_LADDR);
+    uint8_t locstate = readb(tpm_device_base_addr + A_CRB_LOC_STATE);
+    uint32_t locctrl = readl(tpm_device_base_addr + A_CRB_LOC_CTRL);
+    uint32_t locsts = readl(tpm_device_base_addr + A_CRB_LOC_STS);
+    uint32_t sts = readl(tpm_device_base_addr + A_CRB_CTRL_STS);
+
+    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, InterfaceType), ==, 1);
+    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, InterfaceVersion), ==, 1);
+    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapLocality), ==, 0);
+    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapCRBIdleBypass), ==, 0);
+    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapDataXferSizeSupport),
+                    ==, 3);
+    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapFIFO), ==, 0);
+    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapCRB), ==, 1);
+    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, InterfaceSelector), ==, 1);
+    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, RID), ==, 0);
+
+    g_assert_cmpint(csize, >=, 128);
+    g_assert_cmpint(rsize, >=, 128);
+    g_assert_cmpint(caddr, >, tpm_device_base_addr);
+    g_assert_cmpint(raddr, >, tpm_device_base_addr);
+
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmEstablished), ==, 1);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, locAssigned), ==, 0);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, activeLocality), ==, 0);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, reserved), ==, 0);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmRegValidSts), ==, 1);
+
+    g_assert_cmpint(locctrl, ==, 0);
+
+    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, Granted), ==, 0);
+    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, beenSeized), ==, 0);
+
+    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), ==, 1);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), ==, 0);
+
+    /* request access to locality 0 */
+    writeb(tpm_device_base_addr + A_CRB_LOC_CTRL, 1);
+
+    /* granted bit must be set now */
+    locsts = readl(tpm_device_base_addr + A_CRB_LOC_STS);
+    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, Granted), ==, 1);
+    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, beenSeized), ==, 0);
+
+    /* we must have an assigned locality */
+    locstate = readb(tpm_device_base_addr + A_CRB_LOC_STATE);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmEstablished), ==, 1);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, locAssigned), ==, 1);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, activeLocality), ==, 0);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, reserved), ==, 0);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmRegValidSts), ==, 1);
+
+    /* set into ready state */
+    writel(tpm_device_base_addr + A_CRB_CTRL_REQ, 1);
+
+    /* TPM must not be in the idle state */
+    sts = readl(tpm_device_base_addr + A_CRB_CTRL_STS);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), ==, 0);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), ==, 0);
+
+    memwrite(caddr, TPM_CMD, sizeof(TPM_CMD));
+
+    uint32_t start = 1;
+    uint64_t end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
+    writel(tpm_device_base_addr + A_CRB_CTRL_START, start);
+    do {
+        start = readl(tpm_device_base_addr + A_CRB_CTRL_START);
+        if ((start & 1) == 0) {
+            break;
+        }
+    } while (g_get_monotonic_time() < end_time);
+    start = readl(tpm_device_base_addr + A_CRB_CTRL_START);
+    g_assert_cmpint(start & 1, ==, 0);
+
+    /* TPM must still not be in the idle state */
+    sts = readl(tpm_device_base_addr + A_CRB_CTRL_STS);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), ==, 0);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), ==, 0);
+
+    struct tpm_hdr tpm_msg;
+    memread(raddr, &tpm_msg, sizeof(tpm_msg));
+    g_assert_cmpmem(&tpm_msg, sizeof(tpm_msg), s->tpm_msg, sizeof(*s->tpm_msg));
+
+    /* set TPM into idle state */
+    writel(tpm_device_base_addr + A_CRB_CTRL_REQ, 2);
+
+    /* idle state must be indicated now */
+    sts = readl(tpm_device_base_addr + A_CRB_CTRL_STS);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), ==, 1);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), ==, 0);
+
+    /* relinquish locality */
+    writel(tpm_device_base_addr + A_CRB_LOC_CTRL, 2);
+
+    /* Granted flag must be cleared */
+    sts = readl(tpm_device_base_addr + A_CRB_LOC_STS);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_LOC_STS, Granted), ==, 0);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_LOC_STS, beenSeized), ==, 0);
+
+    /* no locality may be assigned */
+    locstate = readb(tpm_device_base_addr + A_CRB_LOC_STATE);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmEstablished), ==, 1);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, locAssigned), ==, 0);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, activeLocality), ==, 0);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, reserved), ==, 0);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmRegValidSts), ==, 1);
+
+}
diff --git a/tests/qtest/tpm-tis-device-swtpm-test.c b/tests/qtest/tpm-tis-device-swtpm-test.c
index 517a077005..54d1cedc6f 100644
--- a/tests/qtest/tpm-tis-device-swtpm-test.c
+++ b/tests/qtest/tpm-tis-device-swtpm-test.c
@@ -21,7 +21,7 @@
 #include "tpm-tis-util.h"
 #include "hw/acpi/tpm.h"
 
-uint64_t tpm_tis_base_addr = 0xc000000;
+uint64_t tpm_device_base_addr = 0xc000000;
 #define MACHINE_OPTIONS "-machine virt,gic-version=max -accel tcg"
 
 typedef struct TestState {
diff --git a/tests/qtest/tpm-tis-device-test.c b/tests/qtest/tpm-tis-device-test.c
index 3ddefb51ec..4f6609ae98 100644
--- a/tests/qtest/tpm-tis-device-test.c
+++ b/tests/qtest/tpm-tis-device-test.c
@@ -27,7 +27,7 @@
  * platform bus and it is the only sysbus device dynamically
  * instantiated, it gets plugged at its base address
  */
-uint64_t tpm_tis_base_addr = 0xc000000;
+uint64_t tpm_device_base_addr = 0xc000000;
 
 int main(int argc, char **argv)
 {
diff --git a/tests/qtest/tpm-tis-i2c-test.c b/tests/qtest/tpm-tis-i2c-test.c
index 3a1af026f2..9495cc1739 100644
--- a/tests/qtest/tpm-tis-i2c-test.c
+++ b/tests/qtest/tpm-tis-i2c-test.c
@@ -39,6 +39,9 @@
 #define I2C_SLAVE_ADDR   0x2e
 #define I2C_DEV_BUS_NUM  10
 
+/* unused but needed for tpm-util.c to link */
+uint64_t tpm_device_base_addr;
+
 static const uint8_t TPM_CMD[12] =
     "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00";
 
diff --git a/tests/qtest/tpm-tis-swtpm-test.c b/tests/qtest/tpm-tis-swtpm-test.c
index 105e42e21d..5bfbbc0a67 100644
--- a/tests/qtest/tpm-tis-swtpm-test.c
+++ b/tests/qtest/tpm-tis-swtpm-test.c
@@ -20,7 +20,7 @@
 #include "tpm-tis-util.h"
 #include "hw/acpi/tpm.h"
 
-uint64_t tpm_tis_base_addr = TPM_TIS_ADDR_BASE;
+uint64_t tpm_device_base_addr = TPM_TIS_ADDR_BASE;
 
 typedef struct TestState {
     char *src_tpm_path;
diff --git a/tests/qtest/tpm-tis-test.c b/tests/qtest/tpm-tis-test.c
index a4a25ba745..7661568aa8 100644
--- a/tests/qtest/tpm-tis-test.c
+++ b/tests/qtest/tpm-tis-test.c
@@ -22,7 +22,7 @@
 #include "tpm-emu.h"
 #include "tpm-tis-util.h"
 
-uint64_t tpm_tis_base_addr = TPM_TIS_ADDR_BASE;
+uint64_t tpm_device_base_addr = TPM_TIS_ADDR_BASE;
 
 int main(int argc, char **argv)
 {
diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
index dd02057fc0..1608901a76 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -24,18 +24,20 @@ void tpm_util_crb_transfer(QTestState *s,
                            const unsigned char *req, size_t req_size,
                            unsigned char *rsp, size_t rsp_size)
 {
-    uint64_t caddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_LADDR);
-    uint64_t raddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_LADDR);
+    uint64_t caddr = qtest_readq(s, tpm_device_base_addr +
+                                    A_CRB_CTRL_CMD_LADDR);
+    uint64_t raddr = qtest_readq(s, tpm_device_base_addr +
+                                    A_CRB_CTRL_RSP_LADDR);
 
-    qtest_writeb(s, TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 1);
+    qtest_writeb(s, tpm_device_base_addr + A_CRB_LOC_CTRL, 1);
 
     qtest_memwrite(s, caddr, req, req_size);
 
     uint32_t sts, start = 1;
     uint64_t end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
-    qtest_writel(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START, start);
+    qtest_writel(s, tpm_device_base_addr + A_CRB_CTRL_START, start);
     while (true) {
-        start = qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
+        start = qtest_readl(s, tpm_device_base_addr + A_CRB_CTRL_START);
         if ((start & 1) == 0) {
             break;
         }
@@ -43,9 +45,9 @@ void tpm_util_crb_transfer(QTestState *s,
             break;
         }
     };
-    start = qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
+    start = qtest_readl(s, tpm_device_base_addr + A_CRB_CTRL_START);
     g_assert_cmpint(start & 1, ==, 0);
-    sts = qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
+    sts = qtest_readl(s, tpm_device_base_addr + A_CRB_CTRL_STS);
     g_assert_cmpint(sts & 1, ==, 0);
 
     qtest_memread(s, raddr, rsp, rsp_size);
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index d6022ebd64..0e6ef6aebf 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -215,6 +215,8 @@ qtests_aarch64 = \
   (cpu != 'arm' and unpack_edk2_blobs ? ['bios-tables-test'] : []) +                            \
   (config_all.has_key('CONFIG_TCG') and config_all_devices.has_key('CONFIG_TPM_TIS_SYSBUS') ?            \
     ['tpm-tis-device-test', 'tpm-tis-device-swtpm-test'] : []) +                                         \
+  (config_all.has_key('CONFIG_TCG') and config_all_devices.has_key('CONFIG_TPM_CRB_SYSBUS') ?            \
+    ['tpm-crb-device-test', 'tpm-crb-device-swtpm-test'] : []) +                                         \
   (config_all_devices.has_key('CONFIG_XLNX_ZYNQMP_ARM') ? ['xlnx-can-test', 'fuzz-xlnx-dp-test'] : []) + \
   (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ? ['xlnx-canfd-test'] : []) + \
   (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test'] : []) +  \
@@ -312,6 +314,8 @@ qtests = {
   'qos-test': [chardev, io, qos_test_ss.apply(config_targetos, strict: false).sources()],
   'tpm-crb-swtpm-test': [io, tpmemu_files],
   'tpm-crb-test': [io, tpmemu_files],
+  'tpm-crb-device-swtpm-test': [io, tpmemu_files],
+  'tpm-crb-device-test': [io, tpmemu_files],
   'tpm-tis-swtpm-test': [io, tpmemu_files, 'tpm-tis-util.c'],
   'tpm-tis-test': [io, tpmemu_files, 'tpm-tis-util.c'],
   'tpm-tis-i2c-test': [io, tpmemu_files, 'qtest_aspeed.c'],
-- 
2.41.0


