Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2CD7E6300
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 05:59:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0x7P-0007K4-8F; Wed, 08 Nov 2023 23:58:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r0x7N-0007Jh-5U
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 23:58:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r0x7J-0003Zu-Vd
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 23:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699505889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aWZlSDJwFVJQVLZ45zUMJSIGPWvMA3lUcOeRE/pFG/w=;
 b=C6RvjUspbm6Cq6+SI31Lnl8i5tT3O2mHyyt1y5SdxVkDArSF6gkX8ViwjFKLLXyaQWJoAp
 fOYgRVaiwok1A9Jx7mdLCAJ3Rh+EoUrAqoNh/scPB5tzgaV7nYX7U83cMrMeU5zkm7asDf
 uEanUZe1KBpQCaJCGZ1GeieTcwQUqoA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-GROJ3LbYMlun7leVe2MOOw-1; Wed, 08 Nov 2023 23:56:24 -0500
X-MC-Unique: GROJ3LbYMlun7leVe2MOOw-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5a08e5c7debso343274a12.2
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 20:56:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699505783; x=1700110583;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aWZlSDJwFVJQVLZ45zUMJSIGPWvMA3lUcOeRE/pFG/w=;
 b=CqLVaN1QcwTXr7kIcpnBIz5NjIOU2byA6h8h+I7YxBKUhSgNbWD4HWAalKY0ccCaQP
 gIcS2GLSMIM1SaP4ZvDaJLIC01PkBWJ0Y5bMn44zb4lLyXKtABH1kLSjG/S9Dvxf15mv
 NHccF6pZkUi/gM3xLNBC/wdR3hKWSZTOGncEa9Rm83XQ4ufbRoWkPFVtSyzGTKl7oHn+
 fnoWiOeN/Vw65L+6z+YtjOSZ8AEdXL95STF7lofRMIHUEdETBYQG86XQp9aTRACD5ISY
 4TuHZVfOvqH5Lm9BU32RPvRWJbesldDXxZATGKsDEXcUfzaZH0MHH1uZXp8MZxIoHkXZ
 wCBg==
X-Gm-Message-State: AOJu0YwIIYXEd3vXGKf/MtootVzeQX8U00I9thEW1K44lrFXLACAY4T3
 JmhHzhBcIhi4YIdEdmBgbYgrEM0wI0gRxjUsy6N9R814cVSmxZTjbmnQbx+qMAWE3OgZtOMohva
 fWhrUFG/sgQJl31U=
X-Received: by 2002:a05:6a21:3e0c:b0:15b:2125:890f with SMTP id
 bk12-20020a056a213e0c00b0015b2125890fmr4455816pzc.37.1699505782622; 
 Wed, 08 Nov 2023 20:56:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0JLfjTpcP/6iKfRi3epz+BI27I/hT82bc3mJn4wg7vuWDK+qkbrd9WwdmQnYZlKyFrqcYsA==
X-Received: by 2002:a05:6a21:3e0c:b0:15b:2125:890f with SMTP id
 bk12-20020a056a213e0c00b0015b2125890fmr4455802pzc.37.1699505782076; 
 Wed, 08 Nov 2023 20:56:22 -0800 (PST)
Received: from localhost.localdomain ([115.96.107.18])
 by smtp.googlemail.com with ESMTPSA id
 l2-20020a17090aec0200b00273744e6eccsm358958pjy.12.2023.11.08.20.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 20:56:21 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, imammedo@redhat.com,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v6] tests/avocado: add test to exercize processor address
 space memory bound checks
Date: Thu,  9 Nov 2023 10:26:01 +0530
Message-ID: <20231109045601.33349-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

QEMU has validations to make sure that a VM is not started with more memory
(static and hotpluggable memory) than what the guest processor can address
directly with its addressing bits. This change adds a test to make sure QEMU
fails to start with a specific error message when an attempt is made to
start a VM with more memory than what the processor can directly address.
The test also checks for passing cases when the address space of the processor
is capable of addressing all memory. Boundary cases are tested.

CC: imammedo@redhat.com
CC: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/avocado/mem-addr-space-check.py | 367 ++++++++++++++++++++++++++
 1 file changed, 367 insertions(+)
 create mode 100644 tests/avocado/mem-addr-space-check.py

