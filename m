Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 282387A91FF
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:19:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjDxN-0007wv-03; Thu, 21 Sep 2023 03:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qjDxJ-0007wc-2n
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:18:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qjDxG-0002XA-UI
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695280706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=89G4Y8h92CqGdTvFct4RbuHtb1yqiAGzSSdWnwzkSSs=;
 b=EVy6weKDlL8Iq9OXaGVRXQ8ajhOtcu0akUD4rUBogozErih3FDrPziD+TL7lvls1ImTpHJ
 7J/7D/LybNseV0K0UPRX8rEbt/Swrt7IXZOIUi/bHiLnKfhl4QvHJp7nNFXoYp9CF5B3gh
 fYaXnpZdVgoPlS0iOYwBzdf/h67BEQ0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-TncFQvyTN62E7qdAeE2KIg-1; Thu, 21 Sep 2023 03:18:24 -0400
X-MC-Unique: TncFQvyTN62E7qdAeE2KIg-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1c577fea3dcso5388095ad.2
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 00:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695280703; x=1695885503;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=89G4Y8h92CqGdTvFct4RbuHtb1yqiAGzSSdWnwzkSSs=;
 b=ER9tXqexf2fhxbB01eGogZ4QnLGGQrehoxVA4Kt1RWdolCLXqtuAcGqetZ/fV4XMIj
 SpS5PIVN++yWAQdN7oxLlO1hE+SxhjMV0UfF0K7fyDgVT6BdVJKRy5U6WL70eECG7P7v
 7XC0jrDKfhfkXaQA/8H5ud45lvfKhRwknjxeKbLe7g3ENnpg6CnAP40EoUcfN3Cx+NO+
 eUthhX6JnH3sdopl6kHKa6qinHeBRD7UUWodCzh00WWcsDZZ4S0l9ki/bGlzldXRZgMl
 73/AatU+0IRgQw5hW1zna0rnh9JDYwRuZI7mO3ljw6P5u2mkwVqLsfuSld51cl/tqsj7
 TbUg==
X-Gm-Message-State: AOJu0YzK0fgkx4s6i/RbuRIaVLwPPtr5IaaF4Xgy0BrKagD81GrzxOem
 kSw51IkcRxMvvTrhKMIkb/orb3vZOVMBVJXb8N+V221AM3yzZdZlx4IYs4SLufHRb/brIhbOjLI
 GjFVyMlPPWtBKiHo=
X-Received: by 2002:a17:902:c407:b0:1c3:6251:a78 with SMTP id
 k7-20020a170902c40700b001c362510a78mr4466232plk.3.1695280703361; 
 Thu, 21 Sep 2023 00:18:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7F5LOcFS1tQVvFlBuIOkvvigRWTy6RzeofiZqR+o9lLWmtFubJ1eOkE7mwCoDSraoP80V0g==
X-Received: by 2002:a17:902:c407:b0:1c3:6251:a78 with SMTP id
 k7-20020a170902c40700b001c362510a78mr4466210plk.3.1695280702859; 
 Thu, 21 Sep 2023 00:18:22 -0700 (PDT)
Received: from localhost.localdomain ([115.96.26.17])
 by smtp.googlemail.com with ESMTPSA id
 u2-20020a17090282c200b001bc445e2497sm695384plz.79.2023.09.21.00.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 00:18:22 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: david@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: philmd@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH v3] hw/i386/pc: improve physical address space bound check for
 32-bit systems
Date: Thu, 21 Sep 2023 12:47:54 +0530
Message-Id: <20230921071755.61081-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
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

32-bit systems do not have a reserved memory for hole64 and hotplugging memory
devices are not supported on those systems. Therefore, the maximum limit of the
guest physical address in the absence of additional memory devices effectively
coincides with the end of "above 4G memory space" region. When users configure
additional memory devices, we need to properly account for the additional device
memory region so as to find the maximum value of the guest physical address
and enforce that it is within the physical address space of the processor. For
32-bit, this maximum PA will be outside the range of the processor's address
space.

With this change, for example, previously this was allowed:

$ ./qemu-system-x86_64 -cpu pentium -m size=10G

Now it is no longer allowed:

$ ./qemu-system-x86_64 -cpu pentium -m size=10G
qemu-system-x86_64: Address space limit 0xffffffff < 0x2bfffffff phys-bits too low (32)

For 32-bit, hotplugging additional memory is no longer allowed.

$ ./qemu-system-i386 -m size=1G,maxmem=3G,slots=2
qemu-system-i386: Address space limit 0xffffffff < 0x1ffffffff phys-bits too low (32)

The above is still allowed for older machine types in order to support
compatibility. Therefore, this still works:

$ ./qemu-system-i386 -machine pc-i440fx-8.1 -m size=1G,maxmem=3G,slots=2

