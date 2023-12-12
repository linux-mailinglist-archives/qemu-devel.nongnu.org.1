Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0278C80EB9A
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:22:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD1jL-0005Ch-UY; Tue, 12 Dec 2023 07:19:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rD1jJ-0005C1-KZ; Tue, 12 Dec 2023 07:19:17 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rD1jG-0000Jv-Fz; Tue, 12 Dec 2023 07:19:17 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 425503AEFB;
 Tue, 12 Dec 2023 15:18:49 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 068293B948;
 Tue, 12 Dec 2023 15:18:32 +0300 (MSK)
Received: (nullmailer pid 1003419 invoked by uid 1000);
 Tue, 12 Dec 2023 12:18:31 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.4 07/31] tests/avocado: Replace assertEquals() for Python
 3.12 compatibility
Date: Tue, 12 Dec 2023 15:17:55 +0300
Message-Id: <20231212121831.1003318-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.4-20231211211211@cover.tls.msk.ru>
References: <qemu-stable-8.1.4-20231211211211@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Thomas Huth <thuth@redhat.com>

assertEquals() has been removed in Python 3.12 and should be replaced by
assertEqual(). See: https://docs.python.org/3.12/whatsnew/3.12.html#id3

Message-ID: <20231114134326.287242-1-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 861f724d03e1748cda1c5b9ec8457a368590cbd5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: adjust context in pc_cpu_hotplug_props.py & cpu_queries.py for before
 v8.1.0-1582-g684750ab4f "python/qemu: rename command() to cmd()")

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index b6ad21bed1..1c4ee2af32 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -1077,7 +1077,7 @@ and hypothetical example follows:
               'human-monitor-command',
               command_line='info version')
 
-          self.assertEquals(first_res, second_res, third_res)
+          self.assertEqual(first_res, second_res, third_res)
 
 At test "tear down", ``avocado_qemu.Test`` handles all the QEMUMachines
 shutdown.
diff --git a/tests/avocado/cpu_queries.py b/tests/avocado/cpu_queries.py
index cf69f69b11..295642772e 100644
--- a/tests/avocado/cpu_queries.py
+++ b/tests/avocado/cpu_queries.py
@@ -31,4 +31,4 @@ def test(self):
         for c in cpus:
             model = {'name': c['name']}
             e = self.vm.command('query-cpu-model-expansion', model=model, type='full')
-            self.assertEquals(e['model']['name'], c['name'])
+            self.assertEqual(e['model']['name'], c['name'])
diff --git a/tests/avocado/empty_cpu_model.py b/tests/avocado/empty_cpu_model.py
index 22f504418d..d906ef3d3c 100644
--- a/tests/avocado/empty_cpu_model.py
+++ b/tests/avocado/empty_cpu_model.py
@@ -15,5 +15,5 @@ def test(self):
         self.vm.set_qmp_monitor(enabled=False)
         self.vm.launch()
         self.vm.wait()
-        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be 1")
+        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
         self.assertRegex(self.vm.get_log(), r'-cpu option cannot be empty')
diff --git a/tests/avocado/pc_cpu_hotplug_props.py b/tests/avocado/pc_cpu_hotplug_props.py
index 52b878188e..6100fb7760 100644
--- a/tests/avocado/pc_cpu_hotplug_props.py
+++ b/tests/avocado/pc_cpu_hotplug_props.py
@@ -32,4 +32,4 @@ def test_no_die_id(self):
         self.vm.add_args('-smp', '1,sockets=2,cores=2,threads=2,maxcpus=8')
         self.vm.add_args('-device', 'qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0')
         self.vm.launch()
-        self.assertEquals(len(self.vm.command('query-cpus-fast')), 2)
+        self.assertEqual(len(self.vm.command('query-cpus-fast')), 2)
diff --git a/tests/avocado/x86_cpu_model_versions.py b/tests/avocado/x86_cpu_model_versions.py
index a6edf74c1c..262d6a77fb 100644
--- a/tests/avocado/x86_cpu_model_versions.py
+++ b/tests/avocado/x86_cpu_model_versions.py
@@ -119,94 +119,95 @@ def test_4_1_alias(self):
 
         self.assertFalse(cpus['Cascadelake-Server']['static'],
                          'unversioned Cascadelake-Server CPU model must not be static')
