Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B427516FA
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 05:55:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJnOD-0005RC-JY; Wed, 12 Jul 2023 23:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qJnNx-0005OR-Qp
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 23:52:57 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qJnNn-0004cJ-Jn
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 23:52:57 -0400
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-6b711c3ad1fso222937a34.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 20:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689220366; x=1691812366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4VTJlfLzpuxxNKZPxm/qCkrMkuqDPIbMWB1AskfZxJw=;
 b=ha85q1caz8GfhwvcWdrY3vJeH6z7kJLBsj9MRhrOkF27HpTgTjEZGez+KgoEMf7k/T
 f+48sgr5tFY74ApzZuEj/4oAsHDzShNOygJlFEQ1i1M2gUPbFdBjcVRaGSZMybTns98m
 cwSrL3cLGdw16KyWORT7/CbW04MGKTdO4VKOTgBzKisH5H9/bUFMLXm9A7VuGyb5y2HH
 cn8bXz7Sw95NgaZh5Y/IJhflYtAREWKuASiHLbMOQNyeCjWQPmJZcMND2go/eAdj0wgu
 5VLMtyyUvViBFb+wTs8imTsTOQF4d358L+9P0xJKDSn1lRJD6emlEnXOvHsu+my+67Dg
 V8Ew==
X-Gm-Message-State: ABy/qLbNkhAqmFB8ZQda3+XvnRBuS79NYiOXpUylrwd+2GrJbSaPkDN8
 /yvKQgtKjdbeJATMPAbg3I1ZY7F2Ag0JxA==
X-Google-Smtp-Source: APBJJlHV71HmslCH/ldON2SdfccswbrjVvUdS0WS/hftwOWe+qemYQpACdAEFhO4om+pdrUlfQpB8Q==
X-Received: by 2002:a05:6830:1506:b0:6b9:924e:b43b with SMTP id
 k6-20020a056830150600b006b9924eb43bmr615351otp.6.1689220366298; 
 Wed, 12 Jul 2023 20:52:46 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:8b82:587c:b800:84d:31b7:313d])
 by smtp.gmail.com with ESMTPSA id
 x6-20020a1709027c0600b001b8a37ffb5asm4756199pll.4.2023.07.12.20.52.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Jul 2023 20:52:46 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 05/11] tpm_crb: use the ISA bus
Date: Wed, 12 Jul 2023 20:51:10 -0700
Message-ID: <20230713035232.48406-6-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713035232.48406-1-j@getutm.app>
References: <20230713035232.48406-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.210.48; envelope-from=osy86dev@gmail.com;
 helo=mail-ot1-f48.google.com
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

Since this device is gated to only build for targets with the PC
configuration, we should use the ISA bus like with TPM TIS.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 hw/tpm/tpm_crb.c | 52 ++++++++++++++++++++++++------------------------
 hw/tpm/Kconfig   |  2 +-
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 07c6868d8d..6144081d30 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -22,6 +22,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/pci/pci_ids.h"
 #include "hw/acpi/tpm.h"
+#include "hw/isa/isa.h"
 #include "migration/vmstate.h"
 #include "sysemu/tpm_backend.h"
 #include "sysemu/tpm_util.h"
@@ -34,7 +35,7 @@
 #include "tpm_crb.h"
 
 struct CRBState {
-    DeviceState parent_obj;
+    ISADevice parent_obj;
 
     TPMCRBState state;
 };
@@ -43,49 +44,49 @@ typedef struct CRBState CRBState;
 DECLARE_INSTANCE_CHECKER(CRBState, CRB,
                          TYPE_TPM_CRB)
 
-static void tpm_crb_none_request_completed(TPMIf *ti, int ret)
+static void tpm_crb_isa_request_completed(TPMIf *ti, int ret)
 {
     CRBState *s = CRB(ti);
 
     tpm_crb_request_completed(&s->state, ret);
 }
 
-static enum TPMVersion tpm_crb_none_get_version(TPMIf *ti)
+static enum TPMVersion tpm_crb_isa_get_version(TPMIf *ti)
 {
     CRBState *s = CRB(ti);
 
     return tpm_crb_get_version(&s->state);
 }
 
-static int tpm_crb_none_pre_save(void *opaque)
+static int tpm_crb_isa_pre_save(void *opaque)
 {
     CRBState *s = opaque;
 
     return tpm_crb_pre_save(&s->state);
 }
 
