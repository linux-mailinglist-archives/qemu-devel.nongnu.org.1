Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EF48D1628
	for <lists+qemu-devel@lfdr.de>; Tue, 28 May 2024 10:22:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBs5x-0006eV-JF; Tue, 28 May 2024 04:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sBs5r-0006dm-OV
 for qemu-devel@nongnu.org; Tue, 28 May 2024 04:22:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sBs5m-0002Dj-A0
 for qemu-devel@nongnu.org; Tue, 28 May 2024 04:22:03 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxFPAklFVms5sAAA--.2668S3;
 Tue, 28 May 2024 16:21:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxDMcjlFVmd8QLAA--.30963S2; 
 Tue, 28 May 2024 16:21:56 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Thomas Huth <thuth@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] tests/qtest: Add numa test for loongarch system
Date: Tue, 28 May 2024 16:21:55 +0800
Message-Id: <20240528082155.938586-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxDMcjlFVmd8QLAA--.30963S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add numa test case for loongarch system, it passes to run
with command "make check-qtest".

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 tests/qtest/meson.build |  2 +-
 tests/qtest/numa-test.c | 53 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index b98fae6a6d..12792948ff 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -140,7 +140,7 @@ qtests_hppa = ['boot-serial-test'] + \
   (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : [])
 
 qtests_loongarch64 = qtests_filter + \
-  ['boot-serial-test']
+  ['boot-serial-test', 'numa-test']
 
 qtests_m68k = ['boot-serial-test'] + \
   qtests_filter
diff --git a/tests/qtest/numa-test.c b/tests/qtest/numa-test.c
index 7aa262dbb9..5518f6596b 100644
--- a/tests/qtest/numa-test.c
+++ b/tests/qtest/numa-test.c
@@ -265,6 +265,54 @@ static void aarch64_numa_cpu(const void *data)
     qtest_quit(qts);
 }
 
+static void loongarch64_numa_cpu(const void *data)
+{
+    QDict *resp;
+    QList *cpus;
+    QObject *e;
+    QTestState *qts;
+    g_autofree char *cli = NULL;
+
+    cli = make_cli(data, "-machine "
+        "smp.cpus=2,smp.sockets=2,smp.cores=1,smp.threads=1 "
+        "-numa node,nodeid=0,memdev=ram -numa node,nodeid=1 "
+        "-numa cpu,node-id=0,socket-id=1,core-id=0,thread-id=0 "
+        "-numa cpu,node-id=1,socket-id=0,core-id=0,thread-id=0");
+    qts = qtest_init(cli);
+    cpus = get_cpus(qts, &resp);
+    g_assert(cpus);
+
+    while ((e = qlist_pop(cpus))) {
+        QDict *cpu, *props;
+        int64_t socket, core, thread, node;
+
+        cpu = qobject_to(QDict, e);
+        g_assert(qdict_haskey(cpu, "props"));
+        props = qdict_get_qdict(cpu, "props");
+
+        g_assert(qdict_haskey(props, "node-id"));
+        node = qdict_get_int(props, "node-id");
+        g_assert(qdict_haskey(props, "socket-id"));
+        socket = qdict_get_int(props, "socket-id");
+        g_assert(qdict_haskey(props, "core-id"));
+        core = qdict_get_int(props, "core-id");
+        g_assert(qdict_haskey(props, "thread-id"));
+        thread = qdict_get_int(props, "thread-id");
+
+        if (socket == 0 && core == 0 && thread == 0) {
+            g_assert_cmpint(node, ==, 1);
+        } else if (socket == 1 && core == 0 && thread == 0) {
+            g_assert_cmpint(node, ==, 0);
+        } else {
+            g_assert(false);
+        }
+        qobject_unref(e);
+    }
+
+    qobject_unref(resp);
+    qtest_quit(qts);
+}
+
 static void pc_dynamic_cpu_cfg(const void *data)
 {
     QObject *e;
@@ -593,6 +641,11 @@ int main(int argc, char **argv)
                             aarch64_numa_cpu);
     }
 
+    if (!strcmp(arch, "loongarch64")) {
+        qtest_add_data_func("/numa/loongarch64/cpu/explicit", args,
+                            loongarch64_numa_cpu);
+    }
+
 out:
     return g_test_run();
 }
-- 
2.39.3


