Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0C47AB451
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:02:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjhf5-0000kF-1p; Fri, 22 Sep 2023 11:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qjhez-0000jz-EH
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:01:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qjhew-0002Rf-WE
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695394893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FOSm5F2tTzsjVZdoj6xToFpnZUFZ8+P5ExEHPAQT83k=;
 b=futRKTTkGj4RsX5Pn8NlTUFLriQANlCbmbmUsaOK6TH2B1/JyUspVLobch6EjLrzS3+gLy
 mMmfx/vNBCewAX1qhUykhdPiAk77QbUhaq4i0yefYvMDn/B9Gyj9GH8WVlYuVn4rzphIYb
 Q6sZ61m6TtvT8lbGxWt6QnnxSXsgbyo=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-b5Gb3zk6PhmqzIFjN1y1cw-1; Fri, 22 Sep 2023 11:01:31 -0400
X-MC-Unique: b5Gb3zk6PhmqzIFjN1y1cw-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-68fe22b77b6so1927719b3a.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 08:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695394889; x=1695999689;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FOSm5F2tTzsjVZdoj6xToFpnZUFZ8+P5ExEHPAQT83k=;
 b=kvLrcu3q7zqmCoYXoc27wMByS7Ogxf+a10ZiF9Zt5negAmjhH2CZkQS8U3XLWrjTkR
 fRCUMTYVBihHCVTao/w8A3tS84NWlhMC7evcbUuaOKYlXrpTKTMoaU8o33vrCEPHOh04
 tQROxEestR1UzzgYl7m29k2h/hujiw15dUYRk7ua5iTCf1EEBs5YPZJdUDmQPuBQglZ9
 hNe7uWYEYZev+XKLh7huTB0YFrB7uLZP58CT4o/Tq4d0vlJZ3micIIrxVkaFGyfn9PsX
 SMdv3J4Pzc2/M3dsZrFoZtBrda4/fw3Q8gCbUAS6RQKhEx656WiPjCpMN/j8bKUJJ8HK
 rY3w==
X-Gm-Message-State: AOJu0Yx1rw7IPtN9FYJVYzjAekmgnjSRG+HzMh4LJ6XNpCsdOEKjsqVI
 llWtrBvtXcgvynqEANJtwB+h+GCLQghJvj72p24xClyECfKCIip1OdhbJFy/RpKkRS+9TJgiYDS
 eVHqYExlXnD8lYBbe4rY568A=
X-Received: by 2002:a05:6a00:15ca:b0:690:422f:4f17 with SMTP id
 o10-20020a056a0015ca00b00690422f4f17mr9711906pfu.4.1695394889195; 
 Fri, 22 Sep 2023 08:01:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtCNYwzZUHp5PnE3Oah6O3g+i246F76H/spDjHdqJuOjRpUxxn8J3FCBto4W2o2+CXC5ucZA==
X-Received: by 2002:a05:6a00:15ca:b0:690:422f:4f17 with SMTP id
 o10-20020a056a0015ca00b00690422f4f17mr9711819pfu.4.1695394888128; 
 Fri, 22 Sep 2023 08:01:28 -0700 (PDT)
Received: from localhost.localdomain ([116.73.132.49])
 by smtp.googlemail.com with ESMTPSA id
 e14-20020a62ee0e000000b00690d9901ce5sm3284573pfi.102.2023.09.22.08.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 08:01:27 -0700 (PDT)
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
Subject: [PATCH v5] hw/i386/pc: improve physical address space bound check for
 32-bit x86 systems
Date: Fri, 22 Sep 2023 20:31:02 +0530
Message-Id: <20230922150102.164629-1-anisinha@redhat.com>
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

