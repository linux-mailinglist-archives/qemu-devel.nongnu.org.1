Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 839477CB2EB
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 20:46:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsSXI-0007zA-Il; Mon, 16 Oct 2023 14:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qsSWv-0007qg-Fh; Mon, 16 Oct 2023 14:41:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qsSWl-0006In-C9; Mon, 16 Oct 2023 14:41:28 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GIbNGw008677; Mon, 16 Oct 2023 18:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=DoCl0z1MfIxoPskaxJjIVsbxOavSQSQ3s9uukMk846k=;
 b=fBAfZo86T4H8hmKj1XPQAS1nuhxKAei88q5sHEU22gcxSyDRCR4983W8qhoFcSd8g+Lh
 9X6kVeE9739QmnEYlpokguGXi3uvv5cpg0ovwco/AnHvokNPgrNOe0ugg3fSAVSiNNy+
 FtHnT3QvYMfjK9CYrDCHtqtlzCVGOeYZTHMwSmljH6PNojEJX/R0SCkVjCcqRLLyuIfM
 ykDCRf6Mgcx1VyjySMyGldDBzQDHfsk3E59pxChUEO3+I5lMTjVFrXjUoy7kj+REdGQ5
 qM2RAWjGmffR1AmdO0nFHt4lfWQfqTzn7yXJIpW1Pe5eUvyu6df780hS5vZYBz7njpib HA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tsam6880b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 18:40:38 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39GIc1tl012717;
 Mon, 16 Oct 2023 18:40:14 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tsam6879y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 18:40:13 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GH0ZTa026870; Mon, 16 Oct 2023 18:39:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr5as32rn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 18:39:36 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39GIdYXu8389280
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Oct 2023 18:39:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0359C20040;
 Mon, 16 Oct 2023 18:39:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88BC120043;
 Mon, 16 Oct 2023 18:39:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Oct 2023 18:39:33 +0000 (GMT)
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v26 15/21] tests/avocado: s390x cpu topology core
Date: Mon, 16 Oct 2023 20:39:19 +0200
Message-Id: <20231016183925.2384704-16-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016183925.2384704-1-nsg@linux.ibm.com>
References: <20231016183925.2384704-1-nsg@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LXtXDWB6cFyUkGlGUBC0Go20dxxtcnsY
X-Proofpoint-GUID: 4b5mCxHci917chHDHWaiJRkBj1rCW6-c
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310160162
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
---
 MAINTAINERS                    |   1 +
 tests/avocado/s390_topology.py | 200 +++++++++++++++++++++++++++++++++
 2 files changed, 201 insertions(+)
 create mode 100644 tests/avocado/s390_topology.py

diff --git a/MAINTAINERS b/MAINTAINERS
index e236dd181d..e21a8c8097 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1720,6 +1720,7 @@ F: hw/s390x/cpu-topology.c
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
2.39.2