-        self.assertEquals(cpus['Cascadelake-Server'].get('alias-of'), 'Cascadelake-Server-v1',
-                          'Cascadelake-Server must be an alias of Cascadelake-Server-v1')
+        self.assertEqual(cpus['Cascadelake-Server'].get('alias-of'),
+                         'Cascadelake-Server-v1',
+                         'Cascadelake-Server must be an alias of Cascadelake-Server-v1')
         self.assertNotIn('alias-of', cpus['Cascadelake-Server-v1'],
                          'Cascadelake-Server-v1 must not be an alias')
 
         self.assertFalse(cpus['qemu64']['static'],
                          'unversioned qemu64 CPU model must not be static')
-        self.assertEquals(cpus['qemu64'].get('alias-of'), 'qemu64-v1',
-                          'qemu64 must be an alias of qemu64-v1')
+        self.assertEqual(cpus['qemu64'].get('alias-of'), 'qemu64-v1',
+                         'qemu64 must be an alias of qemu64-v1')
         self.assertNotIn('alias-of', cpus['qemu64-v1'],
                          'qemu64-v1 must not be an alias')
 
         self.validate_variant_aliases(cpus)
 
         # On pc-*-4.1, -noTSX and -IBRS models should be aliases:
-        self.assertEquals(cpus["Haswell"].get('alias-of'),
-                          "Haswell-v1",
+        self.assertEqual(cpus["Haswell"].get('alias-of'),
+                         "Haswell-v1",
                          "Haswell must be an alias")
-        self.assertEquals(cpus["Haswell-noTSX"].get('alias-of'),
-                          "Haswell-v2",
+        self.assertEqual(cpus["Haswell-noTSX"].get('alias-of'),
+                         "Haswell-v2",
                          "Haswell-noTSX must be an alias")
-        self.assertEquals(cpus["Haswell-IBRS"].get('alias-of'),
-                          "Haswell-v3",
+        self.assertEqual(cpus["Haswell-IBRS"].get('alias-of'),
+                         "Haswell-v3",
                          "Haswell-IBRS must be an alias")
-        self.assertEquals(cpus["Haswell-noTSX-IBRS"].get('alias-of'),
-                          "Haswell-v4",
+        self.assertEqual(cpus["Haswell-noTSX-IBRS"].get('alias-of'),
+                         "Haswell-v4",
                          "Haswell-noTSX-IBRS must be an alias")
 
-        self.assertEquals(cpus["Broadwell"].get('alias-of'),
-                          "Broadwell-v1",
+        self.assertEqual(cpus["Broadwell"].get('alias-of'),
+                         "Broadwell-v1",
                          "Broadwell must be an alias")
-        self.assertEquals(cpus["Broadwell-noTSX"].get('alias-of'),
-                          "Broadwell-v2",
+        self.assertEqual(cpus["Broadwell-noTSX"].get('alias-of'),
+                         "Broadwell-v2",
                          "Broadwell-noTSX must be an alias")
-        self.assertEquals(cpus["Broadwell-IBRS"].get('alias-of'),
-                          "Broadwell-v3",
+        self.assertEqual(cpus["Broadwell-IBRS"].get('alias-of'),
+                         "Broadwell-v3",
                          "Broadwell-IBRS must be an alias")
-        self.assertEquals(cpus["Broadwell-noTSX-IBRS"].get('alias-of'),
-                          "Broadwell-v4",
+        self.assertEqual(cpus["Broadwell-noTSX-IBRS"].get('alias-of'),
+                         "Broadwell-v4",
                          "Broadwell-noTSX-IBRS must be an alias")
 
-        self.assertEquals(cpus["Nehalem"].get('alias-of'),
-                          "Nehalem-v1",
+        self.assertEqual(cpus["Nehalem"].get('alias-of'),
+                         "Nehalem-v1",
                          "Nehalem must be an alias")
-        self.assertEquals(cpus["Nehalem-IBRS"].get('alias-of'),
-                          "Nehalem-v2",
+        self.assertEqual(cpus["Nehalem-IBRS"].get('alias-of'),
+                         "Nehalem-v2",
                          "Nehalem-IBRS must be an alias")
 
-        self.assertEquals(cpus["Westmere"].get('alias-of'),
-                          "Westmere-v1",
+        self.assertEqual(cpus["Westmere"].get('alias-of'),
+                         "Westmere-v1",
                          "Westmere must be an alias")
-        self.assertEquals(cpus["Westmere-IBRS"].get('alias-of'),
-                          "Westmere-v2",
+        self.assertEqual(cpus["Westmere-IBRS"].get('alias-of'),
+                         "Westmere-v2",
                          "Westmere-IBRS must be an alias")
 
-        self.assertEquals(cpus["SandyBridge"].get('alias-of'),
-                          "SandyBridge-v1",
+        self.assertEqual(cpus["SandyBridge"].get('alias-of'),
+                         "SandyBridge-v1",
                          "SandyBridge must be an alias")
-        self.assertEquals(cpus["SandyBridge-IBRS"].get('alias-of'),
-                          "SandyBridge-v2",
+        self.assertEqual(cpus["SandyBridge-IBRS"].get('alias-of'),
+                         "SandyBridge-v2",
                          "SandyBridge-IBRS must be an alias")
 
-        self.assertEquals(cpus["IvyBridge"].get('alias-of'),
-                          "IvyBridge-v1",
+        self.assertEqual(cpus["IvyBridge"].get('alias-of'),
+                         "IvyBridge-v1",
                          "IvyBridge must be an alias")
-        self.assertEquals(cpus["IvyBridge-IBRS"].get('alias-of'),
-                          "IvyBridge-v2",
+        self.assertEqual(cpus["IvyBridge-IBRS"].get('alias-of'),
+                         "IvyBridge-v2",
                          "IvyBridge-IBRS must be an alias")
 
-        self.assertEquals(cpus["Skylake-Client"].get('alias-of'),
-                          "Skylake-Client-v1",
+        self.assertEqual(cpus["Skylake-Client"].get('alias-of'),
+                         "Skylake-Client-v1",
                          "Skylake-Client must be an alias")
-        self.assertEquals(cpus["Skylake-Client-IBRS"].get('alias-of'),
-                          "Skylake-Client-v2",
+        self.assertEqual(cpus["Skylake-Client-IBRS"].get('alias-of'),
+                         "Skylake-Client-v2",
                          "Skylake-Client-IBRS must be an alias")
 
-        self.assertEquals(cpus["Skylake-Server"].get('alias-of'),
-                          "Skylake-Server-v1",
+        self.assertEqual(cpus["Skylake-Server"].get('alias-of'),
+                         "Skylake-Server-v1",
                          "Skylake-Server must be an alias")
-        self.assertEquals(cpus["Skylake-Server-IBRS"].get('alias-of'),
-                          "Skylake-Server-v2",
+        self.assertEqual(cpus["Skylake-Server-IBRS"].get('alias-of'),
+                         "Skylake-Server-v2",
                          "Skylake-Server-IBRS must be an alias")
 
-        self.assertEquals(cpus["EPYC"].get('alias-of'),
-                          "EPYC-v1",
+        self.assertEqual(cpus["EPYC"].get('alias-of'),
+                         "EPYC-v1",
                          "EPYC must be an alias")
-        self.assertEquals(cpus["EPYC-IBPB"].get('alias-of'),
-                          "EPYC-v2",
+        self.assertEqual(cpus["EPYC-IBPB"].get('alias-of'),
+                         "EPYC-v2",
                          "EPYC-IBPB must be an alias")
 
         self.validate_aliases(cpus)
-- 
2.39.2


