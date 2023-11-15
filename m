Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A687EC6EC
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 16:14:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3HaA-00040p-Vq; Wed, 15 Nov 2023 10:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r3HZi-0003uS-Mq
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:13:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r3HZe-0003Hk-H8
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700061178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SlfyueLbLD0JsTioXNtVJ/EifcwODu++m93IbshPZgs=;
 b=fiXPzO6Qm+8KtXdR9rZTLDqYkGpLp4smvf6xPicmJW+hAxpG/aGqbj6GmOIvPW29FuxqAv
 1WKmdML1PrNQzGDalZo/j608rxPnJMSz17pTdy+u7Gg69OCm5f5MdoRJgutujRO8Nh14HS
 qJsFKAsGWqj103cLex0+j8AxQNtbLRU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-yzzhB9sAOO2Xi7eGunTUAw-1; Wed, 15 Nov 2023 10:12:55 -0500
X-MC-Unique: yzzhB9sAOO2Xi7eGunTUAw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFF788630DE;
 Wed, 15 Nov 2023 15:12:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 924372166B27;
 Wed, 15 Nov 2023 15:12:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 59CC4180AC1A; Wed, 15 Nov 2023 16:12:43 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Eric Blake <eblake@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?L=C3=A1szl=C3=B3=20=C3=89rsek?= <lersek@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 graf@amazon.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 15/16] hw/arm: add uefi variable support to virt machine type
Date: Wed, 15 Nov 2023 16:12:37 +0100
Message-ID: <20231115151242.184645-16-kraxel@redhat.com>
In-Reply-To: <20231115151242.184645-1-kraxel@redhat.com>
References: <20231115151242.184645-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add -machine virt,x-uefi-vars={on,off} property.  Default is off.
When enabled wire up the uefi-vars-sysbus device.

TODO: wire up jsonfile property.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/arm/virt.h |  2 ++
 hw/arm/virt.c         | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index f69239850e61..3dd655b880a9 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -76,6 +76,7 @@ enum {
     VIRT_ACPI_GED,
     VIRT_NVDIMM_ACPI,
     VIRT_PVTIME,
+    VIRT_UEFI_VARS,
     VIRT_LOWMEMMAP_LAST,
 };
 
@@ -150,6 +151,7 @@ struct VirtMachineState {
     bool ras;
     bool mte;
     bool dtb_randomness;
+    bool uefi_vars;
     OnOffAuto acpi;
     VirtGICType gic_version;
     VirtIOMMUType iommu;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 529f1c089c08..49f692fda7cf 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -65,6 +65,7 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/irq.h"
+#include "hw/uefi/var-service-api.h"
 #include "kvm_arm.h"
 #include "hw/firmware/smbios.h"
 #include "qapi/visitor.h"
@@ -155,6 +156,7 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_NVDIMM_ACPI] =        { 0x09090000, NVDIMM_ACPI_IO_LEN},
     [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
     [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
+    [VIRT_UEFI_VARS] =          { 0x090c0000, 0x00000010 },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
@@ -1296,6 +1298,24 @@ static FWCfgState *create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
     return fw_cfg;
 }
 
+static void create_uefi_vars(const VirtMachineState *vms)
+{
+    hwaddr base = vms->memmap[VIRT_UEFI_VARS].base;
+    hwaddr size = vms->memmap[VIRT_UEFI_VARS].size;
+    MachineState *ms = MACHINE(vms);
+    char *nodename;
+
+    sysbus_create_simple("uefi-vars-sysbus", base, NULL);
+
+    nodename = g_strdup_printf("/%s@%" PRIx64, UEFI_VARS_FDT_NODE, base);
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_string(ms->fdt, nodename,
+                            "compatible", UEFI_VARS_FDT_COMPAT);
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
+                                 2, base, 2, size);
+    g_free(nodename);
+}
+
 static void create_pcie_irq_map(const MachineState *ms,
                                 uint32_t gic_phandle,
                                 int first_irq, const char *nodename)
@@ -2306,6 +2326,10 @@ static void machvirt_init(MachineState *machine)
     vms->fw_cfg = create_fw_cfg(vms, &address_space_memory);
     rom_set_fw(vms->fw_cfg);
 
+    if (vms->uefi_vars) {
+        create_uefi_vars(vms);
+    }
+
     create_platform_bus(vms);
 
     if (machine->nvdimms_state->is_enabled) {
@@ -2502,6 +2526,20 @@ static void virt_set_oem_table_id(Object *obj, const char *value,
     strncpy(vms->oem_table_id, value, 8);
 }
 
+static bool virt_get_uefi_vars(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    return vms->uefi_vars;
+}
+
+static void virt_set_uefi_vars(Object *obj, bool value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    vms->uefi_vars = value;
+}
+
 
 bool virt_is_acpi_enabled(VirtMachineState *vms)
 {
@@ -3092,6 +3130,9 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
                                           "in ACPI table header."
                                           "The string may be up to 8 bytes in size");
 
+    object_class_property_add_bool(oc, "x-uefi-vars",
+                                   virt_get_uefi_vars,
+                                   virt_set_uefi_vars);
 }
 
 static void virt_instance_init(Object *obj)
-- 
2.41.0


