Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7D47DC51E
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 05:02:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxfvz-0001Ns-Sw; Tue, 31 Oct 2023 00:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qxfvi-0001L2-Vb
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 00:00:40 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qxfvg-0005FL-7J
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 00:00:37 -0400
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-1cc5fa0e4d5so8739605ad.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 21:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698724833; x=1699329633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LPHMauEdGh1K7jUPni50wpUw7wRpJku5xT3uhlS42Zw=;
 b=p50t4vKH4h6IK/8g3ICTtqD6siqV4jKuumaAWZjCnqszr5sXd0z+7izvZ1aUul9biq
 OVVOIcrSYEEOCpNBce/jMde2z5j2WfwV1Vj9VizUR/7s1qW1WYNsP7bRfvxEwF5gDwR+
 3sXoNILVEw/Nusb7UWxnU4dFfDdWjCF0VDPHPySkRkEElPSdAXHBBMk0cHX9s2oIZ2RS
 A92I9cfqxXiGxT5jo/tnEWrXER9BBkhrawUvoT81WOZkF76Z5LyPhbhGrDGB4VQ67y2Y
 d7GVO9ABdaZtSAXqqZtCuFsNr3jf3XE11+lYcHkaBM2gPajtfs8AyizbIoRg1SjSqwzi
 xgYA==
X-Gm-Message-State: AOJu0Yxw5+iCSsZJtu7DGD16h9Uc9gAyPFmftc9sEIGZ2XOCvVjO0miT
 NOKUSBZNxk6XRzks2hEB0KdtIYh4hmqAEw==
X-Google-Smtp-Source: AGHT+IGuZp/Eo0FXlKBc2o9tkVksFQsdcBQUS6F8paebi1hNrRaxvaEySlrBS2sxGGNlSboYoabeLw==
X-Received: by 2002:a17:902:c952:b0:1cc:560a:5500 with SMTP id
 i18-20020a170902c95200b001cc560a5500mr3806864pla.65.1698724832920; 
 Mon, 30 Oct 2023 21:00:32 -0700 (PDT)
Received: from localhost.localdomain ([2601:642:4c02:7b37:49a8:6e6e:cee6:cee7])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a170902f54400b001bbfa86ca3bsm257975plf.78.2023.10.30.21.00.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Oct 2023 21:00:32 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v4 05/14] tpm_crb: move ACPI table building to device interface
Date: Mon, 30 Oct 2023 21:00:08 -0700
Message-ID: <20231031040021.65582-6-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031040021.65582-1-j@getutm.app>
References: <20231031040021.65582-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.174; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f174.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This logic is similar to TPM TIS ISA device. Since TPM CRB can only
support TPM 2.0 backends, we check for this in realize.

Signed-off-by: Joelle van Dyne <j@getutm.app>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_crb.h        |  2 ++
 hw/i386/acpi-build.c    | 23 -----------------------
 hw/tpm/tpm_crb.c        | 16 ++++++++++++++++
 hw/tpm/tpm_crb_common.c | 19 +++++++++++++++++++
 4 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/hw/tpm/tpm_crb.h b/hw/tpm/tpm_crb.h
index 36863e1664..e6a86e3fd1 100644
--- a/hw/tpm/tpm_crb.h
+++ b/hw/tpm/tpm_crb.h
@@ -73,5 +73,7 @@ void tpm_crb_init_memory(Object *obj, TPMCRBState *s, Error **errp);
 void tpm_crb_mem_save(TPMCRBState *s, uint32_t *saved_regs, void *saved_cmdmem);
 void tpm_crb_mem_load(TPMCRBState *s, const uint32_t *saved_regs,
                       const void *saved_cmdmem);
+void tpm_crb_build_aml(TPMIf *ti, Aml *scope, uint32_t baseaddr, uint32_t size,
+                       bool build_ppi);
 
 #endif /* TPM_TPM_CRB_H */
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 80db183b78..ce3f7b2d91 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1441,9 +1441,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     uint32_t nr_mem = machine->ram_slots;
     int root_bus_limit = 0xFF;
     PCIBus *bus = NULL;
-#ifdef CONFIG_TPM
-    TPMIf *tpm = tpm_find();
-#endif
     bool cxl_present = false;
     int i;
     VMBusBridge *vmbus_bridge = vmbus_bridge_find();
