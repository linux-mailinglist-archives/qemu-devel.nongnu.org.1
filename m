Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD2C7EA2B3
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:19:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2bVl-0007nh-97; Mon, 13 Nov 2023 13:18:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2bVh-0007iV-Oa
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:18:09 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2bVe-0000XM-Gx
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:18:09 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507adc3381cso6306758e87.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 10:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699899484; x=1700504284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cIDYmW795avdqlddhv1SI9qKCLfA9vhXJay8WJOaVbQ=;
 b=m3QClHer4d1X7fweXkmWIdnrWEOByyjekK9OqgTIs3FjmP9oYxZpj6xX8uFItCuxx4
 ZxWVFdqo+hdYpfS5yYSzSyYoSomXB72GgHr9Oa0KZEYCyYC897iWIRvXKUTaGe7P3HCm
 W0CM2YIdVmoWtQctsTEibpolGAAc6dPRjwZnKb1hMchmhrZoFiyWW8Nah7mI3I3zNQgr
 R0m4pe7T+xa9p/K0ET6aTBlglmy+yUcooysrfurOAj86XuUPuxoQ0A96mZmDdubw9UIi
 3ee89KMj1+ujAWXr23qk4yIIC4Tdij2nobeosIYC9/2F6QQYi93BaBMWTichk3AcUjwx
 5ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699899484; x=1700504284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cIDYmW795avdqlddhv1SI9qKCLfA9vhXJay8WJOaVbQ=;
 b=d1npt6EKY23+htdD8OAL6KPbUgA827wudk1DTYO8IZZu7z4LDQ1/ZIiwL7tpLhFASV
 fB74a3PYaVhQi4CfzmTvRl24UPbu+Sbrrft8ovbJxm6XnSg4EQNUnlSpn9dT5FT2WDl/
 2rdy9XaPPpjve7pad874/O0uX2MAcDKnJVaGdxLC/1i90cD/ayCmGc6vf47gHl+33ZxP
 g9j31h9HLX0yM9BmhUJL2cWkzYxFU8N7gbYsm2EfoVdvJvUQYb80jzKQ8C51yzovS51w
 wiVhjoDXA/0yD/nZJCpj4O6KrQBWCwx60Lx+4zPeOa7qkKPPv1WhrAXWJ8ab4C+3X41v
 2c/w==
X-Gm-Message-State: AOJu0YzqEEfXCdB2GaqcbnSFk04QcyhRcs1hhfHErBfpTgW+67wiWzAy
 w3WQ2h3DxvzIord3/l2FUL5FAPYyyjk5GvnjuVo=
X-Google-Smtp-Source: AGHT+IFHQgdbO+hNj3D6cei5osDOlywBzESF6YFgxrrwio61NjiugKXc7nSgBLXwIDJM+9l36DNmyw==
X-Received: by 2002:a05:6512:2303:b0:50a:2710:d207 with SMTP id
 o3-20020a056512230300b0050a2710d207mr6909410lfu.53.1699899483790; 
 Mon, 13 Nov 2023 10:18:03 -0800 (PST)
Received: from m1x-phil.lan ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 27-20020a508e1b000000b0053e89721d4esm4082767edw.68.2023.11.13.10.18.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 10:18:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 imammedo@redhat.com, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 3/5] tests/avocado: add test to exercise processor address
 space memory bound checks
Date: Mon, 13 Nov 2023 19:17:42 +0100
Message-ID: <20231113181744.49537-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113181744.49537-1-philmd@linaro.org>
References: <20231113181744.49537-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Ani Sinha <anisinha@redhat.com>

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
Message-ID: <20231109045601.33349-1-anisinha@redhat.com>
Message-ID: <D5D8D419-76BA-4FB0-9BAC-4F7470A052FC@redhat.com>
[PMD: Use SPDX tag]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/avocado/mem-addr-space-check.py | 356 ++++++++++++++++++++++++++
 1 file changed, 356 insertions(+)
 create mode 100644 tests/avocado/mem-addr-space-check.py

diff --git a/tests/avocado/mem-addr-space-check.py b/tests/avocado/mem-addr-space-check.py
new file mode 100644
index 0000000000..be949222a4
--- /dev/null
+++ b/tests/avocado/mem-addr-space-check.py
@@ -0,0 +1,356 @@
+# Check for crash when using memory beyond the available guest processor
+# address space.
+#
+# Copyright (c) 2023 Red Hat, Inc.
+#
+# Author:
+#  Ani Sinha <anisinha@redhat.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
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
2.41.0