32-bit x86 systems do not have a reserved memory for hole64. On those 32-bit
systems without PSE36 or PAE CPU features, hotplugging memory devices are not
supported by QEMU as QEMU always places hotplugged memory above 4 GiB boundary
which is beyond the physical address space of the processor. Linux guests also
does not support memory hotplug on those systems. Please see Linux
kernel commit b59d02ed08690 ("mm/memory_hotplug: disable the functionality
for 32b") for more details.

Therefore, the maximum limit of the guest physical address in the absence of
additional memory devices effectively coincides with the end of
"above 4G memory space" region for 32-bit x86 without PAE/PSE36. When users
configure additional memory devices, after properly accounting for the
additional device memory region to find the maximum value of the guest
physical address, the address will be outside the range of the processor's
physical address space.

This change adds improvements to take above into consideration.

For example, previously this was allowed:

$ ./qemu-system-x86_64 -cpu pentium -m size=10G

With this change now it is no longer allowed:

$ ./qemu-system-x86_64 -cpu pentium -m size=10G
qemu-system-x86_64: Address space limit 0xffffffff < 0x2bfffffff phys-bits too low (32)

However, the following are allowed since on both cases physical address
space of the processor is 36 bits:

$ ./qemu-system-x86_64 -cpu pentium2 -m size=10G
$ ./qemu-system-x86_64 -cpu pentium,pse36=on -m size=10G

For 32-bit, without PAE/PSE36, hotplugging additional memory is no longer allowed.

$ ./qemu-system-i386 -m size=1G,maxmem=3G,slots=2
qemu-system-i386: Address space limit 0xffffffff < 0x1ffffffff phys-bits too low (32)
$ ./qemu-system-i386 -machine q35 -m size=1G,maxmem=3G,slots=2
qemu-system-i386: Address space limit 0xffffffff < 0x1ffffffff phys-bits too low (32)

A new compatibility flag is introduced to make sure pc_max_used_gpa() keeps
returning the old value for machines 8.1 and older.
Therefore, the above is still allowed for older machine types in order to support
compatibility. Hence, the following still works:

$ ./qemu-system-i386 -machine pc-i440fx-8.1 -m size=1G,maxmem=3G,slots=2
$ ./qemu-system-i386 -machine pc-q35-8.1 -m size=1G,maxmem=3G,slots=2

Further, following is also allowed as with PSE36, the processor has 36-bit
address space:

$ ./qemu-system-i386 -cpu 486,pse36=on -m size=1G,maxmem=3G,slots=2

After calling CPUID with EAX=0x80000001, all AMD64 compliant processors
have the longmode-capable-bit turned on in the extended feature flags (bit 29)
in EDX. The absence of CPUID longmode can be used to differentiate between
32-bit and 64-bit processors and is the recommended approach. QEMU takes this
approach elsewhere (for example, please see x86_cpu_realizefn()), With
this change, pc_max_used_gpa() also uses the same method to detect 32-bit
processors.

Unit tests are modified to not run 32-bit x86 tests that use memory hotplug.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c                   | 30 +++++++++++++++++++++++++++---
 hw/i386/pc_piix.c              |  4 ++++
 hw/i386/pc_q35.c               |  2 ++
 include/hw/i386/pc.h           |  6 ++++++
 tests/qtest/bios-tables-test.c | 26 ++++++++++++++++++--------
 tests/qtest/numa-test.c        |  7 ++++++-
 6 files changed, 63 insertions(+), 12 deletions(-)

changelog:
v5: addressed phil's suggestions in code reorg to make it cleaner.
v4: address comments from v3. Fix a bug where compat knob was absent
from q35 machines. Commit message adjustment.
v3: still accounting for additional memory device region above 4G.
unit tests fixed (not running for 32-bit where mem hotplug is used).
v2: removed memory hotplug region from max_gpa. added compat knobs.

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3db0743f31..f8d1cd1362 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -907,13 +907,37 @@ static uint64_t pc_get_cxl_range_end(PCMachineState *pcms)
 static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
 {
     X86CPU *cpu = X86_CPU(first_cpu);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    MachineState *ms = MACHINE(pcms);
+    uint64_t devmem_start = 0;
+    ram_addr_t devmem_size = 0;
 
-    /* 32-bit systems don't have hole64 thus return max CPU address */
-    if (cpu->phys_bits <= 32) {
+    if (cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
+        /* 64-bit systems */
+        return pc_pci_hole64_start() + pci_hole64_size - 1;
+    }
+
+    /*
+     * 32-bit systems don't have hole64 but they might have a region for
+     * memory devices. Even if additional hotplugged memory devices might
+     * not be usable by most guest OSes, we need to still consider them for
+     * calculating the highest possible GPA so that we can properly report
+     * if someone configures them on a CPU that cannot possibly address them.
+     */
+    if (pcmc->broken_32bit_mem_addr_check) {
+        /* old value for compatibility reasons */
         return ((hwaddr)1 << cpu->phys_bits) - 1;
     }
 
-    return pc_pci_hole64_start() + pci_hole64_size - 1;
+    if (pcmc->has_reserved_memory &&
+        (ms->ram_size < ms->maxram_size)) {
+        pc_get_device_memory_range(pcms, &devmem_start,
+                                   &devmem_size);
+        devmem_start += devmem_size;
+        return devmem_start - 1;
+    } else {
+        return pc_above_4g_end(pcms) - 1;
+    }
 }
 
 /*
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 8321f36f97..71003759bb 100644
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
+    pcmc->broken_32bit_mem_addr_check = true;
+
     compat_props_add(m->compat_props, hw_compat_8_1, hw_compat_8_1_len);
     compat_props_add(m->compat_props, pc_compat_8_1, pc_compat_8_1_len);
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 2dd1158b70..a7386f2ca2 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -394,8 +394,10 @@ DEFINE_Q35_MACHINE(v8_2, "pc-q35-8.2", NULL,
 
 static void pc_q35_8_1_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_8_2_machine_options(m);
     m->alias = NULL;
+    pcmc->broken_32bit_mem_addr_check = true;
     compat_props_add(m->compat_props, hw_compat_8_1, hw_compat_8_1_len);
     compat_props_add(m->compat_props, pc_compat_8_1, pc_compat_8_1_len);
 }
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 0fabece236..bec38cb92c 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -129,6 +129,12 @@ struct PCMachineClass {
 
     /* resizable acpi blob compat */
     bool resizable_acpi_blob;
+
+    /*
+     * whether the machine type implements broken 32-bit address space bound
+     * check for memory.
+     */
+    bool broken_32bit_mem_addr_check;
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


