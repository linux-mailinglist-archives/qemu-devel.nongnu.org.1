Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A4E7EA8A8
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 03:15:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2is7-0001Ja-2u; Mon, 13 Nov 2023 21:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2is4-0001Hf-Ig
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 21:09:44 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2is2-0007aH-U1
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 21:09:44 -0500
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-282ff1a97dcso3283471a91.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 18:09:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699927781; x=1700532581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SFCjYhKVZnE2YpkIUkqgvjnf/2XFMF0OVXQFbD0oMKo=;
 b=c3/OdmPrV8zaDwv7olOsrH8/YDdSV0wPXbBJ3LMmpEdSxNgj7MrHNE5iQIzIjz60Bt
 Cew9e0L0Is0v7DXQA1W5QY77vmrfvPhJHxeKY1EEna8iSjGGWaPUbejEhMIIKCUOdprD
 3QeA2EAhlxoQjJ1xfumbhxvn4VYuZGn7z/NHXjPkPZTWEzTN+JapnwC5SKzELQuvJO7x
 kpI9n4443SnzRphJrLRrojXNl2ShjdrqGTNby764M/WUk24LdyZZ0Vi/F6EoPZoJoHZ9
 jIYG3ycyLtQXjp5dZebLHLl4peftb6YixOb5dAMpOcocZEELC3pLVtBCExox5oQ0yRzd
 MLJQ==
X-Gm-Message-State: AOJu0YwNsA9EiU3KP/geNgI8E34zqkNJguacsIJqL4bSogSh35oSJEBD
 HEZNopW23CsqKY+SBVM98voNRdQRTPO+eA==
X-Google-Smtp-Source: AGHT+IGcoiMj+cWOnxGxOijbZAYVGKi/+aacwULKuHlE9CCdTNSef4WOJNSFQFX5SUZOH3/GyvDxIg==
X-Received: by 2002:a17:90b:4c89:b0:27e:3342:5c1f with SMTP id
 my9-20020a17090b4c8900b0027e33425c1fmr6172234pjb.43.1699927781397; 
 Mon, 13 Nov 2023 18:09:41 -0800 (PST)
Received: from localhost.localdomain ([2601:642:4c01:2f7:5d09:c219:9099:a639])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a17090ae58d00b0027d12b1e29dsm6175362pjz.25.2023.11.13.18.09.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 18:09:40 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v5 05/14] tpm_crb: move ACPI table building to device interface
Date: Mon, 13 Nov 2023 18:09:15 -0800
Message-ID: <20231114020927.62315-6-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114020927.62315-1-j@getutm.app>
References: <20231114020927.62315-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.216.54; envelope-from=osy86dev@gmail.com;
 helo=mail-pj1-f54.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
 hw/tpm/tpm_crb.h        |  2 ++
 hw/i386/acpi-build.c    | 16 +---------------
 hw/tpm/tpm_crb.c        | 16 ++++++++++++++++
 hw/tpm/tpm_crb_common.c | 19 +++++++++++++++++++
 4 files changed, 38 insertions(+), 15 deletions(-)

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
index 80db183b78..7491cee2af 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1792,21 +1792,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
 
 #ifdef CONFIG_TPM
     if (TPM_IS_CRB(tpm)) {
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
+        call_dev_aml_func(DEVICE(tpm), scope);
     }
 #endif
 
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
index f96a8cf299..09ca55eece 100644
--- a/hw/tpm/tpm_crb_common.c
+++ b/hw/tpm/tpm_crb_common.c
@@ -241,3 +241,22 @@ void tpm_crb_mem_load(TPMCRBState *s, const uint32_t *saved_regs,
     memcpy(regs, saved_regs, A_CRB_DATA_BUFFER);
     memcpy(&regs[R_CRB_DATA_BUFFER], saved_cmdmem, CRB_CTRL_CMD_SIZE);
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


