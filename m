Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7597BB22D
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 09:32:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qofJN-0006XP-NP; Fri, 06 Oct 2023 03:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qofJB-0006TD-Su
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 03:31:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qofJ9-00031X-ON
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 03:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696577494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oIbD361Dq1XrdFMBm2ks5K17RPXWKenYwe5/7qyYG28=;
 b=B7Sf91YanvaAwZbpDGUSFy5tzH75DDa0U7pcl1dN1oM/F/NfRy98c2D44NbLmlXNsgz7wg
 6e1UbcERoc3H7wgwfJrhnMWaEgsRwM6A8l1HAaImrdE0Awb5p8zZ0HW9DT4lcHNpQZVQ3W
 q2CeEA3IQDydz3G0yHSUZdGNT7wj2f8=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-wUg6LeeaNeSxTOoq7XvOwA-1; Fri, 06 Oct 2023 03:31:22 -0400
X-MC-Unique: wUg6LeeaNeSxTOoq7XvOwA-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3ae65e9d394so2800657b6e.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 00:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696577481; x=1697182281;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oIbD361Dq1XrdFMBm2ks5K17RPXWKenYwe5/7qyYG28=;
 b=QzP231Isgw6KUtdDYjD1/rGg2HEIBij+TD6dLI99DS8/Gia67i3HQST9YnuC4Ah2Hq
 91QzF3HyYs1L6Q6xoC1CQV5YC6nObzj4aKOiIqO1SFsl+n8W2Fa15tJnd/kW7X/QOGaa
 zHniaZkstg+pgfuVEJiH+xzqH2qRCCg980RM2J9h8rpvhV1Jf1aGZ6qeDtN8jksLfhps
 G6hrZbLN6/vVcGwmPGcWKz8A5JsQ2YGOGBDKpHEaVM+Vmi1w8fGe2NTCFxtw5Y/isjBu
 tbG9NxLRFJCJr6KsthMYFAZaoKyzq8xgrTTicbvgECgDh1rzkDGpZiUte+cprVDfhvlv
 +kBA==
X-Gm-Message-State: AOJu0YwmDME6LWkDzjPKl0p3jLZJHd+TfwUDrw4sWPUYyJBOHnR74FLI
 a0GWtLp0M4lYaLlW5IX/vdebY6gkrI/+ElWwYFJY4ZgTl7LHZr0ShbUqJH1+5W+HYm3+hNdURJk
 1ADaa4q1HEqICaFw=
X-Received: by 2002:a05:6358:339b:b0:143:9235:9f1f with SMTP id
 i27-20020a056358339b00b0014392359f1fmr6429637rwd.12.1696577481422; 
 Fri, 06 Oct 2023 00:31:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG+qnPy/0Lkqjsgq3XYccmaoWl+Oj4DZTYPIlt/+7tKb7NlHKbnXacGPlMicFHzL7+L0zzVQ==
X-Received: by 2002:a05:6358:339b:b0:143:9235:9f1f with SMTP id
 i27-20020a056358339b00b0014392359f1fmr6429628rwd.12.1696577480922; 
 Fri, 06 Oct 2023 00:31:20 -0700 (PDT)
Received: from localhost.localdomain ([115.96.157.133])
 by smtp.googlemail.com with ESMTPSA id
 m22-20020a637d56000000b00563590be25esm2670338pgn.29.2023.10.06.00.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 00:31:20 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, imammedo@redhat.com,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH] tests/avocado: add test to exercize processor address space
 memory bound checks
Date: Fri,  6 Oct 2023 13:00:22 +0530
Message-ID: <20231006073022.120279-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

QEMU has validations to make sure that a VM is not started with more memory
(static and hotpluggable memory) than what the guest processor can address
directly with its addressing bits. This change adds a test to make sure QEMU
fails to start with a specific error message when an attempt is made to
start a VM with more memory than what the processor can directly address.
The test also checks for passing cases when the address space of the processor
is capable of addressing all memory. Boundary cases are tested.

CC: imammedo@redhat.com
CC: David Hildenbrand <david@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/avocado/mem-addr-space-check.py | 113 ++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 tests/avocado/mem-addr-space-check.py

diff --git a/tests/avocado/mem-addr-space-check.py b/tests/avocado/mem-addr-space-check.py
new file mode 100644
index 0000000000..6949f7567e
--- /dev/null
+++ b/tests/avocado/mem-addr-space-check.py
@@ -0,0 +1,113 @@
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
+
+class MemAddrCheck(QemuSystemTest):
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
+        If maxmem is set to 59.6G, QEMU should fail to start with a message that
+        says "phy-bits are too low".
+        If maxmem is set to 59.5G with all other QEMU parameters identical, QEMU
+        should start fine.
+        """
+        self.vm.add_args('-S', '-machine', 'q35', '-m',
+                         '512,slots=1,maxmem=59.6G',
+                         '-cpu', 'pentium,pse36=on', '-display', 'none',
+                         '-object', 'memory-backend-ram,id=mem1,size=1G',
+                         '-device', 'virtio-mem-pci,id=vm0,memdev=mem1')
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
+        same options as the failing case above.
+        """
+        self.vm.add_args('-machine', 'q35', '-m',
+                         '512,slots=1,maxmem=59.5G',
+                         '-cpu', 'pentium,pse36=on', '-display', 'none',
+                         '-object', 'memory-backend-ram,id=mem1,size=1G',
+                         '-device', 'virtio-mem-pci,id=vm0,memdev=mem1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        self.vm.shutdown()
+        self.assertEquals(self.vm.exitcode(), -signal.SIGTERM,
+                          "QEMU did not terminate gracefully upon SIGTERM")
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
+                         '-device', 'virtio-mem-pci,id=vm0,memdev=mem1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        self.vm.shutdown()
+        self.assertEquals(self.vm.exitcode(), -signal.SIGTERM,
+                          "QEMU did not terminate gracefully upon SIGTERM")
+
+    def test_phybits_low_nonpse36(self):
+        """
+        :avocado: tags=machine:q35
+        :avocado: tags=arch:x86_64
+
+        Pentium processor has 32 bits of addressing without pse36 or pae
+        so it can access up to 4 GiB of memory. Setting maxmem to 4GiB
+        should make QEMU fail to start with "phys-bits too low" message.
+        """
+        self.vm.add_args('-S', '-machine', 'q35', '-m',
+                         '512,slots=1,maxmem=4G',
+                         '-cpu', 'pentium', '-display', 'none',
+                         '-object', 'memory-backend-ram,id=mem1,size=1G',
+                         '-device', 'virtio-mem-pci,id=vm0,memdev=mem1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        self.vm.wait()
+        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be 1")
+        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
-- 
2.42.0