Changelog:
v6: added phil's suggestions - added comment to explain why a sleep delay
    is needed. Reduced delay to 1 sec. Added a one place definition for
    the sleep duration so we can tweak it if needed later. Added phil's
    tag. rebased.
v5:
  - made the negative test cases (ones that do not result in QEMU crash)
    more robust by checking the non-existence of the "phys-bits too low"
    log.
  - added a new test case for AMD HT window where QEMU starts fine.
  - rebased.
  - cosmetic typo/comment adjustments.

Tests all pass:
$ ./pyvenv/bin/avocado run tests/avocado/mem-addr-space-check.py --tap -
1..15
ok 1 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_pse36
ok 2 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_pae
ok 3 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_pentium_pse36
ok 4 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_pentium_pae
ok 5 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_pentium2
ok 6 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_nonpse36
ok 7 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_tcg_q35_70_amd
ok 8 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_tcg_q35_71_amd
ok 9 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35_70_amd
ok 10 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35_71_amd
ok 11 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35_71_intel
ok 12 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_tcg_q35_71_amd_41bits
ok 13 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35_71_amd_41bits
ok 14 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_tcg_q35_intel_cxl
ok 15 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35_intel_cxl

v4: incorporated changes related to suggestions from David.
v3: added pae tests as well.
v2: added 64-bit tests. Added cxl tests.

