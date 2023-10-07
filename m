Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB977BC7B5
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:43:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6as-00043i-L5; Sat, 07 Oct 2023 08:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6ah-0003FC-8b
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:33 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6ae-0002r1-NT
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:30 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so8920031a12.1
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682366; x=1697287166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V2equ74X5NLxGNnpVP+KYFOQdPrr3TI8IEtBKPHbhHo=;
 b=cmrAgtQBQNaaREFcsj/y87hdAWiJQRR7A66l9sCEWjbXReWuvpRqaV9+AwseqmF+f6
 XWJ8fIuQZrkZvecjr1px4zl89lEJ++sOOxfGJG9o4MWrNCsaaMjeYyvfssyWoJFO+htR
 1pUlgS/g8fPBApB/b2rgbwgEnAt/+6urqg14n1zkBtmAohB0MH+k8vrlMtCgoFN8XzZz
 HFHlmd7b4Q8KVtgy+jrQnzMNjptEx/oR7+46G8uHVeYQEbfvcBuk8TIwshcSaXaU528Y
 kN7USrfNyfyr5YCHDthOnYggIkwgdPebktQSagPvxTUwGnH/HBtWKUkjqSr38emrptGk
 UWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682366; x=1697287166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V2equ74X5NLxGNnpVP+KYFOQdPrr3TI8IEtBKPHbhHo=;
 b=uUh4hxTCmIyxxvht+TK7F8ZZEFABeyJTxGfabRDXfE2ueuvdDRKD/ygTUN+Z69gZrE
 gEOWkRtFbBUxoAnOcVNhdmyfGfsvkfhTYGO/ff7W97UBW6Y1ZncPskEQm8b5d3TQawNl
 qXM668VzMSVIuM3Rh6gjiUcF0Llun6j2ZWgiIWIVADG52YWu5DndQcVugYJ9xyq1NClJ
 RjGEuRU3kpeNNTUjhccFM7+ykopq+TeHZwIqgHDGv/qeD4oRJeGGgnp9H5rOljVTmxbU
 W+tJQzwL0WUeFAGCa3JOidp79LwUSTQ4frneBqcxbiN0LCxfXryYVxZ+9aArVwLwhvEO
 zk5A==
X-Gm-Message-State: AOJu0YzqNzl6ZQM/8hv4qqE+B5CYIWy1Zw9byAG0Mdu+GX9d2FG9TpRZ
 ZlQdrUnGe9g4CckMfn9HgAd7nbSSX8o=
X-Google-Smtp-Source: AGHT+IGzxOyRrKWh17rk65rrgsiHv8UJRXQ9uhXVPoraQnBGLUHjeUk54oydbUigK3ot4noP0LecJQ==
X-Received: by 2002:a17:907:868f:b0:9ad:e62c:4517 with SMTP id
 qa15-20020a170907868f00b009ade62c4517mr6738065ejc.34.1696682366439; 
 Sat, 07 Oct 2023 05:39:26 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:39:25 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chuck Zmudzinski <brchuckz@aol.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v8 29/29] hw/i386/pc_piix: Make PIIX4 south bridge usable in
 PC machine
Date: Sat,  7 Oct 2023 14:38:37 +0200
Message-ID: <20231007123843.127151-30-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

QEMU's PIIX3 implementation actually models the real PIIX4, but with different
PCI IDs. Usually, guests deal just fine with it. Still, in order to provide a
more consistent illusion to guests, allow QEMU's PIIX4 implementation to be used
in the PC machine.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/target-i386-desc.rst.inc |  8 ++++
 include/hw/i386/pc.h                 |  2 +
 hw/i386/pc.c                         |  1 +
 hw/i386/pc_piix.c                    | 61 +++++++++++++++++++++++++++-
 4 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/docs/system/target-i386-desc.rst.inc b/docs/system/target-i386-desc.rst.inc
index 7d1fffacbe..5ebbcda9db 100644
--- a/docs/system/target-i386-desc.rst.inc
+++ b/docs/system/target-i386-desc.rst.inc
@@ -71,3 +71,11 @@ machine property, i.e.
    |qemu_system_x86| some.img \
    -audiodev <backend>,id=<name> \
    -machine pcspk-audiodev=<name>
