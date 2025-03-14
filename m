Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC44CA60C3B
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Mar 2025 09:53:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt0ly-0007vi-Hf; Fri, 14 Mar 2025 04:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tt0lu-0007vI-P3
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 04:52:02 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tt0lo-0008UV-MI
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 04:52:02 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxbWsm7tNnFz+WAA--.58888S3;
 Fri, 14 Mar 2025 16:51:50 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxb8ck7tNn2ItKAA--.13804S2;
 Fri, 14 Mar 2025 16:51:48 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Thomas Huth <thuth@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3] tests/qtest/cpu-plug-test: Add cpu hotplug support for
 LoongArch
Date: Fri, 14 Mar 2025 16:51:30 +0800
Message-Id: <20250314085130.4184272-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxb8ck7tNn2ItKAA--.13804S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add cpu hotplug testcase support for LoongArch system, it passes to
run with command "make check-qtest-loongarch64" as following:
  qemu:qtest+qtest-loongarch64 / qtest-loongarch64/cpu-plug-test OK 0.38s 1 subtests passed

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
v2 ... v3:
  1. Remove redundant check with machine type since it is constant
     string.

v1 ... v2:
  1. Call test function add_loongarch_test_case() directly rather than
     qtest_cb_for_every_machine() since compatible machine is not
     supported on LoongArch system.
  2. Add architecture specified test case in separate line.
---
 tests/qtest/cpu-plug-test.c | 24 ++++++++++++++++++++++++
 tests/qtest/meson.build     |  3 ++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/cpu-plug-test.c b/tests/qtest/cpu-plug-test.c
index 6633abfc10..44d704680b 100644
--- a/tests/qtest/cpu-plug-test.c
+++ b/tests/qtest/cpu-plug-test.c
@@ -156,6 +156,28 @@ static void add_s390x_test_case(const char *mname)
     g_free(path);
 }
 
+static void add_loongarch_test_case(const char *mname)
+{
+    char *path;
+    PlugTestData *data;
+
+    data = g_new(PlugTestData, 1);
+    data->machine = g_strdup(mname);
+    data->cpu_model = "la464";
+    data->device_model = g_strdup("la464-loongarch-cpu");
+    data->sockets = 1;
+    data->cores = 3;
+    data->threads = 1;
+    data->maxcpus = data->sockets * data->cores * data->threads;
+
+    path = g_strdup_printf("cpu-plug/%s/device-add/%ux%ux%u&maxcpus=%u",
+                           mname, data->sockets, data->cores,
+                           data->threads, data->maxcpus);
+    qtest_add_data_func_full(path, data, test_plug_with_device_add,
+                             test_data_free);
+    g_free(path);
+}
+
 int main(int argc, char **argv)
 {
     const char *arch = qtest_get_arch();
@@ -168,6 +190,8 @@ int main(int argc, char **argv)
         qtest_cb_for_every_machine(add_pseries_test_case, g_test_quick());
     } else if (g_str_equal(arch, "s390x")) {
         qtest_cb_for_every_machine(add_s390x_test_case, g_test_quick());
+    } else if (g_str_equal(arch, "loongarch64")) {
+        add_loongarch_test_case("virt");
     }
 
     return g_test_run();
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 5a8c1f102c..788093f744 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -149,7 +149,8 @@ qtests_hppa = \
 
 qtests_loongarch64 = qtests_filter + \
   (config_all_devices.has_key('CONFIG_LOONGARCH_VIRT') ? ['numa-test'] : []) + \
-  ['boot-serial-test']
+  ['boot-serial-test',
+   'cpu-plug-test']
 
 qtests_m68k = ['boot-serial-test'] + \
   qtests_filter

base-commit: 4c33c097f3a8a8093bcbaf097c3a178051e51b3e
-- 
2.39.3


