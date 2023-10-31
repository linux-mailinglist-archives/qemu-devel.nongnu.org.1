Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 127AE7DC51D
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 05:02:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxfvz-0001NY-Lb; Tue, 31 Oct 2023 00:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qxfvk-0001L5-LT
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 00:00:40 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qxfvi-0005FX-LL
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 00:00:40 -0400
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-1cc3bb4c307so13715465ad.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 21:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698724834; x=1699329634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XmoSDh3FflhgvarrhXHbZE0EyngVnBYKj7kY4+NX8LI=;
 b=P1W6CtM0UpRk4f0Z5KhKT9S4z2KvKIIQN4F7NeyhTVYwsg/e7noSqf8JL7Upp4h8HT
 /TdAgTJeH6Ks3Io0X55oDb9VrWOGS0fQ5oSO86ieMxBfiancX+1HGWTGYzhUwvWBtthX
 8t32qQUvr3EeGuV0QYpRe8qQYN7lwcpjofi3WivHvWkXJVEvHUZJAx2sw9hdrjcaeSz/
 KP2LGeF3ucY4JvfMATKsHVA+3vOBMwL4E7yvPFy2ZixGJGrXBXi0XzwNjWujCsViFlwc
 iRxRHWDc3heXwpjyExTU1nd7T40FD/gRXdOY/V1ILRJR6+Seu5m/mYeafpdeHx/2zp8c
 fCEA==
X-Gm-Message-State: AOJu0YxocO7qBGRTMCm86bUdu7ia/GCdoV7Pv6KEsm4z8LF6dT0PnbfA
 rP4KYL6zJTvSIkTCEfd/p/FX5G3gq2edTg==
X-Google-Smtp-Source: AGHT+IHDLZ6XlO38Ff0pMLbdoOxwtj1puQz8ORKQVN1Hf32WmbZUEdjvuvp7dmwbJbcvmZi5uQNIRg==
X-Received: by 2002:a17:902:eccf:b0:1cc:3c2f:9c41 with SMTP id
 a15-20020a170902eccf00b001cc3c2f9c41mr5363834plh.23.1698724834411; 
 Mon, 30 Oct 2023 21:00:34 -0700 (PDT)
Received: from localhost.localdomain ([2601:642:4c02:7b37:49a8:6e6e:cee6:cee7])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a170902f54400b001bbfa86ca3bsm257975plf.78.2023.10.30.21.00.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Oct 2023 21:00:34 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v4 06/14] tpm-sysbus: add plug handler for TPM on SysBus
Date: Mon, 30 Oct 2023 21:00:09 -0700
Message-ID: <20231031040021.65582-7-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031040021.65582-1-j@getutm.app>
References: <20231031040021.65582-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.169; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f169.google.com
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

TPM needs to know its own base address in order to generate its DSDT
device entry.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 include/sysemu/tpm.h |  4 ++++
 hw/tpm/tpm-sysbus.c  | 47 ++++++++++++++++++++++++++++++++++++++++++++
 hw/tpm/meson.build   |  1 +
 3 files changed, 52 insertions(+)
 create mode 100644 hw/tpm/tpm-sysbus.c

diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 1ee568b3b6..ffd300e607 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -12,6 +12,8 @@
 #ifndef QEMU_TPM_H
 #define QEMU_TPM_H
 
+#include "qemu/osdep.h"
+#include "exec/hwaddr.h"
 #include "qapi/qapi-types-tpm.h"
 #include "qom/object.h"
 
@@ -78,6 +80,8 @@ static inline TPMVersion tpm_get_version(TPMIf *ti)
     return TPM_IF_GET_CLASS(ti)->get_version(ti);
 }
 
+void tpm_sysbus_plug(TPMIf *tpmif, Object *pbus, hwaddr pbus_base);
+
 #else /* CONFIG_TPM */
 
 #define tpm_init()  (0)
diff --git a/hw/tpm/tpm-sysbus.c b/hw/tpm/tpm-sysbus.c
new file mode 100644
index 0000000000..732ce34c73
--- /dev/null
+++ b/hw/tpm/tpm-sysbus.c
@@ -0,0 +1,47 @@
+/*
+ * tpm-sysbus.c - Support functions for SysBus TPM devices
+ *
+ * Copyright (c) 2023 QEMU contributors
+ *
+ * Authors:
+ *   Joelle van Dyne <j@getutm.app>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#include "sysemu/tpm.h"
+#include "hw/platform-bus.h"
+#include "hw/sysbus.h"
+#include "qapi/error.h"
+
+/**
+ * Called from a machine's pre_plug handler to set the device's physical addr.
+ */
+void tpm_sysbus_plug(TPMIf *tpmif, Object *pbus, hwaddr pbus_base)
+{
+    PlatformBusDevice *pbusdev = PLATFORM_BUS_DEVICE(pbus);
+    SysBusDevice *sbdev = SYS_BUS_DEVICE(tpmif);
+    MemoryRegion *sbdev_mr;
+    hwaddr tpm_base;
+    uint64_t tpm_size;
+
+    /* exit early if TPM is not a sysbus device */
+    if (!object_dynamic_cast(OBJECT(tpmif), TYPE_SYS_BUS_DEVICE)) {
+        return;
+    }
+
+    assert(object_dynamic_cast(pbus, TYPE_PLATFORM_BUS_DEVICE));
+
+    tpm_base = platform_bus_get_mmio_addr(pbusdev, sbdev, 0);
+    assert(tpm_base != -1);
+
+    tpm_base += pbus_base;
+
+    sbdev_mr = sysbus_mmio_get_region(sbdev, 0);
+    tpm_size = memory_region_size(sbdev_mr);
+
+    object_property_set_uint(OBJECT(sbdev), "x-baseaddr",
+                             tpm_base, &error_abort);
+    object_property_set_uint(OBJECT(sbdev), "x-size",
+                             tpm_size, &error_abort);
+}
diff --git a/hw/tpm/meson.build b/hw/tpm/meson.build
index cb8204d5bc..3060ac05e8 100644
--- a/hw/tpm/meson.build
+++ b/hw/tpm/meson.build
@@ -1,6 +1,7 @@
 system_ss.add(when: 'CONFIG_TPM_TIS', if_true: files('tpm_tis_common.c'))
 system_ss.add(when: 'CONFIG_TPM_TIS_ISA', if_true: files('tpm_tis_isa.c'))
 system_ss.add(when: 'CONFIG_TPM_TIS_SYSBUS', if_true: files('tpm_tis_sysbus.c'))
+system_ss.add(when: 'CONFIG_TPM_TIS_SYSBUS', if_true: files('tpm-sysbus.c'))
 system_ss.add(when: 'CONFIG_TPM_TIS_I2C', if_true: files('tpm_tis_i2c.c'))
 system_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_crb.c'))
 system_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_crb_common.c'))
-- 
2.41.0