-static const VMStateDescription vmstate_tpm_crb_none = {
+static const VMStateDescription vmstate_tpm_crb_isa = {
     .name = "tpm-crb",
-    .pre_save = tpm_crb_none_pre_save,
+    .pre_save = tpm_crb_isa_pre_save,
     .fields = (VMStateField[]) {
         VMSTATE_END_OF_LIST(),
     }
 };
 
-static Property tpm_crb_none_properties[] = {
+static Property tpm_crb_isa_properties[] = {
     DEFINE_PROP_TPMBE("tpmdev", CRBState, state.tpmbe),
     DEFINE_PROP_BOOL("ppi", CRBState, state.ppi_enabled, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static void tpm_crb_none_reset(void *dev)
+static void tpm_crb_isa_reset(void *dev)
 {
     CRBState *s = CRB(dev);
 
     return tpm_crb_reset(&s->state, TPM_CRB_ADDR_BASE);
 }
 
-static void tpm_crb_none_realize(DeviceState *dev, Error **errp)
+static void tpm_crb_isa_realize(DeviceState *dev, Error **errp)
 {
     CRBState *s = CRB(dev);
 
@@ -100,52 +101,51 @@ static void tpm_crb_none_realize(DeviceState *dev, Error **errp)
 
     tpm_crb_init_memory(OBJECT(s), &s->state, errp);
 
-    memory_region_add_subregion(get_system_memory(),
+    memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
         TPM_CRB_ADDR_BASE, &s->state.mmio);
 
     if (s->state.ppi_enabled) {
-        memory_region_add_subregion(get_system_memory(),
+        memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
             TPM_PPI_ADDR_BASE, &s->state.ppi.ram);
     }
 
     if (xen_enabled()) {
-        tpm_crb_none_reset(dev);
+        tpm_crb_isa_reset(dev);
     } else {
-        qemu_register_reset(tpm_crb_none_reset, dev);
+        qemu_register_reset(tpm_crb_isa_reset, dev);
     }
 }
 
-static void tpm_crb_none_class_init(ObjectClass *klass, void *data)
+static void tpm_crb_isa_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     TPMIfClass *tc = TPM_IF_CLASS(klass);
 
-    dc->realize = tpm_crb_none_realize;
-    device_class_set_props(dc, tpm_crb_none_properties);
-    dc->vmsd  = &vmstate_tpm_crb_none;
+    dc->realize = tpm_crb_isa_realize;
+    device_class_set_props(dc, tpm_crb_isa_properties);
+    dc->vmsd  = &vmstate_tpm_crb_isa;
     dc->user_creatable = true;
     tc->model = TPM_MODEL_TPM_CRB;
-    tc->get_version = tpm_crb_none_get_version;
-    tc->request_completed = tpm_crb_none_request_completed;
+    tc->get_version = tpm_crb_isa_get_version;
+    tc->request_completed = tpm_crb_isa_request_completed;
 
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
-static const TypeInfo tpm_crb_none_info = {
+static const TypeInfo tpm_crb_isa_info = {
     .name = TYPE_TPM_CRB,
-    /* could be TYPE_SYS_BUS_DEVICE (or LPC etc) */
-    .parent = TYPE_DEVICE,
+    .parent = TYPE_ISA_DEVICE,
     .instance_size = sizeof(CRBState),
-    .class_init  = tpm_crb_none_class_init,
+    .class_init  = tpm_crb_isa_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_TPM_IF },
         { }
     }
 };
 
-static void tpm_crb_none_register(void)
+static void tpm_crb_isa_register(void)
 {
-    type_register_static(&tpm_crb_none_info);
+    type_register_static(&tpm_crb_isa_info);
 }
 
-type_init(tpm_crb_none_register)
+type_init(tpm_crb_isa_register)
diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
index a46663288c..1fd73fe617 100644
--- a/hw/tpm/Kconfig
+++ b/hw/tpm/Kconfig
@@ -22,7 +22,7 @@ config TPM_TIS
 
 config TPM_CRB
     bool
-    depends on TPM && PC
+    depends on TPM && ISA_BUS
     select TPM_BACKEND
 
 config TPM_SPAPR
-- 
2.39.2 (Apple Git-143)


