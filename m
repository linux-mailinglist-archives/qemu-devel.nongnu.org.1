Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE00A6D05D
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Mar 2025 18:45:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPKQ-0002Z4-HB; Sun, 23 Mar 2025 13:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1twPJT-0001LL-Db; Sun, 23 Mar 2025 13:41:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1twPJQ-0003U6-In; Sun, 23 Mar 2025 13:40:42 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NEGEEw016422;
 Sun, 23 Mar 2025 17:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TAEW8jD+NymiRQO5L
 zbwtNDcgEz6xdf96J3I6KRe3iM=; b=WDeO8TGd0rrVS0Ll4wD68yxgvcd7Hw5xX
 0jji1aVViDdtp94sdq7Y/b8GNmhRdv9eFthsnxnCwLJ3V7DJaSDfuy5ZrCDDQ4WT
 9wDGuh4UyG89tWStfrMvoTIJ7BgTjzL/SoEOsmKgc48WeT6wFbssFeFmQEkO5m8y
 qWyMEfmCAKd4QucJdMSf2PJg6ym1A7qgEBGUvHR9le311NIheH7arJWBj1QycQA/
 TG4J5l70RYU/DJ7Yhipj9MqijL4FGZus/6uvTceWkpBHxB8qgB+gUkd1SMh2zV+c
 y3wKyz7MmWBCNdykobQaJgiqGgpkcIuZNA8d4w0fAH2OjoAP4evTA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45j4cp3154-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Mar 2025 17:40:38 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52NHecQh004488;
 Sun, 23 Mar 2025 17:40:38 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45j4cp3151-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Mar 2025 17:40:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52NHNd1i020082;
 Sun, 23 Mar 2025 17:40:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j8hnjp10-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Mar 2025 17:40:37 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52NHeYKm30671478
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 23 Mar 2025 17:40:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01F0F20040;
 Sun, 23 Mar 2025 17:40:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC63420043;
 Sun, 23 Mar 2025 17:40:31 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.214.162])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 23 Mar 2025 17:40:31 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH v4 8/8] tests/functional: Add test for fadump in PSeries
Date: Sun, 23 Mar 2025 23:10:07 +0530
Message-ID: <20250323174007.221116-9-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250323174007.221116-1-adityag@linux.ibm.com>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PtUhs8c_ikWrUsQ1aH2L_HqDTF1UaOCs
X-Proofpoint-GUID: lmB1YzGyQYAo7pnY7Zaa0WPgNAgGtya2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-23_08,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503230123
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Add testcases for testing fadump with PSeries and PSeries+KVM
combinations

It tests if fadump is successfully detected and registered in the first
kernel boot. Then crashes the kernel, and verifies whether we have a
/proc/vmcore in the 2nd boot

Also introduce 'wait_for_regex_console_pattern' to check for cases where
there is a single success message, but can have multiple failure
messages.

This is particularly useful for cases such as fadump, where the
success message is
    "Reserved 1024MB ... successfully"
But at the same point, it can fail with multiple errors such as
    "Not supported" or "Allocation failed"

