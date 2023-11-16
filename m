Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4187EE663
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 19:07:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3gkS-0002Pr-1e; Thu, 16 Nov 2023 13:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3gkK-0002MY-FQ
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 13:05:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3gkI-00041J-Bn
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 13:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700157941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+q0puVjuQK+0+JCHt7Qdbx28ezP65GhnXeH0zP+Al8s=;
 b=QTDK8nrFtsn2lEu4ry79InlyWlsssv2AUHie0gs+UO1YBM7Q2uuLaPCjs7Suz3l2EyZudk
 tl3wE8FW2wD6GM++JUb7dQen6yv1xEwXvJLyuA6/bfjt/zPwPRKR9FnEekIDhiW8XltT/J
 CYSpOIeXoXx+o3N50f8eiOvsKGvwy20=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-DRQJ_dvyO5KA61xA58962A-1; Thu, 16 Nov 2023 13:05:38 -0500
X-MC-Unique: DRQJ_dvyO5KA61xA58962A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2CE4811E82;
 Thu, 16 Nov 2023 18:05:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8E691121306;
 Thu, 16 Nov 2023 18:05:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/10] tests/avocado: Replace assertEquals() for Python 3.12
 compatibility
Date: Thu, 16 Nov 2023 19:05:25 +0100
Message-ID: <20231116180534.566469-2-thuth@redhat.com>
In-Reply-To: <20231116180534.566469-1-thuth@redhat.com>
References: <20231116180534.566469-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

assertEquals() has been removed in Python 3.12 and should be replaced by
assertEqual(). See: https://docs.python.org/3.12/whatsnew/3.12.html#id3

Message-ID: <20231114134326.287242-1-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/testing.rst                  |  2 +-
 tests/avocado/cpu_queries.py            |  2 +-
 tests/avocado/empty_cpu_model.py        |  2 +-
 tests/avocado/pc_cpu_hotplug_props.py   |  2 +-
 tests/avocado/x86_cpu_model_versions.py | 97 +++++++++++++------------
 5 files changed, 53 insertions(+), 52 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index fef64accc1..87ed30af22 100644
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
index 86c2d5c92d..d3faa14720 100644
--- a/tests/avocado/cpu_queries.py
+++ b/tests/avocado/cpu_queries.py
@@ -32,4 +32,4 @@ def test(self):
             model = {'name': c['name']}
             e = self.vm.cmd('query-cpu-model-expansion', model=model,
                             type='full')
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
index b56f51d02a..4bd3e02665 100644
--- a/tests/avocado/pc_cpu_hotplug_props.py
+++ b/tests/avocado/pc_cpu_hotplug_props.py
@@ -32,4 +32,4 @@ def test_no_die_id(self):
         self.vm.add_args('-smp', '1,sockets=2,cores=2,threads=2,maxcpus=8')
         self.vm.add_args('-device', 'qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0')
         self.vm.launch()
-        self.assertEquals(len(self.vm.cmd('query-cpus-fast')), 2)
+        self.assertEqual(len(self.vm.cmd('query-cpus-fast')), 2)
diff --git a/tests/avocado/x86_cpu_model_versions.py b/tests/avocado/x86_cpu_model_versions.py
index 9e07b8a55d..11101e02b9 100644
--- a/tests/avocado/x86_cpu_model_versions.py
+++ b/tests/avocado/x86_cpu_model_versions.py
@@ -121,94 +121,95 @@ def test_4_1_alias(self):
 
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
2.41.0