@@ -1790,26 +1787,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         }
     }
 
-#ifdef CONFIG_TPM
-    if (TPM_IS_CRB(tpm)) {
-        dev = aml_device("TPM");
-        aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
-        aml_append(dev, aml_name_decl("_STR",
-                                      aml_string("TPM 2.0 Device")));
-        crs = aml_resource_template();
-        aml_append(crs, aml_memory32_fixed(TPM_CRB_ADDR_BASE,
-                                           TPM_CRB_ADDR_SIZE, AML_READ_WRITE));
-        aml_append(dev, aml_name_decl("_CRS", crs));
-
-        aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
-        aml_append(dev, aml_name_decl("_UID", aml_int(1)));
-
-        tpm_build_ppi_acpi(tpm, dev);
-
-        aml_append(sb_scope, dev);
-    }
-#endif
-
     if (pcms->sgx_epc.size != 0) {
         uint64_t epc_base = pcms->sgx_epc.base;
         uint64_t epc_size = pcms->sgx_epc.size;
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 99c64dd72a..8d57295b15 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -19,6 +19,8 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
+#include "hw/acpi/acpi_aml_interface.h"
+#include "hw/acpi/tpm.h"
 #include "hw/qdev-properties.h"
 #include "hw/pci/pci_ids.h"
 #include "hw/acpi/tpm.h"
@@ -121,6 +123,11 @@ static void tpm_crb_none_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (tpm_crb_none_get_version(TPM_IF(s)) != TPM_VERSION_2_0) {
+        error_setg(errp, "TPM CRB only supports TPM 2.0 backends");
+        return;
+    }
+
     tpm_crb_init_memory(OBJECT(s), &s->state, errp);
 
     /* only used for migration */
@@ -142,10 +149,17 @@ static void tpm_crb_none_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static void build_tpm_crb_none_aml(AcpiDevAmlIf *adev, Aml *scope)
+{
+    tpm_crb_build_aml(TPM_IF(adev), scope, TPM_CRB_ADDR_BASE, TPM_CRB_ADDR_SIZE,
+                      true);
+}
+
 static void tpm_crb_none_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     TPMIfClass *tc = TPM_IF_CLASS(klass);
+    AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
 
     dc->realize = tpm_crb_none_realize;
     device_class_set_props(dc, tpm_crb_none_properties);
@@ -154,6 +168,7 @@ static void tpm_crb_none_class_init(ObjectClass *klass, void *data)
     tc->model = TPM_MODEL_TPM_CRB;
     tc->get_version = tpm_crb_none_get_version;
     tc->request_completed = tpm_crb_none_request_completed;
+    adevc->build_dev_aml = build_tpm_crb_none_aml;
 
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
@@ -166,6 +181,7 @@ static const TypeInfo tpm_crb_none_info = {
     .class_init  = tpm_crb_none_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_TPM_IF },
+        { TYPE_ACPI_DEV_AML_IF },
         { }
     }
 };
diff --git a/hw/tpm/tpm_crb_common.c b/hw/tpm/tpm_crb_common.c
index 605e8576e9..4fff0c6b59 100644
--- a/hw/tpm/tpm_crb_common.c
+++ b/hw/tpm/tpm_crb_common.c
@@ -239,3 +239,22 @@ void tpm_crb_mem_load(TPMCRBState *s, const uint32_t *saved_regs,
     memcpy(regs, saved_regs, TPM_CRB_R_MAX);
     memcpy(&regs[R_CRB_DATA_BUFFER], saved_cmdmem, A_CRB_DATA_BUFFER);
 }
+
+void tpm_crb_build_aml(TPMIf *ti, Aml *scope, uint32_t baseaddr, uint32_t size,
+                       bool build_ppi)
+{
+    Aml *dev, *crs;
+
+    dev = aml_device("TPM");
+    aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
+    aml_append(dev, aml_name_decl("_STR", aml_string("TPM 2.0 Device")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(1)));
+    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
+    crs = aml_resource_template();
+    aml_append(crs, aml_memory32_fixed(baseaddr, size, AML_READ_WRITE));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+    if (build_ppi) {
+        tpm_build_ppi_acpi(ti, dev);
+    }
+    aml_append(scope, dev);
+}
-- 
2.41.0