'wait_for_regex_console_pattern' also has a timeout, for cases when we
know the success/failure should appear in a short amount of time,
instead of waiting for the much longer test timeout, such as kernels
with support of fadump will print the success/failure in earlyboot of
the kernel, while kernel without support of fadump won't print anything
for long time, and without a timeout the testcase keeps waiting till
longer test timeout

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
PowerNV also can be tested with this, will enable PowerNV tests after
MPIPL patches go in
---
---
 tests/functional/meson.build              |   2 +
 tests/functional/qemu_test/linuxkernel.py |  59 +++++++
 tests/functional/test_ppc64_fadump.py     | 182 ++++++++++++++++++++++
 3 files changed, 243 insertions(+)
 create mode 100755 tests/functional/test_ppc64_fadump.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 96d282892798..a1e8d7bf385a 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -47,6 +47,7 @@ test_timeouts = {
   'ppc64_powernv' : 480,
   'ppc64_pseries' : 480,
   'ppc64_replay' : 210,
+  'ppc64_fadump' : 480,
   'ppc64_tuxrun' : 420,
   'ppc64_mac99' : 120,
   'riscv64_tuxrun' : 120,
@@ -231,6 +232,7 @@ tests_ppc64_system_thorough = [
   'ppc64_replay',
   'ppc64_tuxrun',
   'ppc64_mac99',
+  'ppc64_fadump',
 ]
 
 tests_riscv32_system_quick = [
diff --git a/tests/functional/qemu_test/linuxkernel.py b/tests/functional/qemu_test/linuxkernel.py
index 2aca0ee3cd03..c4767527daf6 100644
--- a/tests/functional/qemu_test/linuxkernel.py
+++ b/tests/functional/qemu_test/linuxkernel.py
@@ -5,6 +5,9 @@
 
 import hashlib
 import urllib.request
+import logging
+import re
+import time
 
 from .cmd import wait_for_console_pattern, exec_command_and_wait_for_pattern
 from .testcase import QemuSystemTest
@@ -19,6 +22,62 @@ def wait_for_console_pattern(self, success_message, vm=None):
                                  failure_message='Kernel panic - not syncing',
                                  vm=vm)
 
+    def wait_for_regex_console_pattern(self, success_pattern,
+                                       failure_pattern=None,
+                                       timeout=None):
+        """
+        Similar to 'wait_for_console_pattern', but supports regex patterns,
+        hence multiple failure/success patterns can be detected at a time.
+
+        Args:
+            success_pattern (str | re.Pattern): A regex pattern that indicates
+                a successful event. If found, the method exits normally.
+            failure_pattern (str | re.Pattern, optional): A regex pattern that
+                indicates a failure event. If found, the test fails
+            timeout (int, optional): The maximum time (in seconds) to wait for
+                a match.
+                If exceeded, the test fails.
+        """
+
+        console = self.vm.console_file
+        console_logger = logging.getLogger('console')
+
+        self.log.debug(
+            f"Console interaction: success_msg='{success_pattern}' " +
+            f"failure_msg='{failure_pattern}' timeout='{timeout}s'")
+
+        # Only consume console output if waiting for something
+        if success_pattern is None and failure_pattern is None:
+            return
+
+        start_time = time.time()
+
+        while time.time() - start_time < timeout:
+            try:
+                msg = console.readline().decode().strip()
+            except UnicodeDecodeError:
+                msg = None
+            if not msg:
+                continue
+            console_logger.debug(msg)
+            if success_pattern is None or re.search(success_pattern, msg):
+                break
+            if failure_pattern:
+                # Find the matching error to print in log
+                match = re.search(failure_pattern, msg)
+                if not match:
+                    continue
+
+                console.close()
+                fail = 'Failure message found in console: "%s".' \
+                        ' Expected: "%s"' % \
+                        (match.group(), success_pattern)
+                self.fail(fail)
+
+        if time.time() - start_time >= timeout:
+            fail = f"Timeout ({timeout}s) while trying to search pattern"
+            self.fail(fail)
+
     def launch_kernel(self, kernel, initrd=None, dtb=None, console_index=0,
                       wait_for=None):
         self.vm.set_console(console_index=console_index)
diff --git a/tests/functional/test_ppc64_fadump.py b/tests/functional/test_ppc64_fadump.py
new file mode 100755
index 000000000000..d21175013490
--- /dev/null
+++ b/tests/functional/test_ppc64_fadump.py
@@ -0,0 +1,182 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from unittest import skip
+from qemu_test import Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test import LinuxKernelTest
+from qemu_test import exec_command, exec_command_and_wait_for_pattern
+
+class QEMUFadump(LinuxKernelTest):
+    """
+    Functional test to verify Fadump is working in following scenarios:
+
+    1. test_fadump_pseries:       PSeries
+    2. test_fadump_pseries_kvm:   PSeries + KVM
+    """
+
+    timeout = 90
+    KERNEL_COMMON_COMMAND_LINE = 'console=hvc0 fadump=on '
+    msg_panic = 'Kernel panic - not syncing'
+    msg_not_supported = 'Firmware-Assisted Dump is not supported on this hardware'
+    msg_registered_success = ''
+    msg_registered_failed = ''
+    msg_dump_active = ''
+
+    ASSET_EPAPR_KERNEL = Asset(
+        ('https://github.com/open-power/op-build/releases/download/v2.7/'
+         'zImage.epapr'),
+        '0ab237df661727e5392cee97460e8674057a883c5f74381a128fa772588d45cd')
+
+    ASSET_VMLINUZ_KERNEL = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora-secondary/'
+         'releases/39/Everything/ppc64le/os/ppc/ppc64/vmlinuz'),
+        ('81e5541d243b50c8f9568906c6918dda22239744d637bb9a7b22d23c3d661226'
+         '8d5302beb2ca5c06f93bdbc9736c414ef5120756c8bf496ff488ad07d116d67f')
+        )
+
+    ASSET_FEDORA_INITRD = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora-secondary/'
+        'releases/39/Everything/ppc64le/os/ppc/ppc64/initrd.img'),
+        'e7f24b44cb2aaa67d30e551db6ac8d29cc57c934b158dabca6b7f885f2cfdd9b')
+
+    def do_test_fadump(self, is_kvm=False, is_powernv=False):
+        """
+        Helper Function for Fadump tests below
+
+        It boots the VM with fadump enabled, checks if fadump is correctly
+        registered.
+        Then crashes the system causing a QEMU_SYSTEM_RESET, after which
+        dump should be available in the kernel.
+        Finally it checks the filesize of the exported /proc/vmcore in 2nd
+        kernel to verify it's same as the VM's memory size
+        """
+        if is_kvm:
+            self.require_accelerator("kvm")
+            self.vm.add_args("-accel", "kvm")
+        else:
+            self.require_accelerator("tcg")
+
+        if is_powernv:
+            self.set_machine("powernv10")
+        else:
+            # SLOF takes upto >20s in startup time, use VOF
+            self.set_machine("pseries")
+            self.vm.add_args("-machine", "x-vof=on")
+            self.vm.add_args("-m", "6G")
+
+        self.vm.set_console()
+
+        kernel_path = None
+
+        if is_powernv:
+            kernel_path = self.ASSET_EPAPR_KERNEL.fetch()
+        else:
+            kernel_path = self.ASSET_VMLINUZ_KERNEL.fetch()
+
+        initrd_path = self.ASSET_FEDORA_INITRD.fetch()
+
+        self.vm.add_args('-kernel', kernel_path)
+        self.vm.add_args('-initrd', initrd_path)
+        self.vm.add_args('-append', "fadump=on"\
+                         " -nodefaults -serial mon:stdio crashkernel=2G"\
+                         " rdinit=/bin/sh ")
+
+        self.vm.launch()
+
+        # If kernel detects fadump support, and "fadump=on" is in command
+        # line which we add above, it will print something like:
+        #
+        #     fadump: Reserved 1024MB of memory at 0x00000040000000 ...
+        #
+        # Else, if the kernel doesn't detect fadump support, it prints:
+        #
+        #     fadump: Firmware-Assisted Dump is not supported on this hardware
+        #
+        # Timeout after 10s if kernel doesn't print any fadump logs, this
+        # can happen due to fadump being disabled in the kernel
+        self.wait_for_regex_console_pattern(
+            success_pattern="fadump: Reserved ",
+            failure_pattern=r"fadump: (Firmware-Assisted Dump is not"\
+            " supported on this hardware|Failed to find memory chunk for"\
+            " reservation!)",
+            timeout=10
+        )
+
+        # Ensure fadump is registered successfully, if registration
+        # succeeds, we get a log from rtas fadump:
+        #
+        #     rtas fadump: Registration is successful!
+        self.wait_for_console_pattern(
+            "rtas fadump: Registration is successful!"
+        )
+
+        # Wait for the shell
+        self.wait_for_console_pattern("#")
+
+        # Mount /proc since not available in the initrd used
+        exec_command(self, command="mount -t proc proc /proc")
+
+        # Crash the kernel
+        exec_command(self, command="echo c > /proc/sysrq-trigger")
+
+        # Check for the kernel panic message, setting timeout to 10s as it
+        # should occur almost immediately after previous echo c
+        self.wait_for_regex_console_pattern(
+            success_pattern="Kernel panic - not syncing: sysrq" \
+                " triggered crash",
+            timeout=10
+        )
+
+        # Check if fadump is active
+        # If the kernel shows that fadump is active, that implies it's a
+        # crashkernel boot
+        # Else if the kernel shows "fadump: Reserved ..." then it's
+        # treating this as the first kernel boot, this is likely the case
+        # that qemu didn't pass the 'ibm,kernel-dump' device tree node
+        wait_for_console_pattern(
+            test=self,
+            success_message="rtas fadump: Firmware-assisted dump is active",
+            failure_message="fadump: Reserved "
+        )
+
+        # In a successful fadump boot, we get these logs:
+        #
+        # [    0.000000] fadump: Firmware-assisted dump is active.
+        # [    0.000000] fadump: Reserving <>MB of memory at <> for preserving crash data
+        #
+        # Check if these logs are present in the fadump boot
+        self.wait_for_console_pattern("preserving crash data")
+
+        # Wait for prompt
+        self.wait_for_console_pattern("sh-5.2#")
+
+        # Mount /proc since not available in the initrd used
+        exec_command_and_wait_for_pattern(self,
+            command="mount -t proc proc /proc",
+            success_message="#"
+        )
+
+        # Check if vmcore exists
+        exec_command_and_wait_for_pattern(self,
+            command="stat /proc/vmcore",
+            success_message="File: /proc/vmcore",
+            failure_message="No such file or directory"
+        )
+
+    def test_fadump_pseries(self):
+        return self.do_test_fadump(is_kvm=False, is_powernv=False)
+
+    @skip("PowerNV Fadump not supported yet")
+    def test_fadump_powernv(self):
+        return
+
+    def test_fadump_pseries_kvm(self):
+        """
+        Test Fadump in PSeries with KVM accel
+        """
+        self.do_test_fadump(is_kvm=True, is_powernv=False)
+
+if __name__ == '__main__':
+    QEMUFadump.main()
-- 
2.49.0


