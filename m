Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F61E7B2E7B
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:54:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9Db-0005Al-EC; Fri, 29 Sep 2023 04:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DY-00057a-NY
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DC-0005dk-SH
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lGiKOv060cQANUItZbv+wuoAJ5NzveoKqVEzBRGLyno=;
 b=i/wn0Nk50/HHiAMYhS4DlxjjdaNKYa9HuwurqwnlI0pSWfzCHbZV8y+gwgEeOStrmDqW8l
 ulw+RXuEEFI6WJKu1jXkmrKcLgSNpGyVcncrRMUmXyybQAm8eULWO+/+rkGDpxAt+IJOpf
 t8QmLWHWnquvcozrKSvVs6bXMHhcF+k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-42pUnnrRNhyPTfH7Iinkxw-1; Fri, 29 Sep 2023 04:50:58 -0400
X-MC-Unique: 42pUnnrRNhyPTfH7Iinkxw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B92E5101AA6D;
 Fri, 29 Sep 2023 08:50:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A7A110F1BE7;
 Fri, 29 Sep 2023 08:50:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C2ED421E689B; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Ani Sinha <anisinha@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>, mst@redhat.com,
 imammedo@redhat.com
Subject: [PULL 38/56] hw/acpi: changes towards enabling -Wshadow=local
Date: Fri, 29 Sep 2023 10:50:35 +0200
Message-ID: <20230929085053.2789105-39-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Code changes in acpi that addresses all compiler complaints coming from enabling
-Wshadow flags. Enabling -Wshadow catches cases of local variables shadowing
other local variables or parameters. These makes the code confusing and/or adds
bugs that are difficult to catch.  See also

    Subject: Help wanted for enabling -Wshadow=local
    Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
    https://lore.kernel.org/qemu-devel/87r0mqlf9x.fsf@pond.sub.org

The code is tested to build with and without the flag turned on.

CC: Markus Armbruster <armbru@redhat.com>
CC: Philippe Mathieu-Daude <philmd@linaro.org>
CC: mst@redhat.com
CC: imammedo@redhat.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Message-ID: <20230922124203.127110-1-anisinha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/acpi/cpu_hotplug.c | 25 +++++++++++++------------
 hw/i386/acpi-build.c  | 24 ++++++++++++------------
 hw/smbios/smbios.c    | 37 +++++++++++++++++++------------------
 3 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
