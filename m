Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFA27532A5
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 09:11:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKCwE-0006NN-QP; Fri, 14 Jul 2023 03:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKCwC-0006Mi-6p
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:10:00 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKCwA-00059W-JE
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:09:59 -0400
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-553ad54d3c6so982031a12.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 00:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689318597; x=1691910597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xo9OkFpgbvpNKryAzul/xGcwNnsWXHdnyLucVXwFaGU=;
 b=TI5N5gzjm23ZOy2xLjH8l1wc+/enwRvmx4t9U7KRhSvx2oKZPKVOy+GYP/f6ln0XLp
 n+QVrDxcuzWBkn3YEWDQiJIKGfLfqyod7UnboQiA8SBmpEErnEJ53t/JU0c5YHLzgUjJ
 MW9jmzZGLaLJOLHNOfew2hxSETsX+qlO7PeeV2fOxUNb0Qd01Box1HYE+y8HhoKxdVyN
 1LV6eSk3UjdDvUqnNAfM4XhYoQ+Mr3U9HJA6FhRqM5QJE+qp9TqT/GP/v38YT/aOEHtG
 lOL+gKMlUlbYvuuHXJ2MTqefiKXSeg0A3/cyspo0Ymz9y9Wgjj6iYkZtDDMPeXiNiteb
 icCQ==
X-Gm-Message-State: ABy/qLZiyR02riNUpPJaaEiXM1JSBeeLwR9KoXlcO0U7579TMtIL15q4
 OCo+t97ORhMYtDCHFHDrgIhRIat+uza+Uw==
X-Google-Smtp-Source: APBJJlHdDqzcKPu086PbquKBjAiwOFA3YfIr8OtaKs1H2trPUlz5Pw6Ryh+6a2f3Wy4EaaroT57YIA==
X-Received: by 2002:a17:902:e743:b0:1b9:ce7a:8603 with SMTP id
 p3-20020a170902e74300b001b9ce7a8603mr3215540plf.66.1689318597102; 
 Fri, 14 Jul 2023 00:09:57 -0700 (PDT)
Received: from localhost.localdomain
 ([2607:fb90:dd17:8dad:e558:8948:1ff6:c8c1])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a170902b20800b001b89466a5f4sm7041513plr.105.2023.07.14.00.09.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 14 Jul 2023 00:09:56 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v2 06/11] tpm_crb: move ACPI table building to device interface
Date: Fri, 14 Jul 2023 00:09:22 -0700
Message-ID: <20230714070931.23476-7-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714070931.23476-1-j@getutm.app>
References: <20230714070931.23476-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.215.182; envelope-from=osy86dev@gmail.com;
 helo=mail-pg1-f182.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
---
 hw/i386/acpi-build.c | 23 -----------------------
 hw/tpm/tpm_crb.c     | 29 +++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9c74fa17ad..b767df39df 100644
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
@@ -1793,26 +1790,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
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
index 6144081d30..594696ffb8 100644
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
@@ -99,6 +101,11 @@ static void tpm_crb_isa_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (tpm_crb_isa_get_version(TPM_IF(s)) != TPM_VERSION_2_0) {
+        error_setg(errp, "TPM CRB only supports TPM 2.0 backends");
+        return;
+    }
+
     tpm_crb_init_memory(OBJECT(s), &s->state, errp);
 
     memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
@@ -116,10 +123,30 @@ static void tpm_crb_isa_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static void build_tpm_crb_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
+{
+    Aml *dev, *crs;
+    CRBState *s = CRB(adev);
+    TPMIf *ti = TPM_IF(s);
+
+    dev = aml_device("TPM");
+    aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
+    aml_append(dev, aml_name_decl("_STR", aml_string("TPM 2.0 Device")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(1)));
+    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
+    crs = aml_resource_template();
+    aml_append(crs, aml_memory32_fixed(TPM_CRB_ADDR_BASE, TPM_CRB_ADDR_SIZE,
+                                      AML_READ_WRITE));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+    tpm_build_ppi_acpi(ti, dev);
+    aml_append(scope, dev);
+}
+
 static void tpm_crb_isa_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     TPMIfClass *tc = TPM_IF_CLASS(klass);
+    AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
 
     dc->realize = tpm_crb_isa_realize;
     device_class_set_props(dc, tpm_crb_isa_properties);
@@ -128,6 +155,7 @@ static void tpm_crb_isa_class_init(ObjectClass *klass, void *data)
     tc->model = TPM_MODEL_TPM_CRB;
     tc->get_version = tpm_crb_isa_get_version;
     tc->request_completed = tpm_crb_isa_request_completed;
+    adevc->build_dev_aml = build_tpm_crb_isa_aml;
 
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
@@ -139,6 +167,7 @@ static const TypeInfo tpm_crb_isa_info = {
     .class_init  = tpm_crb_isa_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_TPM_IF },
+        { TYPE_ACPI_DEV_AML_IF },
         { }
     }
 };
-- 
2.39.2 (Apple Git-143)