diff --git a/tests/avocado/mem-addr-space-check.py b/tests/avocado/mem-addr-space-check.py
new file mode 100644
index 0000000000..fae7d48598
--- /dev/null
+++ b/tests/avocado/mem-addr-space-check.py
@@ -0,0 +1,367 @@
+# Check for crash when using memory beyond the available guest processor
+# address space.
+#
+# Copyright (c) 2023 Red Hat, Inc.
+#
+# Author:
+#  Ani Sinha <anisinha@redhat.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+
+from avocado_qemu import QemuSystemTest
+import signal
+import time
+
+class MemAddrCheck(QemuSystemTest):
+    # after launch, in order to generate the logs from QEMU we need to
+    # wait for some time. Launching and then immediately shutting down
+    # the VM generates empty logs. A delay of 1 second is added for
+    # this reason.
+    DELAY_Q35_BOOT_SEQUENCE = 1
+
+    # first, lets test some 32-bit processors.
+    # for all 32-bit cases, pci64_hole_size is 0.
+    def test_phybits_low_pse36(self):
+        """
+        :avocado: tags=machine:q35
+        :avocado: tags=arch:x86_64
+
+        With pse36 feature ON, a processor has 36 bits of addressing. So it can
+        access up to a maximum of 64GiB of memory. Memory hotplug region begins
+        at 4 GiB boundary when "above_4g_mem_size" is 0 (this would be true when
+        we have 0.5 GiB of VM memory, see pc_q35_init()). This means total
+        hotpluggable memory size is 60 GiB. Per slot, we reserve 1 GiB of memory
+        for dimm alignment for all newer machines (see enforce_aligned_dimm
+        property for pc machines and pc_get_device_memory_range()). That leaves
+        total hotpluggable actual memory size of 59 GiB. If the VM is started
+        with 0.5 GiB of memory, maxmem should be set to a maximum value of
+        59.5 GiB to ensure that the processor can address all memory directly.
+        Note that 64-bit pci hole size is 0 in this case. If maxmem is set to
+        59.6G, QEMU should fail to start with a message "phy-bits are too low".
+        If maxmem is set to 59.5G with all other QEMU parameters identical, QEMU
+        should start fine.
+        """
+        self.vm.add_args('-S', '-machine', 'q35', '-m',
+                         '512,slots=1,maxmem=59.6G',
+                         '-cpu', 'pentium,pse36=on', '-display', 'none',
+                         '-object', 'memory-backend-ram,id=mem1,size=1G',
+                         '-device', 'pc-dimm,id=vm0,memdev=mem1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        self.vm.wait()
+        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be 1")
+        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
+
+    def test_phybits_low_pae(self):
+        """
+        :avocado: tags=machine:q35
+        :avocado: tags=arch:x86_64
+
+        With pae feature ON, a processor has 36 bits of addressing. So it can
+        access up to a maximum of 64GiB of memory. Rest is the same as the case
+        with pse36 above.
+        """
+        self.vm.add_args('-S', '-machine', 'q35', '-m',
+                         '512,slots=1,maxmem=59.6G',
+                         '-cpu', 'pentium,pae=on', '-display', 'none',
+                         '-object', 'memory-backend-ram,id=mem1,size=1G',
+                         '-device', 'pc-dimm,id=vm0,memdev=mem1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        self.vm.wait()
+        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be 1")
+        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
+
+    def test_phybits_ok_pentium_pse36(self):
+        """
+        :avocado: tags=machine:q35
+        :avocado: tags=arch:x86_64
+
+        Setting maxmem to 59.5G and making sure that QEMU can start with the
+        same options as the failing case above with pse36 cpu feature.
+        """
+        self.vm.add_args('-machine', 'q35', '-m',
+                         '512,slots=1,maxmem=59.5G',
+                         '-cpu', 'pentium,pse36=on', '-display', 'none',
+                         '-object', 'memory-backend-ram,id=mem1,size=1G',
+                         '-device', 'pc-dimm,id=vm0,memdev=mem1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        time.sleep(self.DELAY_Q35_BOOT_SEQUENCE)
+        self.vm.shutdown()
+        self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')
+
+    def test_phybits_ok_pentium_pae(self):
+        """
+        :avocado: tags=machine:q35
+        :avocado: tags=arch:x86_64
+
+        Test is same as above but now with pae cpu feature turned on.
+        Setting maxmem to 59.5G and making sure that QEMU can start fine
+        with the same options as the case above.
+        """
+        self.vm.add_args('-machine', 'q35', '-m',
+                         '512,slots=1,maxmem=59.5G',
+                         '-cpu', 'pentium,pae=on', '-display', 'none',
+                         '-object', 'memory-backend-ram,id=mem1,size=1G',
+                         '-device', 'pc-dimm,id=vm0,memdev=mem1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        time.sleep(self.DELAY_Q35_BOOT_SEQUENCE)
+        self.vm.shutdown()
+        self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')
+
+    def test_phybits_ok_pentium2(self):
+        """
+        :avocado: tags=machine:q35
+        :avocado: tags=arch:x86_64
+
+        Pentium2 has 36 bits of addressing, so its same as pentium
+        with pse36 ON.
+        """
+        self.vm.add_args('-machine', 'q35', '-m',
+                         '512,slots=1,maxmem=59.5G',
+                         '-cpu', 'pentium2', '-display', 'none',
+                         '-object', 'memory-backend-ram,id=mem1,size=1G',
+                         '-device', 'pc-dimm,id=vm0,memdev=mem1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        time.sleep(self.DELAY_Q35_BOOT_SEQUENCE)
+        self.vm.shutdown()
+        self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')
+
+    def test_phybits_low_nonpse36(self):
+        """
+        :avocado: tags=machine:q35
+        :avocado: tags=arch:x86_64
+
+        Pentium processor has 32 bits of addressing without pse36 or pae
+        so it can access physical address up to 4 GiB. Setting maxmem to
+        4 GiB should make QEMU fail to start with "phys-bits too low"
+        message because the region for memory hotplug is always placed
+        above 4 GiB due to the PCI hole and simplicity.
+        """
+        self.vm.add_args('-S', '-machine', 'q35', '-m',
+                         '512,slots=1,maxmem=4G',
+                         '-cpu', 'pentium', '-display', 'none',
+                         '-object', 'memory-backend-ram,id=mem1,size=1G',
+                         '-device', 'pc-dimm,id=vm0,memdev=mem1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        self.vm.wait()
+        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be 1")
+        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
+
+    # now lets test some 64-bit CPU cases.
+    def test_phybits_low_tcg_q35_70_amd(self):
+        """
+        :avocado: tags=machine:q35
+        :avocado: tags=arch:x86_64
+
+        For q35 7.1 machines and above, there is a HT window that starts at
+        1024 GiB and ends at 1 TiB - 1. If the max GPA falls in this range,
+        "above_4G" memory is adjusted to start at 1 TiB boundary for AMD cpus
+        in the default case. Lets test without that case for machines 7.0.
+        For q35-7.0 machines, "above 4G" memory starts are 4G.
+        pci64_hole size is 32 GiB. Since TCG_PHYS_ADDR_BITS is defined to
+        be 40, TCG emulated CPUs have maximum of 1 TiB (1024 GiB) of
+        directly addressible memory.
+        Hence, maxmem value at most can be
+        1024 GiB - 4 GiB - 1 GiB per slot for alignment - 32 GiB + 0.5 GiB
+        which is equal to 987.5 GiB. Setting the value to 988 GiB should
+        make QEMU fail with the error message.
+        """
+        self.vm.add_args('-S', '-machine', 'pc-q35-7.0', '-m',
+                         '512,slots=1,maxmem=988G',
+                         '-display', 'none',
+                         '-object', 'memory-backend-ram,id=mem1,size=1G',
+                         '-device', 'pc-dimm,id=vm0,memdev=mem1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        self.vm.wait()
+        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be 1")
+        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
+
+    def test_phybits_low_tcg_q35_71_amd(self):
+        """
+        :avocado: tags=machine:q35
+        :avocado: tags=arch:x86_64
+
+        AMD_HT_START is defined to be at 1012 GiB. So for q35 machines
+        version > 7.0 and AMD cpus, instead of 1024 GiB limit for 40 bit
+        processor address space, it has to be 1012 GiB , that is 12 GiB
+        less than the case above in order to accomodate HT hole.
+        Make sure QEMU fails when maxmem size is 976 GiB (12 GiB less
+        than 988 GiB).
+        """
+        self.vm.add_args('-S', '-machine', 'pc-q35-7.1', '-m',
+                         '512,slots=1,maxmem=976G',
+                         '-display', 'none',
+                         '-object', 'memory-backend-ram,id=mem1,size=1G',
+                         '-device', 'pc-dimm,id=vm0,memdev=mem1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        self.vm.wait()
+        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be 1")
+        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
+
+    def test_phybits_ok_tcg_q35_70_amd(self):
+        """
+        :avocado: tags=machine:q35
+        :avocado: tags=arch:x86_64
+
+        Same as q35-7.0 AMD case except that here we check that QEMU can
+        successfully start when maxmem is < 988G.
+        """
+        self.vm.add_args('-S', '-machine', 'pc-q35-7.0', '-m',
+                         '512,slots=1,maxmem=987.5G',
+                         '-display', 'none',
+                         '-object', 'memory-backend-ram,id=mem1,size=1G',
+                         '-device', 'pc-dimm,id=vm0,memdev=mem1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        time.sleep(self.DELAY_Q35_BOOT_SEQUENCE)
+        self.vm.shutdown()
+        self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')
+
+    def test_phybits_ok_tcg_q35_71_amd(self):
+        """
+        :avocado: tags=machine:q35
+        :avocado: tags=arch:x86_64
+
+        Same as q35-7.1 AMD case except that here we check that QEMU can
+        successfully start when maxmem is < 976G.
+        """
+        self.vm.add_args('-S', '-machine', 'pc-q35-7.1', '-m',
+                         '512,slots=1,maxmem=975.5G',
+                         '-display', 'none',
+                         '-object', 'memory-backend-ram,id=mem1,size=1G',
+                         '-device', 'pc-dimm,id=vm0,memdev=mem1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        time.sleep(self.DELAY_Q35_BOOT_SEQUENCE)
+        self.vm.shutdown()
+        self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')
+
+    def test_phybits_ok_tcg_q35_71_intel(self):
+        """
+        :avocado: tags=machine:q35
+        :avocado: tags=arch:x86_64
+
+        Same parameters as test_phybits_low_tcg_q35_71_amd() but use
+        Intel cpu instead. QEMU should start fine in this case as
+        "above_4G" memory starts at 4G.
+        """
+        self.vm.add_args('-S', '-cpu', 'Skylake-Server',
+                         '-machine', 'pc-q35-7.1', '-m',
+                         '512,slots=1,maxmem=976G',
+                         '-display', 'none',
+                         '-object', 'memory-backend-ram,id=mem1,size=1G',
+                         '-device', 'pc-dimm,id=vm0,memdev=mem1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        time.sleep(self.DELAY_Q35_BOOT_SEQUENCE)
+        self.vm.shutdown()
+        self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')
+
+    def test_phybits_low_tcg_q35_71_amd_41bits(self):
+        """
+        :avocado: tags=machine:q35
+        :avocado: tags=arch:x86_64
+
+        AMD processor with 41 bits. Max cpu hw address = 2 TiB.
+        By setting maxram above 1012 GiB  - 32 GiB - 4 GiB = 976 GiB, we can
+        force "above_4G" memory to start at 1 TiB for q35-7.1 machines
+        (max GPA will be above AMD_HT_START which is defined as 1012 GiB).
+
+        With pci_64_hole size at 32 GiB, in this case, maxmem should be 991.5
+        GiB with 1 GiB per slot for alignment and 0.5 GiB as non-hotplug
+        memory for the VM (1024 - 32 - 1 + 0.5). With 992 GiB, QEMU should
+        fail to start.
+        """
+        self.vm.add_args('-S', '-cpu', 'EPYC-v4,phys-bits=41',
+                         '-machine', 'pc-q35-7.1', '-m',
+                         '512,slots=1,maxmem=992G',
+                         '-display', 'none',
+                         '-object', 'memory-backend-ram,id=mem1,size=1G',
+                         '-device', 'pc-dimm,id=vm0,memdev=mem1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        self.vm.wait()
+        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be 1")
+        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
+
+    def test_phybits_ok_tcg_q35_71_amd_41bits(self):
+        """
+        :avocado: tags=machine:q35
+        :avocado: tags=arch:x86_64
+
+        AMD processor with 41 bits. Max cpu hw address = 2 TiB.
+        Same as above but by setting maxram beween 976 GiB and 992 Gib,
+        QEMU should start fine.
+        """
+        self.vm.add_args('-S', '-cpu', 'EPYC-v4,phys-bits=41',
+                         '-machine', 'pc-q35-7.1', '-m',
+                         '512,slots=1,maxmem=990G',
+                         '-display', 'none',
+                         '-object', 'memory-backend-ram,id=mem1,size=1G',
+                         '-device', 'pc-dimm,id=vm0,memdev=mem1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        time.sleep(self.DELAY_Q35_BOOT_SEQUENCE)
+        self.vm.shutdown()
+        self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')
+
+    def test_phybits_low_tcg_q35_intel_cxl(self):
+        """
+        :avocado: tags=machine:q35
+        :avocado: tags=arch:x86_64
+
+        cxl memory window starts after memory device range. Here, we use 1 GiB
+        of cxl window memory. 4G_mem end aligns at 4G. pci64_hole is 32 GiB and
+        starts after the cxl memory window.
+        So maxmem here should be at most 986 GiB considering all memory boundary
+        alignment constraints with 40 bits (1 TiB) of processor physical bits.
+        """
+        self.vm.add_args('-S', '-cpu', 'Skylake-Server,phys-bits=40',
+                         '-machine', 'q35,cxl=on', '-m',
+                         '512,slots=1,maxmem=987G',
+                         '-display', 'none',
+                         '-device', 'pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1',
+                         '-M', 'cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=1G')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        self.vm.wait()
+        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be 1")
+        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
+
+    def test_phybits_ok_tcg_q35_intel_cxl(self):
+        """
+        :avocado: tags=machine:q35
+        :avocado: tags=arch:x86_64
+
+        Same as above but here we do not reserve any cxl memory window. Hence,
+        with the exact same parameters as above, QEMU should start fine even
+        with cxl enabled.
+        """
+        self.vm.add_args('-S', '-cpu', 'Skylake-Server,phys-bits=40',
+                         '-machine', 'q35,cxl=on', '-m',
+                         '512,slots=1,maxmem=987G',
+                         '-display', 'none',
+                         '-device', 'pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        time.sleep(self.DELAY_Q35_BOOT_SEQUENCE)
+        self.vm.shutdown()
+        self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')
-- 
2.42.0


