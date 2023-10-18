Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F517CDCED
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:14:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6IE-0006K5-2s; Wed, 18 Oct 2023 09:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6HP-0004Ye-3L
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:08:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6HK-00081O-8M
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697634481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PqOCqxXlBbK1bizrXYP68QVYEW/W4PHiJ4zRDkLjD+0=;
 b=BW2eDZmUnuoaddu/yITzwjPkRNJr7qm0bom/1uX5JQwbMK+6XXJPtq3Y5Vne9lfGvGc5sR
 g+PoBhJuYRSsbbCeaNEc0vaKPBYZqplk5CZcIL19jAaBcNAjno3o00LpmXFpHCO/RIosjW
 EfUwNxkPYTsgCx86LMJ0+XxgsM0jtEg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-693-Lp98PKMMOzabspBVwuDQ7A-1; Wed, 18 Oct 2023 09:07:44 -0400
X-MC-Unique: Lp98PKMMOzabspBVwuDQ7A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8878088B7AB;
 Wed, 18 Oct 2023 13:07:44 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5423B20268C8;
 Wed, 18 Oct 2023 13:07:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PULL 15/25] tests/avocado: s390x cpu topology core
Date: Wed, 18 Oct 2023 15:07:06 +0200
Message-ID: <20231018130716.286638-16-thuth@redhat.com>
In-Reply-To: <20231018130716.286638-1-thuth@redhat.com>
References: <20231018130716.286638-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Pierre Morel <pmorel@linux.ibm.com>

Introduction of the s390x cpu topology core functions and
basic tests.

We test the correlation between the command line and
the QMP results in query-cpus-fast for various CPU topology.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Message-ID: <20231016183925.2384704-16-nsg@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                    |   1 +
 tests/avocado/s390_topology.py | 200 +++++++++++++++++++++++++++++++++
 2 files changed, 201 insertions(+)
 create mode 100644 tests/avocado/s390_topology.py

diff --git a/MAINTAINERS b/MAINTAINERS
index de8d9f5104..9ad32e20f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1718,6 +1718,7 @@ F: hw/s390x/cpu-topology.c
 F: target/s390x/kvm/stsi-topology.c
 F: docs/devel/s390-cpu-topology.rst
 F: docs/system/s390x/cpu-topology.rst
+F: tests/avocado/s390_topology.py
 
 X86 Machines
 ------------
diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topology.py
new file mode 100644
index 0000000000..9078b45281
--- /dev/null
+++ b/tests/avocado/s390_topology.py
@@ -0,0 +1,200 @@
+# Functional test that boots a Linux kernel and checks the console
+#
+# Copyright IBM Corp. 2023
+#
+# Author:
+#  Pierre Morel <pmorel@linux.ibm.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import os
+import shutil
+import time
+
+from avocado_qemu import QemuSystemTest
+from avocado_qemu import exec_command
+from avocado_qemu import exec_command_and_wait_for_pattern
+from avocado_qemu import interrupt_interactive_console_until_pattern
+from avocado_qemu import wait_for_console_pattern
+from avocado.utils import process
+from avocado.utils import archive
+
+
+class S390CPUTopology(QemuSystemTest):
+    """
+    S390x CPU topology consists of 4 topology layers, from bottom to top,
+    the cores, sockets, books and drawers and 2 modifiers attributes,
+    the entitlement and the dedication.
+    See: docs/system/s390x/cpu-topology.rst.
+
+    S390x CPU topology is setup in different ways:
+    - implicitly from the '-smp' argument by completing each topology
+      level one after the other beginning with drawer 0, book 0 and
+      socket 0.
+    - explicitly from the '-device' argument on the QEMU command line
+    - explicitly by hotplug of a new CPU using QMP or HMP
+    - it is modified by using QMP 'set-cpu-topology'
+
+    The S390x modifier attribute entitlement depends on the machine
+    polarization, which can be horizontal or vertical.
+    The polarization is changed on a request from the guest.
+    """
+    timeout = 90
+
+    KERNEL_COMMON_COMMAND_LINE = ('printk.time=0 '
+                                  'root=/dev/ram '
+                                  'selinux=0 '
+                                  'rdinit=/bin/sh')
+
+    def wait_until_booted(self):
+        wait_for_console_pattern(self, 'no job control',
+                                 failure_message='Kernel panic - not syncing',
+                                 vm=None)
+
+    def check_topology(self, c, s, b, d, e, t):
+        res = self.vm.qmp('query-cpus-fast')
+        cpus =  res['return']
+        for cpu in cpus:
+            core = cpu['props']['core-id']
+            socket = cpu['props']['socket-id']
+            book = cpu['props']['book-id']
+            drawer = cpu['props']['drawer-id']
+            entitlement = cpu.get('entitlement')
+            dedicated = cpu.get('dedicated')
+            if core == c:
+                self.assertEqual(drawer, d)
+                self.assertEqual(book, b)
+                self.assertEqual(socket, s)
+                self.assertEqual(entitlement, e)
+                self.assertEqual(dedicated, t)
+
+    def kernel_init(self):
+        """
+        We need a VM that supports CPU topology,
+        currently this only the case when using KVM, not TCG.
+        We need a kernel supporting the CPU topology.
+        We need a minimal root filesystem with a shell.
+        """
+        self.require_accelerator("kvm")
+        kernel_url = ('https://archives.fedoraproject.org/pub/archive'
+                      '/fedora-secondary/releases/35/Server/s390x/os'
+                      '/images/kernel.img')
+        kernel_hash = '0d1aaaf303f07cf0160c8c48e56fe638'
+        kernel_path = self.fetch_asset(kernel_url, algorithm='md5',
+                                       asset_hash=kernel_hash)
+
+        initrd_url = ('https://archives.fedoraproject.org/pub/archive'
+                      '/fedora-secondary/releases/35/Server/s390x/os'
+                      '/images/initrd.img')
+        initrd_hash = 'a122057d95725ac030e2ec51df46e172'
+        initrd_path_xz = self.fetch_asset(initrd_url, algorithm='md5',
+                                          asset_hash=initrd_hash)
+        initrd_path = os.path.join(self.workdir, 'initrd-raw.img')
+        archive.lzma_uncompress(initrd_path_xz, initrd_path)
+
+        self.vm.set_console()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
+        self.vm.add_args('-nographic',
+                         '-enable-kvm',
+                         '-cpu', 'max,ctop=on',
+                         '-m', '512',
+                         '-kernel', kernel_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line)
+
+    def test_single(self):
+        """
+        This test checks the simplest topology with a single CPU.
+
+        :avocado: tags=arch:s390x
+        :avocado: tags=machine:s390-ccw-virtio
+        """
+        self.kernel_init()
+        self.vm.launch()
+        self.wait_until_booted()
+        self.check_topology(0, 0, 0, 0, 'medium', False)
+
+    def test_default(self):
+        """
+        This test checks the implicit topology.
+
+        :avocado: tags=arch:s390x
+        :avocado: tags=machine:s390-ccw-virtio
+        """
+        self.kernel_init()
+        self.vm.add_args('-smp',
+                         '13,drawers=2,books=2,sockets=3,cores=2,maxcpus=24')
+        self.vm.launch()
+        self.wait_until_booted()
+        self.check_topology(0, 0, 0, 0, 'medium', False)
+        self.check_topology(1, 0, 0, 0, 'medium', False)
+        self.check_topology(2, 1, 0, 0, 'medium', False)
+        self.check_topology(3, 1, 0, 0, 'medium', False)
+        self.check_topology(4, 2, 0, 0, 'medium', False)
+        self.check_topology(5, 2, 0, 0, 'medium', False)
+        self.check_topology(6, 0, 1, 0, 'medium', False)
+        self.check_topology(7, 0, 1, 0, 'medium', False)
+        self.check_topology(8, 1, 1, 0, 'medium', False)
+        self.check_topology(9, 1, 1, 0, 'medium', False)
+        self.check_topology(10, 2, 1, 0, 'medium', False)
+        self.check_topology(11, 2, 1, 0, 'medium', False)
+        self.check_topology(12, 0, 0, 1, 'medium', False)
+
+    def test_move(self):
+        """
+        This test checks the topology modification by moving a CPU
+        to another socket: CPU 0 is moved from socket 0 to socket 2.
+
+        :avocado: tags=arch:s390x
+        :avocado: tags=machine:s390-ccw-virtio
+        """
+        self.kernel_init()
+        self.vm.add_args('-smp',
+                         '1,drawers=2,books=2,sockets=3,cores=2,maxcpus=24')
+        self.vm.launch()
+        self.wait_until_booted()
+
+        self.check_topology(0, 0, 0, 0, 'medium', False)
+        res = self.vm.qmp('set-cpu-topology',
+                          {'core-id': 0, 'socket-id': 2, 'entitlement': 'low'})
+        self.assertEqual(res['return'], {})
+        self.check_topology(0, 2, 0, 0, 'low', False)
+
+    def test_dash_device(self):
+        """
+        This test verifies that a CPU defined with the '-device'
+        command line option finds its right place inside the topology.
+
+        :avocado: tags=arch:s390x
+        :avocado: tags=machine:s390-ccw-virtio
+        """
+        self.kernel_init()
+        self.vm.add_args('-smp',
+                         '1,drawers=2,books=2,sockets=3,cores=2,maxcpus=24')
+        self.vm.add_args('-device', 'max-s390x-cpu,core-id=10')
+        self.vm.add_args('-device',
+                         'max-s390x-cpu,'
+                         'core-id=1,socket-id=0,book-id=1,drawer-id=1,entitlement=low')
+        self.vm.add_args('-device',
+                         'max-s390x-cpu,'
+                         'core-id=2,socket-id=0,book-id=1,drawer-id=1,entitlement=medium')
+        self.vm.add_args('-device',
+                         'max-s390x-cpu,'
+                         'core-id=3,socket-id=1,book-id=1,drawer-id=1,entitlement=high')
+        self.vm.add_args('-device',
+                         'max-s390x-cpu,'
+                         'core-id=4,socket-id=1,book-id=1,drawer-id=1')
+        self.vm.add_args('-device',
+                         'max-s390x-cpu,'
+                         'core-id=5,socket-id=2,book-id=1,drawer-id=1,dedicated=true')
+
+        self.vm.launch()
+        self.wait_until_booted()
+
+        self.check_topology(10, 2, 1, 0, 'medium', False)
+        self.check_topology(1, 0, 1, 1, 'low', False)
+        self.check_topology(2, 0, 1, 1, 'medium', False)
+        self.check_topology(3, 1, 1, 1, 'high', False)
+        self.check_topology(4, 1, 1, 1, 'medium', False)
+        self.check_topology(5, 2, 1, 1, 'high', True)
-- 
2.41.0