After calling CPUID with EAX=0x80000001, all AMD64 compliant processors
have the longmode-capable-bit turned on in the extended feature flags (bit 29)
in EDX. The absence of CPUID longmode can be used to differentiate between
32-bit and 64-bit processors and is the recommended approach. QEMU takes this
approach elsewhere (for example, please see x86_cpu_realizefn()) and with
this change, pc_max_used_gpa() also takes the same approach to detect 32-bit
processors.

Unit tests are modified to not run those tests that use memory hotplug
on 32-bit x86 architecture.

Finally, a new compatibility flag is introduced to retain the old behavior
for pc_max_used_gpa() for machines 8.1 and older.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/pc.c                   | 34 +++++++++++++++++++++++++++++++---
 hw/i386/pc_piix.c              |  4 ++++
 include/hw/i386/pc.h           |  3 +++
 tests/qtest/bios-tables-test.c | 26 ++++++++++++++++++--------
 tests/qtest/numa-test.c        |  7 ++++++-
 5 files changed, 62 insertions(+), 12 deletions(-)

changelog:
v3: still accounting for additional memory device region above 4G.
unit tests fixed (not running for 32-bit where mem hotplug is used).

v2: removed memory hotplug region from max_gpa. added compat knobs.

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 54838c0c41..0aa2f6b6c0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -907,12 +907,39 @@ static uint64_t pc_get_cxl_range_end(PCMachineState *pcms)
 static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
 {
     X86CPU *cpu = X86_CPU(first_cpu);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    MachineState *ms = MACHINE(pcms);
+    uint64_t devmem_start = 0;
+    ram_addr_t devmem_size = 0;
 
-    /* 32-bit systems don't have hole64 thus return max CPU address */
-    if (cpu->phys_bits <= 32) {
-        return ((hwaddr)1 << cpu->phys_bits) - 1;
+    /*
+     * 32-bit systems don't have hole64 but they might have a region for
+     * memory devices. Even if additional hotplugged memory devices might
+     * not be usable by most guest OSes, we need to still consider them for
+     * calculating the highest possible GPA so that we can properly report
+     * if someone configures them on a CPU that cannot possibly address them.
+     */
+    if (!(cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM)) {
+        /* 32-bit systems */
+        if (pcmc->fixed_32bit_mem_addr_check) {
+            if (pcmc->has_reserved_memory &&
+                (ms->ram_size < ms->maxram_size)) {
+                pc_get_device_memory_range(pcms, &devmem_start,
+                                           &devmem_size);
+                if (!pcmc->broken_reserved_end) {
+                    devmem_start += devmem_size;
+                }
+                return devmem_start - 1;
+            } else {
+                return pc_above_4g_end(pcms) - 1;
+            }
+        } else {
+            /* old value for compatibility reasons */
+            return ((hwaddr)1 << cpu->phys_bits) - 1;
+        }
     }
 
+    /* 64-bit systems */
     return pc_pci_hole64_start() + pci_hole64_size - 1;
 }
 
@@ -1867,6 +1894,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->pvh_enabled = true;
     pcmc->kvmclock_create_always = true;
     pcmc->resizable_acpi_blob = true;
+    pcmc->fixed_32bit_mem_addr_check = true;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = pc_get_hotplug_handler;
     mc->hotplug_allowed = pc_hotplug_allowed;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 8321f36f97..f100a5de8b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -517,9 +517,13 @@ DEFINE_I440FX_MACHINE(v8_2, "pc-i440fx-8.2", NULL,
 
 static void pc_i440fx_8_1_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_i440fx_8_2_machine_options(m);
     m->alias = NULL;
     m->is_default = false;
+    pcmc->fixed_32bit_mem_addr_check = false;
+
     compat_props_add(m->compat_props, hw_compat_8_1, hw_compat_8_1_len);
     compat_props_add(m->compat_props, pc_compat_8_1, pc_compat_8_1_len);
 }
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 0fabece236..5a70d163d0 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -129,6 +129,9 @@ struct PCMachineClass {
 
     /* resizable acpi blob compat */
     bool resizable_acpi_blob;
+
+    /* fixed 32-bit processor address space bound check for memory */
+    bool fixed_32bit_mem_addr_check;
 };
 
 #define TYPE_PC_MACHINE "generic-pc-machine"
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index d1b80149f2..f8e03dfd46 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2080,7 +2080,6 @@ int main(int argc, char *argv[])
                            test_acpi_piix4_no_acpi_pci_hotplug);
             qtest_add_func("acpi/piix4/ipmi", test_acpi_piix4_tcg_ipmi);
             qtest_add_func("acpi/piix4/cpuhp", test_acpi_piix4_tcg_cphp);
