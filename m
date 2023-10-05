Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1367BA351
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 17:53:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoQep-0005ok-6H; Thu, 05 Oct 2023 11:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qoQeS-0005iV-UP
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:52:39 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qoQeF-0004bS-0v
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:52:36 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c60a514f3aso8904825ad.3
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 08:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696521140; x=1697125940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dHHSw1bdvRzpP+mdl94PVamC16RKtUmyc+K1JCzF9+w=;
 b=P/j2bz87uvhkmf6CcDsTntT4NK1UbK085Yk/HTWco5zDgKpuue7+eTB8Vz66tsJlQf
 KaHddqIPKnpmQHgH4sPWSE0sxUkafbvClP8HbFdZj/y2nuMCQD38e/+Y9AKMk077QNMP
 Zj4x4mxGubrj67Ot5dtAFL5crN2koQ93/EvHU/4g+55zdr5M9Qsx+PBKu9JO25QbgP7Z
 25R5EiVgHbl9ZKNlIqOHjPdB1TjPodsy0RngiNdBI/o/Ujnn9rIBDCaxzejMIOlb9gxc
 lmidZ6Keknh9zddZJvEJHyAiyX7A3dhdMoT32ew8KKO+ezkvATk19Co/qOCpYk0eC27V
 5Nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696521140; x=1697125940;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dHHSw1bdvRzpP+mdl94PVamC16RKtUmyc+K1JCzF9+w=;
 b=faaCjf9EDVXjqy8XnAM9X9o6JWJHyaB/cKq0YiahQTMsnIq53VUUvGY96eIt71SYau
 RYgv+/sTSvInLsfqfk232P6WRtCGa4k8+cj7SehCzrFKn04lsDn0UEeXFgcWWeG0V+FL
 E2EcWxRErZ3eaGMSE28G9DMFisuj3h2t8atNe+B9R9jhq4NhqAWWH2xx9q/AREfhxRzw
 9Tre5EpAJOm7y8IlEs86IL4RgEyv6uWpl9jRLIpE6bgaue8Bh63lYdjaQJla4+PosWc1
 vlUm/hwI4BJL20kQb3acoUrtpp/K/abL8NIA/3GVCDrE1okMw5LuBKazm44LSKzfy33e
 +OUg==
X-Gm-Message-State: AOJu0Yx1XjqcYmMx6se+CCvPp/XOE+npNdJYBuRdfcQMySHvCl6xQPvf
 TMRoMlExy1bJGwUVsZ42ca624a+1lVMZ8Q==
X-Google-Smtp-Source: AGHT+IHdo9SCVSoo8KJMH4qbWXQF+cWpuhirvITSzC+PGswQkzo/DAzl2kCm+AGlTOQOxrrCY/OZQg==
X-Received: by 2002:a17:902:904b:b0:1b9:e241:ad26 with SMTP id
 w11-20020a170902904b00b001b9e241ad26mr5237797plz.9.1696521140465; 
 Thu, 05 Oct 2023 08:52:20 -0700 (PDT)
Received: from ?IPV6:2001:ee0:50f4:9050:b98f:b88b:1a9d:6699?
 ([2001:ee0:50f4:9050:b98f:b88b:1a9d:6699])
 by smtp.gmail.com with ESMTPSA id
 n14-20020a170902968e00b001bf044dc1a6sm1865071plp.39.2023.10.05.08.52.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 08:52:20 -0700 (PDT)
Message-ID: <296fd85e-6e52-4357-a603-68e9e5611df4@gmail.com>
Date: Thu, 5 Oct 2023 22:52:16 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [RFC PATCH] tcg, apic: create a separate root memory region for each
 CPU
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Joao Martins <joao.m.martins@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20230926160637.27995-1-minhquangbui99@gmail.com>
 <b05e4594-aa41-477f-9914-2835ebe9643b@gmail.com>
In-Reply-To: <b05e4594-aa41-477f-9914-2835ebe9643b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

Currently, by default, every TCG cpu has root memory region to the same
system memory region. In order to support APIC MMIO relocation as well as
correctly disable APIC MMIO in disabled and x2APIC state, in this commit,
we create a separate root memory region for every CPU. The system memory
region is added to this container root memory region, later an separate
APIC MMIO is added with higher priority than system memory . With separate
APIC MMIO region per CPU, APIC MMIO relocation and disable can be done per
CPU without interfering without others.

