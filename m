Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 569117D2258
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:32:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUiM-00070Y-CT; Sun, 22 Oct 2023 05:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUiK-0006za-Mf
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:25:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUiI-0000tB-SE
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bKxpfI1ewkLWXrLPRKRjX/JTEEf96RdRnERqJjhDehM=;
 b=Bk/THkkK0MEdmGg9LgkDeZhGog8rDdoiAZ6RsJtlomx9bZOSJ1lay4Dr1PRlHouTdIQheM
 jx2q4QOYS57S1Manp/r32xvYyMBxG71EUnPgleTmQoRhgU10ZihMzsiObrCoj/apuSbx3C
 ThuLKyDbfNNZraHinp9iLT+agjszFfs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-6q5HbukrPcmEeQZoGbnxpw-1; Sun, 22 Oct 2023 05:25:36 -0400
X-MC-Unique: 6q5HbukrPcmEeQZoGbnxpw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso12652285e9.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966734; x=1698571534;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKxpfI1ewkLWXrLPRKRjX/JTEEf96RdRnERqJjhDehM=;
 b=qH0EO+c7cubQFOQiPEUcFwf6pzmgIFfwvH4cq2/2wU/f50+Fsp+KWj9qFrUYTzx62Q
 9r1eoU7fedac+o+UUuMouFn+CnADQSA4aASMM6B70kU8CdV20Ip2i9J42u6XtskpP7mr
 m0yylfcDY59d1Ge7ifvGqARWWrezCjLsqtGtqXpmJNrPB+x1X6rEYDkimjENZWfEg1HS
 PgOTrn50rnRbTgauWZDRXxUZBWhCANz3P1gA4LSzkgJJTJUzZXqm0Gejy002De3RgrRh
 /RIDKDmw1xt+aInyIs51Wxil6T2qlOCPpVKA8m7WwqPRZmkUVYYzzdhr1TYWp1pGFfz2
 vj1w==
X-Gm-Message-State: AOJu0YyoKzwxGwrhy/iNviGohyyw+NC6/hFRR5+frm1mLkGY+UAzHXRw
 fLbICNR6KYnp0iStd+7OZDovr4KEb1Jo+iYyv4njcMRIHl9Y7DO1Amb97GDVX5DdXTbUj7TqQva
 qP/nmzm2ogWMtKIB4yIEPt6kZxejktQAwoI0NElzKQryDDsy7btsSJhvYij0yO4yjYoaC
X-Received: by 2002:a05:600c:15c1:b0:3fc:dd9:91fd with SMTP id
 v1-20020a05600c15c100b003fc0dd991fdmr4375537wmf.40.1697966734603; 
 Sun, 22 Oct 2023 02:25:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSGSHPXWw0dc3Yjes0b8MQ96N2euVtBQIVvoJ0VQsdcZt2b6otWygAtLqMfaCHij0N9PUxRw==
X-Received: by 2002:a05:600c:15c1:b0:3fc:dd9:91fd with SMTP id
 v1-20020a05600c15c100b003fc0dd991fdmr4375523wmf.40.1697966734263; 
 Sun, 22 Oct 2023 02:25:34 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 l21-20020a056000023500b003198a9d758dsm5322883wrz.78.2023.10.22.02.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:25:33 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:25:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v3 50/62] hw/i386/pc_piix: Make PIIX4 south bridge usable in
 PC machine
Message-ID: <aa0c9aec575f6dba4e6548ad9e5de1b1899d843e.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Bernhard Beschow <shentey@gmail.com>

QEMU's PIIX3 implementation actually models the real PIIX4, but with different
PCI IDs. Usually, guests deal just fine with it. Still, in order to provide a
more consistent illusion to guests, allow QEMU's PIIX4 implementation to be used
in the PC machine.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20231007123843.127151-30-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/pc.h                 |  2 +
 hw/i386/pc.c                         |  1 +
 hw/i386/pc_piix.c                    | 61 +++++++++++++++++++++++++++-
 docs/system/target-i386-desc.rst.inc |  8 ++++
 4 files changed, 71 insertions(+), 1 deletion(-)

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
index 355e1b7cf6..6293f57a0c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1706,6 +1706,7 @@ static void pc_machine_initfn(Object *obj)
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
-- 
MST