+
+Machine-specific options
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+It supports the following machine-specific options:
+
+- ``x-south-bridge=PIIX3|piix4-isa`` (Experimental option to select a particular
+  south bridge. Default: ``PIIX3``)
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index bec38cb92c..29a9724524 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -42,6 +42,7 @@ typedef struct PCMachineState {
     uint64_t max_ram_below_4g;
     OnOffAuto vmport;
     SmbiosEntryPointType smbios_entry_point_type;
+    const char *south_bridge;
 
     bool acpi_build_enabled;
     bool smbus_enabled;
@@ -92,6 +93,7 @@ struct PCMachineClass {
     /* Device configuration: */
     bool pci_enabled;
     bool kvmclock_enabled;
+    const char *default_south_bridge;
 
     /* Compat options: */
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4e844d02f2..c84d1bdf08 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1707,6 +1707,7 @@ static void pc_machine_initfn(Object *obj)
 #endif /* CONFIG_VMPORT */
     pcms->max_ram_below_4g = 0; /* use default */
     pcms->smbios_entry_point_type = pcmc->default_smbios_ep_type;
+    pcms->south_bridge = pcmc->default_south_bridge;
 
     /* acpi build is enabled by default if machine supports it */
     pcms->acpi_build_enabled = pcmc->has_acpi_build;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e38942a3c3..334d9a0299 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -262,7 +262,7 @@ static void pc_init1(MachineState *machine,
         DeviceState *dev;
         size_t i;
 
-        pci_dev = pci_new_multifunction(-1, TYPE_PIIX3_DEVICE);
+        pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
         object_property_set_bool(OBJECT(pci_dev), "has-usb",
                                  machine_usb(machine), &error_abort);
         object_property_set_bool(OBJECT(pci_dev), "has-acpi",
@@ -394,6 +394,56 @@ static void pc_init1(MachineState *machine,
     }
 }
 
+typedef enum PCSouthBridgeOption {
+    PC_SOUTH_BRIDGE_OPTION_PIIX3,
+    PC_SOUTH_BRIDGE_OPTION_PIIX4,
+    PC_SOUTH_BRIDGE_OPTION_MAX,
+} PCSouthBridgeOption;
+
+static const QEnumLookup PCSouthBridgeOption_lookup = {
+    .array = (const char *const[]) {
+        [PC_SOUTH_BRIDGE_OPTION_PIIX3] = TYPE_PIIX3_DEVICE,
+        [PC_SOUTH_BRIDGE_OPTION_PIIX4] = TYPE_PIIX4_PCI_DEVICE,
+    },
+    .size = PC_SOUTH_BRIDGE_OPTION_MAX
+};
+
+#define NotifyVmexitOption_str(val) \
+    qapi_enum_lookup(&NotifyVmexitOption_lookup, (val))
+
+static int pc_get_south_bridge(Object *obj, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+    int i;
+
+    for (i = 0; i < PCSouthBridgeOption_lookup.size; i++) {
+        if (g_strcmp0(PCSouthBridgeOption_lookup.array[i],
+                      pcms->south_bridge) == 0) {
+            return i;
+        }
+    }
+
+    error_setg(errp, "Invalid south bridge value set");
+    return 0;
+}
+
+static void pc_set_south_bridge(Object *obj, int value, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    if (value < 0) {
+        error_setg(errp, "Value can't be negative");
+        return;
+    }
+
+    if (value >= PCSouthBridgeOption_lookup.size) {
+        error_setg(errp, "Value too big");
+        return;
+    }
+
+    pcms->south_bridge = PCSouthBridgeOption_lookup.array[value];
+}
+
 /* Looking for a pc_compat_2_4() function? It doesn't exist.
  * pc_compat_*() functions that run on machine-init time and
  * change global QEMU state are deprecated. Please don't create
@@ -473,6 +523,8 @@ static void pc_xen_hvm_init(MachineState *machine)
 static void pc_i440fx_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+    ObjectClass *oc = OBJECT_CLASS(m);
+    pcmc->default_south_bridge = TYPE_PIIX3_DEVICE;
     pcmc->pci_root_uid = 0;
     pcmc->default_cpu_version = 1;
 
@@ -484,6 +536,13 @@ static void pc_i440fx_machine_options(MachineClass *m)
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
+
+    object_class_property_add_enum(oc, "x-south-bridge", "PCSouthBridgeOption",
+                                   &PCSouthBridgeOption_lookup,
+                                   pc_get_south_bridge,
+                                   pc_set_south_bridge);
+    object_class_property_set_description(oc, "x-south-bridge",
+                                     "Use a different south bridge than PIIX3");
 }
 
 static void pc_i440fx_8_2_machine_options(MachineClass *m)
-- 
2.42.0