Because the MSI base address is the same as APIC MMIO, the MMIO region
currently serves 2 purposes: APIC register access and MSI handler. In case
no interrupt remapping device is used, devices send MSI by writing to
0xfee00000 in system memory. However, as we move APIC MMIO out of system
memory we need to change the device code to call apic_send_msi instead of
writing to system memory.

This commit passes the APIC MMIO relocation test in kvm-unit-tests, still
fails APIC disable, however, I think we should treat those as pass

Before:
	FAIL: apic_disable: *0xfee00030: 50014
	FAIL: apic_disable: *0xfee00080: f0
	FAIL: apic_disable: *0xfee00030: 50014
	FAIL: apic_disable: *0xfee00080: f0
After:
	FAIL: apic_disable: *0xfee00030: 0
	FAIL: apic_disable: *0xfee00080: 0
	FAIL: apic_disable: *0xfee00030: 0
	FAIL: apic_disable: *0xfee00080: 0

Before this commit, we still can read APIC register, after this commit we
cannot. However, the test memset disabled MMIO region with 0xff and expects
to read back the 0xff value. As we disable APIC MMIO memory region, the
write is dispatched to system memory which has unassigned read/write
operation, so read returns 0 and write has no effect.

This commit is tested on booting up Linux kernel with and without Intel/AMD
IOMMU on enabled/disabled x2APIC CPUs.

The memory region tree when running without interrupt remapping device

	~ info mtree
Before:
	address-space: cpu-memory-0
	address-space: cpu-memory-1
	address-space: memory
	  0000000000000000-ffffffffffffffff (prio 0, i/o): system
After:
	address-space: cpu-memory-0
	  0000000000000000-ffffffffffffffff (prio 0, i/o): memory
	    0000000000000000-ffffffffffffffff (prio 0, i/o): alias memory
	      @system 0000000000000000-ffffffffffffffff
	    00000000fee00000-00000000feefffff (prio 4096, i/o): apic-msi

	address-space: cpu-memory-1
	  0000000000000000-ffffffffffffffff (prio 0, i/o): memory
	    0000000000000000-ffffffffffffffff (prio 0, i/o): alias memory
	      @system 0000000000000000-ffffffffffffffff
	    00000000fee00000-00000000feefffff (prio 4096, i/o): apic-msi

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
  hw/intc/apic.c                   | 24 ++++++++++++++++++++++--
  hw/intc/ioapic.c                 | 32 +++++++++++++++++++++++++++-----
  hw/pci/pci.c                     | 25 +++++++++++++++++++++++--
  include/hw/i386/apic.h           |  1 +
  target/i386/cpu-sysemu.c         | 14 +++++++++++---
  target/i386/tcg/sysemu/tcg-cpu.c | 13 +++++++++++++
  6 files changed, 97 insertions(+), 12 deletions(-)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index b8f56836a6..0bd5b5d1f9 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -340,17 +340,34 @@ static void apic_set_base_check(APICCommonState 
*s, uint64_t val)
          raise_exception_ra(&s->cpu->env, EXCP0D_GPF, GETPC());
  }

+/* set base address and enable/disable APIC MMIO */
+static void apic_io_memory_set_base_enabled(APICCommonState *s,
+                                            hwaddr address,
+                                            bool enabled)
+{
+    if (tcg_enabled()) {
+        qemu_mutex_lock_iothread();
+        memory_region_set_address(&s->io_memory, address);
+        memory_region_set_enabled(&s->io_memory, enabled);
+        qemu_mutex_unlock_iothread();
+    }
+}
+
  static void apic_set_base(APICCommonState *s, uint64_t val)
  {
+    hwaddr new_base = val & MSR_IA32_APICBASE_BASE;
+    bool enabled = true;
+
      apic_set_base_check(s, val);

-    s->apicbase = (val & 0xfffff000) |
+    s->apicbase = new_base |
          (s->apicbase & (MSR_IA32_APICBASE_BSP | 
MSR_IA32_APICBASE_ENABLE));
      /* if disabled, cannot be enabled again */
      if (!(val & MSR_IA32_APICBASE_ENABLE)) {
          s->apicbase &= ~MSR_IA32_APICBASE_ENABLE;
          cpu_clear_apic_feature(&s->cpu->env);
          s->spurious_vec &= ~APIC_SV_ENABLE;
+        enabled = false;
      }

      /* Transition from disabled mode to xAPIC */
@@ -368,7 +385,10 @@ static void apic_set_base(APICCommonState *s, 
uint64_t val)

          s->log_dest = ((s->initial_apic_id & 0xffff0) << 16) |
                        (1 << (s->initial_apic_id & 0xf));
+        enabled = false;
      }
