Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B2A7AF16C
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 19:00:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlBPG-0001uM-8E; Tue, 26 Sep 2023 12:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPC-0001tN-3b
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPA-0006a3-2C
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695747563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uS9e0u939TiosSXsVTYY/Ak/WMnhDdIB0Sz03AXbc3c=;
 b=Y3DS6vCloHmTVarecRu39osUVrM+WXwgQFThC6h33rYQ8HC8YdeH73REoCQUgIvpRtXHeD
 vNIteTUKbh3wjXW7/v9I/T4ZN+PEPmvX1MOjiydSOP/oy6rtS5P34i3Os2cDtNNnj0FfMI
 aKYBqiPT0Brc7Ca15jiFn011YraoVOM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-p9qSK-cUOsCPrmvqfBaLfw-1; Tue, 26 Sep 2023 12:59:21 -0400
X-MC-Unique: p9qSK-cUOsCPrmvqfBaLfw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-405334b0873so76141105e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695747560; x=1696352360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uS9e0u939TiosSXsVTYY/Ak/WMnhDdIB0Sz03AXbc3c=;
 b=RwCE5+uveWxjSNBuL/2tHPPigBLmSmsgXFfP37ZeEmAWxA7qfD5LjYlNtnqUBv9aH2
 D63mZ4qhkTQqn63wW2ZCJPg5ka85Luu7oaqqKgxCOHnbT2b2qj2z4KlYPUfKBXZShMFo
 EnH5NNf3E9reZAVZAiutSH8mT4ghnpS3fjxZBZwRBAPd5vUfCZ220cZt+5IzmTEHwqZC
 v6QxBa9v01clkGzJ+idVUz5xLBAxDAqqPRt0PFBS9QeVAGnyEpnTvE30y8TqwPsP9kFh
 5uGiERRGOf0Ep8KoqPI8PNN+d3t/H9N6c4329QvEgXYfTE0fhGJjLpKVMlGi9uw7tUaw
 6dtA==
X-Gm-Message-State: AOJu0YxZYZuDk66ehP5LqAMpuBuCWrid9nSzjW4MAvAqlQP73+e0mQmO
 mHLg1IiFDEBusvDChdISC6szg5+/vnCaCua18Dxr5WzC8hB2/Hhd3/igNJKeSnXOvwMabiH/YhD
 ALQM38lOt8nrx/Mwy+2xfaBKcpeSGzFzQSXcjb8tRTeS8XeAdTG7hJMz898Ln9Fjdcsj+q3Jlqu
 E=
X-Received: by 2002:a5d:4fc9:0:b0:31a:dc2e:2db2 with SMTP id
 h9-20020a5d4fc9000000b0031adc2e2db2mr9780326wrw.49.1695747559761; 
 Tue, 26 Sep 2023 09:59:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw+4TJDcibNsyVMnNSOgHDPLEJs8k0efBWXxusqwFUHpdyp4j8wtbLHk8HLd5/EVXTqGuD5g==
X-Received: by 2002:a5d:4fc9:0:b0:31a:dc2e:2db2 with SMTP id
 h9-20020a5d4fc9000000b0031adc2e2db2mr9780308wrw.49.1695747559365; 
 Tue, 26 Sep 2023 09:59:19 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 f1-20020a5d50c1000000b003142e438e8csm15136171wrt.26.2023.09.26.09.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:59:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 01/19] pc_piix: remove pc-i440fx-1.4 up to pc-i440fx-1.7
Date: Tue, 26 Sep 2023 18:58:57 +0200
Message-ID: <20230926165915.738719-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926165915.738719-1-pbonzini@redhat.com>
References: <20230926165915.738719-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

These are the last users of the 128K SeaBIOS blob in the i440FX family.
Removing them allows us to drop PCI support from the 128K blob,
thus making it easier to update SeaBIOS to newer versions.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/deprecated.rst           |  8 ----
 docs/about/removed-features.rst     |  4 +-
 hw/i386/pc.c                        | 60 ++----------------------
 hw/i386/pc_piix.c                   | 73 -----------------------------
 tests/qtest/test-x86-cpuid-compat.c | 10 +---
 5 files changed, 6 insertions(+), 149 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index dc4da95329e..8f3fef97bd4 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -277,14 +277,6 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
-``pc-i440fx-1.4`` up to ``pc-i440fx-1.7`` (since 7.0)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-These old machine types are quite neglected nowadays and thus might have
-various pitfalls with regards to live migration. Use a newer machine type
-instead.
-
-
 Backend options
 ---------------
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index c2043fd415d..97ec47f1d25 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -715,8 +715,8 @@ mips ``fulong2e`` machine alias (removed in 6.0)
 
 This machine has been renamed ``fuloong2e``.
 
