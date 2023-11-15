Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DB07EC6F5
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 16:15:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3HaS-0004AS-3k; Wed, 15 Nov 2023 10:13:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r3HZm-0003uq-Gm
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:13:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r3HZf-0003Ht-Ir
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700061178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1703dOjesTS8lC9RyrytkP2Jb4PIVv6TIpKvHPw8BMs=;
 b=V88NoHSxR2bIjUCF9XpAHyGXuBSwt091vEHuC/mrF7/JmN+vqljaXjsgwRWNBIcvJrASf5
 GdPCTAhvsDPbVMO+kTV2UkgYbzl79qIKCfHq4Mtf7d1i7w7P99Bblql67g1ekHHxz+uT/h
 3GKr5VEHwo/DIzQmLMmsXD4M4yBmOoE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-7x7UXb0rPpyPxmxJBHKXcw-1; Wed,
 15 Nov 2023 10:12:55 -0500
X-MC-Unique: 7x7UXb0rPpyPxmxJBHKXcw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CED363810D28;
 Wed, 15 Nov 2023 15:12:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 55A5FC15881;
 Wed, 15 Nov 2023 15:12:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 497EE180AC19; Wed, 15 Nov 2023 16:12:43 +0100 (CET)
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
Subject: [PATCH 14/16] hw/uefi: add uefi-vars-isa device
Date: Wed, 15 Nov 2023 16:12:36 +0100
Message-ID: <20231115151242.184645-15-kraxel@redhat.com>
In-Reply-To: <20231115151242.184645-1-kraxel@redhat.com>
References: <20231115151242.184645-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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

This adds isa bindings for the variable service.

Usage: qemu-system-x86_64 -device uefi-vars-isa,jsonfile=/path/to/uefivars.json

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-isa.c | 88 +++++++++++++++++++++++++++++++++++++++
 hw/uefi/Kconfig           |  6 +++
 hw/uefi/meson.build       |  5 +++
 3 files changed, 99 insertions(+)
 create mode 100644 hw/uefi/var-service-isa.c

diff --git a/hw/uefi/var-service-isa.c b/hw/uefi/var-service-isa.c
new file mode 100644
index 000000000000..bdb270c2a643
--- /dev/null
+++ b/hw/uefi/var-service-isa.c
@@ -0,0 +1,88 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * uefi vars device - ISA variant for x64.
+ */
+#include "qemu/osdep.h"
+#include "migration/vmstate.h"
+
+#include "hw/isa/isa.h"
+#include "hw/qdev-properties.h"
+
+#include "hw/uefi/var-service.h"
+#include "hw/uefi/var-service-api.h"
+
+#define TYPE_UEFI_VARS_ISA "uefi-vars-isa"
+OBJECT_DECLARE_SIMPLE_TYPE(uefi_vars_isa_state, UEFI_VARS_ISA)
+
+struct uefi_vars_isa_state {
+    ISADevice parent_obj;
+    struct uefi_vars_state state;
+};
+
+static const VMStateDescription vmstate_uefi_vars_isa = {
+    .name = "uefi-vars-isa",
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT(state, uefi_vars_isa_state, 0,
+                       vmstate_uefi_vars, uefi_vars_state),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property uefi_vars_isa_properties[] = {
+    DEFINE_PROP_SIZE("size", uefi_vars_isa_state, state.max_storage,
+                     256 * 1024),
+    DEFINE_PROP_STRING("jsonfile", uefi_vars_isa_state, state.jsonfile),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void uefi_vars_isa_init(Object *obj)
+{
+    uefi_vars_isa_state *uv = UEFI_VARS_ISA(obj);
+
+    uefi_vars_init(obj, &uv->state);
+}
+
+static void uefi_vars_isa_reset(DeviceState *dev)
+{
+    uefi_vars_isa_state *uv = UEFI_VARS_ISA(dev);
+
+    uefi_vars_hard_reset(&uv->state);
+}
+
+static void uefi_vars_isa_realize(DeviceState *dev, Error **errp)
+{
+    uefi_vars_isa_state *uv = UEFI_VARS_ISA(dev);
+    ISADevice *isa = ISA_DEVICE(dev);
+
+    isa_register_ioport(isa, &uv->state.mr, UEFI_VARS_IO_BASE);
+    uefi_vars_realize(&uv->state, errp);
+}
+
+static void uefi_vars_isa_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = uefi_vars_isa_realize;
+    dc->reset = uefi_vars_isa_reset;
+    dc->vmsd = &vmstate_uefi_vars_isa;
+    device_class_set_props(dc, uefi_vars_isa_properties);
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static const TypeInfo uefi_vars_isa_info = {
+    .name          = TYPE_UEFI_VARS_ISA,
+    .parent        = TYPE_ISA_DEVICE,
+    .instance_size = sizeof(uefi_vars_isa_state),
+    .instance_init = uefi_vars_isa_init,
+    .class_init    = uefi_vars_isa_class_init,
+};
+module_obj(TYPE_UEFI_VARS_ISA);
+module_dep("hw-uefi-vars");
+
+static void uefi_vars_isa_register_types(void)
+{
+    type_register_static(&uefi_vars_isa_info);
+}
+
+type_init(uefi_vars_isa_register_types)
diff --git a/hw/uefi/Kconfig b/hw/uefi/Kconfig
index ca6c2bc46a96..feb9f6de5e30 100644
--- a/hw/uefi/Kconfig
+++ b/hw/uefi/Kconfig
@@ -1,3 +1,9 @@
 config UEFI_VARS
 	bool
         default y if X86_64 || AARCH64
+
+config UEFI_VARS_ISA
+	bool
+        default y
+        depends on UEFI_VARS
+        depends on ISA_BUS
diff --git a/hw/uefi/meson.build b/hw/uefi/meson.build
index dc363d67cccc..959d2a630bbf 100644
--- a/hw/uefi/meson.build
+++ b/hw/uefi/meson.build
@@ -8,6 +8,11 @@ uefi_vars_ss.add(when: 'CONFIG_UEFI_VARS',
                                 'var-service-policy.c',
                                 'var-service-sysbus.c'))
 
+uefi_vars_isa_ss = ss.source_set()
+uefi_vars_isa_ss.add(when: 'CONFIG_UEFI_VARS_ISA',
+                     if_true: files('var-service-isa.c'))
+
 modules += { 'hw-uefi' : {
     'vars'     : uefi_vars_ss,
+    'vars-isa' : uefi_vars_isa_ss,
 }}
-- 
2.41.0