+
+    apic_io_memory_set_base_enabled(s, new_base, enabled);
  }

  static void apic_set_tpr(APICCommonState *s, uint8_t val)
@@ -889,7 +909,7 @@ static uint64_t apic_mem_read(void *opaque, hwaddr 
addr, unsigned size)
      return val;
  }

-static void apic_send_msi(MSIMessage *msi)
+void apic_send_msi(MSIMessage *msi)
  {
      uint64_t addr = msi->address;
      uint32_t data = msi->data;
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 716ffc8bbb..8e85a3165a 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -35,6 +35,7 @@
  #include "hw/i386/apic-msidef.h"
  #include "hw/i386/x86-iommu.h"
  #include "trace.h"
+#include "hw/i386/apic.h"

  #define APIC_DELIVERY_MODE_SHIFT 8
  #define APIC_POLARITY_SHIFT 14
@@ -131,11 +132,32 @@ static void ioapic_service(IOAPICCommonState *s)
                  }
  #endif

-                /* No matter whether IR is enabled, we translate
-                 * the IOAPIC message into a MSI one, and its
-                 * address space will decide whether we need a
-                 * translation. */
-                stl_le_phys(ioapic_as, info.addr, info.data);
+                /*
+                 * We reuse the APIC MMIO memory region for MSI because
+                 * by default, they are at the same base address but
+                 * the register addresses are not overlapped. However,
+                 * in TCG we try to support APIC MMIO relocation and
+                 * disable per cpu APIC MMIO when that CPU switches
+                 * to different APIC state. So in case, when using TCG
+                 * and the no interrupt remapping device is used, we
+                 * call apic_send_msi to send MSI to APIC directly
+                 * instead of writing to MSI address.
+                 */
+                if (tcg_enabled() && ioapic_as == &address_space_memory) {
+                    MSIMessage msg = {
+                        .address = info.addr,
+                        .data = info.data,
+                    };
+                    apic_send_msi(&msg);
+                } else {
+                    /*
+                     * No matter whether IR is enabled, we translate
+                     * the IOAPIC message into a MSI one, and its
+                     * address space will decide whether we need a
+                     * translation.
+                     */
+                    stl_le_phys(ioapic_as, info.addr, info.data);
+                }
              }
          }
      }
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 881d774fb6..b680c3869b 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -50,6 +50,9 @@
  #include "qemu/cutils.h"
  #include "pci-internal.h"

+#include "sysemu/tcg.h"
+#include "hw/i386/apic.h"
+
  #include "hw/xen/xen.h"
  #include "hw/i386/kvm/xen_evtchn.h"

@@ -346,6 +349,7 @@ void pci_device_deassert_intx(PCIDevice *dev)
  static void pci_msi_trigger(PCIDevice *dev, MSIMessage msg)
  {
      MemTxAttrs attrs = {};
+    AddressSpace *dma_as = pci_device_iommu_address_space(dev);

      /*
       * Xen uses the high bits of the address to contain some of the bits
@@ -359,8 +363,25 @@ static void pci_msi_trigger(PCIDevice *dev, 
MSIMessage msg)
          return;
      }
      attrs.requester_id = pci_requester_id(dev);
-    address_space_stl_le(&dev->bus_master_as, msg.address, msg.data,
-                         attrs, NULL);
+
+
+    /*
+     * We reuse the APIC MMIO memory region for MSI because
+     * by default, they are at the same base address but
+     * the register addresses are not overlapped. However,
+     * in TCG we try to support APIC MMIO relocation and
+     * disable per cpu APIC MMIO when that CPU switches
+     * to different APIC state. So in case, when using TCG
+     * and the no interrupt remapping device is used, we
+     * call apic_send_msi to send MSI to APIC directly
+     * instead of writing to MSI address.
+     */
+    if (tcg_enabled() && dma_as == &address_space_memory) {
+        apic_send_msi(&msg);
+    } else {
+        address_space_stl_le(&dev->bus_master_as, msg.address, msg.data,
+                             attrs, NULL);
+    }
  }

  static void pci_reset_regions(PCIDevice *dev)