-            qtest_add_func("acpi/piix4/memhp", test_acpi_piix4_tcg_memhp);
             qtest_add_func("acpi/piix4/numamem", test_acpi_piix4_tcg_numamem);
             qtest_add_func("acpi/piix4/nosmm", test_acpi_piix4_tcg_nosmm);
             qtest_add_func("acpi/piix4/smm-compat",
@@ -2088,9 +2087,15 @@ int main(int argc, char *argv[])
             qtest_add_func("acpi/piix4/smm-compat-nosmm",
                            test_acpi_piix4_tcg_smm_compat_nosmm);
             qtest_add_func("acpi/piix4/nohpet", test_acpi_piix4_tcg_nohpet);
-            qtest_add_func("acpi/piix4/dimmpxm", test_acpi_piix4_tcg_dimm_pxm);
-            qtest_add_func("acpi/piix4/acpihmat",
-                           test_acpi_piix4_tcg_acpi_hmat);
+
+            /* i386 does not support memory hotplug */
+            if (strcmp(arch, "i386")) {
+                qtest_add_func("acpi/piix4/memhp", test_acpi_piix4_tcg_memhp);
+                qtest_add_func("acpi/piix4/dimmpxm",
+                               test_acpi_piix4_tcg_dimm_pxm);
+                qtest_add_func("acpi/piix4/acpihmat",
+                               test_acpi_piix4_tcg_acpi_hmat);
+            }
 #ifdef CONFIG_POSIX
             qtest_add_func("acpi/piix4/acpierst", test_acpi_piix4_acpi_erst);
 #endif
@@ -2108,11 +2113,9 @@ int main(int argc, char *argv[])
                            test_acpi_q35_tcg_no_acpi_hotplug);
             qtest_add_func("acpi/q35/multif-bridge",
                            test_acpi_q35_multif_bridge);
-            qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
             qtest_add_func("acpi/q35/ipmi", test_acpi_q35_tcg_ipmi);
             qtest_add_func("acpi/q35/smbus/ipmi", test_acpi_q35_tcg_smbus_ipmi);
             qtest_add_func("acpi/q35/cpuhp", test_acpi_q35_tcg_cphp);
-            qtest_add_func("acpi/q35/memhp", test_acpi_q35_tcg_memhp);
             qtest_add_func("acpi/q35/numamem", test_acpi_q35_tcg_numamem);
             qtest_add_func("acpi/q35/nosmm", test_acpi_q35_tcg_nosmm);
             qtest_add_func("acpi/q35/smm-compat",
@@ -2120,10 +2123,17 @@ int main(int argc, char *argv[])
             qtest_add_func("acpi/q35/smm-compat-nosmm",
                            test_acpi_q35_tcg_smm_compat_nosmm);
             qtest_add_func("acpi/q35/nohpet", test_acpi_q35_tcg_nohpet);
-            qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
-            qtest_add_func("acpi/q35/acpihmat", test_acpi_q35_tcg_acpi_hmat);
             qtest_add_func("acpi/q35/acpihmat-noinitiator",
                            test_acpi_q35_tcg_acpi_hmat_noinitiator);
+
+            /* i386 does not support memory hotplug */
+            if (strcmp(arch, "i386")) {
+                qtest_add_func("acpi/q35/memhp", test_acpi_q35_tcg_memhp);
+                qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
+                qtest_add_func("acpi/q35/acpihmat",
+                               test_acpi_q35_tcg_acpi_hmat);
+                qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
+            }
 #ifdef CONFIG_POSIX
             qtest_add_func("acpi/q35/acpierst", test_acpi_q35_acpi_erst);
 #endif
diff --git a/tests/qtest/numa-test.c b/tests/qtest/numa-test.c
index c5eb13f349..4f4404a4b1 100644
--- a/tests/qtest/numa-test.c
+++ b/tests/qtest/numa-test.c
@@ -568,7 +568,7 @@ int main(int argc, char **argv)
     qtest_add_data_func("/numa/mon/cpus/partial", args, test_mon_partial);
     qtest_add_data_func("/numa/qmp/cpus/query-cpus", args, test_query_cpus);
 
-    if (!strcmp(arch, "i386") || !strcmp(arch, "x86_64")) {
+    if (!strcmp(arch, "x86_64")) {
         qtest_add_data_func("/numa/pc/cpu/explicit", args, pc_numa_cpu);
         qtest_add_data_func("/numa/pc/dynamic/cpu", args, pc_dynamic_cpu_cfg);
         qtest_add_data_func("/numa/pc/hmat/build", args, pc_hmat_build_cfg);
@@ -576,6 +576,11 @@ int main(int argc, char **argv)
         qtest_add_data_func("/numa/pc/hmat/erange", args, pc_hmat_erange_cfg);
     }
 
+    if (!strcmp(arch, "i386")) {
+        qtest_add_data_func("/numa/pc/cpu/explicit", args, pc_numa_cpu);
+        qtest_add_data_func("/numa/pc/dynamic/cpu", args, pc_dynamic_cpu_cfg);
+    }
+
     if (!strcmp(arch, "ppc64")) {
         qtest_add_data_func("/numa/spapr/cpu/explicit", args, spapr_numa_cpu);
     }
-- 
2.39.1


