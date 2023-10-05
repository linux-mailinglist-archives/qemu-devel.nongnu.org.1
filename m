Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2277B9A64
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:48:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFJL-0000U1-Pl; Wed, 04 Oct 2023 23:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFJ3-0008Jw-SE
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFJ1-0000mw-II
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K+ppmYi5eqIqGeWAxSO0NhMvP+pyAbMAK1TQA6ddhAE=;
 b=PNdSQVMKxGgoPhq7Ty5jKtYsLf45GJ6uewsxAw5cM2OJ7aAlPPzTl2L4XmvghKbWauFpSn
 gQRFj8Q1iOUpQjft+wvlf0wKFlI8Zv9D+AmjpdTPkZxC1mDEZkrKSRSv6hz1bPrpR3sd/7
 NHEEVGTQYdlX4tPZwFmIN7EPb174qbk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-ZTkm4HWANma4VHG2ADJc_A-1; Wed, 04 Oct 2023 23:45:30 -0400
X-MC-Unique: ZTkm4HWANma4VHG2ADJc_A-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4053d832d51so4165895e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477529; x=1697082329;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K+ppmYi5eqIqGeWAxSO0NhMvP+pyAbMAK1TQA6ddhAE=;
 b=RGKUCPzlETsfMZ95phPnEXuO6N2SyldUw/EnIuMjN1y8sNQtCv2CxxB00FOB54FIpt
 gTOLA4YqVvae6YN7ZIftd0cmh2hPzWZ5i/f2GlLLwPQ5t9BRa2hG8KaaTN7dyoq4Ah7r
 tfjOyQDWaOBZ+AO8fEtHt5KaQRVsTmaf2FL4Zk/R1Iiic1qC4Ua6/rPLztfuat6izzvG
 K7Vh8g6G/7G78BjO9yXty3yuA7dCwIaVgQeDhME3G/LD2JoQPH0oz86+7phHfB7ihXkJ
 gsUN6lbG2dqDoT01Z81Ix0hhsVVKlJoalcVcA+MHSgF2Tkd0ck4MtW/cH/fMtOQsvPam
 Q/zg==
X-Gm-Message-State: AOJu0YxrRgCXpUiMARbqqcU53QkBvANfb3xumDT53jIW55W8FR9mR5En
 aKk/fRtzfTx/EbKaQ1v3A/eUno43w+lJDIDHefzEEFGM011hqGj3rusEw121HcFc8APgeX/bvcF
 Y9a2g9xzql5FCu3UAQPWBzIWuDWYgzePmqUrqzycHgqTVD1zK7YuClRClu4rpXZPJiwbK
X-Received: by 2002:a7b:c7d7:0:b0:404:72fe:ed5c with SMTP id
 z23-20020a7bc7d7000000b0040472feed5cmr3840976wmk.29.1696477528680; 
 Wed, 04 Oct 2023 20:45:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElsslY/ebLOdGFILVvdZmyO7Z178BurYpOLGUNHqKwROvaQ5kKpgS1hPeCTQJOwcpVHg9Nbw==
X-Received: by 2002:a7b:c7d7:0:b0:404:72fe:ed5c with SMTP id
 z23-20020a7bc7d7000000b0040472feed5cmr3840955wmk.29.1696477528352; 
 Wed, 04 Oct 2023 20:45:28 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 w21-20020a05600c015500b0040535648639sm534275wmm.36.2023.10.04.20.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:45:27 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:45:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL v2 44/53] hw/i386/pc: improve physical address space bound
 check for 32-bit x86 systems
Message-ID: <cf0386509ece089213226855ae685e2228315ffe.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Ani Sinha <anisinha@redhat.com>

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
Message-Id: <20230922160413.165702-1-anisinha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/pc.h           |  6 ++++++
 hw/i386/pc.c                   | 32 +++++++++++++++++++++++++++++---
 hw/i386/pc_piix.c              |  4 ++++
 hw/i386/pc_q35.c               |  2 ++
 tests/qtest/bios-tables-test.c | 26 ++++++++++++++++++--------
 tests/qtest/numa-test.c        |  7 ++++++-
 6 files changed, 65 insertions(+), 12 deletions(-)

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
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3db0743f31..a532d42cf4 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -907,13 +907,39 @@ static uint64_t pc_get_cxl_range_end(PCMachineState *pcms)
 static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
 {
     X86CPU *cpu = X86_CPU(first_cpu);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    MachineState *ms = MACHINE(pcms);
 
-    /* 32-bit systems don't have hole64 thus return max CPU address */
-    if (cpu->phys_bits <= 32) {
+    if (cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
+        /* 64-bit systems */
+        return pc_pci_hole64_start() + pci_hole64_size - 1;
+    }
+
+    /* 32-bit systems */
+    if (pcmc->broken_32bit_mem_addr_check) {
+        /* old value for compatibility reasons */
         return ((hwaddr)1 << cpu->phys_bits) - 1;
     }
 
-    return pc_pci_hole64_start() + pci_hole64_size - 1;
+    /*
+     * 32-bit systems don't have hole64 but they might have a region for
+     * memory devices. Even if additional hotplugged memory devices might
+     * not be usable by most guest OSes, we need to still consider them for
+     * calculating the highest possible GPA so that we can properly report
+     * if someone configures them on a CPU that cannot possibly address them.
+     */
+    if (pcmc->has_reserved_memory &&
+        (ms->ram_size < ms->maxram_size)) {
+        hwaddr devmem_start;
+        ram_addr_t devmem_size;
+
+        pc_get_device_memory_range(pcms, &devmem_start, &devmem_size);
+        devmem_start += devmem_size;
+        return devmem_start - 1;
+    }
+
+    /* configuration without any memory hotplug */
+    return pc_above_4g_end(pcms) - 1;
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
MST


