Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B32517A949C
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 15:21:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjJbS-00042a-Lz; Thu, 21 Sep 2023 09:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjJbL-00041y-2W
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:20:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjJbB-0002qH-2d
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695302404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i5jrhay0HrjqEL1gbKPGoZxi+AOdn4xNERksOXwl7Dk=;
 b=R/0DYRrtyZWClzIry6Oh3R7kd82IYK4k7iYEy4lSSi0C1nXRNAlVciPTuS43Kk3L08663S
 rEYx8kVKNl/P8YtC8FujfbVVYBpa9BbRi9zDjE1FzxJ1ldCcEj3cmYUeSfbxYWA2sMHCML
 DUt7l+pThug5aWIXdsXCZdWi3B8W2D8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-he_kSMSrP4admPhIvj0WUQ-1; Thu, 21 Sep 2023 08:10:57 -0400
X-MC-Unique: he_kSMSrP4admPhIvj0WUQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31dc8f0733dso662989f8f.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 05:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695298256; x=1695903056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i5jrhay0HrjqEL1gbKPGoZxi+AOdn4xNERksOXwl7Dk=;
 b=vxdHpMgfvwEYIPZVlLtJrfVcur2xHE6X/Acye5Wh4f3hsBwqKtVOf7pDwVPx1A02SO
 gy2lcK+/GEGjbTYWddj7+cH29Hd0Bx9jDZE5tjzl4e3GlUYFt8pxm1tElFOLJw/P1wHV
 xe9E5vSLMgFd9XEY/6OUj57D+Sdppb7mWDAopuVEN51YC2GMbbIc768qIhAE0vHf2wuU
 2TsvBQ59yzegEl70J7NF/Rw8y+y+plYTBMei3X5DCiDMEskwz+ipSR/5NFR7j6njVvfq
 in5lzbsAYotESFjEvPgcDDbB0PsZJ0PGB9czXXt/2gaxx7Z0vc+9FmxHz56FfranC7TK
 PBsw==
X-Gm-Message-State: AOJu0YyNNJpGmiew9uvV+OYQIZ9L32YAxolTWB5hL8o64CtkS+lKKXYr
 kJd3SwIUoio2haZFZuZ3suEjs/1ywScQPON0vnrF8RvgpOJ2I9ehzohJHbEcGW6H8yXYsiy31pN
 8JI3YDMBhDVFVIg8Q+l8KOxZvTlFVPZCGyFtpL155+mXFtpaMJswW1rWvLlRj/AvN+Nxhyh2UR1
 c=
X-Received: by 2002:adf:e684:0:b0:320:6db:3548 with SMTP id
 r4-20020adfe684000000b0032006db3548mr4859507wrm.55.1695298255773; 
 Thu, 21 Sep 2023 05:10:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWcaAaM3XRt/q1NFj0IghKJP0UA9+2ZkBb8060sJgIqeC6bzluigfbfyHmHlZboqnP5mR+JQ==
X-Received: by 2002:adf:e684:0:b0:320:6db:3548 with SMTP id
 r4-20020adfe684000000b0032006db3548mr4859488wrm.55.1695298255351; 
 Thu, 21 Sep 2023 05:10:55 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a05600c300900b003fe407ca05bsm483075wmh.37.2023.09.21.05.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 05:10:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	kraxel@redhat.com
Subject: [PATCH 1/2] pc_piix: remove pc-i440fx-1.4 up to pc-i440fx-1.7
Date: Thu, 21 Sep 2023 14:10:50 +0200
Message-ID: <20230921121051.192355-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921121051.192355-1-pbonzini@redhat.com>
References: <20230921121051.192355-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/deprecated.rst           |  8 ----
 docs/about/removed-features.rst     |  2 +-
 hw/i386/pc.c                        | 54 ---------------------
 hw/i386/pc_piix.c                   | 73 -----------------------------
 tests/qtest/test-x86-cpuid-compat.c | 10 +---
 5 files changed, 2 insertions(+), 145 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 694a165a54a..d59bcf36230 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -261,14 +261,6 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
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
index 39468b6e926..56e078ad126 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -730,7 +730,7 @@ mips ``fulong2e`` machine alias (removed in 6.0)
 
 This machine has been renamed ``fuloong2e``.
 
-``pc-0.10`` up to ``pc-1.3`` (removed in 4.0 up to 6.0)
+``pc-0.10`` up to ``pc-1.7`` (removed in 4.0 up to 8.2)
 '''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These machine types were very old and likely could not be used for live
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 54838c0c411..1c7898a2d34 100644
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