diff --git a/include/hw/i386/apic.h b/include/hw/i386/apic.h
index 12aad09f4c..045eb96d0e 100644
--- a/include/hw/i386/apic.h
+++ b/include/hw/i386/apic.h
@@ -20,6 +20,7 @@ int apic_get_highest_priority_irr(DeviceState *dev);
  uint64_t apic_register_read(int index);
  void apic_register_write(int index, uint64_t val);
  bool is_x2apic_mode(DeviceState *d);
+void apic_send_msi(MSIMessage *msi);

  /* pc.c */
  DeviceState *cpu_get_current_apic(void);
diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index 7422096737..a4c10591ef 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -316,14 +316,22 @@ void x86_cpu_apic_realize(X86CPU *cpu, Error **errp)

      /* Map APIC MMIO area */
      apic = APIC_COMMON(cpu->apic_state);
-    if (!apic_mmio_map_once) {
+    if (tcg_enabled()) {
+        /*
+         * Map the APIC MMIO to the private root memory of the CPU
+         */
+        memory_region_add_subregion_overlap(cpu->parent_obj.memory,
+                                            apic->apicbase &
+                                            MSR_IA32_APICBASE_BASE,
+                                            &apic->io_memory,
+                                            0x1000);
+    } else if (!apic_mmio_map_once) {
          memory_region_add_subregion_overlap(get_system_memory(),
                                              apic->apicbase &
                                              MSR_IA32_APICBASE_BASE,
                                              &apic->io_memory,
                                              0x1000);
-        apic_mmio_map_once = true;
-     }
+    }
  }

  GuestPanicInformation *x86_cpu_get_crash_info(CPUState *cs)
diff --git a/target/i386/tcg/sysemu/tcg-cpu.c 
b/target/i386/tcg/sysemu/tcg-cpu.c
index c223c0fe9b..7731c422b9 100644
--- a/target/i386/tcg/sysemu/tcg-cpu.c
+++ b/target/i386/tcg/sysemu/tcg-cpu.c
@@ -24,6 +24,7 @@
  #include "sysemu/sysemu.h"
  #include "qemu/units.h"
  #include "exec/address-spaces.h"
+#include "hw/i386/x86.h"

  #include "tcg/tcg-cpu.h"

@@ -46,6 +47,7 @@ static void tcg_cpu_machine_done(Notifier *n, void 
*unused)
  bool tcg_cpu_realizefn(CPUState *cs, Error **errp)
  {
      X86CPU *cpu = X86_CPU(cs);
+    MemoryRegion *root_memory, *system_memory_alias;

      /*
       * The realize order is important, since x86_cpu_realize() checks if
@@ -72,6 +74,17 @@ bool tcg_cpu_realizefn(CPUState *cs, Error **errp)
      memory_region_add_subregion_overlap(cpu->cpu_as_root, 0, 
cpu->cpu_as_mem, 0);
      memory_region_set_enabled(cpu->cpu_as_mem, true);

+    root_memory = g_new(MemoryRegion, 1);
+    memory_region_init(root_memory, OBJECT(cs), "memory", ~0ull);
+
+    object_property_set_link(OBJECT(cs), "memory", OBJECT(root_memory), 
errp);
+
+    system_memory_alias = g_new(MemoryRegion, 1);
+    memory_region_init_alias(system_memory_alias, OBJECT(cpu), "memory",
+                             get_system_memory(), 0, ~0ull);
+
+    memory_region_add_subregion_overlap(cs->memory, 0, 
system_memory_alias, 0);
+
      cs->num_ases = 2;
      cpu_address_space_init(cs, 0, "cpu-memory", cs->memory);
      cpu_address_space_init(cs, 1, "cpu-smm", cpu->cpu_as_root);
-- 
2.25.1