index ff14c3f410..634bbecb31 100644
--- a/hw/acpi/cpu_hotplug.c
+++ b/hw/acpi/cpu_hotplug.c
@@ -265,26 +265,27 @@ void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineState *machine,
 
     /* build Processor object for each processor */
     for (i = 0; i < apic_ids->len; i++) {
-        int apic_id = apic_ids->cpus[i].arch_id;
+        int cpu_apic_id = apic_ids->cpus[i].arch_id;
 
-        assert(apic_id < ACPI_CPU_HOTPLUG_ID_LIMIT);
+        assert(cpu_apic_id < ACPI_CPU_HOTPLUG_ID_LIMIT);
 
-        dev = aml_processor(i, 0, 0, "CP%.02X", apic_id);
+        dev = aml_processor(i, 0, 0, "CP%.02X", cpu_apic_id);
 
         method = aml_method("_MAT", 0, AML_NOTSERIALIZED);
         aml_append(method,
-            aml_return(aml_call2(CPU_MAT_METHOD, aml_int(apic_id), aml_int(i))
+            aml_return(aml_call2(CPU_MAT_METHOD,
+                                 aml_int(cpu_apic_id), aml_int(i))
         ));
         aml_append(dev, method);
 
         method = aml_method("_STA", 0, AML_NOTSERIALIZED);
         aml_append(method,
-            aml_return(aml_call1(CPU_STATUS_METHOD, aml_int(apic_id))));
+            aml_return(aml_call1(CPU_STATUS_METHOD, aml_int(cpu_apic_id))));
         aml_append(dev, method);
 
         method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
         aml_append(method,
-            aml_return(aml_call2(CPU_EJECT_METHOD, aml_int(apic_id),
+            aml_return(aml_call2(CPU_EJECT_METHOD, aml_int(cpu_apic_id),
                 aml_arg(0)))
         );
         aml_append(dev, method);
@@ -298,11 +299,11 @@ void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineState *machine,
     /* Arg0 = APIC ID */
     method = aml_method(AML_NOTIFY_METHOD, 2, AML_NOTSERIALIZED);
     for (i = 0; i < apic_ids->len; i++) {
-        int apic_id = apic_ids->cpus[i].arch_id;
+        int cpu_apic_id = apic_ids->cpus[i].arch_id;
 
-        if_ctx = aml_if(aml_equal(aml_arg(0), aml_int(apic_id)));
+        if_ctx = aml_if(aml_equal(aml_arg(0), aml_int(cpu_apic_id)));
         aml_append(if_ctx,
-            aml_notify(aml_name("CP%.02X", apic_id), aml_arg(1))
+            aml_notify(aml_name("CP%.02X", cpu_apic_id), aml_arg(1))
         );
         aml_append(method, if_ctx);
     }
@@ -319,13 +320,13 @@ void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineState *machine,
                                         aml_varpackage(x86ms->apic_id_limit);
 
     for (i = 0, apic_idx = 0; i < apic_ids->len; i++) {
-        int apic_id = apic_ids->cpus[i].arch_id;
+        int cpu_apic_id = apic_ids->cpus[i].arch_id;
 
-        for (; apic_idx < apic_id; apic_idx++) {
+        for (; apic_idx < cpu_apic_id; apic_idx++) {
             aml_append(pkg, aml_int(0));
         }
         aml_append(pkg, aml_int(apic_ids->cpus[i].cpu ? 1 : 0));
-        apic_idx = apic_id + 1;
+        apic_idx = cpu_apic_id + 1;
     }
     aml_append(sb_scope, aml_name_decl(CPU_ON_BITMAP, pkg));
     aml_append(ctx, sb_scope);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 4d2d40bab5..95199c8900 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1585,12 +1585,12 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
             aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
             if (pci_bus_is_cxl(bus)) {
-                struct Aml *pkg = aml_package(2);
+                struct Aml *aml_pkg = aml_package(2);
 
                 aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0016")));
-                aml_append(pkg, aml_eisaid("PNP0A08"));
-                aml_append(pkg, aml_eisaid("PNP0A03"));
-                aml_append(dev, aml_name_decl("_CID", pkg));
+                aml_append(aml_pkg, aml_eisaid("PNP0A08"));
+                aml_append(aml_pkg, aml_eisaid("PNP0A03"));
+                aml_append(dev, aml_name_decl("_CID", aml_pkg));
                 build_cxl_osc_method(dev);
             } else if (pci_bus_is_express(bus)) {
                 aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
@@ -1783,14 +1783,14 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         Object *pci_host = acpi_get_i386_pci_host();
 
         if (pci_host) {
-            PCIBus *bus = PCI_HOST_BRIDGE(pci_host)->bus;
-            Aml *scope = aml_scope("PCI0");
+            PCIBus *pbus = PCI_HOST_BRIDGE(pci_host)->bus;
+            Aml *ascope = aml_scope("PCI0");
             /* Scan all PCI buses. Generate tables to support hotplug. */
-            build_append_pci_bus_devices(scope, bus);
-            if (object_property_find(OBJECT(bus), ACPI_PCIHP_PROP_BSEL)) {
-                build_append_pcihp_slots(scope, bus);
+            build_append_pci_bus_devices(ascope, pbus);
+            if (object_property_find(OBJECT(pbus), ACPI_PCIHP_PROP_BSEL)) {
+                build_append_pcihp_slots(ascope, pbus);
             }
-            aml_append(sb_scope, scope);
+            aml_append(sb_scope, ascope);
         }
     }
 
@@ -1842,10 +1842,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         bool has_pcnt;
 
         Object *pci_host = acpi_get_i386_pci_host();
-        PCIBus *bus = PCI_HOST_BRIDGE(pci_host)->bus;
+        PCIBus *b = PCI_HOST_BRIDGE(pci_host)->bus;
 
         scope = aml_scope("\\_SB.PCI0");
-        has_pcnt = build_append_notfication_callback(scope, bus);
+        has_pcnt = build_append_notfication_callback(scope, b);
         if (has_pcnt) {
             aml_append(dsdt, scope);
         }
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index b753705856..2a90601ac5 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -1423,13 +1423,14 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             if (!qemu_opts_validate(opts, qemu_smbios_type8_opts, errp)) {
                 return;
             }
-            struct type8_instance *t;
-            t = g_new0(struct type8_instance, 1);
-            save_opt(&t->internal_reference, opts, "internal_reference");
-            save_opt(&t->external_reference, opts, "external_reference");
-            t->connector_type = qemu_opt_get_number(opts, "connector_type", 0);
-            t->port_type = qemu_opt_get_number(opts, "port_type", 0);
-            QTAILQ_INSERT_TAIL(&type8, t, next);
+            struct type8_instance *t8_i;
+            t8_i = g_new0(struct type8_instance, 1);
+            save_opt(&t8_i->internal_reference, opts, "internal_reference");
+            save_opt(&t8_i->external_reference, opts, "external_reference");
+            t8_i->connector_type = qemu_opt_get_number(opts,
+                                                       "connector_type", 0);
+            t8_i->port_type = qemu_opt_get_number(opts, "port_type", 0);
+            QTAILQ_INSERT_TAIL(&type8, t8_i, next);
             return;
         case 11:
             if (!qemu_opts_validate(opts, qemu_smbios_type11_opts, errp)) {
@@ -1452,27 +1453,27 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             type17.speed = qemu_opt_get_number(opts, "speed", 0);
             return;
         case 41: {
-            struct type41_instance *t;
+            struct type41_instance *t41_i;
             Error *local_err = NULL;
 
             if (!qemu_opts_validate(opts, qemu_smbios_type41_opts, errp)) {
                 return;
             }
-            t = g_new0(struct type41_instance, 1);
-            save_opt(&t->designation, opts, "designation");
-            t->kind = qapi_enum_parse(&type41_kind_lookup,
-                                      qemu_opt_get(opts, "kind"),
-                                      0, &local_err) + 1;
-            t->kind |= 0x80;     /* enabled */
+            t41_i = g_new0(struct type41_instance, 1);
+            save_opt(&t41_i->designation, opts, "designation");
+            t41_i->kind = qapi_enum_parse(&type41_kind_lookup,
+                                          qemu_opt_get(opts, "kind"),
+                                          0, &local_err) + 1;
+            t41_i->kind |= 0x80;     /* enabled */
             if (local_err != NULL) {
                 error_propagate(errp, local_err);
-                g_free(t);
+                g_free(t41_i);
                 return;
             }
-            t->instance = qemu_opt_get_number(opts, "instance", 1);
-            save_opt(&t->pcidev, opts, "pcidev");
+            t41_i->instance = qemu_opt_get_number(opts, "instance", 1);
+            save_opt(&t41_i->pcidev, opts, "pcidev");
 
-            QTAILQ_INSERT_TAIL(&type41, t, next);
+            QTAILQ_INSERT_TAIL(&type41, t41_i, next);
             return;
         }
         default:
-- 
2.41.0