-``pc-0.10`` up to ``pc-1.3`` (removed in 4.0 up to 6.0)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''''
+``pc-0.10`` up to ``pc-i440fx-1.7`` (removed in 4.0 up to 8.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These machine types were very old and likely could not be used for live
 migration from old QEMU versions anymore. Use a newer machine type instead.
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3db0743f319..5d399b6247e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -359,60 +359,6 @@ GlobalProperty pc_compat_2_0[] = {
 };
 const size_t pc_compat_2_0_len = G_N_ELEMENTS(pc_compat_2_0);
 
-GlobalProperty pc_compat_1_7[] = {
-    PC_CPU_MODEL_IDS("1.7.0")
-    { TYPE_USB_DEVICE, "msos-desc", "no" },
-    { "PIIX4_PM", ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, "off" },
-    { "hpet", HPET_INTCAP, "4" },
-};
-const size_t pc_compat_1_7_len = G_N_ELEMENTS(pc_compat_1_7);
-
-GlobalProperty pc_compat_1_6[] = {
-    PC_CPU_MODEL_IDS("1.6.0")
-    { "e1000", "mitigation", "off" },
-    { "qemu64-" TYPE_X86_CPU, "model", "2" },
-    { "qemu32-" TYPE_X86_CPU, "model", "3" },
-    { "i440FX-pcihost", "short_root_bus", "1" },
-    { "q35-pcihost", "short_root_bus", "1" },
-};
-const size_t pc_compat_1_6_len = G_N_ELEMENTS(pc_compat_1_6);
-
-GlobalProperty pc_compat_1_5[] = {
-    PC_CPU_MODEL_IDS("1.5.0")
-    { "Conroe-" TYPE_X86_CPU, "model", "2" },
-    { "Conroe-" TYPE_X86_CPU, "min-level", "2" },
-    { "Penryn-" TYPE_X86_CPU, "model", "2" },
-    { "Penryn-" TYPE_X86_CPU, "min-level", "2" },
-    { "Nehalem-" TYPE_X86_CPU, "model", "2" },
-    { "Nehalem-" TYPE_X86_CPU, "min-level", "2" },
-    { "virtio-net-pci", "any_layout", "off" },
-    { TYPE_X86_CPU, "pmu", "on" },
-    { "i440FX-pcihost", "short_root_bus", "0" },
-    { "q35-pcihost", "short_root_bus", "0" },
-};
-const size_t pc_compat_1_5_len = G_N_ELEMENTS(pc_compat_1_5);
-
-GlobalProperty pc_compat_1_4[] = {
-    PC_CPU_MODEL_IDS("1.4.0")
-    { "scsi-hd", "discard_granularity", "0" },
-    { "scsi-cd", "discard_granularity", "0" },
-    { "ide-hd", "discard_granularity", "0" },
-    { "ide-cd", "discard_granularity", "0" },
-    { "virtio-blk-pci", "discard_granularity", "0" },
-    /* DEV_NVECTORS_UNSPECIFIED as a uint32_t string: */
-    { "virtio-serial-pci", "vectors", "0xFFFFFFFF" },
-    { "virtio-net-pci", "ctrl_guest_offloads", "off" },
-    { "e1000", "romfile", "pxe-e1000.rom" },
-    { "ne2k_pci", "romfile", "pxe-ne2k_pci.rom" },
-    { "pcnet", "romfile", "pxe-pcnet.rom" },
-    { "rtl8139", "romfile", "pxe-rtl8139.rom" },
-    { "virtio-net-pci", "romfile", "pxe-virtio.rom" },
-    { "486-" TYPE_X86_CPU, "model", "0" },
-    { "n270" "-" TYPE_X86_CPU, "movbe", "off" },
-    { "Westmere" "-" TYPE_X86_CPU, "pclmulqdq", "off" },
-};
-const size_t pc_compat_1_4_len = G_N_ELEMENTS(pc_compat_1_4);
-
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
 {
     GSIState *s;
@@ -1293,9 +1239,9 @@ void pc_basic_device_init(struct PCMachineState *pcms,
             exit(1);
         }
         /*
-         * For pc-piix-*, hpet's intcap is always IRQ2. For pc-q35-1.7 and
-         * earlier, use IRQ2 for compat. Otherwise, use IRQ16~23, IRQ8 and
-         * IRQ2.
+         * For pc-piix-*, hpet's intcap is always IRQ2. For pc-q35-*,
+         * use IRQ16~23, IRQ8 and IRQ2.  If the user has already set
+         * the property, use whatever mask they specified.
          */
         uint8_t compat = object_property_get_uint(OBJECT(hpet),
                 HPET_INTCAP, NULL);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 8321f36f97f..ff8654ecdab 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -423,27 +423,6 @@ static void pc_compat_2_0_fn(MachineState *machine)
     pc_compat_2_1_fn(machine);
 }
 
-static void pc_compat_1_7_fn(MachineState *machine)
-{
-    pc_compat_2_0_fn(machine);
-    x86_cpu_change_kvm_default("x2apic", NULL);
-}
-
-static void pc_compat_1_6_fn(MachineState *machine)
-{
-    pc_compat_1_7_fn(machine);
-}
-
-static void pc_compat_1_5_fn(MachineState *machine)
-{
-    pc_compat_1_6_fn(machine);
-}
-
-static void pc_compat_1_4_fn(MachineState *machine)
-{
-    pc_compat_1_5_fn(machine);
-}
-
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
@@ -876,58 +855,6 @@ static void pc_i440fx_2_0_machine_options(MachineClass *m)
 DEFINE_I440FX_MACHINE(v2_0, "pc-i440fx-2.0", pc_compat_2_0_fn,
                       pc_i440fx_2_0_machine_options);
 
-static void pc_i440fx_1_7_machine_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_i440fx_2_0_machine_options(m);
-    m->hw_version = "1.7.0";
-    m->default_machine_opts = NULL;
-    m->option_rom_has_mr = true;
-    m->deprecation_reason = "old and unattended - use a newer version instead";
-    compat_props_add(m->compat_props, pc_compat_1_7, pc_compat_1_7_len);
-    pcmc->smbios_defaults = false;
-    pcmc->gigabyte_align = false;
-    pcmc->legacy_acpi_table_size = 6414;
-}
-
-DEFINE_I440FX_MACHINE(v1_7, "pc-i440fx-1.7", pc_compat_1_7_fn,
-                      pc_i440fx_1_7_machine_options);
-
-static void pc_i440fx_1_6_machine_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_i440fx_1_7_machine_options(m);
-    m->hw_version = "1.6.0";
-    m->rom_file_has_mr = false;
-    compat_props_add(m->compat_props, pc_compat_1_6, pc_compat_1_6_len);
-    pcmc->has_acpi_build = false;
-}
-
-DEFINE_I440FX_MACHINE(v1_6, "pc-i440fx-1.6", pc_compat_1_6_fn,
-                      pc_i440fx_1_6_machine_options);
-
-static void pc_i440fx_1_5_machine_options(MachineClass *m)
-{
-    pc_i440fx_1_6_machine_options(m);
-    m->hw_version = "1.5.0";
-    compat_props_add(m->compat_props, pc_compat_1_5, pc_compat_1_5_len);
-}
-
-DEFINE_I440FX_MACHINE(v1_5, "pc-i440fx-1.5", pc_compat_1_5_fn,
-                      pc_i440fx_1_5_machine_options);
-
-static void pc_i440fx_1_4_machine_options(MachineClass *m)
-{
-    pc_i440fx_1_5_machine_options(m);
-    m->hw_version = "1.4.0";
-    compat_props_add(m->compat_props, pc_compat_1_4, pc_compat_1_4_len);
-}
-
-DEFINE_I440FX_MACHINE(v1_4, "pc-i440fx-1.4", pc_compat_1_4_fn,
-                      pc_i440fx_1_4_machine_options);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index b39c9055b30..6a39454fce1 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -313,18 +313,10 @@ int main(int argc, char **argv)
                        "xlevel2", 0);
     }
     /*
-     * QEMU 1.4.0 had auto-level enabled for CPUID[7], already,
+     * QEMU 2.3.0 had auto-level enabled for CPUID[7], already,
      * and the compat code that sets default level shouldn't
      * disable the auto-level=7 code:
      */
-    if (qtest_has_machine("pc-i440fx-1.4")) {
-        add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-1.4/off",
-                       "-machine pc-i440fx-1.4 -cpu Nehalem",
-                       "level", 2);
-        add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-1.5/on",
-                       "-machine pc-i440fx-1.4 -cpu Nehalem,smap=on",
-                       "level", 7);
-    }
     if (qtest_has_machine("pc-i440fx-2.3")) {
         add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.3/off",
                        "-machine pc-i440fx-2.3 -cpu Penryn",
-- 
2.41.0


